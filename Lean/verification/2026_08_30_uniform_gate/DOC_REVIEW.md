# Mathematical proof and manuscript review

Author: ChatGPT. Research date: 2026-08-30.

This is an internal proof/source review, separate from PDF visual QA.
No external human review, journal acceptance or priority claim is implied.
The accepted PDF is the 34-page artifact identified in `VALIDATION.md`.

| Mathematical record | Review and accepted boundary |
| --- | --- |
| `research/ANALYTIC_ACTUAL_RADICAL_UNIFORM_GATE_2026_08_30.md` | Analytic agent's proof; root independently checked the original S-unit constant, divisor sum, actual radical/excess identities, exponent intersection and exact counterexamples. The necessary window is not an output lower bound. |
| `research/GEOMETRY_GLOBAL_UNIFORM_GATE_2026_08_30.md` | Geometry agent's proof; root checked the actual points, prime costs, cubic orders/indices, common curve and torsion formulas. Analytic agent independently checked the fixed-support Siegel step and its height/denominator normalization. Pasten's 2026 source is identified as a preprint. |
| `research/GEOMETRY_COMMON_CURVE_SIEGEL_CROSS_REVIEW_2026_08_30.md` | Independent proof review of the common curve, rational 3-torsion orbit and fixed-support asymptotic. The support bound remains fixed in the limiting quantifiers. |
| `research/IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md` | IUT agent's source reconstruction; root checked the original Ism pages and Milne's norm correspondence. Geometry and analytic agents cross-checked the norm/trace, trace-kernel and lattice steps. No full matrix lift is inferred. |
| `research/IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md` | Original IUT I and III definitions checked against their exact local category, capsule-full representatives and tensor-factor summands. Ind2 hull equality is for a fixed coefficient ring B. |
| `research/UNIFORM_GATE_STRUCTURAL_TESTS_2026_08_30.md` | Root's full trace-stabilizer transvection, all-neighborhoods rigidity and infinite fixed-residual-support example; independently reviewed by route agents. The transvection is not itself a Galois lift; the infinite example is not an abc counterexample. |

The manuscript integrates these results in the three new TeX inputs
`uniform_gate_actual_radicals_2026.tex`,
`uniform_gate_admissible_arrows_2026.tex` and
`uniform_gate_global_geometry_2026.tex`. The four previous continuation
inputs are preserved. Formal scope is stated in the updated table.

The root review corrected the geometric height sentence so that the
third point is **at least** `32c` (equality can occur); the other two
strict estimates were not incorrectly imposed on it. The factorization
root is distinguished from an ordinary real cube-root floor. The
manuscript does not identify the common curve's rational 3-isogeny with
a 3-isogeny of the Frey curve.

The local review retains the distinction among the integral tensor order,
its maximal order B, a convex `Z_p` hull and a B-module hull. It does not
infer a hull inequality from affine trace-orbit separation. The proof
of Ism scalar rigidity uses all open subgroups and their unit-image
lattices; it does not treat their images as all of the corresponding
field. The source definitions of mono-analytic processions are used
without reinserting forgotten curve data.

The 89 public Lean theorems formalize their stated algebraic, valuation
and lattice components. The source theorems and global analytic/Galois
bridges listed as external in `VALIDATION.md` remain outside Lean.
The recorded dependency audit contains no extra mathematical axiom.

The later full Jannsen--Wingberg minimum-layer work is held in separate
research logs and is not represented as part of this PDF or the
89-theorem acceptance record.
