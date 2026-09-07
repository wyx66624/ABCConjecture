# Independent review of the actual residual-support bill

Date: 2026-09-07. All seven declarations and their proofs, the full
ordinary scope note, the final manifest, and complete axiom output were
read. Independent source/signature/proof-scope review PASS. The root agent
performed the fresh compilation; this reviewer did not rerun the build.

Source: `2026_09_07_integral_lifting/Lean/ResidualReflectionArithmetic.lean`.
SHA256: `2585a666feedc5ce4c94e1a9fe3ed53dd60ef09476bed039dd817e8fb0238b83`.
Scope note: `2026_09_07_integral_lifting/residual_bill_formal_scope.md`.
SHA256: `0024593a14784b4b180c754c24a736f28ac0f70d206c90cc88a0c97b77d475dc`.

## Signatures and the actual support law

The integer lemma uses n,a,f positive and b,r nonnegative. Its small-a
branch converts the absolute value to a+b=n(f-r)>0, so the integer
multiple is at least n. No bound on f-r is assumed. The natural-number
version has exact casts of the original reflected depth equality. The
sharp a=f=1 example covers every n>=2.

The distinct-prime product theorem proves a product of prime powers
divides one integer from their individual divisibilities. It uses the
actual finite set and coprimality of its distinct prime members, rather
than assuming the desired product divisibility.

`actual_reflected_support_bill` uses the actual `Nat.factorization` of
V,V',R,R' and the actual `C.primeFactors`. Its explicit local hypothesis
at EACH member p is exactly

    v_p(V)>0, v_p(R)>0,
    |v_p(V)-n v_p(R)| = v_p(V')+n v_p(R').

From this it proves `primeSupportProduct C ^ n | V*V'`, with V,V'
nonzero and n positive. The intermediate factorization-product identity
has its necessary nonzero hypotheses. C is an arbitrary natural number
in this module: it is NOT silently defined to be the coordinate gcd of
an Eisenstein product. Its positive support assumptions and reflected
local law must still be supplied from the ordinary oriented-factorization
argument when applying it to that product. Empty prime support, including
the library convention at C=0, makes the general product theorem harmless;
the final content-one theorem explicitly excludes C=0.

`content_one_of_small_joint_product` uses explicit hbill, hmin (all actual
prime divisors of C are at least seven), and V V'<7^n. It selects an
actual prime divisor if C is not one, transports its nth power through
the support product, and obtains the contradiction with the positive
integer product. It does not establish hmin or the Eisenstein reflection
law itself. In the intended application, hbill is supplied by the
preceding proved theorem, not introduced as an axiom. The lack of a
positive-n requirement in this final statement only includes the
vacuous n=0 case, since V,V' are nonzero and V V'<1 cannot hold.

## What has and has not been formalized

The finite local-depth-to-actual-support-product step is formal. The
separate nine-declaration actual-content module is unchanged. There is
no hidden formal connection identifying its gcd with C and deriving the
local reflection law from Eisenstein UFD/orientation allocation. The
module does not prove that UFD, the complete projective inverse, the
positive-sector normalization, the real-log version of the threshold,
actual point existence, the n-free canonical exact formula CR1, or ABC.
The ordinary scope note states these limitations faithfully.

## Final evidence checked

Current combined manifest:
`2026_09_07_integral_lifting/verification/mathlib_validation.json`, SHA256
`7e3c6241e40666ee8b7400bdeb3f4d31d9c99e7d6d3083ecf454087b2c63ff52`.
Fresh log SHA256:
`a37b45e07676e8904b7ff6b8863c0e7c3d43fc0b5d7b286ccd3f6595dd885ca1`.

This current run has 16 new declarations (9 actual content + 7 residual
reflection) and 29 unchanged Eisenstein declarations. All three current
source hashes and their theorem counts were independently recomputed and
matched; all 45 manifest query names occur in the fully inspected axiom
output. The only axioms are propext, Classical.choice, and Quot.sound.
Lean 4.32.0, commit 8c9756b28d64dab099da31a4c09229a9e6a2ef35, and Mathlib
81a5d257c8e410db227a6665ed08f64fea08e997 are recorded. The existing Mathlib
cache was reused. No whole-repository or full-Mathlib rebuild is claimed.

The root subsequently extended this same manifest with the actual
integer-radical logarithm module and the global prime-log dependencies.
The seven residual source bytes did not change. The current 31-new +
53-old snapshot is recorded in `actual_log_threshold_review.md`; the
hashes in this file identify the earlier 16-new + 29-old snapshot.
