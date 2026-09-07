# Review of the proposed finite density core

2026-09-07, adversarial_audit. Full ordinary scope review PASS; proposed Lean source not yet reviewed.

Source: research/checkpoints/2026_09_07_adaptive_precision/ordinary_density_formal_scope.md.
SHA256: 7878723c6307692b5e188844208977809269d879fddede0411ca94eab79549fc.

The actual cofactor identities use the integer equality 9b^2+3b+1=mc: multiplication reconstructs Q(b+mt), and the discriminant reduces to -27. Neither inversion of m nor local-prime simplicity is inferred in this finite core.

The mass split uses an actual finite set s and an actual e contained in s. Its pointwise exceptional indicator inequality sums correctly, including empty sets. In the more general weighted version, the nonexceptional bound (2-epsilon)l and exceptional bound 2l+c yield (2-epsilon)|s|l+epsilon|e|l+c|s|. The extra c on nonexceptional indices only enlarges the upper bound. Nonnegativity hypotheses are sufficient for applying the exceptional-cardinality and ambient-cardinality bounds.

The strict gain has the exact numerator computation (1-C0 epsilon^2)-(2-epsilon)/2=epsilon/2-C0 epsilon^2>=epsilon/4. If an additional numerator error is at most epsilon/8, the remaining quotient exceeds one half by at least epsilon/[8(2-epsilon)]. The domain epsilon<=1/10 guarantees the denominator is positive. No eventual estimate is discharged by the numerical algebra alone.

For the finite weighted cutoff, positive natural indices make every log(index) nonnegative. A term above the real cutoff z contributes at least log(z) times its weight, while the terms at or below it cannot reduce the moment. Since z>1, division by log(z) and exact finite partition give at least half the total mass at or below the cutoff. This includes zero weights and empty support.

The ordinary scope accurately leaves the Euler-product construction, its analytic moment bound, cofactor local roots, sieve inequality, actual prime-weight construction, ideal valuations and asymptotics outside the proposed formal core. No compiler run, source audit of a not-yet-delivered module, or full DG Lean proof is claimed in this record.
