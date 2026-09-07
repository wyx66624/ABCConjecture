"""Independent exact replay for counts, stopping towers and second-norm lifts."""
from math import gcd
from pathlib import Path
import hashlib
import json


def mul(z, w, modulus=None):
    x, y = z
    u, v = w
    result = x * u - y * v, x * v + y * u + y * v
    return result if modulus is None else tuple(t % modulus for t in result)


def power(z, exponent, modulus=None):
    result = (1, 0)
    while exponent:
        if exponent & 1:
            result = mul(result, z, modulus)
        z = mul(z, z, modulus)
        exponent //= 2
    return result


def boundary(z):
    x, y = z
    return x * y * (x + y)


def quartic(z):
    x, y = z
    return x**4 + 3*x**3*y + 5*x*x*y*y + 3*x*y**3 + y**4


def gradient(z):
    x, y = z
    return (4*x**3 + 9*x*x*y + 10*x*y*y + 3*y**3,
            3*x**3 + 10*x*x*y + 9*x*y*y + 4*y**3)


def lift_prime(p, period, initial, levels):
    step = power((2, 1), period, p*p)
    assert step[0] % p == 1 and step[1] % p == 0
    delta = ((step[0]-1)//p, step[1]//p)
    start = power((2, 1), initial, p)
    direction = mul(start, delta, p)
    grad = gradient(start)
    derivative = sum(x*y for x, y in zip(grad, direction)) % p
    assert derivative and quartic(start) % p == 0
    g = initial
    rows = []
    for depth in range(1, levels+1):
        modulus = p**(depth+1)
        remainder = quartic(power((2, 1), g, modulus)) % modulus
        assert remainder % p**depth == 0
        digit = (-remainder//p**depth * pow(derivative, -1, p)) % p
        jump = period*p**(depth-1)
        if p == 67 or depth <= 2:
            # Independently check uniqueness among every next digit.
            hits = [j for j in range(p)
                    if quartic(power((2, 1), g+j*jump, modulus)) % modulus == 0]
            assert hits == [digit]
        rows.append({"depth": depth, "g": g, "modulus": jump,
                     "next_digit": digit})
        g += digit*jump
    return {"p": p, "initial": initial, "period": period, "delta": delta,
            "initial_pair_mod_p": start, "derivative": derivative, "rows": rows}


def main():
    count_cases = 0
    for d in range(1, 32):
        for a in range(d):
            for N in range(101):
                count = 0 if N <= a else (N-1-a)//d+1
                hits = [n for n in range(N) if n % d == a]
                assert hits == [a+d*j for j in range(count)]
                assert d*count <= N+d-1 and N <= d*count+d-1
                count_cases += 1
    z = (1, 5)
    for n in range(101):
        assert z[0] % 25 == 1 and z[1] % 25 == 5
        assert boundary(z) % 25 == 5
        z = mul(z, (1, 50))
    modulus13_cases = 0
    for a in range(169):
        for b in range(169):
            if a % 13 == b % 13 == 0:
                continue
            F = quartic((a, b))
            assert (F % 13 == 0) == (a % 13 == b % 13)
            if F % 13 == 0:
                assert F % 169 != 0
            modulus13_cases += 1
    primary67 = lift_prime(67, 66, 1, 8)
    branch67 = lift_prime(67, 66, 21, 6)
    branch967 = lift_prime(967, 966, 651, 6)
    assert primary67["derivative"] == 22
    assert [r["g"] for r in primary67["rows"][:4]] == [1, 199, 9043, 7415893]
    assert branch67["derivative"] == 7 and branch67["rows"][1]["g"] == 1275
    assert branch967["derivative"] == 39 and branch967["rows"][1]["g"] == 77931
    assert 7413 % 66 == 21 and 7413 % 966 == 651
    for r in branch67["rows"]:
        for s in branch967["rows"]:
            assert gcd(r["modulus"], s["modulus"]) == 6
            assert (r["g"]-s["g"]) % 6 == 0
    raw199 = power((2, 1), 199)
    assert raw199[0] < 0 and raw199[1] < 0
    F199 = quartic(raw199)
    assert F199 % 67**2 == 0 and F199 % 67**3 != 0
    assert len(str(F199)) == 337
    payload = {"status": "passed, finite exact replay only",
               "residue_count_cases": count_cases, "stopping_orbit_rows": 101,
               "thirteen_modulus_cases": modulus13_cases,
               "primary67": primary67, "branch67": branch67, "branch967": branch967,
               "crt_initial_residue": 7413, "crt_initial_modulus": 10626,
               "g199_second_norm_digits": 337, "g199_exact_v67": 2,
               "g199_full_factorization_attempted": False}
    output = Path(__file__).parent / "verification" / "exact_results.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    # Seal identical UTF-8/LF bytes on Windows and Linux.
    output.write_bytes((json.dumps(payload, indent=2)+"\n").encode("utf-8"))
    print(json.dumps({"ok": True, "count_cases": count_cases,
                      "mod13_cases": modulus13_cases,
                      "sha256": hashlib.sha256(output.read_bytes()).hexdigest()}))


if __name__ == "__main__":
    main()
