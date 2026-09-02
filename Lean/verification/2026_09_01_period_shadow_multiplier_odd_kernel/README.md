# Period, rational-shadow, multiplier-index, and odd-kernel verification

This package validates four Lean modules from the September 1, 2026 abc
research checkpoint:

- `AffineCollinearPeriodEnergy20260901.lean`;
- `IUTRationalTripodShadowComparison20260901.lean`;
- `MersenneMultiplierIndexTwoArm20260901.lean`;
- `PellOddKernelThirdOrderPacket20260901.lean`.

The validator strips comments and literals before rejecting proof
placeholders and unsafe declaration forms.  It parses all theorem and lemma
declarations with their active namespaces, generates one `#print axioms`
command per proof, and compiles a deterministic same-scope amalgamation so
that private proofs are covered.  Each target module is also compiled directly
with warnings promoted to errors.  Only Lean's standard `propext`,
`Classical.choice`, and `Quot.sound` axioms are allowed.

The validation additionally replays the independent Pell odd-kernel verifier
and requires byte equality with its frozen output.  The replay checks the
exact parameter triple `(5000, 2000000, 191)`, all 668 bounded odd-prime
indices, 648189 repeated-factor candidate tests, and all 42 exact certificates
through index 191.  It records 187 bounded unresolved rows and makes no
asymptotic inference from them.

All local Lean sources, the Lake configuration, the four mathematical reports,
the relevant source notes and computation bundle, the integrated paper, and
its final PDF are frozen by SHA-256.  Every Lake Git dependency must be clean
at its pinned revision, and the aggregate target must complete exactly 9,224
jobs.

These checks certify the stated formal reductions and finite computation. They
do not prove or disprove the standard abc conjecture.  See `COMMANDS.md` for
the exact freeze, record, seal, verify, and ordinary replay commands.
