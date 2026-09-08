# Independent review of CC1--CC4

Status: complete ordinary proof and cited primary analytic input PASS.
The source is critical_bottleneck/seventeenth_round/collective_norm_content.md.
No change to the author's mathematical source was requested.

The oriented ideal valuations in CC1 are actual valuations of primitive
unramified Eisenstein roots. For the canonical signed product, their sum
and difference are U and D, so its rational content depth is exactly
(U-|D|)/2. This also proves the primitive norm formula and covers the
empty vector. It does not require multiplicative independence.

The support cutoff in CC2 correctly uses two distinct root indices.
If the same split rational prime occurred in both orientations, primitiveness
excludes its coming from one root. A common prime divides
3(k-l)(3(k+l)+1); both nonzero factors have absolute value below p when
p>12B-5. For a canonical signed vector, conjugation merely changes the
orientation at each index, so the same restriction applies. The warning
about noncanonical w_k times its conjugate is essential and accurate.

For CC3, each of the two split-prime root towers is simple and has one
residue per prime-power precision. Summing the interval counts through
h_p gives the H/(p-1) term with error h_p+1. The omitted geometric tail
is less than one uniformly in interval length and position. Applying the
same bound to the minimum is legitimate. Summing up to 12B captures the
entire actual content, including error terms for primes absent from the
particular interval. Since (h_p+1)log p=O(log B) on this range and
pi(12B)=O(B/log B), the total endpoint error is O(B). The resulting
H log log B+B error has the advertised uniformity for every contained
consecutive interval; it is not claimed to be a relative asymptotic for
very short intervals.

The fixed-modulus input was actually reopened in
[Bennett--Martin--O'Bryant--Rechnitzer](https://arxiv.org/pdf/1802.00085),
Theorem 1.2, printed p.5, equation (1.12). With q=3 this supplies
theta(x;3,1)=x/2+O(x/log x). Partial summation gives the stated weighted
prime sum with O(log log x); the change from p to p-1 has convergent
error. No moving-modulus or quadratic-prime distribution claim is used.

CC4's primewise inequality min(a+c,b+d)<=min(a,b)+max(c,d) is correct.
It gives the exact deletion divisibility, with an integer norm/content
quotient, before taking logarithms. Deleting o(B) roots changes the
full-block content by o(B log B). For a fixed positive proportion the
charged error is too large to transfer the same main term to the
roughly-half-sized independent domain, as the source states.

The full source of `replay_collective_content.py` was read and its
`--check` was actually executed successfully. Canonical certificate SHA256:
`cbb9f7a0a1de88576c9c2014e02da2c7fe32f03e17e6b3ccef8fabbba7a5ff34`.
It covers 70 blocks, 4368 root occurrences, 2046 complete norm
factorizations, 3275 signed vectors, 280 intervals and 280 deletion checks.
Its orientation convention fixes the smaller root modulo each prime,
and its trial-prime supply exceeds every required square-root bound.
This is exact finite content evidence, not an asymptotic certificate.

The gain is an actual collective coefficient-height reduction. Cancelled
input-norm primes have not been identified with boundary-prime radical
credits. A boundary prime hitting one root does not put a product of
unhit roots in the same torsion target. Thus the content theorem does not
close the nonrectangular incidence, independent-domain complement or
the signed far tail. These are substantive remaining interfaces, not
defects hidden by the content estimate.
