# Mathematical, source and manuscript-scope review

Author and coordinating reviewer: ChatGPT. Date: 2026-08-31.

The internal reviews pass for their explicitly stated scope. They
are not external human peer review and do not establish standard abc
or its negation. Mathematical proofs preceded Lean implementations.

| Component | Main research proof | Independent review and boundary |
|---|---|---|
| Complete two-prime support | ANALYTIC_UNIFORM_GATE_2026_08_31.md | Root/code review; actual radical and classification, no general support inference. |
| Actual trace and return | TRACE_COVARIANT_RATIONAL_RETURN_PROOFS_2026_08_31.md | Geometry review; actual trace and dimensions, explicit covariance and unit assumptions. |
| Odd-part fibre | ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md | Analytic review; proved finite injection and attained actual example. |
| Entire isogeny class | ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md | Root/IUT review; cyclic-degree classification, least-degree path, Frobenius and quotient graph. Classification remains outside Lean. |
| Actual Weil heights | FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md and formal proof note | Root/analytic review of all public/private proofs; actual signed reduced coordinates and library heights; necessary n≥1 restriction. |
| Native theta point source | IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md | Root/analytic review; one common full Galois lift per torsion tuple and actual attained hull. |
| Log-field coordinates | IUT_LOGFIELD_SHELL_COORDINATE_CROSS_REVIEW_2026_08_31.md | Geometry/root review; native unit, operations, scalar embedding and reference must be transported together. |
| Canonical local membership | IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md | Root/analytic original-source review; reciprocity comparison, inverse transfer, preceding carrier, selected-place scope and transported test vector. |
| Arithmetic bundles | IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md | Root/geometry calculation; genuine objects, exact weights/signs and isometric descent, without identifying the whole published pilot. |

These records and all cross-reviews are in research/. The comprehensive
root report is UNIFORM_CONTINUATION_ROOT_CROSS_REVIEW_2026_08_31.md.
UNIFORM_CONTINUATION_KERNEL_SCOPE_REVIEW_2026_08_31.md separately
recomputes 97+9 declarations, all 106 dependencies, warnings, core hashes
and historical replays. The geometry author's role is disclosed; the
additional analytic height review independently checks those modules.

The canonical local-membership report is frozen at SHA256
`6ca3f92988be870df06b3536d9f1f6b598e9ed1f87cbd2feef5d8785e3f6d3d9`;
its independent source review is frozen at
`c3e62d570623fec67dcdf8b09c116985c7155baada7435c2aad1932d0c4cf5a4`.
Later root approval is recorded separately instead of changing its
earlier review-status line. Both root and analytic agents read the
complete English input, with no required mathematical correction.
Its final SHA256 is
`2aae23c0559da16268b71b3b68beddd52defb561e5206c1fbe466c41376cd8b0`.

The six new English inputs were read against their proofs. Final
typesetting/scope edits are explicit:

- Entire-isogeny: a long module filename became a prose reference.
  Final SHA256 `fa8c19bbc5253501e30a9877e3232288e413c538ac7ffcae644b3bd20f2a387d`.
- Arithmetic bundles: the inline average became a displayed formula;
  no coefficient or sign changed. Final SHA256
  `13f5902e575e8d0070f7cc9bef47ba4468fcc05a250d4ce0c4ea6f23d4dd0855`.
- Heights: long module/API names in the final scope paragraph became
  prose references; mathematical statements and formal scope are
  unchanged. The reviewed input hash was
  `fa24fbcca18eafea6beb2d94ff40a6abca88f22ffff4c08d770854763e4e6ffe`;
  final input `29115592aacf7e4c11d4d73a10cb850547e8d653ba1b987a526d702fce33f116`.
  The Lean module remains `40421af9b48a4898b6e4982dbf68a0b1bdd17dd7885d8026bcfa734781a06587`.
- Theta points: the final boundary paragraph now points to the new
  one-branch inclusion, retaining the full global/Ind3 obligation.
  No proved formula changed. Final input SHA256
  `1a3951e316b97009cb323a794d1d798987c7fb633b3a5bb74eadc6f648e62ef8`.
- Analytic input unchanged at
  `d53545157b75539293e58735f36e917f5f1c492a1da4c357b695a62254f52196`.

The final main source hash is
`ed57c6990996fad3f981d22e2d43d7df937217063e853dc9de5daafabeecd7e4`.
The abstract and conclusion explicitly retain the absence of a proof
or disproof of general ABC. Actual four-model Lean minimization is
distinguished from entire-class classification, and local canonical
membership from the complete global comparison. Source reconstruction
theorems are explicit external inputs, not independently reproved here
in full. Source image checks are separate from final manuscript QA.
