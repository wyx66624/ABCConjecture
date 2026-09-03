from __future__ import annotations

import json

from ownership_aggregation import analyze_selected


def main() -> None:
    cases = {
        "period_direction": analyze_selected(7, 400, [(349, 301), (358, 73)]),
        "three_pair_collapse": analyze_selected(
            4, 390, [(240, 248), (289, 166), (387, 2)]
        ),
        "one_class_two_tops": analyze_selected(
            5, 254, [(35, 139), (59, 135), (186, 254)]
        ),
    }

    period_case = cases["period_direction"]
    assert period_case["maximal_tops"] == 1
    assert period_case["repeated_nonarm_labels"] == 2
    # The exact owned mass and energy force the two periods 1 and 3.
    assert period_case["S_non"] == "445280/3"
    assert period_case["E_non"] == "445280"
    assert period_case["tops"][0]["r"] == 2
    assert period_case["tops"][0]["Q_exact"] == "445280/3"

    collapse = cases["three_pair_collapse"]
    assert collapse["all_pair_tops"] == 1
    assert collapse["maximal_tops"] == 1
    assert collapse["tops"][0]["r"] == 3
    assert collapse["S_non"] == "86184"
    assert collapse["E_non"] == str(8 * 86184)
    assert collapse["H3_exact_full_caps"] == str(86184 // 8)

    two_tops = cases["one_class_two_tops"]
    assert two_tops["maximal_tops"] == 2
    supports = [set(t["support"]) for t in two_tops["tops"]]
    assert len(supports[0] & supports[1]) == 1
    assert {t["Q_exact"] for t in two_tops["tops"]} == {"89320", "277704"}

    print(json.dumps(cases, indent=2))
    print("PASS canonical ownership/maximality boundaries")


if __name__ == "__main__":
    main()
