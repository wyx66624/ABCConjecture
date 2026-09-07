# Fourth round: signed support and depth entropy

The ordinary proof is `signed_support_entropy.md`; the manuscript input is
`paper/signed_support_entropy.tex`. The SE1--SE3 ordinary statements have
been independently reviewed by both the parent and adversarial agents.
The complete TeX transcription subsequently passed the adversarial
agent's independent final review. These files are ready for integration.

The finite primitive-pair reference law gives exact signed moments.
Conditioning on the actual supported primes retains the radical credit.
A uniform height bound makes the remaining conditional Shannon entropy
sublinear as the cutoff tends to infinity. The resulting allowance is
equivalent to the one-sided signed target, and has not been bounded on
the actual power orbit. No ABC solution or new Lean probability theorem
is claimed.

Run the reproducible finite checks with

```text
python research/checkpoints/2026_09_07_critical_bottleneck/fourth_round/replay.py --check
```

The checked payload in `finite_replay.json` has canonical SHA-256
`9cf9f7cdfbbbc671d63e2c05c4641b8ef6d4c299ea70f0d5eaeef28684a6f67e`.
It covers nine exact local distributions (407,952 primitive states), a
CRT joint distribution (28,800 states), and an exact fraction identity
for conditional entropy on fifty actual primitive boundary seeds. The
actual ensemble includes a common retained support with several depths,
including both signs of the signed contribution. Thirteen finite
stars-and-bars ranges are counted independently by recursion.
Probability calculations use rational numbers, including convergent
generating-function evaluations at rational arguments. The entropy
identity is checked in exponentiated form using exact fractions; there
is no floating-point entropy assertion. These finite checks support
the ordinary proof and are not substitutes for its infinite statements.

`review.md` records independent reviews of the other two agents' new
fourth-round ordinary proofs and the third-round typography handoff.
All third-round source files remain frozen.
