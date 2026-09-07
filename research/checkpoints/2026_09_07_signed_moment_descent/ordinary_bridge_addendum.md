# Concrete diamond to the actual high-depth cardinality

This addendum is to be reviewed before implementation. It uses the already
reviewed actual signed-product and finite-diamond theorems, without adding
an arithmetic rigidity or target-size assertion.

Let s be a finite set of indices with actual elements a_i of a commutative
group G and private integer-valued homomorphisms v_i. Let phi_i lie in a
finite commutative group H of cardinality at most n. Suppose n <= 2r^2.
For every distinct i,j in s, use the actual two-element arrays (a_i,a_j)
and (phi_i,phi_j). Assume equality of the latter signed products on two
points of the concrete diamond D_r implies equality of the former.

If i and j were distinct, their restricted homomorphisms would have zero
off-diagonal and nonzero diagonal integer values. The existing actual
diamond injection would then imply 2r^2+2r+1 <= n <= 2r^2, impossible.
Thus any two elements of s coincide, and |s| <= 1. This includes r=0,
when the target-size hypotheses themselves may be inconsistent.

Apply this to the actual filtered set of depths at least
max(4,ceil(2rL/w)). Together with the explicit lower-layer inequality
2|{i in s: e_i>=4}|^2 <= n, r^2<=n, L>=0, w>0, and the actual caps
e_i w<=nL, the already reviewed actual_single_owner_budget theorem gives
2 sum_i (e_i-3)_+ w <= 5nL, including every finite depth layer.

The intended new bridge proves the cardinality conclusion from actual
products. The lower-layer bound, finite target size and modular rigidity
remain explicit. No complete arithmetic instantiation or all-prime sum
is asserted.
