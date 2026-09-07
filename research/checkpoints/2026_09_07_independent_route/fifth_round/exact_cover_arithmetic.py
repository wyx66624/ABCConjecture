"""Portable exact arithmetic underlying QC1--QC3; no geometric verification."""

from dataclasses import dataclass
from fractions import Fraction
from hashlib import sha256
from pathlib import Path
import json


@dataclass(frozen=True)
class Zeta:
    a: Fraction
    b: Fraction = Fraction(0)

    def __add__(self, other):
        if not isinstance(other, Zeta):
            other = Zeta(Fraction(other))
        return Zeta(self.a + other.a, self.b + other.b)

    def __mul__(self, other):
        if not isinstance(other, Zeta):
            other = Zeta(Fraction(other))
        return Zeta(self.a * other.a - self.b * other.b,
                    self.a * other.b + self.b * other.a + self.b * other.b)

    def conjugate(self):
        return Zeta(self.a + self.b, -self.b)

    def norm(self):
        return self.a * self.a + self.a * self.b + self.b * self.b


def multiply(f, g):
    out = [Zeta(Fraction(0)) for _ in range(len(f) + len(g) - 1)]
    for i, a in enumerate(f):
        for j, b in enumerate(g):
            out[i + j] = out[i + j] + a * b
    return out


def determinant(matrix):
    a = [[Fraction(x) for x in row] for row in matrix]
    result = Fraction(1)
    for i in range(len(a)):
        pivot = next((j for j in range(i, len(a)) if a[j][i]), None)
        if pivot is None:
            return Fraction(0)
        if pivot != i:
            a[i], a[pivot] = a[pivot], a[i]
            result = -result
        p = a[i][i]
        result *= p
        for j in range(i + 1, len(a)):
            q = a[j][i] / p
            for k in range(i + 1, len(a)):
                a[j][k] -= q * a[i][k]
    return result


def F(a, b):
    return a**4 + 3 * a**3 * b + 5 * a * a * b * b + 3 * a * b**3 + b**4


def main():
    d0 = Zeta(Fraction(-1), Fraction(-3))
    assert d0.norm() == 13
    assert d0.conjugate() == Zeta(Fraction(-4), Fraction(3))
    assert d0 * d0.conjugate() == Zeta(Fraction(13))
    q1 = [Zeta(Fraction(1)), Zeta(Fraction(2), Fraction(-1)), Zeta(Fraction(1))]
    q2 = [Zeta(Fraction(1)), Zeta(Fraction(1), Fraction(1)), Zeta(Fraction(1))]
    product = multiply(q1, q2)
    assert product == [Zeta(Fraction(n)) for n in [1, 3, 5, 3, 1]]
    assert q1[1] * q1[1] + (-4) == d0
    assert q2[1] * q2[1] + (-4) == d0.conjugate()

    f, derivative = [1, 3, 5, 3, 1], [4, 9, 10, 3]
    sylvester = []
    for shift in range(3):
        sylvester.append([0] * shift + f + [0] * (2 - shift))
    for shift in range(4):
        sylvester.append([0] * shift + derivative + [0] * (3 - shift))
    discriminant = determinant(sylvester)
    assert discriminant == 117

    primitive_mod3 = 0
    for a in range(3):
        for b in range(3):
            if a or b:
                assert F(a, b) % 3 == 1
                primitive_mod3 += 1

    primitive_mod169 = 0
    divisible13 = 0
    for a in range(169):
        for b in range(169):
            if a % 13 == b % 13 == 0:
                continue
            primitive_mod169 += 1
            value = F(a, b)
            if value % 13 == 0:
                assert a % 13 == b % 13
                assert value % 169 != 0
                divisible13 += 1

    # These are the finite algebraic inputs to the new fixed-field proof;
    # field degree, class numbers, unit heights, and rational-point claims
    # remain justified only by the separately reviewed ordinary arguments.
    result = {
        "scope": "Exact arithmetic only; not a field-degree, class-number, unit-lattice, Kummer, or ABC formalization.",
        "quadratic_factor_coefficients": [[str(x.a), str(x.b)] for x in product],
        "d0_norm": 13,
        "conjugate_discriminant_product": 13,
        "quartic_discriminant_via_sylvester": int(discriminant),
        "primitive_mod3_pairs": primitive_mod3,
        "primitive_mod169_pairs": primitive_mod169,
        "exact_depth_one_mod169_pairs": divisible13,
        "status": "PASS",
    }
    data = (json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode("utf-8")
    path = Path(__file__).with_name("exact_cover_arithmetic_results.json")
    path.write_bytes(data)
    print(json.dumps({"output": str(path), "sha256": sha256(data).hexdigest(), "status": "PASS"}))


if __name__ == "__main__":
    main()
