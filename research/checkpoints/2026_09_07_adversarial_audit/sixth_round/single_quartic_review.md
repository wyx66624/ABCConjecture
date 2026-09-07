# Independent review: conjugate-compatible quartic descent

Date: 2026-09-07. Reviewed the complete root-agent draft
`2026_09_07_quartic_compatibility/single_quartic_descent.md`, SC1--SC5.
Result: PASS as an ordinary mathematical argument. No Lean claim.

SC1's degree-four field, signature (0,2), discriminant upper bound117,
and possible order index primes are correct. Minkowski's bound is
strictly below two, forcing class number one. This is a theorem using
the explicit bound, not a numerical class-group guess. Unit rank one
follows from the signature.

SC2 uses primitivity to make b a unit at each rational prime dividing
F. Away117, the actual residue alpha=a/b identifies one simple linear
factor and one degree-one prime ideal. The order index is harmless
there. At thirteen the exact norm valuation one proves uniqueness,
residue degree one, and depth one even though ramification is allowed.
Three is absent. Thus Norm(A)=V, Norm(B)=Q and (ell)=A B^g are exact,
including shared support of V and Q. Principal integral generators
exist because the relevant integral ideals are principal.

SC3 correctly counts one actual unit class in the quartic field;
its four embeddings do not require four new choices. All three
cover ratios inherit the same kappa. Geometric Kummer independence
uses the valuations at the four distinct roots, and works for
composite g as well. The stated count and union over V are valid
upper bounds with repetitions. They do not count actual solutions.

SC4's rank-one unit balancing has mean log(V)/4 at each of the
two conjugate-pair absolute values. The integral generator bound
h(delta)<=log(V)/4+C and h(xi)<=log(V)/2+C'g follow. The remaining
linear-in-g unit term is not silently discarded.

For SC5, the four embedding coordinates form an invertible linear
change. The image line meets each coordinate hyperplane once and
never two together. A relation between its two defining gradients
would be an annihilator supported on the at-most-one zero coordinate.
No nonzero such vector annihilates the line, which contains the
all-ones vector. The Jacobian consequently has rank two everywhere.
Nonemptiness is also explicit over the algebraic closure: choose a
point on the line and take g-th roots of its four scaled coordinates.
This yields a smooth projective curve of pure dimension one.

On Z4!=0 its function field is the same connected degree-g^3 Kummer
extension as in SC3. The locus Z4=0 maps to one point of the line
and is finite; it cannot contain an additional curve component.
Thus the entire intersection is geometrically connected. Adjunction
for a (g,g) complete intersection, or the four-point Kummer cover,
gives genus 1+g^2(g-2).

The coefficient-height assertion is unaffected by rational basis
coordinates. Clear the common denominator of kappa and choose its
primitive integer coordinate vector. Its projective height is
O(log V+g) by the fixed inverse embedding matrix. The monic minimal
polynomial of alpha bounds the integer multiplication constants
exponentially in g; the multinomial sum is4^g. Hence the coefficient
height of each defining degree-g form is O(log V+g). Actual integral
beta need not have integral coordinates in the order basis, and the
argument never requires this. Its rational projective point is enough.

Finally, projective scaling of beta scales a,-b by a common g-th
power; it recovers a/b but does not automatically give integral,
positive, coprime seed coordinates from an arbitrary rational point.
The draft explicitly preserves this scope. Smoothness, finite cover
count, and controlled coefficient height yield no point-height bound
and no ABC proof.
