# Independent ordinary review of GE1--GE4

Date: 2026-09-07. Full ordinary proof review PASS after the correction
described below. Source:
`2026_09_07_independent_route/eleventh_round/gaussian_even_profile.md`.
Final reviewed SHA256:
`11400f5e2f028af857fe7a2443542e1828f7b3a47e981211af7ba49f519d48a2`.

GE1's identity F=A^2+M c^2 and the primitive gcd conditions imply the
Legendre-symbol constraint for every prime of the actual second support.
The primes are odd, prime to D U c, and already split in Q(sqrt(-3));
therefore both ramified-parity cases in (GE4) follow. The discriminant
bound uses the squarefree part of D and does not assume a uniform
prime-distribution theorem in the moving field.

For the unramified square first norm, the Gaussian pair (A,Uc) is actually
primitive and has odd norm. The Gaussian Euclidean argument, absence of
conjugate pairs, and assignment of the two nonnegative exponent parts
prove the exact Gaussian residual/root profile for arbitrary V1, without
an artificial power-free restriction. The simultaneous Eisenstein
profile uses the same seed, residual norm, and root norm. Their shared
coordinate and square relation are retained. The Gaussian ratio height
is exactly one half log V1, including unit residuals, since its conjugate
prime ideals have disjoint support and its archimedean modulus is one.

The Phi_12 identity and extra square condition give the stated integer
inverse. A real error in an intermediate parity sentence was found:
from a,b both even it does not follow that c,d are both multiples of
four (a=2,b=4 is a counterexample to that intermediate assertion).
The author replaced it by the valid direct argument
U^2=a^2+ab+b^2: both even imply U even, contradicting gcd(U,c)=1.
The replacement was directly reread in the final hashed source.
The odd-prime gcd argument, parity of c,d, strict positivity, and the
exception a=b=1 are valid. Larger specified even exponents still require
the additional U=R^(h/2), and the ramified-square branch has its different
polynomial explicitly displayed.

This is a new compatible quadratic-domain representation, not an
existence/nonexistence theorem for the remaining odd second exponent.
The earlier modular cutoff is used only for the stated pure prime-index
branch p>7. Its intersection with 1 modulo 12 is a necessary support
condition and supplies no point-height bound or contradiction. No new
external perfect-power theorem, finite computation, or Lean verification
is claimed by this review.

The author subsequently clarified two isolated theorem domains in the
TeX by explicitly requiring U to be a positive integer, and wrote the
logarithm of the absolute field discriminant. Those harmless domain and
notation clarifications were mirrored in the ordinary note; its current
SHA256 is `2e9c283817ac5a12c92694f74a42b93ec63407c8e1cd87eb49bb9e4e9bcb64fb`.
The earlier hash above records the fully reviewed proof before these
explicit clarifications. The final TeX review appears in
`paper_transcription_review.md`.
