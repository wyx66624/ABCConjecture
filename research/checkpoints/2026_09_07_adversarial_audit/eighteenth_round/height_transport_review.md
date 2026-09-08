# HT1--HT4 independent ordinary, primary-source, and finite review

Status: PASS. I actually read the complete ordinary argument, both replay
sources, and the relevant pinned C source. I then independently executed
`replay_height_transport.py --check`; it returned PASS with canonical SHA256
`70ec75594f205336757496605750b1302e5f3b271afd6acf5b12275a36c9de05`.

Reviewed ordinary source SHA256:
`545f8dc98bbdd37d6b0b270392a5ecd1f72fe9731b491e7bcc00b2776aa1f3e9`.
The source is `research/checkpoints/2026_09_07_independent_route/eighteenth_round/height_transport.md`.

## Mathematical scope

Both changes X=4x+r,Y=8y, with r=9,-33, give the displayed elliptic models
by substitution. The minimality argument from integral discriminant valuations
below 12 is valid. On differentials, pullback sends omega_F to omega_E/2 and
eta_F to 2eta_E+(r/2)omega_E. This proves the stated unit-root slope transport
and logarithm scaling. The sigma quotient scales by 1/2, whose four factors
cancel in the local pairing; the remaining places use intrinsic minimal local
models. Thus the global diagonal height is invariant and alpha scales by 4.
The treatment does not identify arbitrary local software outputs or tangential
constants with the global invariant.

The convention conversion from the MST introductory h_p and log_p/p to the
diagonal pairing with character log_5 gives exactly -2 log(sigma/d)/m^2.
There is no residual factor of 5 or sign ambiguity in that conversion. The
rank-one use of any infinite-order point is legitimate; no global generator
claim enters it.

The ninth-multiple denominator normalization, nonsingular reduction at 2 and 3,
and formal parameter of valuation one justify m=9 in the sigma formula. Odd
integral sigma gives sigma(t)/t=1+O(t^2), controlling the whole omitted tail.
For a 5-adic unit a, log(a)=(a^4-1)/4 modulo 25. These facts prove the exact
height residues 5 and 10, and the valuation-one naive discrepancy. This is
stronger evidence than matching two software precisions.

## Sources actually inspected

I opened [MST's author-hosted paper](https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/a/189/files/2023/01/Computation-of-p-Adic-Heights-and-Log-Convergence.pdf),
equation (1.1), Theorem 1.3 and Sections 2.3--2.6. These supply the normalization,
integral sigma characterization, four-point quotient and extension of the global
pairing. I opened [Balakrishnan--Dogra](https://arxiv.org/pdf/1601.00388), Algorithm
8.3 and printed page 35: the character and twice-Silverman convention agree,
while local value sets and zero certification are additional tasks.

I also opened the [official PARI documentation](https://pari.math.u-bordeaux.fr/dochtml/html-stable/Elliptic_curves.html)
for ellchangecurve, ellpadicheight and ellpadics2. For the version-specific raw
formula I used the retained **2.15.4** source, not current documentation as a
substitute. I actually read ellpadic.c lines 426--438 and 688--748 and
elliptic.c lines 4993--5016. They implement A=(a+rb)/u, B=ub after minimal-model
reduction. Its inverse gives the displayed exact recovery formula. The naive
A-s_F B therefore fails for these inputs for an algebraic reason; this is not
a claim about every PARI version.

## File and execution bindings

The retained official archive SHA256 is
`c3545bfee0c6dfb40b77fb4bbabaf999d82e60069b9f6d28bcb6cf004c8c5c0f`.
The inspected ellpadic.c SHA256 is
`a58ba83ae7d8dfbe218879418b98fe289a545d63cb446f713d2a0182bede930a`;
elliptic.c is
`d84cc519eababd40f45b69e1a7a68389861c763857d3d75b8030690836049cc1`.
Python replay SHA256:
`8628c32ddd775ed13d45f7b7d518e27ad3ae414ae373f4315947a012362d8515`.
GP replay SHA256:
`8e4f09237c83aade53d3ac9f22c6f5174dca440548a9817bd1d1e7ef472c6426`.

The replay proves finite integer and rational checks directly, and checks
explicit PARI p-adic balls at precisions 12 and 24 to their stated common
absolute precision. It does not formally verify the sigma/Frobenius algorithms.
No complete local-height value set, QC zero set, Mordell--Weil sieve, rational
point classification, or Lean theorem is inferred from these checks.
