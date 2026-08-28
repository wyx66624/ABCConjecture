# Accepted theorem ledger: Thue--Siegel--Roth

## Interface name

`IUTThreeClosures.FixedCoreRothGapBridge.thueSiegelRoth_powerApproximation`

## Primary source

Klaus F. Roth, **Rational approximations to algebraic numbers**,
*Mathematika* **2** (1955), 1-20; corrigendum, p. 168.

## Classical theorem

For an irrational algebraic real number `alpha` and every `epsilon>0`, the
inequality

\[
\left|\alpha-\frac pq\right|<q^{-2-\epsilon}
\]

has only finitely many reduced rational solutions `p/q`.

## Exact normalized statement imported

For every positive integer `N`, there exists `C>0` such that for every
`x in N_{>0}` and `y in N`,

\[
C\le |\alpha x-y|^N x^{N+1}.
\]

## Derivation of the normalization

Take `epsilon=1/N`. Outside the finite exceptional set,

\[
|\alpha-y/x|\ge x^{-2-1/N}
\]

after replacing the reduced denominator by the possibly larger `x`. Multiply
by `x` and raise to the `N`th power. The finitely many exceptional rational
values have nonzero error because `alpha` is irrational; shrinking the constant
to the minimum of their positive normalized errors gives one positive `C`
valid for all `x,y`.

## Trust classification

- independently accepted theorem in the published literature;
- unconditional;
- not equivalent to abc;
- not an IUT source-to-height comparison;
- not currently formalized in the pinned Mathlib dependency graph.

Endpoint label: **closed relative to accepted theorem interfaces**.

The axiom audit must show this single named interface in addition to ordinary
Lean logical axioms. No theorem using it may be described as purely
Lean-kernel closed until Roth's theorem itself is formalized.
