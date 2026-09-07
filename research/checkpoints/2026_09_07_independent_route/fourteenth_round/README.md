# Fourteenth-round independent geometry

The complete ordinary SS1--SS4 proof has full independent reviews from
root, critical_bottleneck and adversarial_audit. Its self-contained
paper source is paper/simultaneous_elliptic_gate.tex. The preceding
thirteenth-round sources remain frozen.

The new result keeps the two genus-two square roots at the same
power-map parameter: it gives an exact quartic equation over one fixed
elliptic curve, an invertible positive rational chart, a genuine integer
factor-allocation condition and an explicit degree-three isogeny
between the earlier two elliptic quotients. The simultaneous rational
point problem is not solved.

Lean/SimultaneousEllipticArithmetic.lean contains twelve declarations.
The author independently compiled all source bytes to a fresh temporary
olean with warnings-as-errors and inspected every axiom query; PASS.
The final source SHA is
0f16c95fd1057018c73cd27090543e43938e1258ef35d0ef478675642a921d6b.
The complete ordinary/formal boundary is in ordinary_formal_scope.md.
Root also reported an independent combined fresh build including these
twelve declarations; that is distinct from the author's execution.

Verification commands:

    python replay_simultaneous_gate.py --check
    python3 verify_mathlib.py

The latter runs in the repository's configured WSL environment using
Lean 4.32.0 and the pinned Mathlib commit. The former is standard-library
Python on either operating system. Its canonical certificate SHA is
0b0d5f29025dcd6618c17bfac17791483eb8a5f09466bca0bc4ea026a437c301;
it checks fifteen exact polynomial identities and eighty specified
signed multiples, with no rational-point completeness claim.

Cross-route ordinary reviews of AP/OC and DG and the source/scope
review of AdaptiveOwnerArithmetic are separate files in this directory.
No reviewed finite computation or formal arithmetic claim is presented
as a proof of the ABC conjecture.
