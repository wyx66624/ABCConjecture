# Independent final source and scope audit: JP/QS arithmetic

Status: full semantic source review PASS for the ten theorems in
`JointPhasePackets.lean` and seventeen in `QuotientCurveArithmetic.lean`.
The complete final source bodies and all theorem signatures were actually
read, together with `ordinary_formal_scope.md`, `actual_phase_bridge.tex`
and `sixteenth_research_status.tex`. No compilation was started by this
reviewer. Exact final hashes and the checked author verification evidence
are in `root_final_formal_review.json`.

## Actual phase source

The integer coordinate definitions use the actual Eisenstein rotation and
determinant. Addition, norm and the cubic discriminant are proved by ring
arithmetic. The strict height/divisibility conclusion is obtained from a
nonnegative integer square, so signs of m and individual coordinates do
not create an omitted branch. The hypotheses themselves exclude m=0.
The product-modulus statement uses actual pairwise integer coprimality;
different local phase choices are retained.

The finite injection and cardinality theorems explicitly assume hlocal,
hheight and hsep, as well as hcop and the finite target bound hcard.
Their target is the dependent finite product, whose cardinality is at most
n raised to the cardinality of S. The source does not construct the
arithmetic reduction maps, prove their torsion cardinalities, enumerate
the full signed ball or establish arbitrary-root membership.

The last theorem uses a genuine group homomorphism phi with a kernel
killed by three. Applying each actual multiplicative integer-valued
homomorphism to the cube of the quotient and using the proved signed
valuation formula cancels the nonzero diagonal, including negative values.
The product-injectivity conclusion is proved, not supplied as a premise;
construction of the private valuation witnesses remains an application
input.

## Finite curve source

The homogeneous cubic, Mobius iterate and factor difference are literal
integer identities. The eight finite counts enumerate all ordinate/base
pairs using the stated ZMod-p multiplication or explicit quadratic-pair
multiplication. Their +2 terms are explicit arithmetic constants. The
interpretation as two projective infinity points, good reduction and the
quadratic algebra being a field remain the ordinary chart and nonsquare
arguments. Nothing in the Lean type asserts that those geometric facts
were derived from the pair definition.

The two nonsquare theorems are elementary integer proofs. Their trace-factor
consequences retain the exact coefficient equations as hypotheses. The
Frobenius-number and torsion-divisor theorems prove the numerical equalities
and coprimalities only. The curve/Jacobian trace theorem, rational simplicity,
absence of rational torsion, lower ranks, Neron--Severi classes and quadratic
Chabauty conclusions have not been silently formalized by these theorems.

## Final manuscript and verification scope

The root TeX faithfully matches the ordinary PB proof and the two finite
modules. The final domain clarification explicitly gives finite S and
natural n in the capacity proposition. The status distinguishes 27 new
theorems from 45 previously established dependency theorems, and fresh
compilation of the five local modules from reuse of the pinned Mathlib
compiled cache. This reviewer checked the final manifest and log, including
all expected axiom-query names and exact source hashes. Only the three
standard axioms listed in the manifest occur.

An intermediate manifest was seen while the author's final formatting-only
rebuild was running; that RUNNING snapshot was not counted as successful
evidence. The adjacent JSON binds the subsequently completed PASS result.
No whole-repository rebuild, full finite-field interpretation, intrinsic
genus-six QC locus, global radical estimate or ABC proof is claimed.
