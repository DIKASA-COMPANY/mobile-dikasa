import pathlib
import subprocess
import sys
import tempfile
import unittest


SCRIPT = pathlib.Path(__file__).resolve().parents[1] / "check_dead_code.py"


class DeadCodeGateTest(unittest.TestCase):
    def run_gate(self, files):
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            for name, content in files.items():
                target = root / name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_text(content, encoding="utf-8")
            return subprocess.run(
                [sys.executable, str(SCRIPT), "--root", str(root)],
                capture_output=True, text=True, check=False,
            )

    def test_tracks_conditional_imports_exports_and_parts(self):
        result = self.run_gate({
            "lib/main.dart": "import 'stub.dart' if (dart.library.io) 'native.dart';",
            "lib/stub.dart": "export 'package:mobile_dikasa/model.dart';",
            "lib/native.dart": "part 'native.g.dart';",
            "lib/native.g.dart": "part of 'native.dart';",
            "lib/model.dart": "class Model {}",
        })
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("all 5 app Dart files", result.stdout)

    def test_rejects_mutually_referencing_but_unreachable_code(self):
        result = self.run_gate({
            "lib/main.dart": "void main() {}",
            "lib/old_service.dart": "import 'old_model.dart';",
            "lib/old_model.dart": "import 'old_service.dart';",
        })
        self.assertEqual(result.returncode, 1)
        self.assertIn("old_service.dart", result.stdout)
        self.assertIn("old_model.dart", result.stdout)

    def test_rejects_serializer_left_by_renamed_model(self):
        result = self.run_gate({
            "lib/main.dart": "void main() {}",
            "packages/dikasa_api/lib/src/model/old.g.dart": "part of 'old.dart';",
        })
        self.assertEqual(result.returncode, 1)
        self.assertIn("Orphaned generated serializer", result.stdout)


if __name__ == "__main__":
    unittest.main()
