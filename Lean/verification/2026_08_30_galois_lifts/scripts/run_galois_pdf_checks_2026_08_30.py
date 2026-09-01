"""Compile the expanded manuscript, retaining the final TeX pass and PDF metadata."""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import sys
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_30_galois_lifts"
PDFDIR = ROOT / "output/pdf"
STEM = "ChatGPT_ABC_Uniformity_2026"
TECTONIC = Path("C:/Users/Admin/.codex/plugins/cache/openai-bundled/latex/0.2.6/bin/tectonic.exe")
command = [str(TECTONIC), "-X", "compile", "--outdir", str(PDFDIR),
           "--keep-logs", "--keep-intermediates", "--print", "--untrusted", STEM + ".tex"]
run = subprocess.run(command, cwd=ROOT / "paper", capture_output=True,
                     text=True, encoding="utf-8", errors="replace")
output = run.stdout + "\n" + run.stderr
RECORD.mkdir(parents=True, exist_ok=True)
(RECORD / "tectonic-output.txt").write_text(output, encoding="utf-8")
log_path = PDFDIR / (STEM + ".log")
final_log = log_path.read_text(encoding="utf-8", errors="replace") if log_path.exists() else ""
(RECORD / "tectonic-final.log").write_text(final_log, encoding="utf-8")
warnings = re.findall(r"^.*(?:Warning:|Overfull \\[hv]box|Underfull \\[hv]box|Missing character:).*$",
                      final_log, flags=re.M)
report = {"command": command, "exit_code": run.returncode,
          "final_log_exists": log_path.exists(), "final_warning_count": len(warnings),
          "final_warnings": warnings}
pdf = PDFDIR / (STEM + ".pdf")
if run.returncode == 0 and pdf.exists():
    reader = PdfReader(pdf)
    metadata = {"path": pdf.relative_to(ROOT).as_posix(), "pages": len(reader.pages),
                "bytes": pdf.stat().st_size, "sha256": hashlib.sha256(pdf.read_bytes()).hexdigest(),
                "metadata": {str(k): str(v) for k, v in (reader.metadata or {}).items()}}
    (RECORD / "pdf-metadata.json").write_text(
        json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    report["pdf"] = metadata
(RECORD / "latex-run.json").write_text(
    json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps(report, ensure_ascii=False))
sys.exit(run.returncode)
