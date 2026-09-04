# Exact SCRT-0 and FCRT finite audit

This directory contains a reproducible, exact finite computation for the
shared CRT boundary in
`research/ABC_SHARED_CRT_INCIDENCE_SUCCESSOR_2026_09_03.md` and for the
candidate surplus-token successor FCRT.

Every optimization choice is made over integers and `Fraction` values.  The
decimal logarithms in `OUTPUT.json` are display values only.  The computation
does **not** prove or refute SCRT-0, FCRT, or the standard abc conjecture.

## Exact multiplicative model

For `p^e || c`, `e>=2`, source `p` has capacity

```text
d_p = p^(e-1).
```

Each distinct external prime `q|ab` is a sink of capacity `q`.  For nonempty
source and sink masks `(S,T)`, the producer computes the complete arm factors
`a_T,b_T` and tests

```text
compatible:  product(p^e, p in S) divides a_T+b_T,
saturated:   product(d_p, p in S) <= product(q, q in T).
```

It enumerates every compatible saturated block and every union obtainable
from blocks with pairwise-disjoint source and sink masks.  For each union it
solves the remaining exclusive packet problem exactly.  If source `p`
receives a sink product `Q_p`, then

```text
exp(B_SCRT) = product_p max(d_p/Q_p, 1).
```

The primary exclusive optimizer is a capped-product dynamic program.  Capping
at `d_p` is exact because every later item has multiplicative weight at least
one.

FCRT enumerates every disjoint block **family**, rather than retaining only a
union mask.  A selected saturated block `(S,T)` has available surplus factor

```text
tau(S,T) = rad(T)/product(d_p, p in S).
```

The block may emit at most one unsplit, one-target token to a remaining source
`p` precisely
when some nonempty proper mask `U` of `T` satisfies

```text
p^e divides a_U+b_U.
```

For that target and witness the emitted token's delivered factor is

```text
min(tau(S,T), rad(U)).
```

The optimizer takes the largest exact delivered factor among all eligible
`U` and records the attaining subset.  Any part of the surplus above this cap
is discarded and cannot become another token.  This proper-subset cap matters
when the incidence witness is smaller than the total surplus.

Residual sinks and several eligible tokens may have the same source owner.
A consumed sink never reappears as a residual item, so its logarithmic mass is
charged once.  Exact mass bookkeeping gives the pointwise sandwich

```text
scalar defect <= FCRT <= SCRT <= PBT.
```

## Four required exact comparisons

The table gives logarithmic boundaries.  Equivalently, the fractions inside
`log` are the exact residual factors stored in the artifacts.

| point | scalar `Delta` | PBT | SCRT | FCRT |
|---|---:|---:|---:|---:|
| `(1,675,676)` | `log(26/15)` | `log 2` | `log 2` | `log(26/15)` |
| `(1,224,225)` | `log(15/14)` | `log(3/2)` | `log(3/2)` | `log(3/2)` |
| `(343,625,968)` | `log(44/35)` | `log(11/7)` | `log(11/7)` | `log(44/35)` |
| `(1,65024,65025)` | `log(255/254)` | `log(15/2)` | `log 3` | `log(3/2)` |

At `(1,675,676)`, the PBT/SCRT optimum assigns both sinks `3,5` to source
`13`, closing it and leaving source `2` with factor `2`.  FCRT instead chooses
the saturated block

```text
S={13}, T={3,5}, surplus=15/13.
```

The proper subset `U={3}` is eligible for source `2`, since
`4 | 1+3^3 = 28`.  Assigning the token to `2` leaves the exact factor
`2/(15/13)=26/15`, attaining the scalar lower bound.

At `(1,224,225)`, all three models attain `3/2` by assigning `2` to source
`3` and `7` to source `5`.  The saturated full-sink singleton blocks have
surpluses, but neither has a nonempty proper subset eligible for the other
source.  Thus the FCRT fragmentation factor remains
`(3/2)/(15/14)=7/5`.

At `(343,625,968)`, PBT and SCRT assign `5` to source `2` and `7` to source
`11`, leaving `11/7`.  FCRT chooses

```text
S={11}, T={5,7}, surplus=35/11.
```

Here `U={7}` is eligible for source `2`, because `8 | 343+1 = 344`.
Giving that token to `2` leaves `4/(35/11)=44/35`, again the scalar lower
bound.  This is a new finite observation about FCRT; it has no asymptotic
force.

The out-of-range hard witness `(1,65024,65025)` has

```text
65025=3^2*5^2*17^2,  65024=2^9*127.
```

PBT assigns the two sinks to the three source bins and has exact factor
`15/2`.  SCRT chooses the saturated full-sink block

```text
S={5,17}, T={2,127}, surplus=254/85,
```

leaving source `3` with factor `3`.  For FCRT the proper subset `U={2}`
satisfies `9 | 1+2^9 = 513`, but caps the reusable factor at `rad(U)=2`.
The remaining source therefore contributes `3/2`.  This gives the strict
four-layer chain

```text
255/254 < 3/2 < 3 < 15/2
scalar      FCRT  SCRT  PBT.
```

## Frozen bounded scan

The exhaustive domain is

```text
1 <= a <= b,  a+b=c,  gcd(a,b)=1,  c<=3000.
```

It contains 1,368,094 triples.  The proved easy strata settle all but six
points; both programs directly enumerate every block family and residual
assignment at those six points:

```text
(1,224,225), (1,675,676), (343,625,968),
(1,2303,2304), (125,2187,2312), (99,2401,2500).
```

The exact counts are:

- 57 points have positive SCRT boundary and 57 have positive FCRT boundary;
- 5 points have SCRT strictly above the scalar defect;
- FCRT strictly improves 3 of those 5 and reaches the scalar lower bound at
  `(1,675,676)`, `(343,625,968)`, and `(99,2401,2500)`;
- the two remaining finite FCRT fragmentation points are `(1,224,225)` and
  `(1,2303,2304)`;
- the largest exact FCRT fragmentation factor over the scalar factor is
  `7/3`, at `(1,2303,2304)`;
- the largest exact residual factor is `343/30`, at `(1,2400,2401)`.  This is
  a one-source point, so PBT, SCRT, and FCRT all equal the scalar defect;
- the largest FCRT improvement factor over SCRT is `3/2`, at
  `(99,2401,2500)`.

The maximum observed `B/log(rad(abc))` lies in the exactly certified grid cell
`[5468/12000,5469/12000)` and is represented by `(1,2400,2401)`.  A bounded
maximum is not a uniform estimate.

## Structured finite tests

`STRUCTURED_FAMILIES.csv` contains 154 fully factored exact rows:

- 23 points `(2,15^n-2,15^n)`, `2<=n<=24`;
- 63 unit-arm composite-base powers for bases
  `6,10,12,15,18,30,42` and exponents `2,...,10`;
- 20 balanced points `(4^r,3^r,4^r+3^r)`, `1<=r<=20`;
- 38 mixed-power generalized-Fermat-style points with at least two powerful
  endpoint primes;
- 5 finite prime-predecessor Linnik representatives;
- 4 finite shifted `ell == -2 mod M^2` representatives.
- the forced out-of-range hard witness `(1,65024,65025)`.

All nine finite Linnik representatives have zero SCRT and FCRT boundary, as
predicted by the full saturated block.  In the exact `15^n` rows, only `n=14`
has positive boundary, and PBT/SCRT/FCRT all equal its scalar factor

```text
1946195068359375 / 305685089271106.
```

The progression exponent `n=284` is recorded separately in `OUTPUT.json`.
The elementary computation certifies `v_31(15^284-2)=2`, but the 335-digit
external arm was not completely factored.  Therefore no exact optimum is
claimed for that point.  Replacing the unknown cofactor by one presumed prime
would not be a valid SCRT/FCRT computation.

Several finite structured rows retain a fragmentation gap, including the
composite-base point with base `15`, exponent `10`, and the mixed-power point
`17^2+12^4=21025`.  These are adversarial test cases only.  No result here
shows an unbounded lower bound of the form needed to refute SCRT-0 or FCRT.

## Independent validation

`validate_shared_crt_exact.py` does not import the producer.  It uses a
different exhaustive algorithm: recursively enumerate every disjoint block
family, then directly enumerate every residual sink/token owner word.  It
independently rechecks:

- all 1,368,094 bounded triples and all six hard configurations;
- all 154 structured rows;
- all detailed certificates and the four forced regressions;
- compatible/saturated block counts and disjoint-family counts;
- a deterministic byte-for-byte producer replay.

The frozen validation status is `PASS`.  See `VALIDATION.log` for the complete
summary.

## Reproduction

From the repository root:

```powershell
python research/computation/2026_09_04_shared_crt_exact/search_shared_crt_exact.py `
  --cmax 3000 `
  --ratio-grid-denominator 12000 `
  --generalized-base-max 20 `
  --generalized-value-max 10000000 `
  --output research/computation/2026_09_04_shared_crt_exact/OUTPUT.json `
  --structured-csv research/computation/2026_09_04_shared_crt_exact/STRUCTURED_FAMILIES.csv

python research/computation/2026_09_04_shared_crt_exact/validate_shared_crt_exact.py `
  --directory research/computation/2026_09_04_shared_crt_exact
```

`SHA256SUMS.txt` records hashes of the final scripts, outputs, report, and
logs.  Finite exact evidence is kept separate from the unbounded proof burden:
only a complete-premise family for which
`B-epsilon*log(rad(abc))` is unbounded for some fixed positive `epsilon` can
refute either quantified gate.
