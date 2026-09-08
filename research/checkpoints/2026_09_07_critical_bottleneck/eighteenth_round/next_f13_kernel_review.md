# Independent audit of the finite F13 kernel

Status: full source, scope and execution-evidence audit PASS. This is a future-batch review, separate from every sealed publication.

The reviewer read all fifteen theorem signatures and proof bodies of research/checkpoints/2026_09_07_adversarial_audit/nineteenth_round/next_Lean/F13FixedCurveArithmetic.lean, the ordinary scope, report, complete verifier, validation manifest, and all fifteen actual compiler-log queries. The five hashes below were independently recomputed from current bytes:

| Item | SHA-256 |
|---|---|
| Lean source | a459a5f16e8f0b8f6a2dd2dbfd742c672721f3963220463eed10e8b456e006ec |
| Ordinary scope | d0135616ccf588da1d5ee58288184fab8386b1e0344f21ac0c48390dfe0fb1e1 |
| Verifier | c429f5f3f0fec012be8ea28911734f454b4a475af5276f22f01d0fa0dd6855fb |
| Validation manifest | c1732fee24ee5f93e87ed8e1aecd93687f87dba98f550002124c6826c2476294 |
| Fresh-build log | 9b802e7ef262bcb8ecb8508d3ad238ff5def73db1b1e01fdaf97ba92f0ae14df |

The evidence directory is next_verification/f13-20260908T055706020261Z/ relative to the author's nineteenth-round directory.

## Mathematical and semantic checks

The Bezout certificate is an equality in Polynomial (ZMod 13), with the literal derivative of the sextic. Its coefficient proof does not replace polynomial equality by thirteen evaluations. The stated coefficients cancel in every positive degree and leave constant coefficient one.

The affine table contains the fourteen actual pairs. The disjoint Sum (F × F) F model imposes the literal sextic equation in its first summand and epsilon-squared equal to one in its second. Its sixteen valid elements are therefore a precisely defined finite model; there is no unproved projective-curve constructor hidden in the count.

All projection statements retain the appropriate domain. The second affine chart explicitly requires nonzero z; the zero chart keeps only the first finite projection, while the infinity chart keeps only the second finite projection. In secondTarget, the explicit nonzero-z conjunct prevents field division at zero from creating a fictitious target.

The polynomials psi, d4, phi and the actual-curve substitution have the standard third-division numerator coefficients. The source proves their literal arithmetic substitution and finite exclusions, including the zero-chart value seven and infinity-chart value nine. It does not prove an equivalence with an abstract elliptic-curve multiplication operation. The final exclusion quantifies over every element of the finite model, not just a list of selected affine points.

The fifteen source theorems match the fifteen printed queries bijectively. Every observed query reports exactly the standard three axioms: propext, Classical.choice, and Quot.sound. Exhaustive statements use ordinary kernel-checked decide; the polynomial identity is proved algebraically. No sorry, new axiom, opaque oracle, or native_decide occurs.

## Execution evidence and its limit

The verifier checks the pinned Lean 4.32.0 and Mathlib revision, uses a fresh copied source/module directory with only the dependency cache reused, rejects placeholder/oracle constructs, checks theorem/query coverage, binds source bytes before and after execution, and records the complete log and allowed axiom union. The inspected manifest records an actual successful author fresh build with all fifteen queries and no warnings accepted.

This reviewer did not launch a second compiler execution. The conclusion is an independent full-source and evidence audit, not a claim of an additional fresh build.

The finite kernel does not formalize smooth projective geometry, elliptic multiplication, reduction of rational points, the prime-to-five global index, p-adic heights or zeros, completeness of the rational locus, or ABC. Those remain separate ordinary results or open global claims as stated in the author's scope.

## Complete paper transcription

I subsequently read research/checkpoints/2026_09_08_descent_and_shift/paper/f13_formal_scope.tex in full and recomputed SHA-256 70416807b07b252cd5b1f72845e1daa5f8cc8b51fd0599b5673b4b21fc8a529d. Full mathematical/source-scope transcription PASS. The actual integer expansion of the Bezout identity, fifteen names, table/model predicates, all three charts, and exact formal boundary agree with the source.

The second successful run's validation record, f13-20260908T060020018236Z/validation.json, was also actually inspected: it reports a distinct fresh project, the same source bytes, fifteen queries, exit zero, standard three axioms and the identical successful log hash. The manuscript correctly distinguishes the author and root compiler executions from this reviewer's source audit. No additional compiler or PDF visual execution is claimed here.

I subsequently actually reread the typography-only change placing the two unchanged run identifiers on centered small-type lines and recomputed the final TeX SHA-256 2bd7e074a77ae3d78df7d504a48bb712b1c45283e3ccd8cb0739c4a0a21bedba. The preceding full transcription PASS remains valid. This rebind is not a PDF visual inspection.
