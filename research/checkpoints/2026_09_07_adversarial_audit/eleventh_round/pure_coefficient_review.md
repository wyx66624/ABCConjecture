# Independent review of the pure-coefficient integral converse

Date: 2026-09-07. CI1--CI2 ordinary proof read in full: PASS.
Source: `2026_09_07_independent_route/eleventh_round/pure_coefficient_inverse.md`.
Reviewed SHA256:
`5acf8bb3ca4e7d2f166a2b0afac788b3fec99058e2d3d46da5843a292b9c0531`.

The use of primitive homogeneous integer representatives covers every
projective rational input, including infinity. Such an input has
gamma-depth zero or one because gamma^2=3*zeta. After factoring out
that exact depth, the remaining element is primitive and unramified:
any common rational divisor of the quotient would also divide the
original primitive input. This step neither assumes the input is a
nonunit nor silently excludes a ramified input.

For a pure multiplier, the only possible content is the ramified one.
The formula gamma^E=3^floor(E/2)*zeta^floor(E/2)*gamma^(E mod 2)
has its unit factor and parity in the correct directions. The remaining
split factors have only one orientation each. Thus its content is
exactly one, and the full output content is exactly 3^floor(E/2).
There is no unaccounted split-prime cancellation analogous to PC.

Positive finite x gives a unique primitive pair a,b>0. The first
primitive output equals this pair up to common sign; the second equals
(ab,M) because gcd(ab,M)=1. This is the complete scalar accounting
needed for both norm identities. The actual quartic is prime to three,
so the second ramified parity vanishes. F>=13 excludes Q=1. If R=1,
then M<=3, hence a=b=1; F=13 cannot be a nontrivial integral g-th
power for g>=2. This excludes every unit or infinity degeneration
that could otherwise invalidate the asserted nonunit output norms.

The first ramified exponent is (e0+epsilon0*h) mod two. It equals e0
when h is even and may change when h is odd, exactly as the theorem
states. The surviving factors, including their units and the common
sign changes, give actual oriented unit-residual profiles. Nonunit
primitive unramified norms are at least seven. The converse, after
allowing the finite unit choices and both initial parities, follows
from the reviewed DC/RD actual forward construction. No uniqueness of
point, factorization or unit choices is asserted.

The QG3 source was checked again: it excludes both N(x)F(x) and
N(x)F(x)/3 from rational squares for positive rational x. Since
M*F=b^6*N(a/b)*F(a/b), this is precisely the combined integer-norm
obstruction invoked in CI2. If h and g are both even, the new pure
profiles would make M*F/3^e a rational square, a contradiction.
Thus the full positive finite-base rational locus is excluded in
this even/even pure-coefficient branch, with no input unramifiedness
assumption left over. No claim excludes boundary or negative base
points, points over other fields, or arbitrary other exponent pairs.

This result is consistent with PC's nonunit multiplier of norm seven:
its split-prime cancellation mechanism cannot occur with the pure
multipliers used here. It proves no uniform height bound or ABC result.
The review contains ordinary arithmetic and scope checking only, not
a new finite replay or Lean verification.
