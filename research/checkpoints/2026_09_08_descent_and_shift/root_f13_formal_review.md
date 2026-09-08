# Independent root review and fresh F13 compilation

PASS within the explicit fifteen-theorem scope. Root actually read the
entire `F13FixedCurveArithmetic.lean`, its prior ordinary scope, complete
verifier, author report, full successful manifest and all fifteen axiom
lines. Root then independently ran the verifier in WSL; the second fresh
run succeeded and is recorded at
`2026_09_07_adversarial_audit/nineteenth_round/next_verification/f13-20260908T060020018236Z/validation.json`.

The checked source SHA256 is
`a459a5f16e8f0b8f6a2dd2dbfd742c672721f3963220463eed10e8b456e006ec`.
All fifteen explicit axiom queries use only propext, Classical.choice
and Quot.sound. The pinned toolchain and Mathlib source checks, fresh
literal module copy, warnings-as-errors compilation, source recheck and
per-run evidence were inspected in the verifier. This was a new compiler
execution, not a reread of the author's prior PASS.

The polynomial Bezout assertion is an equality in Polynomial (ZMod 13).
Its proof uses the coefficient characteristic identity, not equality of
only thirteen evaluations. Literal field formulas reproduce the prior
ordinary finite certificate. All fourteen affine pairs and the separate
two infinity signs, both elliptic affine counts, all three projection
charts, and the substituted third-division numerator are checked.

The final finite exclusion uses a deliberately explicit disjoint-sum
data model. At z=0 the first psi equals seven. At infinity the second
numerator is nine. The nonzero affine implication excludes the target
numerator under the actual curve equation and first-psi condition.
Neither the Finset count nor the final predicate is represented as a
formal construction of a projective curve or its elliptic group law.

`decide +kernel` invokes kernel reduction for inverses in ZMod; the proof
terms and their printed axiom sets were checked in the actual run.
No native evaluation, custom axiom, sorry or admitted geometric bridge
is used in the module. The complete source contains no hidden assumption
of the rational-locus theorem or its p-adic/rank proof.

The ordinary division-polynomial interpretation, good reduction,
prime-to-five rational-group index, full analytic zero bounds and
rational-point completeness remain separate unformalized dependencies.
This next-batch result is not part of the already published twenty-four
selector declarations and is not an ABC proof.
