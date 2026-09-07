# Independent review of the actual integer-radical logarithmic bridge

Date: 2026-09-07. Full ordinary proof and all six new Lean signatures and
proofs reviewed: PASS. The complete current seven-module validation
manifest and all 84 theorem axiom outputs were read. Current hashes,
theorem counts, exact query coverage, and allowed axiom names were also
independently checked by a separate inventory script. The root performed
the fresh compilation; this review did not duplicate that run.

Source: `2026_09_07_integral_lifting/Lean/ActualResidualLogThreshold.lean`.
SHA256: `58667046ae1ec29f7a11999dcb1899b6fa41a7fd889a1afb383370769a7cd297`.
Ordinary proof: `2026_09_07_integral_lifting/ordinary_log_threshold.md`.
SHA256: `9b18ecd87795ddd5e6b53ad2a1a70b8aeb6bbb024a2e94c90880b83ea04dbcd2`.

The finite product is built from the actual Nat.primeFactors support.
Every factor is prime and positive, so the product is positive, including
the empty-support total convention at zero. The actual prime-log sum at
cutoff zero is proved equal to the logarithm of this actual positive
integer product using the finite product log identity and nonzero factors.
This establishes a formal sum-to-integer bridge, rather than assuming a
desired radical identity. It uses the defined integer prime-support
product, not a silently substituted different API with a different zero
convention. For positive arithmetic inputs it is exactly the usual radical.

The joint threshold equivalence has both V,V' positive. Hence V V' and
7^n are positive, and strict monotonicity of log legitimately converts
the sum of logs to the strict product inequality. It holds at n=0 as
well (both sides are false), while the ordinary normalized threshold
explicitly restricts division by n to positive n. Equality is correctly
excluded and is genuinely realized by the norm-seven example.

The content-one logarithmic theorem retains the previously explicit
actual support bill, all-primes-at-least-seven premise, and C nonzero.
It does not derive any of those arithmetic inputs from a projective
point. The last two declarations exactly translate the existing global
signed identity and height lower bound into log of the integer support
product. Their height, tail, and small-mass assumptions are unchanged.
They supply neither the oriented factorization law nor uniform tail
estimates nor actual point existence. The ordinary note states the same
scope and is mathematically complete for this finite bridge.

## Final combined inventory

Manifest: `2026_09_07_integral_lifting/verification/mathlib_validation.json`.
SHA256: `57b98f4f0e29d09b97805e6bc963a60e918c63564bf5d67f1a6f00dc8f1df711`.
Fresh build/axiom log SHA256:
`705d72e4d177478551be30ddb36b560a7a13c3671105f2b273481b9807c4b983`.

All seven module source hashes match. The 31 new declarations are
9 actual global signed + 9 actual projective content + 7 reflected
residual arithmetic + 6 actual logarithmic threshold. The 53 unchanged
declarations are 29 Eisenstein + 17 prime-log compensation + 7 prime-log
height. Exactly one matching axiom output exists for each of the 84
listed theorem queries; the only axioms are propext, Classical.choice,
and Quot.sound. The sources of the previously reviewed nine content,
seven residual, and nine global bridge declarations remain unchanged.

The compiler and cache revisions are Lean 4.32.0 commit
8c9756b28d64dab099da31a4c09229a9e6a2ef35 and Mathlib
81a5d257c8e410db227a6665ed08f64fea08e997. The seven local modules were
freshly compiled, while the pinned Mathlib cache was reused. This is the
current combined snapshot, superseding the earlier 9+29 and 16+29
manifest/log snapshots documented in the preceding review files. It is
not a whole-repository rebuild or a formal proof of ABC.
