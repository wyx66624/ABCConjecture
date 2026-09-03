from __future__ import annotations

import json
import re
import subprocess
import sys
from fractions import Fraction
from itertools import product
from math import gcd
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
LEAN_ROOT = ROOT / "Lean"
LEAN_FILE = LEAN_ROOT / "IUTThreeClosures" / "AffineOwnershipMaximalIntersectionAggregation20260902.lean"
AXIOM_AUDIT_FILE = LEAN_ROOT / "IUTThreeClosures" / "AffineOwnershipMaximalIntersectionAggregation20260902AxiomAudit.lean"
REPORT = ROOT / "research" / "ABC_AFFINE_OWNERSHIP_MAXIMAL_INTERSECTION_AGGREGATION_2026_09_02.md"
GRID_OUTPUT = HERE / "OUTPUT_GRID_SCAN.txt"


def factor_alt(n: int) -> dict[int, int]:
    result: dict[int, int] = {}
    divisor = 2
    while divisor * divisor <= n:
        while n % divisor == 0:
            result[divisor] = result.get(divisor, 0) + 1
            n //= divisor
        divisor += 1
    if n > 1:
        result[n] = result.get(n, 0) + 1
    return result


def phi_alt(n: int) -> int:
    for p in factor_alt(n):
        n = n // p * (p - 1)
    return n


def kernel_alt(n: int) -> int:
    return product_int(p**e for p, e in factor_alt(n).items() if e >= 2)


def product_int(values) -> int:
    ans = 1
    for value in values:
        ans *= value
    return ans


def divisors_alt(n: int) -> list[int]:
    values = [1]
    for p, e in factor_alt(n).items():
        values = [d * p**j for d in values for j in range(e + 1)]
    return sorted(values)


def catalogue_alt(top, coeff, threshold):
    out = []
    for d in product(*(divisors_alt(k) for k in top)):
        D = product_int(d)
        if D <= threshold:
            continue
        capture = product_int(gcd(x, abs(a)) for x, a in zip(d, coeff))
        T = D // capture
        w = product_int(phi_alt(x) for x in d)
        out.append((d, w, T, Fraction(w, T * T)))
    return out


def verify_alt_arithmetic() -> dict:
    period_arms = [(4887, 38599, 34385), (5013, 13189, 12167)]
    period_kernels = [tuple(kernel_alt(z) for z in row) for row in period_arms]
    assert period_kernels == [(27, 1331, 529), (9, 121, 12167)]
    top = tuple(gcd(a, b) for a, b in zip(*period_kernels))
    assert top == (9, 121, 529)
    cat = catalogue_alt(top, (3, -605, -529), 399**2)
    assert cat == [
        ((3, 121, 529), 111320, 1, Fraction(111320)),
        ((9, 121, 529), 333960, 3, Fraction(111320, 3)),
    ]

    collapse_arms = [
        (2401, 14801, 12321),
        (2891, 11191, 9531),
        (3871, 3971, 3951),
    ]
    collapse_kernels = [tuple(kernel_alt(z) for z in row) for row in collapse_arms]
    assert collapse_kernels == [(2401, 361, 12321), (49, 361, 27), (49, 361, 9)]
    pair_tops = {
        tuple(gcd(a, b) for a, b in zip(collapse_kernels[i], collapse_kernels[j]))
        for i in range(3) for j in range(i + 1, 3)
    }
    assert pair_tops == {(49, 361, 9)}
    collapse_cat = catalogue_alt((49, 361, 9), (49, -361, -279), 389**2)
    assert collapse_cat == [((49, 361, 9), 86184, 1, Fraction(86184))]

    class_arms = [
        (1051, 26071, 21901),
        (1771, 26071, 22021),
        (5581, 51301, 43681),
    ]
    class_kernels = [tuple(kernel_alt(z) for z in row) for row in class_arms]
    assert class_kernels == [(1, 841, 121), (1, 841, 361), (1, 841, 43681)]
    assert tuple(gcd(a, b) for a, b in zip(class_kernels[0], class_kernels[2])) == (1, 841, 121)
    assert tuple(gcd(a, b) for a, b in zip(class_kernels[1], class_kernels[2])) == (1, 841, 361)

    graph_kernels = [900, 23716, 74529, 511225]
    graph_gcds = sorted(gcd(graph_kernels[i], graph_kernels[j]) for i in range(4) for j in range(i + 1, 4))
    assert graph_gcds == [4, 9, 25, 49, 121, 169]
    assert sum(x - 1 for x in graph_gcds) == 371

    beta_R = 199 * 277 * 2 * 13781
    assert beta_R == 1519300126
    beta_points = [(1, 1), (3, 2)]
    beta_arms = [
        (1 + beta_R * h,
         1 + beta_R * (h + 55124 * k),
         1 + beta_R * (h + 55123 * k))
        for h, k in beta_points
    ]
    assert beta_arms == [
        (1519300127, 83751419445751, 83749900145625),
        (4557900379, 167504358191627, 167501319591375),
    ]
    for row in beta_arms:
        assert gcd(row[0], row[1]) == gcd(row[0], row[2]) == gcd(row[1], row[2]) == 1
    beta_top = tuple(gcd(a, b) for a, b in zip((1, 1, 275625), (1, 1, 46690875)))
    assert beta_top == (1, 1, 55125) and 4 < product_int(beta_top)
    beta_cat = catalogue_alt(beta_top, (2, 55126, 55125), 4)
    assert len(beta_cat) == 34 and all(T == 1 for _, _, T, _ in beta_cat)
    beta_Q = sum((q for _, _, _, q in beta_cat), Fraction())
    beta_weight = product_int(phi_alt(x) for x in beta_top)
    assert beta_Q == 55122 and beta_weight == 25200
    assert beta_Q / beta_weight == Fraction(9187, 4200) > 2

    return {
        "period_catalogue": [(list(d), w, T, str(q)) for d, w, T, q in cat],
        "collapse_catalogue": [(list(d), w, T, str(q)) for d, w, T, q in collapse_cat],
        "two_maximal_class_kernels": class_kernels,
        "complete_graph_gcds": graph_gcds,
        "beta_above_two": {
            "top": beta_top,
            "catalogue_terms": len(beta_cat),
            "Q": str(beta_Q),
            "weight": beta_weight,
            "beta": str(beta_Q / beta_weight),
        },
    }


def run(command: list[str], cwd: Path) -> str:
    proc = subprocess.run(command, cwd=cwd, text=True, capture_output=True, check=False)
    if proc.returncode != 0:
        raise RuntimeError(
            f"command failed ({proc.returncode}): {' '.join(command)}\n{proc.stdout}\n{proc.stderr}"
        )
    return proc.stdout + proc.stderr


def main() -> None:
    arithmetic = verify_alt_arithmetic()
    canonical = run([sys.executable, "verify_canonical_boundaries.py"], HERE)
    abstract = run([sys.executable, "verify_abstract_sharpness.py"], HERE)
    beta = run([sys.executable, "verify_beta_inflation_witnesses.py"], HERE)
    assert "PASS canonical ownership/maximality boundaries" in canonical
    assert "PASS abstract complete-graph sharpness" in abstract
    assert json.loads(beta)["status"] == "PASS"

    grid_text = GRID_OUTPUT.read_text(encoding="utf-8-sig")
    grid = json.loads(grid_text.split("RESULT_JSON\n", 1)[1])
    assert grid["status"] == "PASS"
    assert grid["scan"]["cases"] == 2208
    assert grid["scan"]["errors"] == []
    assert grid["scan"]["exact_skeleton_all_pair_maximal_system_equalities"] == 2208

    lean_text = LEAN_FILE.read_text(encoding="utf-8")
    theorem_count = len(re.findall(r"^theorem\s+", lean_text, flags=re.MULTILINE))
    print_count = len(re.findall(r"^#print axioms\s+", lean_text, flags=re.MULTILINE))
    assert theorem_count == print_count == 24
    assert not re.search(r"^\s*(axiom|admit|sorry)\b", lean_text, flags=re.MULTILINE)
    assert "native_decide" not in lean_text

    audit_text = AXIOM_AUDIT_FILE.read_text(encoding="utf-8")
    audit_print_count = len(re.findall(r"^#print axioms\s+", audit_text, flags=re.MULTILINE))
    assert audit_print_count == theorem_count
    assert not re.search(r"^\s*(axiom|admit|sorry)\b", audit_text, flags=re.MULTILINE)

    report_bytes = REPORT.read_bytes()
    assert all(byte not in report_bytes for byte in (0, 12, 13))
    lean_output = run(
        ["lake", "env", "lean", "-DwarningAsError=true", str(LEAN_FILE.relative_to(LEAN_ROOT))],
        LEAN_ROOT,
    )
    audit_output = run(
        ["lake", "env", "lean", "-DwarningAsError=true", str(AXIOM_AUDIT_FILE.relative_to(LEAN_ROOT))],
        LEAN_ROOT,
    )
    assert "sorryAx" not in lean_output + audit_output

    result = {
        "arithmetic": arithmetic,
        "canonical_script": "PASS",
        "abstract_script": "PASS",
        "beta_script": "PASS",
        "grid_certificate": "PASS (2208 cases)",
        "lean_warning_as_error": "PASS",
        "theorems": theorem_count,
        "print_axioms": print_count,
        "separate_audit_print_axioms": audit_print_count,
        "custom_axioms": 0,
        "report_control_characters": 0,
    }
    print(json.dumps(result, indent=2))
    print("PASS independent ownership aggregation replay")


if __name__ == "__main__":
    main()
