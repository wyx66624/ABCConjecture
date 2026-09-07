# Tenth-round independent arithmetic boundaries

The ninth-round mathematics and PDF were frozen before these notes.

`three_arm_private_depth.md` gives an independently reviewed construction of
actual primitive unramified roots with prescribed private top-rank depths
in all three quotient arms simultaneously. Both research peers and the
root researcher completed full ordinary review: PASS. It only disproves
automatic membership in the two-cubefree-arm sufficient subclass; it
does not disprove signed compensation or ABC.

The root researcher has independently read the full TD1--TD5 ordinary
proof and returned PASS, specifically checking the elementary prime
supply, inverse ratio, normalized-arm swap, simple derivative, exact
CRT depths and the restriction of the O(1/n) cost to selected primes.
The critical-bottleneck reviewer also read the full replay source and
independently reran `--check`, returning the same canonical PASS result.
The independent-route reviewer did not claim a separate software run.
No new Lean verification of TD is claimed.

The exact finite supplement is `replay_three_arm_depth.py`. Its initial
write and subsequent `--check` invocation both returned
PASS for five exponent rows n=5,7,11,25,35; ten actual roots; and thirty
selected full-depth checks. The depths on the three arms are 4,5,6.
Every chosen prime is proved prime by trial division, each required
residue order is checked against every proper divisor, and every
selected Hensel lifting level is exhaustively checked for uniqueness.
Actual coordinates, quotient divisibilities, coprimality, norm and
boundary identities, the selected depths on all three arms and the
integer height-cost certificate are recomputed exactly.

Canonical UTF-8 LF result SHA256:
`71c8e1d1aa54ecef4048ca2ba05ded94e8efdce60a00b25e7fe707283e1ec0fe`.
The finite run does not factor the whole quotient arms, certify a
simultaneous second pure norm, or certify a signed-tail counterexample.

`full_mass_tail_review.md` records full independent ordinary review of
the analytic team's actual full-mass concentration theorem, FM1--FM3:
PASS. It carefully distinguishes that mass from signed cost and the
radical. These two tenth-round directions address different features of
the still-uncontrolled actual tail.

The complete TD paper is `paper/three_arm_private_depth.tex`, SHA256
`175f8b357f9f23eae4e5ce9e6d8518524bd6049e9b260ab37ff5c53f14f26a8a`.
Both research peers read the full TeX and returned final mathematical
transcription PASS. This includes the stronger cap-union corollary:
because all three chosen actual tail depths are at least four, every
valid finite cap is at least four, and even adaptively chosen caps
have reciprocal sum at most 3/4. This excludes automatic membership in
the coarse reciprocal-cap sufficient classes, while retaining the
unresolved net compensation condition. No rendered tenth-round PDF
review is claimed by these transcription reviews.

`paper_transcription_review.md` records final independent mathematical
transcription PASS for MX, DC, RC and FM. `actual_prime_log_review.md`
records full ordinary and source review of the root's 24 actual prime-log
and finite-height Lean statements, with independently checked source
hashes and root-produced fresh compiler and axiom evidence. It explicitly
distinguishes this audit from a second compiler run.
