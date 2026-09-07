# Ordinary proof preceding the finite pair-phase formalization

The complete MC1--MC4 ordinary proof, including the lower cutoff
Y=6n^3, was reviewed in full by root, independent_route and
adversarial_audit before this formalization.

The new Lean module has the following finite scope.

1. Actual multiplication of (a,1) and (b,1) in the already defined
   integer Eisenstein ring gives coordinates (ab-1,a+b+1).
   Subtracting the two conjugate cross products gives (D,-2D),
   where D is the actual degree-three phase determinant.
2. For a positive rational phase u/v, the exact identity
   (va-u)(vb-u)=u^2+uv+v^2 follows from its cross-multiplied equation.
   Each factor is positive when the two root parameters are positive:
   for example b(va-u)=u(a+1)+v>0.
3. The first positive factor determines a, and the nonzero second-factor
   equation determines b. Thus the actual finite set of ordered pairs
   injects into Nat.divisors of the positive constant's natural absolute
   value. Its cardinality is bounded by that actual finite divisor set.
   Diagonal pairs are not removed.
4. For parameters in [3B,6B), B a positive integer, the actual
   coordinates obey 0<r<=36B^2 and 0<s<=12B. Their cross determinant
   has absolute value at most 864B^3. If a positive modulus exceeding
   this bound divides it, it is zero. The module retains the divisibility
   as an explicit interface from the ordinary finite-ring argument.
5. The reduced positive phase bounds u<=36B^2 and v<=12B give
   u^2+uv+v^2<=2500B^4. This numerical bound is proved in the module;
   extraction of the reduced fraction from a group-image class is
   supplied ordinarily.

The complete fiber-cardinality theorem is not a premise asserting
that the map is injective. Its proof derives the injection from the
actual phase equation and factor positivity.

An exact example guards against accidentally strengthening this to
pair-product injectivity. For n=7 and B=2401 the two distinct unordered
root-parameter pairs (7809,10767) and (8397,9819) lie in the actual
3k block and both have phase 4526. Their factor constant is 20489203,
with factorizations 3283*6241 and 3871*5293. The module checks the
closed integer equalities; the example does not assert fourth-depth
membership at a common prime.

The module does not formalize the order of the finite norm-one group,
its lifting, the reduction from fourth depth to that group, the
asymptotic divisor estimate, Brun--Titchmarsh, the actual mean bound,
or any exceptional-set theorem. Compilation and complete axiom
inventory are recorded separately by verify_phase.py. A completed
finite core must not be described as a complete formalization of
the analytic MC theorem or of ABC.
