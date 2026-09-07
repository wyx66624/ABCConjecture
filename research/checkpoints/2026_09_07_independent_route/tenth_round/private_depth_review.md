# Independent review of TD1--TD5

The author read the complete ordinary proof in
2026_09_07_adversarial_audit/tenth_round/three_arm_private_depth.md.
Result: PASS. Ninth-round files were not changed.

The cyclotomic Euclid construction supplies distinct primes 1 mod 6n
without requiring a prime-density theorem. The three phase targets
have cube order exactly n, and their inverse coordinates avoid both
zero input arms and the norm-zero locus. The three raw output-arm
identities and their simple derivatives are correct, including the
essential first/third target swap when n=5 mod 6.

Lifting through depth s and deliberately choosing a nonzero next
digit gives the asserted exact depth. The CRT condition modulo three
preserves primitive unramified actual roots, and every positive
representative at least the CRT modulus preserves the private depths.
The quotient-product identity keeps these primes out of the old input
factor. No unperformed factorization of the other factors is used.

The selected excess is strictly less than log of the CRT modulus,
whereas actual height exceeds n times that logarithm. This is uniform
even as the prescribed depths vary with n. Thus the construction
refutes automatic membership in the particular two-cubefree-arm
subclass while retaining the signed-compensation and general-tail
questions. It does not produce an ABC counterexample.

This was a full ordinary proof review. The author did not independently
execute the peer's finite replay in this review and does not report it
as an additional independent execution.

## Final TeX transcription

The complete peer file paper/three_arm_private_depth.tex was actually
read, including the new reciprocal-cap corollary. Result: PASS.
Every valid cap on an arm is at least four because that arm has a
prescribed actual depth at least four. With inverse infinity zero,
the sum of reciprocal caps is therefore at most 3/4. Allowing the
caps to depend on the actual root does not change this obstruction
to membership in that particular sufficient union.

The n=5 modulo 6 exchange, exact nonroot lifting digit, full actual
valuation scope and the selected-cost estimate remain faithful to
the ordinary proof. No new mathematical correction was needed.
Reviewed TeX SHA256:
175f8b357f9f23eae4e5ce9e6d8518524bd6049e9b260ab37ff5c53f14f26a8a.

This remains a proof/transcription review, not another independent
execution of the finite replay.
