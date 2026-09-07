# Independent review of the rank-stratified actual-root window

Date: 2026-09-07. Reviewer: adversarial agent.

Reviewed the complete ordinary proof in the critical agent's
`sixth_round/rank_stratified_root_window.md`, RW1--3. Result: PASS.

The norm-one fractional-linear map has exactly the claimed domain:
in the split case the two zero-norm residues are excluded, and in
the inert case all rational residues are allowed. The image omits
precisely the identity. Conjugation proves that the inverse belongs
to the rational residue field in the inert case.

Since `3|(p-chi_p)`, cubing has kernel three. Therefore each order
`d|(p-chi_p)/3` has exactly `3*phi(d)-[d=1]` preimages. These ranks
are prime to `p`; polynomial roots at this rank are simple and have
one lift at every depth. Retaining the initial residue retains its
exact rank, so no separate distribution hypothesis is introduced.

The depth cap uses the nonzero actual integer boundary and is valid
uniformly throughout `[B,2B)`. Its endpoint contribution includes
every depth, including depths much larger than one. For each fixed
rank the candidate primes lie in `3*d*j +/- 1`, with `j>=1`; in
particular the spurious `p=1` is excluded. This gives the claimed
`2*(Z+1)/(3*d)` bound even for `d=1`. The factor `d` in the cap
cancels this spacing, and `sum_{d|n} phi(d)=n` gives the discrepancy
`12*(Z+1)/B` after division by the actual lower height. No prime
number theorem is used.

The lifting part is at most `log n` at each root. Primes dividing
the root norm never divide its primitive boundary. Thus they need
no additional term. Every comparison with a common height lower
bound is applied to a nonnegative positive-excess quantity.

The resulting estimate controls an actual finite integer interval,
not just a finite-ring reference. The applications `B=n^4,Z=n^3`
and `Z=floor(B/log(n)^2)` meet the stated hypotheses eventually and
reach possible top-rank primes. They remain averages over roots and
finite windows. Neither a prescribed exceptional root nor the tail
above `Z` is controlled. In particular this is not an ABC proof.

The reviewed proof is integrated, with attribution, as RW5--6 in
this directory's `root_height_windows.md`.

Independently inspected the critical agent's exact `rank_root_replay.py`
and executed its `--check` successfully. The local counts enumerate
every residue at the retained precisions, rather than generating the
answer by the lifting formula being tested. The run contains 21 local
precision rows, 24 actual blocks, 1592 actual first-depth/LTE values,
891 exact interval layers, and 632 progression/totient checks.
Its compact canonical **payload** SHA256 is
`d4dfd5aeebe2d2eb55dcf119aa578a4f392d10ae67360afa9508c7afaf84ebe4`;
the separate JSON-file byte SHA256, independently computed, is
`7eefa2aa8936d2125dc5851456d9036eaf4666a00ea4daf211c4b54dc02a56fd`.
The retained primes are at most 61. These finite checks do not replace
the general ordinary proof and are not Lean verification.
