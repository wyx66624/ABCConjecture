#!/usr/bin/env python3
"""Independent numerical checks for the actual-Haar normalization note.

The proofs live in Lean.  This script only makes the coefficient bookkeeping
and the full-premise raw-Haar counterexample easy to reproduce.
"""

from __future__ import annotations

import json
import math


def close(x: float, y: float, tol: float = 1e-12) -> bool:
    return abs(x - y) <= tol * max(1.0, abs(x), abs(y))


def main() -> None:
    rows: list[dict[str, float | int | bool]] = []
    for p in (2, 3, 5, 17, 101):
        for e, f in ((1, 1), (1, 2), (2, 1), (3, 4)):
            logp = math.log(p)
            q = p**f
            raw_shift = e * math.log(q)
            predicted_raw = e * f * logp
            normalized_shift = raw_shift / (e * f)
            row = {
                "p": p,
                "e": e,
                "f": f,
                "q": q,
                "raw_shift": raw_shift,
                "predicted_raw": predicted_raw,
                "normalized_shift": normalized_shift,
                "log_p": logp,
                "raw_identity": close(raw_shift, predicted_raw),
                "normalized_identity": close(normalized_shift, logp),
            }
            assert row["raw_identity"]
            assert row["normalized_identity"]
            rows.append(row)

    p = 2
    raw_counterexample = {
        "p": p,
        "weights": [1.0],
        "weight_sum": 1.0,
        "ramification_indices": [1],
        "residue_degrees": [2],
        "raw_shift": math.log(p**2),
        "claimed_shift": math.log(p),
    }
    raw_counterexample["strict_counterexample"] = not close(
        raw_counterexample["raw_shift"], raw_counterexample["claimed_shift"]
    )
    assert raw_counterexample["strict_counterexample"]

    packet_weights = [0.2, 0.3, 0.5]
    normalized_packet_shift = sum(w * math.log(p) for w in packet_weights)
    packet = {
        "p": p,
        "weights": packet_weights,
        "weight_sum": sum(packet_weights),
        "normalized_packet_shift": normalized_packet_shift,
        "log_p": math.log(p),
        "packet_identity": close(normalized_packet_shift, math.log(p)),
    }
    assert packet["packet_identity"]

    print(
        json.dumps(
            {
                "status": "PASS",
                "raw_and_normalized_rows": rows,
                "raw_weight_sum_counterexample": raw_counterexample,
                "normalized_packet_check": packet,
            },
            indent=2,
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
