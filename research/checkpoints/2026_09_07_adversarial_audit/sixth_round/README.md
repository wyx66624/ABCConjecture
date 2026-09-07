# Sixth-round adversarial audit

The preceding five mathematical rounds remain unchanged. This round
studies actual moving integer-root intervals and reviews the separate
elliptic-curve entrance to the pure second-norm equation.

`root_height_windows.md` proves an actual finite-window average. For
`w_k=3k+zeta`, `B<=k<2B`, its strengthened bound is

    mean positive_window_excess / actual_height
      <=10 log Y/(Y^3 log(3B))+12(Z+1)/B+log n/(n log(3B)).

The last improvement uses the critical agent's exact-rank/totient
stratification, independently reviewed here. For `B=n^4`, one may
take `Z=n^3`, or `floor(B/(log n)^2)`, with `Y=n^(1/6)`. These
windows enter the possible top-rank prime range. Exceptional roots
and all primes beyond the chosen window remain open; ABC and its
full signed-tail gate are not proved.

The exact finite replay can be reproduced by

    python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_root_windows.py --check

It verifies 27 actual blocks, 216 prime rows, 1008 individual lifting
identities, 864 simple-root lifts, and 4904 actual layer inequalities.
The finite ranges are diagnostic checks of the ordinary arguments,
not a full prime-tail certificate or a Lean verification.

Canonical UTF-8 LF results:
`verification/root_window_results.json`

SHA256: `9c955ba3ed8d7a5c6f1ff1f7ac0e453377ca81d64cad08cb3b43d190d6fa80ce`.

The critical agent separately replayed the stronger exact-rank
root counts; its script and exact byte/payload hash distinction are
recorded in `rank_window_review.md`. That replay was also independently
read and rerun here.
The complete RW1--6 ordinary proofs and their scope passed the
critical agent's independent review. `rank_window_review.md` records
this agent's completed review of the rank refinement and its replay.
The parent review is complete and recorded in
`../../2026_09_07_quartic_compatibility/verification/ordinary_review.md`.

`paper/root_height_windows.tex` passed the critical agent's complete
final transcription review. Its definitions, full endpoint counting,
exact-rank refinement, Markov constants, and finite-window scope all
match the ordinary proof. The positive-integer rank domain is explicit.
This mathematical source is now stable for parent integration.

`qcurve_local_review.md` independently checks the other agent's actual
quartic curve, inverse square conditions, the two-isogeny twist, and
the complete local Tate branches at two and three. Its conductors
alone are not a rational modular newform level: the splitting
character, residual irreducibility, and remaining modular exclusions
are distinct requirements.

No new Lean theorem is claimed in this directory.

`boundary_shadow.md` and `paper/boundary_shadow.tex` prove that the
excluded boundary curve E0 is non-CM using two exact Frobenius
centralizers, and construct unbounded positive primitive local shadows.
They state a conditional zero factor in one specified Mazur product.
The fixed splitting character gives trace -4 at thirteen; membership
of the E0 descent in the enumerated candidate spaces remains an
explicit premise. Both independent research agents reviewed the
ordinary non-CM and shadow proofs and reran the finite certificates.
The independent-route agent additionally checked the character sign
and completed final BS1--BS4 TeX transcription review with PASS.
`paper/boundary_shadow.tex` is now stable for root integration.

`modular_replay_review.md` records the separately implemented exact
PARI/GP newspace computation. Its dimensions and orbit data agree
with the other agent's probe; they are not a proof of the level or a
global exclusion. `single_quartic_review.md` is the complete independent
ordinary PASS record for the root agent's SC1--SC5 conjugate-compatible
quartic descent, including smoothness at zero coordinates, connectedness
and coefficient-height scope.

The complete list of four finite replays, canonical byte hashes,
commands and precise scopes is in `verification/REPLAY_MANIFEST.md`.
