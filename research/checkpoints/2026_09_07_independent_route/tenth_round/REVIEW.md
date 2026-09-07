# Tenth-round review ledger

## MX1--MX4

- Complete ordinary mathematical review: root PASS; critical_bottleneck
  PASS; adversarial_audit PASS.
- The root-requested QC-domain clarification was implemented: an actual
  primitive quartic has no factors 2,3,5, so Q>1 implies Q>=7.
- The QC coefficient convention was made explicit: the mixed equations
  use the inverse coefficients, with equal heights and unchanged counts.
- Final TeX transcription: critical_bottleneck PASS; adversarial_audit
  PASS. The root's final TeX read is awaited.
- No Lean geometry or point-height upper bound is claimed.

## DC1--DC4

- Complete ordinary mathematical review: root PASS; critical_bottleneck
  PASS; adversarial_audit PASS.
- Both peers independently verified that the g-free condition can be
  removed: each actual oriented exponent is the sum vq(V1)+g*vq(Q)
  with two nonnegative terms. Shared oriented factors are permitted.
- Root read the final version without the g-free assumption and confirmed
  its complete ordinary proof, including the arbitrary relative-exponent
  height comparison and its constants.
- Final TeX transcription: critical_bottleneck PASS; adversarial_audit
  PASS. The root's final TeX read is awaited.
- The degree-hg geometric lifting, coefficient bounds and point-height
  separation are ordinary results. Neither actual point-height upper
  bounds nor the existence of simultaneous small-residual families are
  assumed or concluded.

## RD1--RD3, separate new note

- The separate complete rational-map descent proof is in
  `rational_map_descent.md`; it is not silently added to the reviewed DC
  manuscript. Its full ordinary proof has adversarial_audit PASS and
  critical_bottleneck PASS; root review is pending.
- Final TeX transcription and the bibliography linkage: both peers PASS.
  The power-map lemma explicitly quantifies its positive integer n.
- Direct source checks: Stacks Project Section 53.2, especially Lemma
  53.2.2 and Theorem 53.2.6, for smooth projective function-field models;
  Section 53.12 for characteristic-zero Riemann--Hurwitz.
- The explicit rational model's height includes O(h+g). It does not
  reuse the sparse quadratic model's exponent-free coefficient bound.

## Reviews supplied to peers

The complete TD ordinary proof and final TeX were actually read, and all
seventeen declarations of ReciprocalDepthArithmetic.lean were read with
their proofs. The independent records are in this directory. They do not
claim an additional software replay or fresh Lean compilation.

The follow-up PC1--PC2 projective-content ordinary proof was also
actually read and passed. It is reserved for the next batch, rather
than being inserted into the three current mathematical chapters.
