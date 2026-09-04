# Three-arm incidence successor computation

This directory contains the bounded adversarial search supporting
`research/ABC_THREE_ARM_INCIDENCE_SUCCESSOR_2026_09_03.md`.

Run from the repository root:

```powershell
python research/computation/2026_09_03_three_arm_incidence_successor/search_three_arm_successor.py --cmax 1200 --rmax 12 --tmax 80
```

The run enumerates every unordered positive primitive triple
(a\le b, a+b=c\le1200), every support face of each triple, the balanced
two-prime rows (1\le r\le12), and the Pythagorean-square rows
(1\le t\le80).

Integer factorization, face products, coverage, radicals, defects, and gcd
tests are exact. Floating-point logarithms are used only for finite weighted
flow values and ranking. For each face the descending nested-neighborhood
greedy value is checked against the independent Hall upper-tail min-cut
formula. The script also contains the regression case
`sources=[(5,1),(2,1)], sinks=[(3,1)]`, whose optimum unmatched mass is one.

`OUTPUT.json` contains parameters, semantics, counts, extremal actual rows,
and every tested family row. `OUTPUT.csv` contains the balanced and
Pythagorean family tables. A bounded no-hit search proves no asymptotic claim.
The later prime-square proof retires CT-3C independently of this computation.
