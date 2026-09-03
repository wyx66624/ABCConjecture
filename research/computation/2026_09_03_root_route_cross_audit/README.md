# Root-route cross-audit capsule

This directory independently audits the 2026-09-03 Mersenne--Farey
quantitative swarm and alternative-quality packing routes.  It does not
modify either route, the umbrella theorem, or the main paper.

Run:

```text
python verify_cross_audit.py
```

The generated `cross_audit.json` records source-capsule hashes, source-text
scope anchors for Sankaran's Lemma 4.12 and Theorems 4.13/4.15,
theorem-level AxiomAudit coverage, exact auxiliary countermodels, and a
finite clustered-prime-log check.

The finite cluster output is not an asymptotic theorem.  The mathematical
PNT argument and the full quantifier audit are in
`ROOT_ROUTE_CROSS_AUDIT.md`.
