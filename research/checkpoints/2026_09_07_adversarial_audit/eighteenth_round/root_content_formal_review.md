# Final independent semantic review: actual complement and power extraction

Status: PASS. I actually read both complete final Lean sources and the ordinary
scope note. I also matched all six current source hashes, all declared theorem
names, and all 95 axiom results against the final fresh-build manifest and log.
I did not recompile. Machine-readable bindings are in
`root_content_formal_review.json`.

Sources under `research/checkpoints/2026_09_07_collective_content_closure/`:

- `Lean/ComplementContent.lean`: 24 new theorems, SHA256
  `5ce0713043405dffb2bc15e111b9082d6ea9a5335a7b7e80ecedd3de3c806b3d`.
- `Lean/SquarefreePowerExtraction.lean`: 16 new theorems, SHA256
  `a51957c6846595f7dd2b760f3f5aa80211bdf7002645c905325bc5ace426c745`.

## Complement source and exact observables

The definitions use the literal `Int.gcd` of the two coordinates, integer
division by that gcd, and the actual Eisenstein multiplication and three
rotations. `primitive_reconstruction` proves exact recovery from the quotient;
it does not take a supplied divisibility or Bezout witness. Primitivity of w
implies w is nonzero. The hypotheses v != 0 and gcd(w.1,w.2)=1 make both contents
and their product positive.

The determinant scaling and raw phases are proved as polynomial identities.
They give the cleared equalities for the actual normalized pairs. Bezout is
obtained from the actual gcd premise and proves `normalizer | norm(v)`.
Positivity then makes the literal integer quotient r positive. Cancellation
gives the precise signed coordinates r*(-b,a,a+b), exact pair/triple gcd r,
and recovery after dividing by r. There is no hidden hypothesis asserting the
desired cleared equalities or scalar divisibility.

The last three declarations give a generic observable equality, then instantiate
it with an actual product over `Nat.primeFactors` and with the real logarithmic
sum using `Nat.factorization`. These are genuine observables of the recovered
absolute integer boundary, not arbitrary functions supplied as radical axioms.
Zero boundary coordinates are allowed by these identities: in that case the
library's finite-factor conventions apply. Applying them to a nonzero primitive
ABC triple still requires the ordinary nonzero-arm premise. The theorem does
not construct actual block powers, prove their primitivity, or turn cancelled
input content into a boundary saving.

## Power extraction and the linear obstruction

The first divisibility `Q | D` follows already from Squarefree R and Q^2 | RD;
coprimality R,D is correctly unnecessary for this preliminary fact. Adding it
proves R coprime Q, then R | V and Q^g | D, without assuming V coprime Q. The
domains of zero values in the divisibility-only declarations are sound. The
depth and logarithmic declarations explicitly add D nonzero/positive, Q>1,
V>0, and g>=2 where needed.

The module chooses an actual prime of Q and proves g <= D.factorization p.
The optional uniform depth ceiling remains an explicit `hdepth` premise.
The stronger height bridge uses the explicit profile that every actual prime
p dividing D is at least 7 and p^(v_p D) <= H. From this it proves 7^g <= H
and then the actual real-log ceiling; it does not assume the desired bound on g.
The scalar log lower bounds derive from the actual divisibility R | V.

The final theorem takes B>=36, delta>=0, an explicit mass lower bound
delta*B*log(B)/2 <= log(R), and the actual prime-power height profile with
H=36B^2. It proves delta*log(7)*B/6 <= log(V)/g. All products/exponents before
the casts are natural-number operations. It proves a stronger log(V)/g version
of the ordinary max(1,log(V))/g conclusion. The actual interval realization of
R,D, the split-prime profile, and the sufficiently-large-B mass lower bound are
ordinary input results, not newly formalized consequences.

## Final evidence binding and limits

The final manifest is SHA256
`1a640b38fea8bc3708db6708a04293c88d39f44bc399f2ba95950ad674c3ce7e`.
The full log is SHA256
`c53a786d3c8c16024295ee9e7de6df0f5d8d14e8fd87406ea2b41fc1032ab43e`.
I checked 40 new and 55 prior dependency theorem names against the six current
source files. Every name appears exactly once in the axiom log: 92 entries list
axioms and three explicitly depend on none. Their union is exactly propext,
Classical.choice, Quot.sound. No sorryAx, error, or panic occurs in that log.

This verifies the semantics and the final evidence for the reported scoped
fresh source build against pinned Mathlib cache. It does not report a new build
by this reviewer or a rebuild of all Mathlib/the repository. It does not prove
interval asymptotics, p-adic closure or height normalization, arbitrary-root
signed-tail membership, or ABC.
