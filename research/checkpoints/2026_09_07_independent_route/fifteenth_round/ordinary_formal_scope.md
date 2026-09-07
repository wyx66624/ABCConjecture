# Completed ordinary/formal scope for GD

Status: the ordinary proof has three full independent reviews. The fifteen
arithmetic declarations have now passed a fresh temporary-source/olean
build with warnings treated as errors and all fifteen axiom queries checked.
Only propext, Classical.choice and Quot.sound occur. This work belongs to
the fifteenth round and does not change the frozen fourteenth publication.

The new module has fifteen arithmetic declarations:

1. The actual integer Gaussian norm identity from
   B^2=A^3-9Ad^4-9d^6.
2. The actual integer real-quadratic norm identity from
   B^2=A^3-189Ad^4+999d^6.
3--6. Reduction of the first actual polynomial modulo an arbitrary modulus;
   its full Fin 27 table; transfer to signed integer congruences; and the
   actual primitive-curve conclusion 3 does not divide B from gcd(A,d)=1.
   The table is proved by kernel decide and includes no native axiom.
7. The opposite-isogeny rational-function curve identity, with T-9 nonzero.
8--9. The two explicit rational-function identities equating psi(phi(X,Y))
   with the previously displayed chord-law tripling expressions. Only the
   coefficient of Y is used for the second identity. All chart denominators
   are explicit nonzero hypotheses.
10--12. The Gaussian inverse norm, imaginary coordinate and real coordinate
   rational identities, on the T-9 nonzero chart.
13--15. The corresponding three real-quadratic inverse rational identities,
   on the X+3 nonzero chart.

This scope formalizes actual integer and rational arithmetic; it does not
formalize Euclidean domains or quadratic prime splitting, existence and
uniqueness of the field cube root, the group homomorphism delta, isogeny
degree, extension of curve maps, Mordell--Weil finite generation, exact rank,
a basis, or the rational points of the SS curve. Those remain the reviewed
ordinary mathematical argument. In particular the rational-function
tripling identities are not to be described as a fully formal isogeny
composition theorem on all projective curve points.

An existing exact standard-library replay separately checks eleven full
rational-function identities, the nontrivial unit-class witness, and all
mod-27 primitive model residues. It uses neither a floating calculation
nor a software rank upper bound. Its result is finite exact evidence and
is not substituted for any of the ordinary-only inputs above.


Fresh manifest: `verification/mathlib_validation.json`.
Source SHA-256: `283ba4559cfe8ffbc129f6b7a901921d9d7a179654874df5bf4087aad8cfa30d`.
Lean 4.32.0; Mathlib `81a5d257c8e410db227a6665ed08f64fea08e997`.
The retained tripling chart gap hypothesis is redundant to some of the
other nonzero conditions, but remains in both theorem signatures.
