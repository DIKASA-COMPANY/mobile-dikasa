import copy
import os
import unittest
from unittest.mock import patch

import release


SHA = "a" * 40
REPO = "DIKASA-COMPANY/mobile-dikasa"


class ProvenanceTests(unittest.TestCase):
    def setUp(self):
        self.run = {
            "status": "completed", "conclusion": "success", "event": "push",
            "head_branch": "main", "path": ".github/workflows/mobile-ci.yml",
            "repository": {"full_name": REPO}, "head_repository": {"full_name": REPO},
            "head_sha": SHA,
        }

    def test_successful_main_push_is_accepted(self):
        self.assertEqual(release.validate_run(self.run, REPO), SHA)

    def test_untrusted_or_failed_runs_are_rejected(self):
        for key, value in (
            ("conclusion", "failure"), ("status", "in_progress"),
            ("event", "pull_request"), ("head_branch", "feature/test"),
            ("path", ".github/workflows/other.yml"), ("head_sha", "main"),
            ("repository", {"full_name": "other/repo"}),
            ("head_repository", {"full_name": "attacker/fork"}),
        ):
            with self.subTest(key=key):
                run = copy.deepcopy(self.run)
                run[key] = value
                with self.assertRaises(ValueError):
                    release.validate_run(run, REPO)


class FakeAPI:
    def __init__(self, deployments=(), statuses=()):
        self.deployments = deployments
        self.statuses = statuses

    def pages(self, path, query=None):
        return iter(self.deployments if path == "deployments" else self.statuses)


class PromotionTests(unittest.TestCase):
    def setUp(self):
        self.deployment = {
            "id": 12, "sha": SHA, "environment": "dev", "task": release.TASK,
            "creator": {"login": "github-actions[bot]"}, "payload": {"ci_run_id": "42"},
        }

    def test_dev_has_no_previous_stage(self):
        release.previous_stage_succeeded(FakeAPI(), "dev", SHA, "42")

    def test_sit_accepts_exact_successful_dev_candidate(self):
        release.previous_stage_succeeded(FakeAPI([self.deployment], [{"state": "success"}]), "sit", SHA, "42")

    def test_missing_or_unsuccessful_predecessor_blocks_promotion(self):
        for status in (None, "failure", "pending", "in_progress", "inactive"):
            with self.subTest(status=status), self.assertRaises(ValueError):
                release.previous_stage_succeeded(
                    FakeAPI([self.deployment], [] if status is None else [{"state": status}]), "sit", SHA, "42"
                )
        with self.assertRaises(ValueError):
            release.previous_stage_succeeded(FakeAPI(), "uat", SHA, "42")

    def test_candidate_stays_promotable_after_new_dev_deployment(self):
        release.previous_stage_succeeded(
            FakeAPI([self.deployment], [{"state": "inactive"}, {"state": "success"}]),
            "sit", SHA, "42",
        )

    def test_other_candidate_stage_or_creator_cannot_unlock_promotion(self):
        for key, value in (
            ("sha", "b" * 40), ("environment", "sit"), ("task", "deploy"),
            ("creator", {"login": "someone"}), ("payload", {"ci_run_id": "43"}),
            ("payload", "invalid JSON"), ("payload", []),
        ):
            with self.subTest(key=key):
                deployment = dict(self.deployment, **{key: value})
                with self.assertRaises(ValueError):
                    release.previous_stage_succeeded(FakeAPI([deployment], [{"state": "success"}]), "sit", SHA, "42")


class ConfigurationTests(unittest.TestCase):
    def setUp(self):
        self.environment = {
            "TARGET_ENVIRONMENT": "dev", "API_BASE_URL": "https://api.example.com/dikasa/v1",
            "FIREBASE_APP_ID": "1:123456:android:abcdef", "FIREBASE_GROUPS": "dev,qa",
            "ANDROID_KEYSTORE_PASSWORD": "test", "ANDROID_KEY_ALIAS": "dikasa",
            "ANDROID_KEY_PASSWORD": "test", "ANDROID_BUILD_NUMBER_OFFSET": "100",
            "GITHUB_RUN_NUMBER": "42",
        }

    def test_build_number_includes_offset(self):
        with patch.dict(os.environ, self.environment, clear=True):
            self.assertEqual(release.validate_configuration(), 142)

    def test_private_https_endpoint_can_be_used_by_vpn_testers(self):
        with patch.dict(os.environ, dict(self.environment, API_BASE_URL="https://10.0.0.2/v1"), clear=True):
            self.assertEqual(release.validate_configuration(), 142)

    def test_invalid_distribution_configuration_fails_closed(self):
        for key, value in (
            ("API_BASE_URL", "http://api.example.com"), ("API_BASE_URL", "https://localhost/v1"),
            ("API_BASE_URL", "https://127.0.0.1/v1"), ("API_BASE_URL", "https://0.0.0.0/v1"),
            ("API_BASE_URL", "https://user:pass@api.example.com/v1"),
            ("API_BASE_URL", "https://:@api.example.com/v1"),
            ("FIREBASE_APP_ID", "dikasa-project"), ("FIREBASE_GROUPS", ""),
            ("ANDROID_KEY_ALIAS", ""), ("TARGET_ENVIRONMENT", "production"),
            ("ANDROID_BUILD_NUMBER_OFFSET", "-1"), ("ANDROID_BUILD_NUMBER_OFFSET", "2100000000"),
        ):
            with self.subTest(key=key, value=value):
                with patch.dict(os.environ, dict(self.environment, **{key: value}), clear=True):
                    with self.assertRaises(ValueError):
                        release.validate_configuration()


if __name__ == "__main__":
    unittest.main()
