"""Check app file reachability and orphaned generated Dart serializers.

The Dart analyzer checks declarations; this complements it by detecting whole
files that are never imported by the app. Generated API exports are a public
contract, so they are not required to be reachable from the app entry point.
"""

import argparse
from pathlib import Path
import re
import sys


DIRECTIVE = re.compile(r"\b(?:import|export|part(?!\s+of\b))\s+([^;]+);", re.MULTILINE)
URI = re.compile(r"['\"]([^'\"]+)['\"]")


def audit(root):
    app = root / "lib"
    files = {path.resolve() for path in app.rglob("*.dart")}
    reachable = set()
    pending = [app / "main.dart"]
    while pending:
        path = pending.pop().resolve()
        if path in reachable or path not in files:
            continue
        reachable.add(path)
        for directive in DIRECTIVE.finditer(path.read_text(encoding="utf-8")):
            # Include all branches of conditional imports, not just the host OS.
            for uri in URI.findall(directive.group(1)):
                if uri.startswith("package:mobile_dikasa/"):
                    pending.append(app / uri.split("/", 1)[1])
                elif ":" not in uri:
                    pending.append(path.parent / uri)
    problems = [f"Unreachable app file: {path.relative_to(root)}" for path in sorted(files - reachable)]
    for path in (root / "packages/dikasa_api/lib").rglob("*.g.dart"):
        model = path.with_name(path.name.removesuffix(".g.dart") + ".dart")
        if not model.exists():
            problems.append(f"Orphaned generated serializer: {path.relative_to(root)}")
    return problems, len(reachable)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    root = parser.parse_args().root.resolve()
    if not (root / "lib/main.dart").is_file():
        parser.error(f"Missing app entry point: {root / 'lib/main.dart'}")
    problems, count = audit(root)
    for problem in problems:
        print(problem)
    if problems:
        return 1
    print(f"PASS: all {count} app Dart files are reachable; no orphaned API serializers.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
