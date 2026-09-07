# Independent review and reproducibility plan

Baseline main: `937cb77` (resolved before this research round).

The original user-designated PDF is the tracked 93-page August 31 artifact.
The current main source has SHA256
`f1f673a4b1de8bba0979a76d69f826177ade04126ba61cc30b2f45fbbffc15a9`.
The PDF tracked at the canonical name in main is 353 pages, SHA256
`fd73048426c64882d1d94e2d9e783e1a9c4695572d2573fe092e364682670567`.
The workspace begins with that canonical PDF locally deleted and an untracked
412-page Power_Support PDF. Those local changes are not research claims or
inputs to any mathematical proof and are preserved separately.

Independent mathematical review for the new round:

- The critical-bottleneck member develops shared exponent columns; the
  independent-route member audits the ordinary analytic proof.
- The independent-route member develops product-unit rigidity; the
  adversarial-audit member checks its complete proof and hypotheses.
- The adversarial-audit member develops cubic defect amplification; the
  coordinating member checks the direct radical compression, digit-lift
  existence, quantifiers, and distinction between relative and absolute defect.
- The coordinator's finite shared-column formal statement is checked against
  the ordinary proof by the critical-bottleneck member.

This is independent agent review within one research process, not external
peer review. A later discovered issue must be recorded and repaired before
the relevant statement is reused.

Validation will compile unchanged dependency sources afresh, then the new
scoped modules, under local WSL Lean 4.32.0 (compiler commit
`8c9756b28d64dab099da31a4c09229a9e6a2ef35`) with warnings as errors.
All new theorem declarations must have matching axiom queries. Only
`propext`, `Classical.choice`, and `Quot.sound` are permitted. This is a
scoped checkpoint check; it does not validate the whole repository or
formalize the analytic inputs and global conjecture.
