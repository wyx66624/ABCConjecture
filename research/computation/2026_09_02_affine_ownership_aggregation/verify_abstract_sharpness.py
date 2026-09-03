from __future__ import annotations

import json

from ownership_aggregation import complete_graph_sharpness


def main() -> None:
    result = complete_graph_sharpness()
    assert result["maximal_tops"] == 6
    assert result["vertices"] == 4
    assert result["S"] ** 2 == result["E"] * result["H3"]
    assert result["beta_at_p2"] == "3/2"
    print(json.dumps(result, indent=2))
    print("PASS abstract complete-graph sharpness")


if __name__ == "__main__":
    main()
