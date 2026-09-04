# Exact prime-packet boundary transport audit

This directory freezes an exact adversarial and constructive audit of the
Prime-Packet Boundary Transport (`PBT`) objective.  It covers every normalized
positive primitive point

```text
1 <= a <= b,  a+b=c,  gcd(a,b)=1,  c<=3000.
```

The scan includes unit arms because `(1,p^2-1,p^2)` and the decisive
prime-predecessor mechanism are part of the route being audited.

## Exact model

For each `p^e || c` with `e>=2`, the code forms one source capacity
`p^(e-1)`.  Every distinct prime `q|ab` is one indivisible sink item.  If the
product of the items assigned to source `i` is `T_i`, exponentiating the
logarithmic packet residual gives

```text
R_factor = product_i max(p_i^(e_i-1) / T_i, 1).
```

The producer exhausts every assignment by dynamic programming on the capped
integer states `min(T_i,p_i^(e_i-1))`.  Maximizing the product of these capped
states is exactly equivalent to minimizing the logarithmic residual.  No
floating-point number chooses an assignment.  Ratio thresholds and grid
cells are certified by integer power comparisons such as

```text
R_factor^s >= rad(abc)^r.
```

The decimal ratios in `OUTPUT.json` are display values only.

## Frozen results

The exhaustive scan contains 1,368,094 triples.  It finds:

- 1,367,470 points with zero optimal residual and 624 with positive residual;
- 572 points where indivisibility makes the packet optimum strictly larger
  than the scalar positive-part defect;
- 567 points where that scalar defect is zero but the packet residual is
  positive;
- 58 unit-arm points with a prime predecessor and at least two powerful
  endpoint primes; all 58 have a pure indivisibility gap;
- the first such certificate `(1,71,72)`, with exact optimal residual factor
  `3`;
- the largest residual factor in the frozen exhaustive range,
  `(1,2591,2592)`, with factor `16`;
- the largest observed residual/conductor ratio in the exact grid enclosure
  `[5468/12000,5469/12000)`, attained in that cell by
  `(1,2400,2401)`, whose residual factor is `343/30` and conductor is `210`.

`STRUCTURED_FAMILIES.csv` adds 1,038 exact rows: 669 unit prime-square rows,
329 prime-hypotenuse Pythagorean-square rows, 35 smooth-power unit endpoints,
and five square-primorial prime-predecessor sanity checks.  For `k=2,...,6`,
the latter have residual factors `3,10,70,1260,4620`.  Those five rows are
finite checks of the mechanism in Theorem 5.1 of
`research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md`; they are
not used in its proof.

The same data also records the constructive side: more than 99.95 percent of
the frozen exhaustive points admit complete packet coverage.  This frequency
has no asymptotic force.  The theoretical audit gives a complete-premise
Linnik-family refutation of the exact uniform PBT gate, while leaving the
standard abc conjecture untouched.

## Reproduction

Run from the repository root with Python 3.10 or later:

```powershell
python research/computation/2026_09_03_prime_packet_boundary_transport/search_prime_packet_boundary.py `
  --cmax 3000 `
  --coarse-ratio-denominator 120 `
  --fine-ratio-denominator 12000 `
  --structured-prime-limit 5000 `
  --smooth-power-limit 8 `
  --output research/computation/2026_09_03_prime_packet_boundary_transport/OUTPUT.json `
  --structured-csv research/computation/2026_09_03_prime_packet_boundary_transport/STRUCTURED_FAMILIES.csv
```

Then run the independent full-domain validator and deterministic byte replay:

```powershell
python research/computation/2026_09_03_prime_packet_boundary_transport/validate_prime_packet_boundary.py `
  --directory research/computation/2026_09_03_prime_packet_boundary_transport
```

The validator does not import the producer.  It independently factors and
re-enumerates all 1,368,094 points, recomputes the packet optima with its own
state-set DP, checks all headline classifications and exact ratio cells,
validates every structured certificate, and finally reruns the producer in a
temporary directory and compares both artifacts byte for byte.

All frozen text artifacts use UTF-8 and LF line endings.  `SHA256SUMS.txt`
contains the final file hashes.  A bounded no-hit, a high success frequency,
or a growing finite pattern is never treated as a proof.
