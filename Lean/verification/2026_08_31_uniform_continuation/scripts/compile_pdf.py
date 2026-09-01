"""Compile the expanded manuscript, retaining the final TeX pass and PDF metadata."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import sys
import tempfile
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
PDFDIR = ROOT / "output/pdf"
STEM = "ChatGPT_ABC_Uniformity_2026"
TECTONIC = Path("C:/Users/Admin/.codex/plugins/cache/openai-bundled/latex/0.2.6/bin/tectonic.exe")
def input_tree(path, seen=None):
    seen = set() if seen is None else seen
    path = path.resolve()
    if path in seen:
        return seen
    assert path.is_relative_to(ROOT.resolve()) and path.is_file(), path
    seen.add(path)
    source = path.read_text(encoding="utf-8")
    for name in re.findall(r"^\s*\\input\{([^}]+)\}", source, re.M):
        child = path.parent / (name if name.endswith(".tex") else name + ".tex")
        input_tree(child, seen)
    return seen
source_hashes = {path.relative_to(ROOT).as_posix(): hashlib.sha256(path.read_bytes()).hexdigest()
                 for path in sorted(input_tree(ROOT / "paper" / (STEM + ".tex")))}
build_root = ROOT / "tmp/latex/abc_uniform_continuation_2026_08_31"
build_root.mkdir(parents=True, exist_ok=True)
build_dir = Path(tempfile.mkdtemp(prefix="build-", dir=build_root))
command = [str(TECTONIC), "-X", "compile", "--outdir", str(build_dir),
           "--keep-logs", "--keep-intermediates", "--print", "--untrusted", STEM + ".tex"]
run = subprocess.run(command, cwd=ROOT / "paper", capture_output=True,
                     text=True, encoding="utf-8", errors="replace")
output = run.stdout + "\n" + run.stderr
RECORD.mkdir(parents=True, exist_ok=True)
(RECORD / "tectonic-output.txt").write_text(output, encoding="utf-8")
log_path = build_dir / (STEM + ".log")
final_log = log_path.read_text(encoding="utf-8", errors="replace") if log_path.exists() else ""
(RECORD / "tectonic-final.log").write_text(final_log, encoding="utf-8")
warnings = re.findall(r"^.*(?:Warning:|Overfull \\[hv]box|Underfull \\[hv]box|Missing character:).*$",
                      final_log, flags=re.M)
report = {"command": command, "exit_code": run.returncode,
          "final_log_exists": log_path.exists(), "final_warning_count": len(warnings),
          "final_warnings": warnings}
report["input_sha256"] = source_hashes
report["inputs_changed_during_run"] = [name for name, expected in source_hashes.items()
                                        if hashlib.sha256((ROOT / name).read_bytes()).hexdigest() != expected]
# Preserve the older PDF currently open in the user's WPS session.
pdf = PDFDIR / (STEM + "_08_31.pdf")
staged_pdf = build_dir / (STEM + ".pdf")
report["build_directory"] = build_dir.relative_to(ROOT).as_posix()
if run.returncode == 0 and staged_pdf.exists() and not report["inputs_changed_during_run"]:
    shutil.copyfile(staged_pdf, pdf)
    assert hashlib.sha256(staged_pdf.read_bytes()).digest() == hashlib.sha256(pdf.read_bytes()).digest()
    reader = PdfReader(pdf)
    metadata = {"path": pdf.relative_to(ROOT).as_posix(), "pages": len(reader.pages),
                "bytes": pdf.stat().st_size, "sha256": hashlib.sha256(pdf.read_bytes()).hexdigest(),
                "metadata": {str(k): str(v) for k, v in (reader.metadata or {}).items()}}
    (RECORD / "pdf-metadata.json").write_text(
        json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    report["pdf"] = metadata
    reader.close()
(RECORD / "latex-run.json").write_text(
    json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps(report, ensure_ascii=False))
sys.exit(run.returncode or (1 if report["inputs_changed_during_run"] else 0))
