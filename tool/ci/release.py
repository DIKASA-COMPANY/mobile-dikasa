"""Android release provenance, promotion receipts, and ephemeral credentials.

Uses only the Python standard library available on GitHub-hosted runners.
"""

import base64
import hashlib
import ipaddress
import json
import os
from pathlib import Path
import re
import sys
from urllib.parse import urlencode, urlsplit
from urllib.request import Request, urlopen


STAGES = ("dev", "sit", "uat", "stg", "prd")
TASK = "dikasa-android-distribution"


def required(name):
    value = os.environ.get(name, "").strip()
    if not value:
        raise ValueError(f"Missing required configuration: {name}")
    return value


class GitHub:
    def __init__(self):
        self.repository = required("GITHUB_REPOSITORY")
        self.token = required("GH_TOKEN")
        self.base = os.environ.get("GITHUB_API_URL", "https://api.github.com")

    def request(self, path, data=None):
        request = Request(
            f"{self.base}/repos/{self.repository}/{path}",
            data=None if data is None else json.dumps(data).encode(),
            headers={
                "Authorization": f"Bearer {self.token}",
                "Accept": "application/vnd.github+json",
                "Content-Type": "application/json",
                "X-GitHub-Api-Version": "2022-11-28",
            },
        )
        with urlopen(request, timeout=30) as response:
            return json.load(response)

    def pages(self, path, query=None):
        page = 1
        while True:
            values = self.request(
                f"{path}?{urlencode(dict(query or {}, per_page=100, page=page))}"
            )
            yield from values
            if len(values) < 100:
                return
            page += 1


def validate_run(run, repository):
    if not (
        run.get("status") == "completed"
        and run.get("conclusion") == "success"
        and run.get("event") == "push"
        and run.get("head_branch") == "main"
        and run.get("path") == ".github/workflows/mobile-ci.yml"
        and run.get("repository", {}).get("full_name") == repository
        and run.get("head_repository", {}).get("full_name") == repository
        and re.fullmatch(r"[0-9a-f]{40}", run.get("head_sha", ""))
    ):
        raise ValueError("Candidate must be a successful Mobile CI push run on this repository's main branch")
    return run["head_sha"]


def previous_stage_succeeded(api, stage, sha, ci_run_id):
    if stage == "dev":
        return
    previous = STAGES[STAGES.index(stage) - 1]
    for deployment in api.pages("deployments", {"sha": sha, "environment": previous, "task": TASK}):
        payload = deployment.get("payload", {})
        if isinstance(payload, str):
            try:
                payload = json.loads(payload)
            except ValueError:
                continue
        if not isinstance(payload, dict):
            continue
        if not (
            deployment.get("task") == TASK
            and deployment.get("sha") == sha
            and deployment.get("environment") == previous
            and deployment.get("creator", {}).get("login") == "github-actions[bot]"
            and str(payload.get("ci_run_id")) == ci_run_id
        ):
            continue
        statuses = api.pages(f"deployments/{deployment['id']}/statuses")
        latest = next(statuses, {})
        if latest.get("state") == "success" or (
            latest.get("state") == "inactive"
            and any(status.get("state") == "success" for status in statuses)
        ):
            return
    raise ValueError(f"Promotion blocked: {previous} has no successful distribution for CI run {ci_run_id} at {sha}")


def resolve(write_output=True):
    stage = required("TARGET_ENVIRONMENT")
    ci_run_id = required("CI_RUN_ID")
    if stage not in STAGES or not re.fullmatch(r"[1-9][0-9]*", ci_run_id):
        raise ValueError("Invalid environment or CI run ID")
    api = GitHub()
    sha = validate_run(api.request(f"actions/runs/{ci_run_id}"), api.repository)
    comparison = api.request(f"compare/{sha}...main")
    if comparison.get("status") not in ("ahead", "identical"):
        raise ValueError("Candidate commit is no longer an ancestor of main")
    if os.environ.get("SOURCE_SHA") not in (None, sha):
        raise ValueError("Candidate SHA does not match the selected CI run")
    previous_stage_succeeded(api, stage, sha, ci_run_id)
    if write_output:
        with open(required("GITHUB_OUTPUT"), "a", encoding="utf-8") as output:
            output.write(f"sha={sha}\nci_run_id={ci_run_id}\nenvironment={stage}\n")
    print(f"Verified {stage}: CI {ci_run_id}, commit {sha}")
    return sha


def validate_configuration():
    stage = required("TARGET_ENVIRONMENT")
    if stage not in STAGES:
        raise ValueError("Invalid environment")
    url = urlsplit(required("API_BASE_URL"))
    if url.scheme != "https" or not url.hostname or url.username is not None or url.password is not None or url.query or url.fragment:
        raise ValueError("API_BASE_URL must be an HTTPS endpoint without credentials, query, or fragment")
    if url.hostname == "localhost" or url.hostname.endswith((".localhost", ".local")):
        raise ValueError("Distributed builds cannot target a local development host")
    try:
        address = ipaddress.ip_address(url.hostname)
    except ValueError:
        address = None
    if address is not None and (address.is_loopback or address.is_unspecified or address.is_link_local):
        raise ValueError("Distributed builds cannot target a loopback, unspecified, or link-local address")
    if not re.fullmatch(r"1:[0-9]+:android:[0-9a-f]+", required("FIREBASE_APP_ID")):
        raise ValueError("FIREBASE_APP_ID must be the Android Firebase App ID, not the project ID")
    if not re.fullmatch(r"[A-Za-z0-9_-]+(?:,[A-Za-z0-9_-]+)*", required("FIREBASE_GROUPS")):
        raise ValueError("FIREBASE_GROUPS must contain comma-separated group aliases")
    for name in ("ANDROID_KEYSTORE_PASSWORD", "ANDROID_KEY_ALIAS", "ANDROID_KEY_PASSWORD"):
        required(name)
    offset = required("ANDROID_BUILD_NUMBER_OFFSET")
    number = required("GITHUB_RUN_NUMBER")
    if not offset.isdecimal() or not number.isdecimal():
        raise ValueError("Build number and offset must be nonnegative integers")
    build_number = int(offset) + int(number)
    if not 0 < build_number <= 2100000000:
        raise ValueError("Android build number is outside the supported versionCode range")
    return build_number


def prepare():
    build_number = validate_configuration()
    try:
        keystore = base64.b64decode(required("ANDROID_KEYSTORE_BASE64"), validate=True)
    except ValueError:
        raise ValueError("ANDROID_KEYSTORE_BASE64 is not valid base64") from None
    if not keystore:
        raise ValueError("Android keystore is empty")
    try:
        credentials = json.loads(required("FIREBASE_SERVICE_ACCOUNT_JSON"))
    except ValueError:
        raise ValueError("FIREBASE_SERVICE_ACCOUNT_JSON is not valid JSON") from None
    if not isinstance(credentials, dict) or not all(
        credentials.get(key) for key in ("project_id", "client_email", "private_key")
    ) or credentials.get("type") != "service_account":
        raise ValueError("Firebase credentials must be a service account JSON key")
    for name, content in (
        ("ANDROID_KEYSTORE_PATH", keystore),
        ("GOOGLE_APPLICATION_CREDENTIALS", json.dumps(credentials).encode()),
    ):
        path = Path(required(name))
        path.write_bytes(content)
        path.chmod(0o600)
    with open(required("GITHUB_ENV"), "a", encoding="utf-8") as output:
        output.write(f"ANDROID_BUILD_NUMBER={build_number}\n")
    print("Validated distribution configuration and prepared temporary credentials")


def manifest():
    stage = required("TARGET_ENVIRONMENT")
    apk = Path(f"build/app/outputs/flutter-apk/app-{stage}-release.apk")
    artifacts = [apk]
    if stage == "prd":
        bundles = list(Path("build/app/outputs/bundle/prdRelease").glob("*.aab"))
        if len(bundles) != 1:
            raise ValueError("Expected exactly one signed production AAB")
        artifacts += bundles
    checksums = {}
    for path in artifacts:
        digest = hashlib.sha256()
        with path.open("rb") as stream:
            for block in iter(lambda: stream.read(1024 * 1024), b""):
                digest.update(block)
        checksums[str(path)] = digest.hexdigest()
    metadata = {
        "environment": stage,
        "source_sha": required("SOURCE_SHA"),
        "ci_run_id": required("CI_RUN_ID"),
        "release_run_id": required("GITHUB_RUN_ID"),
        "release_run_attempt": required("GITHUB_RUN_ATTEMPT"),
        "build_number": required("ANDROID_BUILD_NUMBER"),
        "api_base_url": required("API_BASE_URL"),
        "firebase_app_id": required("FIREBASE_APP_ID"),
        "openapi_sha256": hashlib.sha256(Path("openapi/dikasa.openapi.yaml").read_bytes()).hexdigest(),
        "sha256": checksums,
    }
    output = Path("build/distribution")
    output.mkdir(parents=True, exist_ok=True)
    (output / "release.json").write_text(json.dumps(metadata, indent=2) + "\n", encoding="utf-8")
    (output / "release-notes.txt").write_text(
        f"DIKASA Android {stage.upper()}\nCommit: {metadata['source_sha']}\n"
        f"Build: {metadata['build_number']}\nCI run: {metadata['ci_run_id']}\n",
        encoding="utf-8",
    )


def record():
    api = GitHub()
    metadata = json.loads(Path("build/distribution/release.json").read_text(encoding="utf-8"))
    deployment = api.request("deployments", {
        "ref": required("SOURCE_SHA"),
        "task": TASK,
        "auto_merge": False,
        "required_contexts": [],
        "environment": required("TARGET_ENVIRONMENT"),
        "description": "Signed Android build delivered to Firebase App Distribution",
        "transient_environment": False,
        "production_environment": required("TARGET_ENVIRONMENT") == "prd",
        "payload": metadata,
    })
    if "id" not in deployment:
        raise ValueError("GitHub did not create the promotion receipt")
    api.request(f"deployments/{deployment['id']}/statuses", {
        "state": "success",
        "auto_inactive": False,
        "log_url": f"{required('GITHUB_SERVER_URL')}/{api.repository}/actions/runs/{required('GITHUB_RUN_ID')}",
        "description": "Firebase distribution and signed artifact archival succeeded",
    })
    with open(required("GITHUB_STEP_SUMMARY"), "a", encoding="utf-8") as summary:
        summary.write(
            f"### Android {metadata['environment'].upper()} distributed\n\n"
            f"Commit: `{metadata['source_sha']}`  \nCI run: `{metadata['ci_run_id']}`  \n"
            f"Build: `{metadata['build_number']}`\n\nSigned artifacts and SHA-256 hashes are attached to this run.\n"
        )


if __name__ == "__main__":
    commands = {"resolve": resolve, "verify": lambda: resolve(False), "prepare": prepare, "manifest": manifest, "record": record}
    if len(sys.argv) != 2 or sys.argv[1] not in commands:
        sys.exit("Usage: release.py resolve|verify|prepare|manifest|record")
    try:
        commands[sys.argv[1]]()
    except Exception as error:
        print(f"Release failed: {error}", file=sys.stderr)
        sys.exit(1)
