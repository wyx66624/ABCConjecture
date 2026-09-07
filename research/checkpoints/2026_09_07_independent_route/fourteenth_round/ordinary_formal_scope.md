# SS ordinary proof and the exact scope of twelve Lean declarations

The complete SS1--SS4 ordinary proof has been independently reviewed in
full by root, critical_bottleneck and adversarial_audit. Only after those
reviews was the arithmetic module completed. The first source compilation
of all twelve declarations passed with only the standard axioms;
verify_mathlib.py then independently compiled a temporary source copy
to a fresh olean with warnings treated as errors. All twelve axiom
queries passed. Source SHA256:
0f16c95fd1057018c73cd27090543e43938e1258ef35d0ef478675642a921d6b.
The canonical verification/mathlib_validation.json SHA256 is
5c424d7e8e6459bc28c17ef6c9a0f4c06ad58d08ee8bd19a440a2d7b1c5428d5.

The module is Lean/SimultaneousEllipticArithmetic.lean, using the pinned
Mathlib cache. Its names mean the following.

- discriminant_identity proves H(X)^2-f(X)R(X)=J(X)^2(4X+9)
  for the actual integer polynomials, with no supplied identity premise.
- quartic_conic_identity proves the actual quartic/conic polynomial
  equality, again for all integer inputs.
- homogeneous_quartic_conic and actual_homogeneous_conic use the
  actual integral elliptic equation B^2=A^3-9Ad^4-9d^6 and the actual
  cleared quartic to prove the homogeneous conic identity.
- square_factor_divides and square_factor_quotient prove genuine
  integer square divisibility and its quotient square equation. They
  do not assume the desired divisibility.
- actual_integer_conic_lift applies these results to produce an integer
  L with B^2-C^2=6d(A+2d^2)L and L^2=3B^2+C^2. The nonzero d and K
  conditions, supplied by the ordinary positive chart, are explicit.
- actual_curve_boundary_unit uses the actual Int.gcd(A,d)=1, actual
  elliptic equation, and p dividing d(A+2d^2) to prove p does not divide B.
  It derives this by the integral Bezout identity in the actual field
  ZMod p; a unit or valuation conclusion is not supplied as input.
- conic_cofactor_unit proves the complementary square factor is a
  p-unit from the actual conic equation and the preceding boundary
  unit. The prime and p>3 assumptions are explicit.
- square_factor_exact_depth proves equality of actual padicValInt
  values from a square factorization and a p-unit cofactor.
- actual_boundary_exact_depth combines the preceding results to prove
  v_p(B^2-C^2)=v_p(d(A+2d^2)) directly from the actual two homogeneous
  equations, gcd condition, nonzero d,K and the stated prime divisor.
  No supplied depth equality or cofactor-unit hypothesis remains.
- three_isogeny_rational_identity proves the displayed rational
  map satisfies the target Weierstrass equation identically for
  every rational X with X+3 nonzero. It proves the rational-function
  identity, not the geometric extension or degree of that map.

Remaining ordinary-only steps include C=Zd^3 being an integer from
its monic equation over Q, the existence of primitive Weierstrass
coordinates for every rational point, the birational model and all
projective extensions, the positive rational-point bijection, isogeny
degree/kernel, and the Jacobian decomposition. The final separate
allocation to exactly one of B-C or B+C and p not dividing C or L is
also ordinary-only; the full product-depth equality is formalized.

The general rational-point problem, an upper point-height bound, rank
upper bounds, and ABC itself are not proved by this module. The bounded
Python evidence is separate from the Lean proofs and from those open
statements.
