# Independent scope review of LocalPowerArithmetic.lean

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read all fifteen theorem statements and proofs in
`2026_09_07_support_power_classes/Lean/LocalPowerArithmetic.lean`.
Their correspondence with the ordinary LP and PL arithmetic passes
independent review. This initial record is a source/scope review; the
root agent is running a separate fresh compiler and axiom audit.

The module's `second` is the genuine Eisenstein norm of
(a*b,norm(a,b)). Its quartic and consecutive-polynomial expansions are
actual integer identities. The consecutive pair has gcd one, and the
mixed-coordinate gcd is established using the identity
norm(a,a+1)-3a(a+1)=1. No primitive-gcd premise is substituted for that proof.

The two divisibility theorems give explicit integer witnesses for every
modulus dividing L and every natural exponent. The main unbounded-family
theorem constructs a=L(T+1), b=a+1, proves positive coordinates and
height greater than the arbitrary natural T, includes both true gcd
conclusions, and satisfies all the modulus/exponent tests simultaneously.
This formalizes LP1's direct-residue statement, not global perfect-power
norms or LP3's Hensel/CRT extraction family.

The simple-root linearizations retain the actual constants and linear
coefficients seven/nine and sixty-seven/177. The finite data theorem
checks the genuine root norms and derivative coprimality. The residual
data theorem gives thirteen and thirty-one depth one using integer
equalities and nondivisibility; it does not claim that the whole CRT
family or its power extraction has been formalized.

The h-free statement is the exact integer valuation inequality behind
PL1's integrality argument. It is not yet a theorem converting valuations
of arbitrary rationals to integrality. The minimal denominator statement
is at the explicitly stated nonnegative natural valuation level, and the
clearing-degree theorem is the actual integer exponent equality. Their
additional h=0 natural boundary cases are consistent with the statements.

The source contains no Hensel, Kummer, class-group, S-unit, or Faltings
assumption, and does not claim those ordinary dependencies are verified.
No full PL finiteness, LP3 arbitrary extraction, or ABC conclusion has
been promoted to Lean status.

## Final verification inventory and manuscript scope

Read the final `verification/lean_validation.json` in the root checkpoint.
It records PASS for a fresh scoped Lake build with Lean 4.32.0, fifteen
new declarations and twenty-nine unchanged dependency declarations, and
only Classical.choice, Quot.sound, and propext in the complete axiom union.
An independent hash of the actual reviewed LocalPowerArithmetic source
matches the manifest:

    b17af29c82e564816d09ef9d581535f2a110ec1ba5d23dff6ca2490128ce8661

The complete `paper/formal_support_scope.tex` also passes independent
scope review. Its quantified residue theorem, arithmetic-only Hensel
inputs, natural valuation boundary, external geometric dependencies,
and fresh verification counts accurately match the reviewed source.
