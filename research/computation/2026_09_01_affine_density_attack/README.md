# Affine density attack finite replay

This bundle performs the finite all-square conic search described in
`research/ABC_AFFINE_DENSITY_ATTACK_2026_09_01.md`, Section 7.

The scan uses twenty explicitly printed primitive seeds with `R=rad(abc)<c`.
For each seed it enumerates every reduced rational parameter

```text
-500 <= p <= 500,  1 <= q <= 500,  gcd(|p|,q)=1.
```

It then checks, with Python arbitrary-precision integers:

- the conic identity `a*x^2+b*y^2=c*z^2`;
- ordering `0<x<z<y`;
- the three `1 mod R` congruences;
- reconstruction of positive minimal-step `h,k`;
- affine admissibility and all coprimalities;
- the exact output radical; and
- the strict test `rad(output)^4 < H^3`.

The captured result contains 49,671 distinct admissible all-square rows and no
three-quarter exception. This is a finite no-hit only. It is not a
counterexample to an eventual lower bound and proves no asymptotic statement.

Run `verify_square_conic.py` with Python 3.10 or newer. When `OUTPUT.txt` is
present, the script also checks that its regenerated body agrees byte for
byte and prints `captured_output_match=true`.
