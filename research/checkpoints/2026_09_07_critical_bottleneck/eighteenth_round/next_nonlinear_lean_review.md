# Independent full source and scope review: NonlinearPowerSelectors

2026-09-07. Next-only review using the repository Lean 4 review workflow.
No reviewed source, signature, frozen inventory, or Git state was edited.

I read every definition, all 24 theorem statements and their complete
proofs in the adversarial author's `next_Lean/NonlinearPowerSelectors.lean`,
SHA256 `38849679f2e456475bf9f9ef8dfaa0c55df2e0cba8d705d7ec579c2e111776e9`.
I also read the complete prior scope, result report, verifier, validation
manifest and compiler log. **Full source/semantics/scope PASS.**

## Actual mathematical meaning

The coordinate multiplication is the literal Eisenstein law with
zeta^2=zeta-1. The definitions `square` and `cube` multiply the actual root
(3k,1); there is no assumed power representation for unrelated outputs.
The exact coordinates, complete boundary products and norm-square/cube
identities match NP1 and CU1. The formula and residue-at-three theorems are
valid for every integer k. Positivity and norm>1 use the explicit k>=1
domain. In particular no unsigned/truncated coordinate convention has
silently replaced the integer semantics.

I checked the explicit square Bezout identity: the two coefficients are
-12k^2-1 and 3k^2(6k-1), and their linear combination of 9k^2-1,6k+1 is
exactly 1. The cube argument independently proves coprimality with each
factor 3,3k,3k+1 and combines them by the actual `IsCoprime.mul_right`
theorem. The helper for the three arms constructs all three Bezout pairs
and returns literal `Int.gcd = 1`; concrete square/cube primitivity is
proved, not supplied as an interface assumption.

The field helper splits all three boundary-zero cases. In the case
a+b=0, the norm identity minus a(a+b) gives b^2=0, including arbitrary
field characteristics. The final primitive norm-unit lemma uses the
actual integer Bezout identity reduced in ZMod q, with a genuine natural
prime q. It therefore applies to every prime divisor of the full boundary,
including small or unmarked primes. In the square/cube specializations,
the concrete primitivity proofs discharge that hypothesis and the norm
power identities transfer nonvanishing to the input norm. The final
integer nondivisibility statements are exact corollaries.

The 24 theorems consist of 3 root-norm statements; 6 square statements;
6 cube statements; 3 pairwise-gcd statements including the reusable helper;
the field common-zero and primitive norm-unit lemmas; and the 4 concrete
root-norm unit/nondivisibility statements. Every theorem has one matching
explicit axiom query.

Nothing here formalizes CRT selection, exact prescribed valuations,
irreducibility or separability, squarefree-value density, an asymptotic
tail, changing data or exponent uniformity, or ABC. The ordinary NP/CU
proofs still supply those separate claims. The source and report maintain
that boundary accurately.

## Evidence audit, distinct from a new compilation

I independently recomputed these byte hashes and matched them to the
author's record:

* Source: `38849679f2e456475bf9f9ef8dfaa0c55df2e0cba8d705d7ec579c2e111776e9`.
* Prior scope: `b60d0b3ef122faf7d19dbb127b97b2bc4c4a8bc24d11a2d2bf78070cca488533`.
* Verifier: `eae2b1af2d92b15f572b64817eae21a41892ffc5be01ee014c2075fde6913e64`.
* Manifest: `b01e02f2482bef62985243547185acf3c35b60fadd7cf088596a341fbeb22cc6`.
* Complete compiler log: `9d87dfd1d55d6e71eb26807eccce156bd6f0178e10e939f742aad9fe2a321957`.

The manifest is in the author's
`next_verification/nonlinear-20260908T044715848295Z/validation.json`.
It records Lean 4.32.0 and Mathlib commit
`81a5d257c8e410db227a6665ed08f64fea08e997`, a fresh standalone source copy,
warning-as-error mode, and exit code 0. I read all 24 printed axiom sets;
their union is exactly `propext`, `Classical.choice`, `Quot.sound`, agreeing
with the manifest. No sorry or extra analytic axiom appears.

The verifier explicitly checks the pin, tracked Mathlib source cleanliness,
source bytes before/after compilation, one-to-one theorem/query inventory,
and accepted axiom sets. It compiles only this one new source using cached
Mathlib dependencies; it does not rebuild all Mathlib or older project
modules. I did not repeat the already successful compiler run in this
review, and do not label the author's fresh execution as my own.
