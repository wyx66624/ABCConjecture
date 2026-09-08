# Independent final review of the root QS arithmetic and sixteenth scope

Result: PASS after full source/signature/proof reading. No source was edited.
The root's fresh compiler/axiom manifest was read and the source SHA was
independently recomputed. This review did not repeat the compiler.

Reviewed files and SHA256:

* `../../2026_09_07_joint_packets_and_jacobians/Lean/QuotientCurveArithmetic.lean`:
  c1c62d326a1e72bfcbd3a16f25689d9e91c7cf30d1088f49bfb28c2ad353910a.
* `../../2026_09_07_joint_packets_and_jacobians/ordinary_formal_scope.md`:
  06f6faa059474b44801bcd2daf3652babcde9c3e9aa2c55664ff4da9641c6adf.
* `../../2026_09_07_joint_packets_and_jacobians/paper/actual_phase_bridge.tex`:
  9d4685afa82463f404c81763733acc37a4514b05239c248089c18098ce182d20.
* `../../2026_09_07_joint_packets_and_jacobians/paper/sixteenth_research_status.tex`:
  ef9ec7d110e3f2c635af243a18c6f633a96a34a530386af8fac64f911939992c.

The seventeen QS declarations match the intended actual arithmetic:
three homogeneous identities; eight complete kernel-decided finite
enumerations; two integer nonsquare claims; two trace-factor contradictions;
the finite Frobenius-coefficient arithmetic; and the torsion gcd/divisor
arithmetic. The field-pair multiplication is explicitly (a,b)(c,d)=
(ac+Dbd,ad+bc), with D=2 modulo 5 and D=3 modulo 7. The polynomials
evaluated by qcubic are exactly the actual cubics in QS. The counts
enumerate all x,y pairs and explicitly add two; their interpretation as
smooth projective finite-field counts is correctly retained as ordinary
mathematics. No kernel proof asserts an unproved field equivalence.
The nonsquare and trace arguments include signed integers and do not
smuggle in a Jacobian decomposition. All seventeen axiom names in the
manifest match the actual declarations; its source SHA matches this file.

The actual three-phase TeX identities were independently checked using
x=ae-bc, y=ac+bc+be, d=ac+ae+be. The identity d=x+y and the norm product
give the exact discriminant square, including negative moduli and zero
pairs. The strict bound excludes a zero modulus and forces the square
of the divisible product to vanish. The pairwise-coprime product bridge,
finite capacity and cubic-kernel independence retain all their hypotheses.
This TeX review does not add a new full read of JointPhasePackets.lean
to the source audit above.

The final status section accurately separates 27 new plus 45 unchanged
local declarations (72 explicit axiom queries) from Mathlib cache reuse,
and the geometric/Jacobian/QH arguments from finite formal arithmetic.
The two parent gaps remain explicit: nonrectangular and full far-tail
incidence on the analytic side, and the uncomputed finite container plus
varying-parameter uniformity on the geometric side. Seventeenth QL closure
is not silently included in this publication. No PDF visual QA is claimed.
