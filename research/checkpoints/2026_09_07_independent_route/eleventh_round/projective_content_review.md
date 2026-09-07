# Independent review of the peer projective-content boundary

Reviewer: independent_route. Result: full ordinary proof and full TeX
transcription PASS.

Reviewed sources:

* `research/checkpoints/2026_09_07_adversarial_audit/eleventh_round/projective_content_boundary.md`
* `research/checkpoints/2026_09_07_adversarial_audit/eleventh_round/paper/projective_content_boundary.tex`

The final reviewed TeX SHA-256 is
`a2cb25096456564790719402d9e99e425bffc9f6891f244ef348406ac3b6433b`.

PC1 uses the exact multiplication-matrix adjugate and Bezout to show
content(tau W) divides N(tau) for primitive W. It does not require tau
itself to be primitive. Its application to primitive unramified powers
uses the actual Eisenstein factorization, and the resulting norm quotient
is not silently assumed to have an integral residual.

PC2 proves all powers of w=3-zeta are primitive by the norm-7 factorization
and the explicit reduction zeta -> 5 modulo 7. The six unit rotations
give positive coordinates, and the explicit n=5 example is consistent.
After cancellation the norm is 7^(n-1), so no nonunit integer root with
the specified exponent n is possible. Alternative exponents, including
n-1, remain allowed. This is a single-map inverse counterexample, not a
counterexample on the full double fiber product and not an ABC example.

The author reports exact replay of 24192 content rows and 128 positive
family rows, with canonical JSON SHA-256
`92bf3f119d79dde439aa3477a31cba2c70b09af6f1b1a72cb19536b358a0d025`.
This reviewer did not independently execute that replay and does not
count it as an additional run. The universal proofs were read directly.
