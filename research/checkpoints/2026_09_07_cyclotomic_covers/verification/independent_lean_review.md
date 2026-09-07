# Independent ordinary, signature and proof review

Reviewer: critical_bottleneck subagent. Date: 2026-09-07.
Result: PASS for the stated scoped results. No source edits were made.

## Materials actually read

I read the complete `ordinary_lucas_bridge.md`, both complete new Lean
modules `GeneralLucasBoundary.lean` and `QuarticSupportArithmetic.lean`,
and the relevant imported definitions in `EisensteinDescent.lean` and
`LocalPowerArithmetic.lean`. I also read the fresh scoped validation
manifest and independently recomputed all four listed source SHA-256
hashes. All four current source hashes match that manifest.

The parent's manifest reports a fresh Lean 4.32.0 Lake build covering
21 new declarations and 44 dependency theorems, with axiom union
`Classical.choice`, `Quot.sound`, and `propext`. I verified the source
and manifest agreement; I did not rerun that build as part of this
read-only independent review.

## GeneralLucasBoundary: ten actual declarations

The imported `Pair` is `Int × Int`, multiplication is the actual
Eisenstein coordinate multiplication, `norm` is a^2+ab+b^2, and
`boundary` is ab(a+b). The new `power` recursively multiplies actual
pairs; `boundaryOrbit` evaluates that polynomial on actual products.
The new Lucas sequence is parameterized by arbitrary integer trace
and recurrence coefficient, so the result is not confined to the
earlier fixed norm-seven orbit.

I checked each of the ten declarations and its proof:

- `cubic_trace_identity` is the trace of the actual third power.
- `trace_discriminant_identity` is tau^2+27P^2=4N^3.
- `general_shifted_boundary_recurrence` proves the full polynomial
  identity on arbitrary pairs w,z, with no primitivity, nonzero or
  unramified premise.
- `norm_power` proves actual norm multiplicativity for every natural
  exponent by induction.
- `boundary_orbit_recurrence` transfers the polynomial identity to
  every shift and exponent using actual multiplication associativity.
- `lucas_recurrence` unfolds the stated two-step integer recursion.
- `linear_recurrence_solution` proves the general two-initial-value
  solution by simultaneous induction on consecutive indices.
- `actual_shifted_lucas_solution` specializes that proved recurrence
  solution to the actual shifted boundary orbit.
- `actual_power_boundary_lucas` specializes the shift to one, with
  the zero exponent handled explicitly.
- `actual_boundary_divides_powers` supplies the displayed Lucas
  integer as an actual divisibility witness for every exponent.

The ordinary proof agrees with all signs and initial values. The trace
polynomial is 2a^3+3a^2b-3ab^2-2b^3 and the recurrence coefficient
is N(w)^3. The general shifted formula is U_(n+1)P(wz)-N(w)^3 U_nP(z).
Degenerate inputs, including P(w)=0, are legitimately included rather
than excluded by an implicit assumption.

## QuarticSupportArithmetic: eleven declarations

The imported `second a b` is the actual norm of (ab,N(a,b)), and the
proved imported expansion is precisely the binary quartic F(a,b).
The eleven declarations are:

- `second_mod`, transferring evaluation to residues at any modulus;
- `primitive_not_both_zero_mod`, obtaining the residue restriction
  from the actual `Int.gcd a b = 1` premise;
- `second_three_table` and `primitive_second_mod_three`;
- `second_thirteen_table` and `thirteen_remainder_diagonal`;
- `thirteen_shift_identity`;
- `fourth_power_zero_thirteen_table` and
  `thirteen_divides_of_divides_fourth_power`;
- `primitive_second_thirteen_exact_depth`;
- `thirteen_cannot_divide_extraction_root`.

The finite `Fin 3` and `Fin 13` tables use kernel-reducible `decide`.
They are transferred to every integer seed, including negative integer
coordinates, through positive-modulus remainder bounds and explicit
residue congruences. Thus the universal primitive conclusions are not
merely a finite test range.

I checked the exact expansion

    F(b+13t,b)=13b^4+169(2b^3t+20b^2t^2+91bt^3+169t^4).

From 13 dividing F, the proved residue table forces a=b modulo 13.
If 169 also divided F, the expansion would give 13 dividing b^4,
then b=0 modulo 13 and also a=0 modulo 13, contradicting the actual
gcd-one premise. This establishes depth exactly one when thirteen
occurs. The extraction theorem takes a genuine integer equality
F(a,b)=VQ^g with g>=2 and proves 13 cannot divide Q by constructing
a forbidden 169-divisibility witness. No positivity assumptions on
V,Q are needed for that algebraic implication, so their absence is
valid, not a loophole.

## Scope and unresolved results

These modules contain proofs, not additional mathematical axioms or
assumed versions of the intended conclusions. Their formal scope is
the actual polynomial/recurrence Lucas bridge and the universal bad-
prime quartic arithmetic above. They do not formalize the full
cyclotomic factor construction, rank valuations, totient mass budget,
geometric covers, Faltings input, signed saving or ABC. The ordinary
and formal labels in the accompanying record accurately preserve that
boundary. No substantive signature mismatch or proof gap was found.
