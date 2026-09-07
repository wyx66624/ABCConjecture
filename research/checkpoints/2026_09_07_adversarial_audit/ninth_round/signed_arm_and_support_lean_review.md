# Independent scope review of the signed-arm and support arithmetic

Date: 2026-09-07. Both sources and the support assembly note were read
in full. Mathematical fidelity and signature scope: PASS. No source
outside the reviewer's checkpoint was edited.

## SignedArmArithmetic: 32 declarations

Source:
`2026_09_07_critical_bottleneck/ninth_round/Lean/SignedArmArithmetic.lean`,
SHA256 `c9b1b53f7f35b7c2e9f7004c482f182cc1346ff01ca1e66556473c6341ef05aa`.

The pair multiplication, conjugation and power are the actual imported
Eisenstein operations. Congruence is componentwise integer remainder.
The multiplication and conjugation congruences correctly use both
components; exponentiation follows by induction. The six-period unit
calculation treats both residues 1 and 5 modulo six, including the
specified conjugation for residue five.

The three special input lines are actually evaluated. The first and
sum divisibility theorems require the visible residue assumption, while
the second-coordinate theorem is valid for every natural exponent.
Actual integer quotient reconstruction follows from proved divisibility,
not a new quotient-equality assumption. Zero input coordinates cause
no invalid cancellation: the corresponding normalized coordinate has
already been proved zero, and integer division has its total Lean
meaning. The additive relation, full boundary product, conjugation
norm and quotient norm identities are therefore genuine arithmetic
identities for the actual normalized power.

The pairwise coprimality theorem explicitly assumes output primitivity
as `hprim`. Coprime divisors of the first, second and sum coordinates
then give the three asserted gcds. This does not hide the ordinary
number-theoretic theorem that primitive unramified roots have primitive
powers. In particular no unramified hypothesis has been silently erased
from the ordinary application; it remains needed to establish `hprim`.

The last seven declarations have the stated integer-weight scope.
The linear two-arm inequality uses the three visible mass bounds and
the two depth/radical inequalities. Its specialization leaves the third
arm's depth unrestricted. The finite-list depth, radical and excess
functions handle exponent zero correctly, and use natural truncated
subtraction for the excess above two. Nonnegative weights on the first
two lists are precisely what the local-to-list inequality requires;
the third list needs no additional sign premise for the purely linear
conclusion. The overlap inequality retains the negative credit when a
prime first appears, instead of assuming disjoint support. No statement
identifies integer weights with real logarithms, proves the LR2 bound,
or asserts membership in the compensation class.

The author-provided fresh manifest was read, and all three manifest
source hashes were independently recomputed and matched. Their theorem
and query counts are 29, 10 and 32 respectively. Manifest SHA256 is
`090e3a5f9c335f80f4e94cfcc680f7ac13acdcc183881c71b49eb4f4e91fd36b`.
It records fresh scoped Lake success under Lean 4.32.0, compiler commit
`8c9756b28d64dab099da31a4c09229a9e6a2ef35`, and only `propext`,
`Classical.choice`, `Quot.sound` in the axiom union. This reviewer
checked source bytes and manifest consistency, rather than claiming a
separate compiler run.

## Ordinary support assembly and ProgressionSupportArithmetic: seven declarations

Ordinary note:
`2026_09_07_signed_compatibility/integer_support_assembly.md`, SHA256
`30c244c64a46e7c8133afef68f1b1413e4eca97485aace7ac1ad13b1cbda1120`.

Lean source:
`2026_09_07_signed_compatibility/Lean/ProgressionSupportArithmetic.lean`,
SHA256 `db4919deece7078dd9026bea85a3ced90769a8802ffd8346d07486a31a70c7fa`.

The ordinary note is correct. The odd-rank argument uses d dividing
q-1 and q+1, hence d dividing two; positivity and oddness exclude d=2.
It is valid for general odd integer n and does not require a prime or
prime-power hypothesis. The Lean theorem has exactly these antecedents,
including positive d; it does not derive them from a residue-field order.

The first and sum arm height inequalities are actual integer norm
identities and squares. The sum identity is reused from the established
dependency. The ordinary transfer from a positive divisor of a nonzero
arm to its squared size is correct, but the Lean product theorems take
the squared J budget explicitly rather than claiming to have identified
J with a progression part.

The product budget follows by multiplying nonnegative differences.
Its first premise already forces U nonnegative, so the Lean statement
validly omits a separate U sign premise. Likewise the power version
needs no extra sign premise for K: the displayed squared bounds provide
the necessary nonnegativity for its product. The natural exponent and
integer power identity correctly produce e+1.

The last theorem requires R>=1, K>0, K<=N, the explicit actual-root
size bound and an explicit strict good-part bound. The form k+2 gives
the required exponent at least two. Induction proves R^k>=1; combining
the two visible budgets then rules out G^2<=1. The omitted N>0 premise
follows from K>0 and K<=N. No primality, factorization, valuation, or
real logarithm is encoded in this purely integer conclusion.

This review does not assert a completed fresh compilation for these
seven declarations; that is recorded by the root's separate verifier.
The reviewed statements contain proofs and explicit axiom queries.
Their arithmetic interfaces faithfully preserve the ordinary inputs.
Neither source formalizes complete SA, PP, EP, or ABC.

## Final root build follow-up

The root repaired two proof implementations without changing any
signature: the power-product simplification now specifies its exponent,
and the power lower bound uses an independent universal induction.
Both amended proofs were actually reread. Final
`ProgressionSupportArithmetic.lean` SHA256 is
`50874e1dd57ca38fccf09f649cec909e7e2ecfcc31e07261d669d2140b944f7e`.
Final source fidelity and scope remain PASS.

The root's combined fresh manifest
`2026_09_07_signed_compatibility/verification/lean_validation.json`,
SHA256 `e2ff1cce808c2a1ac4f2acc4432f2f335cfe5c52adb3fa72e74585f55b11ee6a`,
was actually read. It records 54 new declarations and 54 unchanged
dependencies under the same compiler, with only the standard three
axioms. All seven module source hashes were independently recomputed
and matched, and each module's theorem and axiom-query counts agree:
29, 15, 10 unchanged and 32, 10, 5, 7 new. This is source and
manifest verification, not a claim to have run another compiler.
