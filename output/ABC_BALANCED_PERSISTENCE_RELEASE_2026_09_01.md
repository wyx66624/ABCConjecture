# Balanced-persistence continuation release

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Release status:** validated research checkpoint; standard abc remains open

This release advances both the positive and counterexample programs without
claiming an unconditional proof or disproof of the abc conjecture.

## Mathematical results

1. The affine-shear exceptional set satisfies the unconditional uniform bound
   `#E(X) << R^(-2/3) X^(2mu/3+epsilon)`.  The corresponding matching lower
   gate remains open.  A local same-prime independence model is refuted, while
   the construction route remains active.
2. Every hypothetical squarefull balancing term forces, at an odd prime rank,
   four distinct balancing-Wieferich primes and one depth-three prime in each
   coprime Pell channel.  No depth-three prime occurs through 2,500,000; this is
   a finite exclusion only.
3. Every squarefull normalized Danilov remainder has index congruent to
   `122136955032565025967809449110840347537827` modulo
   `183205432548847538951714173666260521306741`.  The surviving progression is
   not decided.

The consolidated proof and route ledger is
`research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_09_01.md`.  Full proofs,
finite certificates, and independent audits are retained in the three detailed
route reports and their `tmp` audit bundles.

## Formal verification

The three result modules contain 57 theorem declarations and 30 definitions or
structures.  Four direct elaborations and the aggregate 9,151-job build exit
zero.  The source contains no `sorry`, `admit`, `native_decide`, declared
axiom, `opaque`, or `unsafe`.  The validation package is
`Lean/verification/2026_09_01_balanced_persistence_continuation`.

The formal boundary is explicit.  The analytic de Bruijn/BBLT input and the
literature theorems of Cohn, Ljunggren, Sanna, and the elliptic-divisibility
sources are cited mathematical inputs, not project axioms.  The Walsh branch
retains its positive-rank hypothesis.

## Paper

The English journal manuscript is
`output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_09_01.pdf`:

- title: *Uniformity, Prime Support, and Reachable Lattices in Approaches to
  the abc Conjecture*;
- author metadata: ChatGPT;
- format: A4, 111 pages, 844,056 bytes;
- SHA-256:
  `609962b0bf64daf51e5822410c1dbcdff4f55ae452c70d2da6db9fc3e9f87bbc`.

Tectonic compilation, extracted-text checks, claim audit, and rendered-page
inspection pass.  The QA package is
`output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_09_01_QA`.

## Persistence rule

No route is closed because it is difficult or because a finite search has no
hit.  A full-hypothesis counterexample rejects only its exact proposition, and
a no-go theorem closes only the mechanism covered by its quantifiers.  The
affine, Pell, Danilov, elliptic, Frey, geometric, and IUT parent routes remain
active at the gates recorded in the consolidated report.

The 40-file checksum ledger is
`output/ABC_BALANCED_PERSISTENCE_RELEASE_2026_09_01_SHA256SUMS`.  Run
`output/verify_release_2026_09_01.ps1` from the repository root to replay every
SHA-256 check.
