from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parent


def main() -> None:
    data = json.loads((ROOT / "OUTPUT.json").read_text(encoding="utf-8"))
    if data["status"] != "PASS":
        raise SystemExit("search did not record PASS")
    if data["max_c"] != 6000:
        raise SystemExit("unexpected search cutoff")
    if data["primitive_nonunit_triples"] != 5_465_583:
        raise SystemExit("unexpected primitive-triple count")
    if data["corridor_failures"] != 0:
        raise SystemExit("canonical corridor failure recorded")
    if data["power_gain_gt_three"] != 14:
        raise SystemExit("unexpected power-gain counterexample count")

    row = data["exact_counterexample_3_125_128"]
    exact = row["exact_checks"]
    if (row["a"], row["b"], row["c"], row["radical"], row["product"]) != (
        3,
        125,
        128,
        30,
        48_000,
    ):
        raise SystemExit("named counterexample row changed")
    if not all(exact.values()):
        raise SystemExit("an exact named-counterexample check failed")
    if not 48_000 > 30**3:
        raise SystemExit("exact power-three comparison failed")

    print(
        json.dumps(
            {
                "status": "PASS",
                "cutoff": data["max_c"],
                "triples": data["primitive_nonunit_triples"],
                "corridor_failures": data["corridor_failures"],
                "power_gain_gt_three": data["power_gain_gt_three"],
                "exact_counterexample": [3, 125, 128],
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()

