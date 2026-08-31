# Pointwise theta-frame selection is not a global norm bound

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. The quantifier mismatch

A finite theta-frame inequality has the form

\[
 \forall\sigma\;\exists T:\quad
 |F_{\sigma,T}|\ge c\,\|a_\sigma\|.
\]

A number-field product formula for one algebraic quotient or one algebraic
section requires the different quantifier order

\[
 \exists T\;\forall\sigma
\]

or, more realistically, a lower bound on

\[
 \prod_\sigma |F_{\sigma,T}|.
\]

The pointwise frame theorem does not exchange these quantifiers.

## 2. Exact two-by-two counterexample

For any `delta>0`, consider two embeddings and two kernels with absolute
values

\[
 \begin{pmatrix}
  1&\delta/2\\
  \delta/2&1
 \end{pmatrix}.
\]

At each embedding the pointwise maximum is at least one.  The squared row norm
is also at least one, so the example satisfies the qualitative conclusion of
an `L^2` frame lower bound.

But the product belonging to either fixed kernel is

\[
 1\cdot\frac\delta2=\frac\delta2<\delta.
\]

Thus there is no positive lower bound for a common-kernel product that follows
only from the pointwise frame lower bound.  The accompanying Lean module proves
both the maximum and squared-energy versions over the real numbers.

## 3. Arithmetic interpretation

For a level field, complex embeddings generally permute the graph kernels.
A kernel that is large at one embedding may be very small at another.  A
pointwise choice of a different kernel at every embedding is not an algebraic
object and cannot be inserted into the product formula.

To pass from the finite frame to arithmetic, one therefore needs one of the
following genuinely global devices:

- a nonzero algebraic norm of one evaluation;
- a determinant or Pluecker section;
- an invariant polynomial in the full Galois orbit;
- a global slope theorem for an algebraic subbundle.

The companion determinant-normalization audit shows that the most immediate
full determinant and matching-column Pluecker constructions cancel their raw
theta coefficient order after source normalization.  Hence the pointwise
frame and the full determinant do not close each other's gaps.

## 4. Surviving target

The remaining theta route must construct a **globally algebraic, nonmatching**
section whose divisor has a genuine positive multiplicative-place excess over
its own source line degree.  Its complex conjugate norms must be controlled as
one algebraic packet, not by separate pointwise choices.

No such global section is assumed in the Lean development.
