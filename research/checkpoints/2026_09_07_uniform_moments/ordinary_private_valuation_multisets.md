# Private valuation witnesses and actual symmetric products

Ordinary proof before implementation. This is thirteenth-continuation
work, separate from the frozen published twelfth continuation.

Let I be a finite index type, G a commutative monoid, and a:I->G.
For each i suppose a monoid homomorphism

    v_i:G -> (Z,+),

where the target is written multiplicatively when giving a Lean monoid
homomorphism. Suppose v_i(a_i)=d_i is a nonzero integer, and v_i(a_j)=0
for every j different from i. No positivity or depth-one condition on d_i
is required. These are private valuation witnesses. The actual arithmetic
application obtains them from oriented prime ideal valuations on a
multiplicatively closed group of nonzero field elements. Constructing
those valuations from Eisenstein factorization remains an ordinary input.

For any finite multiset s of indices put

    A(s)=product_(i in I) a_i^(count_i(s)).

This is the actual product of its elements after mapping through a.
The equality follows by grouping a finite multiset by each distinct index.
In particular repeated indices keep their full multiplicity.

Applying v_i to this product gives

    v_i(A(s))=count_i(s)*d_i.

Every other summand is zero. Hence A(s)=A(t) implies
count_i(s)*d_i=count_i(t)*d_i for every i. Cancellation by d_i!=0 in
the integers gives equality of all counts, and therefore s=t. This
proves injectivity of the actual multiset product from private witnesses;
it does not merely assume that product injectivity.

Now let nu be a natural number, H a finite commutative monoid and
phi:I->H. Define its actual symmetric product by the same finite
count-product formula. Suppose equal such H-products on multisets of
length nu imply equal G-products of their actual a-values. This is the
explicit congruence-to-equality (rigidity) interface. UM1 ordinarily
supplies it in the deep-root application. The private witnesses then
make the H-product map injective on Sym(I,nu).

If M=|I|, the stars-and-bars formula is

    |Sym(I,nu)|=choose(M+nu-1,nu),

using natural-number subtraction. This formula includes M=0 and nu=0:
there is one empty multiset, and no positive-length multiset on the
empty type. Consequently

    choose(M+nu-1,nu) <= |H|.

If |H|<=3n, the same expression is <=3n. The existence of a monoid H
already includes its identity; no false claim about an empty target is
needed. There is no restriction on the tuple length in this finite
counting statement. The explicit rigidity hypothesis must be supplied
at the chosen length.

The planned Lean module will prove the grouping identity, private
valuation evaluation, count and multiset injectivity, and the actual
finite symmetric-product count. It will use Sym and its verified
stars-and-bars cardinality, rather than treating an arbitrary count
bound as the definition of independence. It will not claim a Lean proof
of ideal factorization, norm-support density, finite-ring lifting,
uniform determinant estimates or the analytic tail theorem.
