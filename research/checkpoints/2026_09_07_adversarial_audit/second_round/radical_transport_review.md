# Independent review of actual radical transport and the ABC obstruction

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read-only review of:

- `2026_09_07_radical_transport/ordinary_proofs.md`;
- `2026_09_07_radical_transport/Lean/RadicalTransport.lean`;
- `2026_09_07_radical_transport/Lean/TwoStepABCObstruction.lean`;
- the original `Lean/IUTThreeClosures/ABCStatement.lean`;
- the new fresh-output compiler and axiom-audit verifier.

Result: the ordinary proof, formal theorem signatures, and claimed scope
agree. No substantive mathematical or specification issue was found. This
record is an independent source review; the root agent's fresh compiler
record separately establishes machine acceptance of the exact files.

## Genuine natural-number radical arithmetic

`RadicalTransport` uses Mathlib's `UniqueFactorizationMonoid.radical` on
natural numbers, not a free radical parameter or an assumed multiplicative
function. Its compression estimate uses actual radical divisibility and
power invariance. The positivity hypotheses on d,V,Q,g are sufficient, and
overlap between V and Q is allowed; coprime support is not assumed here.

`norm_coprime_boundary` proves coprimality with all three seed factors from
the single primitive-pair hypothesis. `transform_coprime` is its genuine
consequence. Applying this theorem again gives coprimality of the actual
second transformed summands. The addition identities give the exact second
height (a+b)^4, not an approximate height surrogate.

The one-step radical equality is justified by those coprimalities and
positive power invariance. The second equality applies that same theorem to
the first transformed pair, so both new norm radicals are charged exactly
once. The fifth-power gate then uses rad(abc)<=abc<=c^3 to derive
R_2^5<=c^16. All factors and exponents match the ordinary proof.

## Exact connection to the repository ABC statement

The original `IUTThreeClosures.abcRadical` is the product of the entries of
`n.primeFactors`. `repository_radical_eq` identifies this with Mathlib's
natural-number radical through `Nat.radical_eq_prod_primeFactors` and the
definition itself. There is no weaker substitute radical or renamed
conjecture at the endpoint.

`log_radical_gate` casts the genuine integer inequality before applying
monotonicity of the real logarithm. The assumption R>0 and R^5<=c^16 ensure
the comparison is on positive real arguments; no separate c>0 hypothesis
is missing. In its intended application R is positive by `Nat.radical_pos`.

`additive_pairwise` has the exact order required by `PairwiseCoprimeABC`:
coprimality of x,y, of y,x+y, and of x+y,x. The final proof establishes
positivity and this full pairwise property for

    x=abM, y=(ab)^2+abM+M^2, x+y=(a+b)^4.

The maximum in the repository's original logarithmic ABC definition is
then actually the last entry. Natural-number casts and fourth/fifth power
logarithms are transported explicitly into the real inequalities.

## Complete family quantifier and fixed epsilon

The final theorem's premise is exactly an unbounded family of positive
primitive seeds satisfying the full integer two-norm radical gate:

    for every real B, there are a,b>0 with gcd(a,b)=1,
    B<log(a+b), and [rad(M)rad(N)]^5<=a+b.

Assuming the original ABC conjecture, the proof selects epsilon=1/8 and
its corresponding arbitrary real constant C. It then requests a seed with
log(a+b)>(5/2)C. The genuine second transform satisfies

    4 log(a+b) <= (9/8)log R_2+C <= (18/5)log(a+b)+C,

contradicting that strict seed inequality. The argument works for every C,
including nonpositive C; it does not infer a disproof from a finite example,
from large local valuations, or from a varying epsilon.

## Formal scope and audit mechanics

The two modules contain nine and four named theorems, respectively. Their
source includes a `#print axioms` query for each theorem, no `sorry`, `admit`,
custom axiom, or opaque assumption. The verifier builds fresh outputs for
both new modules and their two original repository dependencies, puts that
directory first in `LEAN_PATH`, and checks every theorem's axiom report
against the three standard axioms. It also checks the actual compiler and
Mathlib revision. This review does not claim a fresh build of every Mathlib
or repository source.

The unbounded-family premise is not supplied by either module. Thus the
formal result is a genuine conditional obstruction to standard ABC, while
the arithmetic existence problem and the global conjecture remain open.

