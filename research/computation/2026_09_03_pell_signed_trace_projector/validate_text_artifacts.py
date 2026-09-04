#!/usr/bin/env python3
"""Check UTF-8, C0 bytes, delimiters, and high-risk TeX escapes."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


CONTROL_WORDS = (
    "qquad",
    "cdot",
    "parallel",
    "equiv",
    "pmod",
    "Longleftrightarrow",
    "operatorname",
    "boxed",
)


def inspect(path: Path, kind: str) -> dict:
    payload = path.read_bytes()
    text = payload.decode("utf-8")
    unexpected_c0 = [
        {"offset": offset, "byte": byte}
        for offset, byte in enumerate(payload)
        if byte < 32 and byte not in {9, 10, 13}
    ]
    bare_controls = {
        word: [match.start() for match in re.finditer(rf"(?<!\\)\b{word}\b", text)]
        for word in CONTROL_WORDS
    }
    bare_controls = {word: offsets for word, offsets in bare_controls.items() if offsets}
    checks = {
        "utf8_decodes": True,
        "no_unexpected_c0_bytes": not unexpected_c0,
        "no_bare_high_risk_tex_controls": not bare_controls,
        "display_math_delimiters_balanced": text.count(r"\[") == text.count(r"\]"),
        "tex_environment_delimiters_balanced":
            sorted(re.findall(r"\\begin\{([^}]+)\}", text))
            == sorted(re.findall(r"\\end\{([^}]+)\}", text)),
    }
    if kind == "report":
        checks["signed_factor_line_has_escaped_qquad"] = (
            r"A_{2\ell}-1,\qquad A_{2\ell}+1" in text
        )
    if kind == "paper_fragment":
        labels = set(re.findall(r"\\label\{([^}]+)\}", text))
        refs = set(re.findall(r"\\(?:eqref|ref)\{([^}]+)\}", text))
        forbidden_wrapper_tokens = (
            r"\documentclass",
            r"\begin{document}",
            r"\end{document}",
            r"\maketitle",
            r"\begin{abstract}",
            r"\begin{thebibliography}",
            r"\bibliography",
        )
        checks["directly_inputtable_no_wrapper_tokens"] = not any(
            token in text for token in forbidden_wrapper_tokens
        )
        checks["section_label_is_unique_route_label"] = (
            r"\label{sec:pell-signed-trace-projector}" in text
        )
        checks["all_labels_have_route_prefix"] = all(
            label == "sec:pell-signed-trace-projector"
            or "pell-signed-" in label
            for label in labels
        )
        checks["all_local_refs_resolve"] = refs <= labels
    return {
        "path": path.as_posix(),
        "byte_length": len(payload),
        "unexpected_c0": unexpected_c0,
        "bare_high_risk_tex_controls": bare_controls,
        "checks": checks,
        "status": "PASS" if all(checks.values()) else "FAIL",
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--report", type=Path, required=True)
    parser.add_argument("--paper", type=Path, required=True)
    parser.add_argument("--main-paper", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    artifacts = [
        inspect(args.report, "report"),
        inspect(args.paper, "paper_fragment"),
    ]
    main_paper = args.main_paper.read_text(encoding="utf-8")
    bibliography_checks = {
        "main_paper_has_BHV2001_bibitem":
            r"\bibitem{BHV2001}" in main_paper,
        "fragment_cites_BHV2001": r"\cite{BHV2001}" in args.paper.read_text(encoding="utf-8"),
    }
    result = {
        "schema": "pell-signed-trace-text-validation-v1",
        "artifacts": artifacts,
        "bibliography_checks": bibliography_checks,
        "status": "PASS"
        if all(item["status"] == "PASS" for item in artifacts)
        and all(bibliography_checks.values())
        else "FAIL",
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    if result["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
