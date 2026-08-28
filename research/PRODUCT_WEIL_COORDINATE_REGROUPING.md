# Coordinate regrouping for the product Weil pairing

## 1. Two coordinate conventions

Let `V=F^2` with standard symplectic form

\[
  \omega((a,b),(a',b'))=ab'-ba'.
\]

An element of `E[ell]^2` is written in elliptic-copy coordinates as

\[
  ((a_1,b_1),(a_2,b_2))\in V\oplus V.
\]

The product Weil pairing is

\[
 \omega((a_1,b_1),(a'_1,b'_1))+
 \omega((a_2,b_2),(a'_2,b'_2)).
\]

For the transverse-graph construction, regroup the coordinates as

\[
 A=(a_1,a_2),\qquad B=(b_1,b_2).
\]

Thus

\[
 \Phi((a_1,b_1),(a_2,b_2))=(A,B).
\]

### Theorem 1.1 (regrouping identity)

Under `Phi`, the product Weil pairing becomes

\[
 \boxed{
 \Omega((A,B),(A',B'))
 =A^tB'-B^tA'.}
\]

### Proof

Expand both sides:

\[
 a_1b'_1-b_1a'_1+a_2b'_2-b_2a'_2
 =A^tB'-B^tA'.
\]

## 2. Correct graph criterion

In the regrouped coordinates, define

\[
 H_T=\{(A,TA):A\in F^2\}.
\]

For graph vectors,

\[
 \Omega((A,TA),(A',TA'))
 =A^t(T-T^t)A'.
\]

### Corollary 2.1

`H_T` is isotropic for the actual product Weil pairing if and only if `T` is
symmetric.

Since `H_T` has dimension two in a four-dimensional symplectic space, a
symmetric graph is maximal isotropic.

## 3. Tate-line transversality in the same coordinates

A line of finite slope in one copy of `E[ell]` is

\[
  L_\lambda=F(1,\lambda).
\]

Its diagonal two-copy subspace is

\[
  L_\lambda^2
  =\{((a_1,\lambda a_1),(a_2,\lambda a_2))\}.
\]

After regrouping this is exactly

\[
  \{(A,\lambda A):A\in F^2\}.
\]

Therefore

\[
 H_T\cap L_\lambda^2\ne0
\]

if and only if `lambda` is an eigenvalue of `T`.  The vertical line corresponds
to `A=0` and also meets a graph only at zero.

### Corollary 3.1

A symmetric operator with no eigenvalue in `F` gives a subgroup which is
simultaneously:

1. maximal isotropic for the product polarization;
2. complementary to `L^2` for every cyclic line `L subset E[ell]`.

## 4. Resolution of the temporary audit conflict

A direct-sum pairing applied to the displayed pair `(A,TA)` treats `A` and
`TA` as the two elliptic factors.  They are not: they are the grouped first and
second symplectic coordinates across both factors.  The explicit `ZMod 5`
calculation with that direct-sum pairing is therefore a counterexample only to
the mistaken coordinate interpretation, not to the symmetric transverse
kernel.

The original symmetric construction and its principal-polarization claim are
restored.  The anti-symplectic graph is an alternative linear-algebra object,
but it is not needed for the product-polarized transverse quotient.
