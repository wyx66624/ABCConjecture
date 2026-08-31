# ABC multi-route research note v24b: exact covolume of the compatible-derivation lattice

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. The normalized compatible-derivation lattice

For a positive primitive abc triple, write

\[
a=Aq_a,
\qquad
b=Bq_b,
\qquad
c=Cq_c,
\]

where

\[
A=\operatorname{rad}(a),
\quad
B=\operatorname{rad}(b),
\quad
C=\operatorname{rad}(c).
\]

The six integers `A,B,C,q_a,q_b,q_c` have disjoint prime support across the
three endpoints, and

\[
\operatorname{rad}(abc)=ABC.
\]

An admissible derivative triple can be written

\[
D_a=q_ax,
\qquad
D_b=q_by,
\qquad
D_c=q_cz,
\]

with compatibility

\[
q_ax+q_by=q_cz.
\]

Its normalized first two coordinates are

\[
L_a=\frac{x}{A},
\qquad
L_b=\frac{y}{B}.
\]

Thus the set of normalized compatible pairs is the lattice

\[
\Lambda=
\left\{
\left(\frac{x}{A},\frac{y}{B}\right):
q_ax+q_by\equiv0\pmod{q_c}
\right\}.
\]

Because `q_a` is invertible modulo `q_c`, the congruence map

\[
(x,y)\longmapsto q_ax+q_by\pmod{q_c}
\]

is surjective.  Its kernel in `Z^2` therefore has index `q_c`.  Rescaling the
coordinates by `1/A` and `1/B` gives

\[
\boxed{
\operatorname{covol}(\Lambda)=\frac{q_c}{AB}.
}
\]

Using `c=Cq_c` and `rad(abc)=ABC`,

\[
\boxed{
\operatorname{covol}(\Lambda)
=
\frac{c}{\operatorname{rad}(abc)}.
}
\]

This is an exact identity, not an estimate.

## 2. One derivation

The trivial additive derivative is represented by the diagonal lattice vector

\[
(A,B),
\]

whose normalized form is `(1,1)` and whose Wronskian vanishes.  Every
nondegenerate vector has transverse determinant equal to a nonzero integer
multiple of the lattice covolume.  Consequently

\[
|L_a|+|L_b|
\ge
\frac{c}{\operatorname{rad}(abc)}.
\]

This is the v24 single-Wronskian mass floor.

## 3. Two derivations

For two normalized compatible derivatives

\[
L=(L_a,L_b),
\qquad
M=(M_a,M_b),
\]

the Jacobian determinant is

\[
\det(L,M)=L_aM_b-M_aL_b.
\]

If they are linearly independent lattice vectors, then

\[
\boxed{
|\det(L,M)|
\ge
\operatorname{covol}(\Lambda)
=
\frac{c}{\operatorname{rad}(abc)}.
}
\]

The `l1` Hadamard inequality gives

\[
|\det(L,M)|
\le
( |L_a|+|L_b| )
( |M_a|+|M_b| ).
\]

Therefore

\[
\boxed{
( |L_a|+|L_b| )
( |M_a|+|M_b| )
\ge
\frac{c}{\operatorname{rad}(abc)}.
}
\]

Passing from one derivation to two can distribute the mass between two
vectors, but cannot remove the exact `c/rad` floor.

## 4. Consequence for geometry-of-numbers strategies

Minkowski reduction, successive minima, Bombieri--Vaaler bases, and similar
lattice methods can optimize the shape of a basis of `Lambda`; they cannot
make the product of basis lengths smaller than its covolume.  Since the
covolume itself is exactly `c/rad(abc)`, a proof that the compatible-derivation
lattice has covolume at most `rad(abc)^epsilon` is simply the abc inequality
rewritten.

Hence the following strategy is circular:

1. construct one or several short compatible arithmetic derivations;
2. use only powerful-part divisibility and triangle/Hadamard bounds;
3. conclude abc from the resulting normalized masses.

A non-circular arithmetic-differential proof needs information not encoded in
the bare lattice covolume, such as:

- extra divisibility beyond the powerful parts;
- a resultant or gcd relation between several Wronskians;
- signed archimedean cancellation stronger than `l1` bounds;
- local conditions forcing the determinant multiple to vanish or grow in a
  contradictory direction.

## 5. Lean formalization

The scalar determinant core is formalized in

```text
Lean/IUTThreeClosures/MultiWronskianDeterminantNoGo.lean
```

with theorems

```lean
abs_det₂_le_l1_mul_l1
l1_mass_product_lower_bound_of_quantized_det
determinant_mass_floor_is_sharp
```

The full index/covolume identity for the integral congruence lattice is the
next formalization target.  No abc conclusion is assumed in the current
module.
