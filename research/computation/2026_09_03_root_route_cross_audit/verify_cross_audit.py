#!/usr/bin/env python3
"""Independent, offline cross-audit for two 2026-09-03 root routes.

The script checks source-capsule integrity, theorem-level AxiomAudit
coverage, forbidden proof placeholders, exact finite countermodels, and a
finite clustered-prime-log stress test.  It does not promote any finite
calculation to an asymptotic theorem.
"""

from __future__ import annotations

import hashlib
import json
import math
import re
import unicodedata
from fractions import Fraction
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent

MERSENNE_REPORT = ROOT / "research/ABC_MERSENNE_FAREY_QUANTITATIVE_SWARM_2026_09_03.md"
MERSENNE_LEAN = ROOT / "Lean/IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903.lean"
MERSENNE_AUDIT = ROOT / "Lean/IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903AxiomAudit.lean"
ALTERNATIVE_REPORT = ROOT / "research/ABC_ALTERNATIVE_QUALITY_PACKING_AUDIT_2026_09_03.md"
ALTERNATIVE_LEAN = ROOT / "Lean/IUTThreeClosures/AlternativeQualityPackingBridge20260903.lean"
ALTERNATIVE_AUDIT = ROOT / "Lean/IUTThreeClosures/AlternativeQualityPackingBridge20260903AxiomAudit.lean"
SOURCE_DIR = ROOT / "research/sources/alternative_quality_metrics_2026_09_03"
SOURCE_TEXT = SOURCE_DIR / "Sankaran_Alternative_Quality_Metrics_arXiv2606.08416v1.txt"
SOURCE_PDF = SOURCE_DIR / "Sankaran_Alternative_Quality_Metrics_arXiv2606.08416v1.pdf"
SOURCE_METADATA = SOURCE_DIR / "source-metadata.json"
SOURCE_MANIFEST = SOURCE_DIR / "SHA256SUMS"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def compact(text: str) -> str:
    text = unicodedata.normalize("NFKC", text).lower()
    return re.sub(r"\s+", "", text)


def theorem_names(path: Path) -> set[str]:
    text = path.read_text(encoding="utf-8")
    return set(re.findall(r"(?m)^theorem\s+([A-Za-z0-9_']+)", text))


def audit_names(path: Path) -> set[str]:
    text = path.read_text(encoding="utf-8")
    return set(re.findall(r"(?m)^#print axioms\s+([A-Za-z0-9_']+)", text))


def sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[:2] = b"\x00\x00"
    for p in range(2, math.isqrt(limit) + 1):
        if flags[p]:
            flags[p * p : limit + 1 : p] = b"\x00" * (
                (limit - p * p) // p + 1
            )
    return flags


def clustered_prime_samples() -> list[dict[str, float | int]]:
    """Finite checks only; the asymptotic existence statement uses PNT."""
    xs = [100, 1_000, 10_000, 100_000, 1_000_000]
    flags = sieve(2 * max(xs))
    rows: list[dict[str, float | int]] = []
    for x in xs:
        primes = [p for p in range(x, 2 * x + 1) if flags[p]]
        if not primes:
            raise AssertionError(f"empty prime cluster for X={x}")
        log_coordinates = [math.log(p) for p in primes]
        arithmetic = sum(log_coordinates) / len(log_coordinates)
        geometric = math.exp(
            sum(math.log(value) for value in log_coordinates)
            / len(log_coordinates)
        )
        eta = geometric / arithmetic
        lower = math.log(x) / math.log(2 * x)
        if not (lower <= eta + 1e-14 and eta <= 1 + 1e-14):
            raise AssertionError(f"cluster inequality failed for X={x}")
        rows.append(
            {
                "X": x,
                "prime_count": len(primes),
                "lower_bound": lower,
                "eta": eta,
            }
        )
    return rows


def verify_source_capsule() -> dict[str, object]:
    metadata = json.loads(SOURCE_METADATA.read_text(encoding="utf-8"))
    file_checks = []
    for name, record in metadata["files"].items():
        actual = sha256(SOURCE_DIR / name)
        expected = record["sha256"]
        file_checks.append(
            {"file": name, "expected": expected, "actual": actual, "pass": actual == expected}
        )
    manifest_checks = []
    for line in SOURCE_MANIFEST.read_text(encoding="utf-8").splitlines():
        match = re.fullmatch(r"([0-9a-f]{64})  (.+)", line)
        if match is None:
            raise AssertionError(f"malformed source manifest line: {line!r}")
        expected, name = match.groups()
        actual = sha256(SOURCE_DIR / name)
        manifest_checks.append(
            {"file": name, "expected": expected, "actual": actual, "pass": actual == expected}
        )
    if not all(row["pass"] for row in file_checks + manifest_checks):
        raise AssertionError("source-capsule hash mismatch")
    if not SOURCE_PDF.read_bytes().startswith(b"%PDF-"):
        raise AssertionError("archived source lacks a PDF header")
    return {
        "metadata_files": file_checks,
        "manifest_files": manifest_checks,
        "pdf_header": True,
    }


def verify_source_scope() -> dict[str, bool]:
    text = compact(SOURCE_TEXT.read_text(encoding="utf-8"))
    anchors = {
        "lemma_4_12": "lemma4.12(packingprimes)" in text,
        "fixed_complement": "whilen0remainsinvariant" in text,
        "bounded_complement_and_omega": "becausen0andωarebounded" in text,
        "theorem_4_13": "theorem4.13(factorizationofqs)" in text,
        "extension_invokes_lemma": (
            "asanextension,if,additionally,thelargestprimefactor" in text
            and "thenbylemma4.12,wehaveηn=o" in text
        ),
        "theorem_4_15": "theorem4.15(packing-efficiencyformulationofabc)" in text,
    }
    if not all(anchors.values()):
        raise AssertionError(f"source-scope anchor failure: {anchors}")
    return anchors


def verify_lean_coverage() -> dict[str, object]:
    result: dict[str, object] = {}
    for label, module, audit in (
        ("mersenne", MERSENNE_LEAN, MERSENNE_AUDIT),
        ("alternative_quality", ALTERNATIVE_LEAN, ALTERNATIVE_AUDIT),
    ):
        module_theorems = theorem_names(module)
        audited = audit_names(audit)
        if module_theorems != audited:
            raise AssertionError(
                f"{label} theorem-level audit mismatch: "
                f"missing={sorted(module_theorems - audited)}, "
                f"extra={sorted(audited - module_theorems)}"
            )
        combined = module.read_text(encoding="utf-8") + audit.read_text(encoding="utf-8")
        forbidden = re.findall(
            r"(?im)\b(?:sorry|admit|sorryAx)\b|^\s*axiom\s+", combined
        )
        if forbidden:
            raise AssertionError(f"{label} forbidden proof token: {forbidden}")
        result[label] = {
            "theorem_count": len(module_theorems),
            "audit_count": len(audited),
            "theorem_level_coverage": "exact",
            "forbidden_proof_tokens": [],
        }
    return result


def verify_recorded_runs() -> dict[str, object]:
    exit_labels = [
        "mersenne_main",
        "mersenne_audit",
        "alternative_main",
        "alternative_audit",
        "source_verifier",
    ]
    exit_codes = {}
    for label in exit_labels:
        value = int((HERE / f"{label}.exitcode.txt").read_text(encoding="ascii").strip())
        if value != 0:
            raise AssertionError(f"recorded command failed: {label}={value}")
        exit_codes[label] = value

    expected_counts = {"mersenne_audit": 17, "alternative_audit": 9}
    allowed = {"propext", "Classical.choice", "Quot.sound"}
    axiom_results = {}
    for label, expected_count in expected_counts.items():
        text = (HERE / f"{label}_stdout.txt").read_text(encoding="utf-8-sig")
        matches = re.findall(r"depends on axioms:\s*\[(.*?)\]", text, re.DOTALL)
        used = {
            name.strip()
            for match in matches
            for name in match.split(",")
            if name.strip()
        }
        if len(matches) != expected_count or not used <= allowed:
            raise AssertionError(
                f"axiom output mismatch for {label}: reports={len(matches)}, used={sorted(used)}"
            )
        axiom_results[label] = {
            "reports": len(matches),
            "union": sorted(used),
        }

    source_output = json.loads(
        (HERE / "source_verifier_stdout.txt").read_text(encoding="utf-8-sig")
    )
    if source_output.get("status") != "PASS":
        raise AssertionError("recorded source verifier output is not PASS")
    return {
        "exit_codes": exit_codes,
        "axiom_outputs": axiom_results,
        "source_verifier_status": source_output["status"],
    }


def verify_report_boundaries() -> dict[str, bool]:
    mersenne_raw = MERSENNE_REPORT.read_text(encoding="utf-8")
    alternative_raw = ALTERNATIVE_REPORT.read_text(encoding="utf-8")
    mersenne = compact(mersenne_raw)
    alternative = compact(alternative_raw)
    checks = {
        "mersenne_counting_gate_open": "super-wieferichcountingestimateandtheabcconjectureremainopen" in mersenne,
        "mersenne_counterexample_auxiliary_only": "statement,nottothemersennerouteortoabc" in mersenne,
        "mersenne_divided_form_kernel_checked": (
            "quantitativeSwarm_count_lower" in mersenne_raw
            and "proves the divided form (3.2)" in mersenne_raw
        ),
        "alternative_extension_scope_warning": "doesnotfollowfromthestatedadditionallargest-primehypothesisalone" in alternative,
        "alternative_cluster_width_positive": "foreveryfixed`c>0`" in alternative,
        "alternative_big_o_non_equivalence_recorded": "powerupperboundandisnotequivalent" in alternative,
        "alternative_theorem_4_10_caution_recorded": "asecond,separatecautionconcernstheproofoftheorem4.10" in alternative,
        "alternative_next_gate_exact": "\\etaq_{\\rmdgm}>1+\\delta" in alternative,
        "alternative_cluster_not_abc_triples": "notassertedtoarisefromactualadditiveabctriples" in alternative,
        "alternative_abstract_counterexample_only": "notafamilyofintegerabctriples" in alternative,
    }
    if not all(checks.values()):
        raise AssertionError(f"report-boundary check failed: {checks}")
    return checks


def verify_exact_countermodels() -> dict[str, object]:
    triangular = 2 * (2 - 1) // 2
    harmonic = sum((Fraction(1, q) for q in range(1, 2)), Fraction())
    full_fibre_energy = Fraction(triangular) * harmonic
    if (triangular, harmonic, full_fibre_energy) != (1, Fraction(1), Fraction(1)):
        raise AssertionError("Mersenne prefix witness failed")

    witness_rows = []
    for n in (0, 1, 2, 10, 100):
        dgm = Fraction(n + 1)
        efficiency = Fraction(1, n + 1)
        standard = efficiency * dgm
        if not (0 < efficiency <= 1 and dgm > 0 and standard == 1):
            raise AssertionError(f"alternative-quality witness failed at n={n}")
        witness_rows.append(
            {
                "n": n,
                "efficiency": str(efficiency),
                "dgm": str(dgm),
                "standard": str(standard),
            }
        )
    return {
        "mersenne_full_fibre": {
            "T": 1,
            "H": 2,
            "triangular_capacity": triangular,
            "harmonic_prefix": str(harmonic),
            "prefix_energy": str(full_fibre_energy),
        },
        "alternative_metric_witness_samples": witness_rows,
    }


def main() -> None:
    audited_inputs = [
        MERSENNE_REPORT,
        MERSENNE_LEAN,
        MERSENNE_AUDIT,
        ALTERNATIVE_REPORT,
        ALTERNATIVE_LEAN,
        ALTERNATIVE_AUDIT,
        SOURCE_PDF,
        SOURCE_TEXT,
        SOURCE_METADATA,
        SOURCE_MANIFEST,
    ]
    result = {
        "schema": "abc-root-route-cross-audit-v1",
        "status": "PASS",
        "critical_errors": [],
        "source_capsule": verify_source_capsule(),
        "source_scope_anchors": verify_source_scope(),
        "lean_theorem_audit": verify_lean_coverage(),
        "recorded_runs": verify_recorded_runs(),
        "report_boundaries": verify_report_boundaries(),
        "exact_countermodels": verify_exact_countermodels(),
        "clustered_prime_samples_C_log_2": clustered_prime_samples(),
        "resolved_during_audit": [
            "The PNT cluster sentence now explicitly assumes a fixed width C > 0.",
            "The divided Mersenne inequality (3.2) now has the theorem quantitativeSwarm_count_lower and AxiomAudit coverage.",
            "The report now records that ln(P_n)=O(ln(c_n)) is not equivalent to P_n~c_n^kappa.",
            "The next packing gate now uses the exact product inequality eta*q_DGM > 1+delta.",
        ],
        "source_level_cautions": [
            "Sankaran Lemma 4.12 is fixed-complement; its rate cannot be imported into the growing-complement extension after Theorem 4.13.",
            "The displayed proof of Sankaran Theorem 4.10 establishes an upper estimate, not the claimed exact boundary limsup constant.",
        ],
        "audited_input_sha256": {
            str(path.relative_to(ROOT)).replace("\\", "/"): sha256(path)
            for path in audited_inputs
        },
        "finite_boundary": (
            "Cluster samples and exact witness samples are finite checks only.  "
            "They do not prove an asymptotic prime theorem or any abc statement."
        ),
    }
    output = HERE / "cross_audit.json"
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
