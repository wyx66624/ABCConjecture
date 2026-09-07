# Seventh-round independent review record

## Q13 ordinary proof and transcription

* The author and critical_bottleneck independently derived the actual
  elliptic twist, local descent exclusions, index and torsion calculation,
  and rational map. Both use exact algebra rather than a guessed Jacobian.
* critical_bottleneck read the complete ordinary note and passed all
  signed square classes, three local exclusions, dual image, isogeny
  quotient, Mordell--Weil index, good-prime torsion bound and map exceptions.
* adversarial_audit read the complete ordinary note and independently
  replayed the local tables and point counts. Its full review passed.
* The parent read the complete ordinary proof, derived the simpler
  integral map, and reviewed the all-integer homogeneous extension.
* The author's full independent review of the parent's IM1--IM5 passed:
  the coefficient 8788, the nonzero-U bridge and division only by `a-b`
  are exact. Both peers independently passed this integral map.
* critical_bottleneck and adversarial_audit fully read the Q13 TeX and
  passed it. The wording about positive X was clarified to refer to
  affine points with X nonzero, so that the two-torsion point is not
  called a positive-X point. The parent also passed the final TeX.
* The all-integer corollary adds no geometric premise: the already
  reviewed integral map works for signed and zero coordinates, and
  `s^2=a^4` factors over the integers.

## BC ordinary proof and transcription

* critical_bottleneck and adversarial_audit independently read BC1--BC3
  in full and passed the local multiplicative/finite-flat argument,
  Hasse cutoff, exact general matrix count and fixed-p density scope.
* adversarial_audit independently opened the Serre 1972 primary scan
  and Milne Chebotarev theorem and separately exhausted the matrix counts.
* The quadratic-twist extension and whole-orbit BC4 were then reviewed
  in full by adversarial_audit. The ratio of characters is retained as
  either trivial or chi inverse-square; it is not silently cancelled.
* critical_bottleneck fully read the final BC TeX and passed the twist
  domain, q=p exception, rational density factor 1/2 and all coefficient
  embeddings. The parent also read the full TeX and passed it.
* adversarial_audit completed its final full BC TeX and bibliography
  review: PASS. All three manuscript sources are now frozen for the
  parent's seventh-round integration. No new theorem is being inferred
  from a finite trace list.

## Primary-source verification performed by the author

* Serre 1972 author-institution PDF: actually downloaded, rendered, and
  visually read printed pages 259--260, including assertions (3), (6), (7).
* Milne ANT v3.08: actually opened Definition 8.30 and Theorem 8.31.
* Serre 1987: previously actually read Section 2.9 Proposition 5 and
  Section 3.1.6. The local criterion concerns the full residual module.
* Milne EC2: the earlier descent review actually checked Chapter IV
  finite generation and Corollary II.4.2 torsion injection.
* Ribet Korea 1992 Theorem 6.1 and its proof, and Khare--Wintenberger I
  Corollary 10.2: actually opened for the independent BM review.

## Cross-review of the independent BM proof

The author read the complete ordinary boundary-modularity note and its
final TeX in adversarial_audit/seventh_round. Both passed: the finite
character comparison over a fixed finite Galois extension; the GL2-type
abelian variety and modular twist; oddness and determinant; algebraic
Frobenius compatibility; the second auxiliary prime for removing the
first from the conductor; the actual boundary local conductor; and the
complete exact newform enumeration used for the orbit identification.
This is an ordinary proof with explicitly identified exact software
enumeration, not a Lean proof or an inference from a few matching traces.

## Seven-statement Lean bridge review

The author actually read the whole parent `ThirteenMapArithmetic.lean`,
followed its imports through `QuarticSupportArithmetic` to
`LocalPowerArithmetic`, and verified that `second` is the actual
`norm(a*b,norm(a,b))` with its proved quartic expansion.

The two complement identities, the integral cubic identity, the actual
weighted curve, nonzero-U statement, and existential nontrivial integral
point have the intended arbitrary-Int signatures and proofs. The seventh
theorem, `diagonal_of_integral_point_obstruction`, explicitly accepts
`hE`, the homogenized elliptic-point obstruction. This is a conditional
interface; the ordinary E(Q) classification has not become a proved
formal antecedent. No sorry, admit or custom axiom declaration occurs
in this module. Seven `#print axioms` commands are present.

Current reviewed SHA256:
`4f07b9574be916ad673d4b748b9eddb1614e7e1473721855ee693477658284f4`.
The parent reports a fresh successful 65-module build; this source/scope
review does not pretend to be a separate re-execution of that full build.

## Exact evidence

Both local standard-library replay scripts were executed and their
`--check` modes subsequently passed. Hashes are listed in README.
The parent also reports independently reading and running both scripts.
Finite evidence supplements the general ordinary proofs and does not
replace any elliptic, Galois or geometric theorem.
