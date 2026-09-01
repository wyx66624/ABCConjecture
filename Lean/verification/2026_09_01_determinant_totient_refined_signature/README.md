# Determinant, totient, and refined-signature verification

This package validates three Lean modules from the September 1, 2026 abc
research checkpoint:

- `AffineDeterminantLayerEntropy20260901.lean`;
- `MersenneTotientDivisorConcentration20260901.lean`;
- `IUTRefinedFactorZeroAwareSignature20260901.lean`.

The validator scans comment- and literal-stripped source for `sorry`, `admit`,
`native_decide`, `sorryAx`, custom `axiom` declarations, `opaque`, `unsafe`,
`partial`, and `extern`. It parses every theorem and lemma with its active Lean
namespace and generates one independent `#print axioms` command for every
proof declaration.

Lean deliberately hides private constants from importing files. To avoid an
audit gap, `axiom-audit.lean` is a deterministic amalgamation of the exact
three source bodies with their original `#print` commands removed. It then
prints axioms for every parsed theorem and lemma in the same file scope, where
private logical names remain addressable. Each replay regenerates the expected
file in memory and requires byte equality before compiling it.

The three modules are compiled directly. The aggregate target must complete
exactly 9,212 jobs. All local Lean inputs and the Lake manifest are hashed, and
every Lake Git dependency must be clean at its pinned revision. Only Lean's
standard `propext`, `Classical.choice`, and `Quot.sound` axioms are allowed.

These checks establish kernel acceptance and complete theorem-level axiom
coverage for this checkpoint. They do not prove or disprove the standard abc
conjecture. See `COMMANDS.md` for the exact freeze, record, seal, verify, and
replay commands.
