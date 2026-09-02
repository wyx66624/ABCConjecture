# Adaptive-kernel, polylogarithmic, near-diagonal, and current-IUT verification

This package validates four Lean modules from the September 1, 2026 abc
research checkpoint:

- `AffineAdaptiveCommonKernel20260901.lean`;
- `MersennePolylogCodivisorGate20260901.lean`;
- `MersenneNearDiagonalGlobalTriage20260901.lean`;
- `IUTLanaCurrentConcreteImplicationAudit20260901.lean`.

The validator strips comments and literals before scanning for proof
placeholders, custom axiom declarations, native evaluation, opaque or unsafe
declarations, partial definitions, and external declarations. It parses every
theorem and lemma with its namespace and generates one independent
`#print axioms` query per proof declaration.

Because Lean hides private declarations after import, `axiom-audit.lean`
deterministically amalgamates the exact four source bodies and runs all 56
queries in the original scopes. The package also compiles each module directly,
checks every pinned Lake dependency, freezes all local Lean inputs, and rebuilds
the aggregate `IUTThreeClosures` target.

The `detached-current-iut-*` files record a separate audit of public LANA commit
`6e963070c73c5defd1012320deccc777e2555d22`. That checkout is not the dependency
used by the aggregate build. Its public `Iut` target was built first; the
detached audit then proves that the unrestricted real-valued `LocalTheory`
scaling law makes `LocalTheory K` empty. The copied upstream source and manifest,
commands, outputs, and hashes make the scope reproducible.

These checks establish kernel acceptance and the stated interface
counterexamples. They do not prove or disprove the standard abc conjecture.

