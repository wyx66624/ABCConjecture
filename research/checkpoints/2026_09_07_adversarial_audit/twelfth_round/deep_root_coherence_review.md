# Independent ordinary review of MC1--MC4

Date: 2026-09-07. Full ordinary proof review PASS, including the strengthened
lower cutoff Y=6n^3 and the separate exceptional-set terms. Eleventh-round
files remain frozen; this review belongs entirely to round twelve.

Source: `2026_09_07_critical_bottleneck/twelfth_round/deep_root_multiplicative_coherence.md`.
Reviewed SHA256:
`3ec67af4b4b460cdb066228a57bbad044dca40582ae30a9cec9333a1824b4234`.

## Finite-ring and actual-coordinate inputs

The domain is prime n>=7, B=n^4, actual integer k in [B,2B), and q>Y=6n^3.
At a supported q the quadratic norm is a unit: the inert case would
otherwise annihilate the pair with second coordinate one, and in the
split case exactly one nonzero component would contradict the cubic
boundary identity. Its scalar 3 sqrt(-3) is a unit modulo q^4.
Consequently the actual ratios lie in a single norm-one 3n-torsion group.
In both split and inert unramified rings, reduction injects this group
into at most 3n roots modulo q, since q does not divide 3n and the
polynomial derivative is a unit. The proof does not replace actual
integers by uniform samples of that group.

An equality of pair products clears unit denominators to the actual
integer determinant

    (ab-1)(c+d+1)-(cd-1)(a+b+1).

Its absolute value is at most 864B^3. The improved cutoff gives
q^4>1296B^3, so it is zero. Here a,b,c,d are explicitly root parameters,
not the entries of the original ABC triple. No integer denominator or
infinite-phase exception is hidden: r=ab-1 and s=a+b+1 are positive.
For the reduced phase u/v, the bounds u<=36B^2 and v<=12B are valid.

The identity (va-u)(vb-u)=u^2+uv+v^2 has positive integer factors because
u/v<min(a,b). The right side is between one and 2500B^4. Choosing its
first positive divisor determines both ordered parameters uniquely,
including diagonal and exchanged pairs. Thus a phase has at most tau(K)
ordered pairs. The elementary divisor estimate is proved from finitely
many small-prime constants and the elementary large-prime bound; its
constant depends only on the fixed positive epsilon.

## Root count and simultaneous interval

There are |A_q|^2 ordered pairs and at most 3n product classes. Every
class has just one actual rational phase, giving the uniform bound
|A_q|<=C_epsilon sqrt(n) B^(2epsilon). This is an actual short-block
count at fixed fourth depth, not a count of every residue modulo q^4.

The rank-one alternative cannot have depth two, since the two old
factors a,a+1 are coprime and individually below 6B+1<q^2. Exponent
lifting is absent at q>n. Therefore every nonempty A_q has rank n and
q is in one of the two eligible classes modulo 3n. The established
two-progression Brun--Titchmarsh bound then gives exactly the stated
order Z B^(2epsilon)/(B sqrt(n) log(Z/(3n))) after a union over actual
root sets. No independence of primes is used.

For fixed 0<delta<1/2, Z=floor(B n^(1/2-delta)) and epsilon=delta/16
give exponent -delta+8epsilon=-delta/2. The sufficiently-large-prime
domain is explicit. The result holds simultaneously at every supported
prime in (Y,Z], so that entire interval has the exact nonpositive signed
contribution -2 times depth-one radical mass minus depth-two radical
mass. Depth three contributes zero. This is an actual proven membership
interval; the remaining farther interval is not covered by this count.

## Low-prime mass and remaining gate

At Y=6n^3, the previously reviewed full-mass mean's three prime-index
terms are O(log n/n), O(1/(n log n)), and O(1/n). The elementary 2/3
contribution is O(1/n). Markov at eta=sqrt(log n/n) has exceptional
fraction O(eta). Intersecting with the fourth-depth union set must retain
O_delta(eta+n^(-delta/2)/log n), as the source does: the slower-decaying
second term has not been absorbed into eta.

The resulting global signed inequality and radical lower bound retain
the actual far signed cost W_delta, with only its positive part needed
for the displayed lower bound. The elementary angular term gives the
correct 4/(3n), and the small-mass allowance gives eta/3. The proof uses
the full-mass estimate only at Y; it does not transfer SQ3's almost-full
far-mass conclusion to the new, much larger cutoff. No lower bound for
the interval's full mass or negative credit has been obtained, and the
farther tail and individual exceptional roots remain unresolved.

This is ordinary proof review. No finite replay or Lean execution for
this new theorem is claimed by the reviewer. The finite-ring, elementary
integer, and previously reviewed sieve dependencies are explicit; no
new unverified stronger distribution estimate is invoked.
