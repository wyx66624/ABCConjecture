"""Run the independent GP/Sturm check and seal canonical exact output.

The GP engine supplies exact modular-form coefficients.  Mathematical
twist membership and Sturm's theorem are separate ordinary inputs.
"""
from argparse import ArgumentParser
from hashlib import sha256
from pathlib import Path
import json
import os
import subprocess


def main():
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    source = Path(__file__).with_suffix(".gp").resolve()
    if os.name == "nt":
        task_path = "/mnt/" + source.drive[0].lower() + source.as_posix()[2:]
        command = ["wsl", "-d", "Ubuntu-24.04", "--", "gp", "-q", "-f", task_path]
    else:
        command = ["gp", "-q", "-f", str(source)]
    run = subprocess.run(command, capture_output=True, text=True, encoding="utf-8", timeout=240)
    assert run.returncode == 0, (run.returncode, run.stdout, run.stderr)
    # GP can continue after a top-level error and still exit zero.  Reject
    # every unexpected stderr line rather than trusting only the sentinel.
    unexpected = [s for s in run.stderr.splitlines() if s.strip() and
                  not ("Warning:" in s and "stack size" in s)]
    assert not unexpected, unexpected
    lines = [s for s in run.stdout.splitlines() if s.strip()]
    assert lines[-1] == "INDEPENDENT_TWIST_STURM_PASS", lines
    assert '["VERSION", [2, 15, 4]]' in lines
    assert '["STURM", 36864, 73728, 12288]' in lines
    assert '["ALL_COEFFICIENTS", 0, 12288, "MINUS8_SIGMA7_PASS", "PLUS8_SIGMA5_PASS"]' in lines
    assert '["FOUR_COORDINATE_COMPARISONS", 98312]' in lines
    result = {
        "status": "PASS",
        "scope": "exact software coefficient equalities through the complete common-level Sturm bound; separate ordinary twist and Sturm inputs; not a Lean proof",
        "gp_source_sha256": sha256(source.read_bytes()).hexdigest(),
        "stdout_lines": lines,
    }
    payload = (json.dumps(result, indent=2, sort_keys=True)+"\n").encode("utf-8")
    target = source.with_name("independent_twist_results.json")
    if args.check:
        assert target.read_bytes() == payload, "canonical certificate differs"
    else:
        target.write_bytes(payload)
    print(json.dumps({"status": "PASS", "sha256": sha256(payload).hexdigest(),
                      "coefficient_indices_per_identity": 12289,
                      "rational_coordinate_comparisons": 98312}, sort_keys=True))


if __name__ == "__main__":
    main()
