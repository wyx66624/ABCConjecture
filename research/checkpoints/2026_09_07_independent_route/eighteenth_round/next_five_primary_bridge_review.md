# Independent five-primary bridge and the complete F13 table

2026-09-07, next-only. This records a fresh read of the frozen QL2
and an independent derivation/computation, not a review of an unseen
parent manuscript. No publication source is changed.

## The saturation bridge is valid without a computed global basis

QL2 explicitly proves that each E_i(Q) is torsion-free of rank one,
and that the index of ZP_i is finite and prime to five. The proof
uses local nondivisibility by five; this is stronger than merely
saying the subgroup is dense. I actually reread that whole section.

Choose an abstract generator G_i of the free rank-one rational group,
and write P_i=d_i G_i, Q_i=n_i G_i. Then d_i is an integer prime
to five, and

    m_i=log(Q_i)/log(P_i)=n_i/d_i in Z5.

This uses the proved nonzero logarithm of P_i. It does not require
finding G_i, knowing d_i, or declaring P_i itself to be a generator.
If a good auxiliary prime has #E_i(F_l)=5h_i with 5 not dividing h_i,
then h_i red(G_i) is killed by five. Reduction is a group homomorphism,
so

    h_i red(Q_i)=(m_i mod5) h_i red(P_i).             (FP1)

In detail, multiply the identity P_i=d_iG_i by h_i after reduction;
d_i is invertible on the group killed by five. Multiplying its
inverse by n_i gives exactly the residue of n_i/d_i. The same proof
works at higher 5-primary exponent with the corresponding modulus.
There is no omitted rational torsion term, because QL2 excluded it.

For an extra UD zero, s=4 mod5 on its representative disk. The
already certified complete logarithm congruences give

    m_1=(4+4s)/4=0 mod5,
    m_2=(3+s)/2=1 mod5.

The involutions from DS give (m_1,m_2)=(0,+/-1) on the whole extra
orbit. Thus at l=13, where both elliptic groups have order15,
every hypothetical rational point in that orbit must have

    [3]red(R1)=O,       [3]red(R2)=+/−[3]red(P').     (FP2)

## Independent complete finite calculation

I wrote `next_replay_thirteen_sieve_peer.py` without reading or
importing the parent's probe. It imports no elliptic helper, PARI,
or Sage. It enumerates every x,y pair over F13. Its group law takes
the chord/tangent line, forms its intersection cubic, divides by
the two known roots (retaining the tangent multiplicity), and
negates the remaining intersection ordinate.

The actual write and `--check` both passed. The canonical file
`next_thirteen_sieve_peer.json` has SHA256
`c09d0ec464455d095aea01792fa3c92af7b82ab8ca1760f1c2e7c5c3bce1d725`.

It independently gives #E1(F13)=#E2(F13)=15, #C(F13)=16, and
[3]P'=(11,2). Both projected base points have order exactly five,
checked by all five successive multiples. The complete sixteen-row
table has **zero** occurrences of either pair in FP2.

The sextic derivative Euclidean sequence is included and gives gcd1
over F13, so square-freeness is geometric, not just the absence of
rational singularities. The two infinity branches have v=+/-1 and
are smooth. Both quotient models have unit discriminant at thirteen.

The exceptional quotient values are included explicitly. At z=0,
R1=(-9/4,W/8) and R2=O; the ordinate is a unit since W^2=-9 !=0
mod13. At infinity with v=W/z^3=+/-1, R1=O and
R2=(33/4,-9v/8). These also follow directly by valuation for a
rational point specializing to either fiber. At all other finite
points the displayed denominators are units, so the finite maps
are the reductions of the actual rational quotient maps.

Consequently the finite table contradicts the necessary condition
FP2 for every hypothetical rational extra UD zero. This excludes
that extra orbit by a genuine rational-group/reduction bridge,
not by interpreting an arbitrary five-adic point as an integer
multiple of the displayed base points.

Together with the full four-orbit analytic certificates this leaves
only the six known rational points on this fixed C. The parent's
complete final classification proof should still assemble the
precise input chain and undergo full peer review. This record does
not transfer such a fixed-curve result to arbitrary exponents,
residuals, or a uniform ABC height statement.

## Subsequent full review of the assembled root SM1--SM3

I then actually read root's complete `next_fixed_curve_rational_points.md`.
The assembled ordinary classification proof is **PASS**. Its
source SHA256 is `d74cdd8f7da9261b17e40cb8e76e13e38645a2b370216d74e49fc32fd09b3fab`.
Its integer
finite-index relation proves the same bridge as FP1 without choosing
a computed basis. The entire sixteen-row table agrees entry by entry
with the independent certificate above, and I also checked the short
sextic/derivative Bezout identity coefficient by coefficient modulo13.

The final proof distinguishes the finite nonzero chart, the irrational
zero fiber, and the two directly treated rational infinity points.
Every rational point is therefore covered without extending an affine
height identity at a missing divisor by assertion. The four complete
analytic certificates and symmetry supply precisely ten local zeros;
the four extras have the stated logarithm residues and fail the global
five-primary sieve. The six surviving points are explicitly verified.
No missing saturation, torsion, projective fiber, or uniformity claim
was found. This is an ordinary/software-assisted result, not a full
Lean proof of the p-adic/Jacobian/height chain.
