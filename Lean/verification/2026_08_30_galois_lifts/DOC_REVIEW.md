# Mathematical proof, source, and formal-scope review

Author: ChatGPT. Research dates: 2026-08-30 and 2026-08-31.

This record describes internal mathematical reviews of the exact
partial-results manuscript identified in `VALIDATION.md`. It is separate
from PDF visual QA and does not imply external human peer review.

## Proof and review index

All following paths are relative to `research/`.

| Proof record | Independent checks and accepted scope |
| --- | --- |
| `IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md` | Root checked the full relative profinite presentation, every extra relator, integral basis, and inverse-arrow Kummer convention. `JW_CROSS_HANDLE_AUTOMORPHISM_CROSS_REVIEW_2026_08_30.md` checks the literal words and boundary. Only the discrete free-group part is fully formalized. |
| `IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md` | Root and `IUT_MINIMUM_LAYER_ARITHMETIC_CROSS_REVIEW_2026_08_30.md` check the actual ramification, rational unit, trace depths and minimum layer. `IUT_THREE_LABEL_MINIMUM_LAYER_CROSS_REVIEW_2026_08_30.md` checks one common arrow. |
| `IUT_NATIVE_PILOT_DICTIONARY_2026_08_30.md` | IUT and root check the singleton root/log bridge, actual full principal-unit image, the distinct pre-ideal input, and the change of every tensor coordinate and source under the standard logarithm. |
| `TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md` | Root proves the sharper normalized trace-dual bound; geometry and `TRACE_DUAL_PREIDEAL_EXACT_HULL_CROSS_REVIEW_2026_08_31.md` independently verify it. The maximal order's individual idempotents remove any erroneous product-component factor. Actual point attainment proves the equality, not a guessed interchange of B-span and transport. |
| `TRACE_DUAL_PREIDEAL_LEAN_BOUNDARY_2026_08_31.md` | Complete algebraic proofs preceded the six Lean theorems. Root inspected actual `Algebra.traceForm`, dual submodules, product traces, normalization, and the B-span after merely K-linear transport. Local inverse-different and attainment identifications remain paper mathematics. |
| `FREY_139_TATE_210_REALIZATION_2026_08_30.md` | `FREY_139_REALIZATION_ARITHMETIC_CROSS_REVIEW_2026_08_30.md` and root check both curves, genuine finite-field point counts, Galois kernels, exact logarithmic bounds, and the small-height exception in the cited existence argument. |
| `SL2_TRANSVECTION_GENERATION_2026_08_30.md` | Complete elementary proof before Lean. The formal module uses actual SL2 matrices, Mathlib transvection induction, and normal-subgroup order arguments; the arithmetic Tate/Frobenius realization is not smuggled into a matrix lemma. |
| `FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md` | Root checks the rational Legendre isomorphism, split nodes, good reduction at two, exact height bounds, torsion-field equality, and genuine uniformizer. `GEOMETRY_43_1289_ARITHMETIC_CERTIFICATE_2026_08_30.json` is auxiliary computation; the Lean proof independently uses exact primorial/gcd and size arguments. |
| `FREY_43_FORMAL_ARITHMETIC_PROOFS_2026_08_30.md` | Root's complete all-prime-exponent and real-logarithm proofs precede the associated implementation. No complete factorization of the enormous endpoints is assumed. |
| `FREY_GALOIS_REALIZATIONS_TEX_CROSS_REVIEW_2026_08_30.md` | Analytic agent independently checks the corresponding English section, including constants, every-prime quantifiers, and small-example exception boundaries. Later TeX changes were typographical only. |
| `IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md` | Root, analytic and IUT reviews check all labels, the one possible short inertia orbit, the strict count `9*ell-9 < 15*ell`, and both hull scales. The later sharp trace-dual equality supersedes the earlier unresolved middle-set question. |
| `FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md` | Root checks the complete finite sieve count, Xylouris's archived effective exponent 5.2, polynomial modulus growth, exact height interval, good reduction, image and ramification. Original finite-extension compactness conditions are distinguished from literal ambient-Qbar2 compactness. |
| `IUT_INITIAL_DATA_BALANCED43_AUDIT_2026_08_30.md` | Root verifies original IUT I pp. 61–63, CanLift, EtTh, Takeuchi and Sijsling. `IUT_INITIAL_DATA_BALANCED43_CROSS_REVIEW_2026_08_30.md` and `IUT_INITIAL_DATA_BALANCED43_GEOMETRY_REVIEW_2026_08_31.md` independently check the full construction. |
| `IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md` | Root and `IUT_INITIAL_DATA_POWERFREE_GEOMETRY_REVIEW_2026_08_31.md` check the general criterion and all members of the unbounded family. One global decorated line and independent local place choices are used; no common Galois element for all places is required by the original definition. |
| `GALOIS_LIFTS_ROOT_CROSS_REVIEW_2026_08_30.md` | Coordinating proof/scope review, with a dated addendum recording the subsequent sharp equality and full initial-data results. Earlier boundaries remain historical, not current unresolved claims. |

## Principal source checks

`SOURCE_INDEX.md` records ten newly archived primary PDFs, exact hashes,
versions and used passages. The original IUT I, III, IV, Joshi III/IV,
Silverman and earlier sources remain in the preserved prior manifests.

Jannsen–Wingberg is used for the full presentation, not just a maximal
pro-p quotient. The precise Hoshi–Nishio generator and Kondo trace-kernel
statements are checked in the required even-degree and tame range.
Kondo is explicitly a December 2025 preprint. The CRT family uses the
archived 2009 Xylouris theorem with exponent 5.2; it does not claim that
an unarchived later exponent was checked. Original IUT Definition 3.1
and the canonical-curve and étale-theta theorems were read at the pages
used, including hypotheses on covers, splitting fields and orientation.

The graph-direction map is the dual isogeny from the q^ell Tate curve
to the q Tate curve. The cover is not confused with a root-pullback.
The original ununderlined curve supplies the torsion condition in the
oriented-cover construction. No full ell-squared torsion is silently
adjoined. The common distinguished cusp is obtained from the same
decorated quotient vector at separately chosen places. The four
arithmetic once-punctured j-invariants exclude a core obstruction by a
negative j-valuation at a rational prime greater than five.

The fixed compact bounding domain satisfies the original finite-local-
extension slice condition. A literal compact subset with nonempty
interior in ambient Qbar2 is impossible. This rejects that precise
wording, not IUT or abc, and the manuscript does not silently substitute
the corrected condition into the literal assertion.

## Formalization and remaining target

The seven Lean modules have 130 public theorems and 15 additionally
audited constructions. Their statements and dependency reports are
listed in this record. Proof text came first. Arithmetic constants,
actual points and ideals are used rather than labels containing assumed
answers. Full local-field/cohomological reconstruction and the geometric
initial-data construction remain outside Lean; the abstract or algebraic
formal components do not claim to have proved them.

Full original initial data and exact local hulls are still not a global
comparison theorem. Global weights, source-set identity, Ind3, arithmetic
holomorphic structures and cross-Frobenius compatibility must be treated
together in the same published construction. Independent analytic and
arithmetic-geometric uniform estimates also remain active. No final
ABC closed term, rigorous abc disproof, or new axiom is supplied here.
