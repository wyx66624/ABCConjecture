# The corrected cyclic-line object: determinant of cohomology

## 1. Motivation

The square evaluation map

\[
  H^0\!\left(E,\mathcal O_E((\ell-1)O)\right)
  \longrightarrow
  \bigoplus_{P\in C\setminus\{O\}}
    \mathcal O_E((\ell-1)O)|_P
\]

is singular: the principal section whose divisor is

\[
  \sum_{P\in C\setminus\{O\}}(P)-(\ell-1)O
\]

lies in its kernel.  This document constructs the canonical replacement rather
than discarding the broader torsion-energy route.

## 2. Exact evaluation sequence

Let `E/k` be an elliptic curve with origin `O`, let `C` be a cyclic subgroup of
odd prime order `ell`, and put

\[
  D_C=\sum_{P\in C\setminus\{O\}}(P),
  \qquad
  L_C=\mathcal O_E((\ell-1)O).
\]

Since the group-law sum of the nonzero points of `C` is zero,

\[
  D_C\sim(\ell-1)O.
\]

Choose a nonzero rational function `f_C`, unique up to multiplication by
`k^\times`, with

\[
  \operatorname{div}(f_C)=D_C-(\ell-1)O.
\]

Multiplication by the section `f_C` gives a short exact sequence of sheaves

\[
  0\longrightarrow\mathcal O_E
  \xrightarrow{\,f_C\,}L_C
  \longrightarrow L_C|_{D_C}
  \longrightarrow0.
\]

### Theorem 2.1 (cohomology sequence)

There is a canonical exact sequence

\[
  0\longrightarrow H^0(E,\mathcal O_E)
  \longrightarrow H^0(E,L_C)
  \xrightarrow{\operatorname{ev}_C}H^0(D_C,L_C|_{D_C})
  \longrightarrow H^1(E,\mathcal O_E)
  \longrightarrow0.
\]

### Proof

The long exact cohomology sequence of the displayed short exact sequence ends
with `H^1(E,L_C)`.  Since `deg L_C=ell-1>0` and `E` has genus one, Serre
duality gives

\[
  H^1(E,L_C)\cong H^0(E,L_C^{-1})^\vee=0.
\]

This proves exactness.  In particular,

\[
  \dim\ker(\operatorname{ev}_C)
  =\dim\operatorname{coker}(\operatorname{ev}_C)=1.
\]

Thus the failure of the naive determinant is controlled by one Hodge line on
each side, not by an uncontrolled higher-dimensional defect.

## 3. Canonical determinant-line isomorphism

For a finite-dimensional vector space `V`, write `det V` for its top exterior
power.  Applying the determinant functor to Theorem 2.1 gives a canonical
isomorphism

\[
  \boxed{
  \det H^0(E,L_C)\otimes\det H^1(E,\mathcal O_E)
  \simeq
  \det H^0(E,\mathcal O_E)\otimes
  \det H^0(D_C,L_C|_{D_C}).}
\]

### Proof

Let `I` be the image of the evaluation map.  The two short exact sequences

\[
  0\to H^0(\mathcal O_E)\to H^0(L_C)\to I\to0,
\]

\[
  0\to I\to H^0(L_C|_{D_C})\to H^1(\mathcal O_E)\to0
\]

give

\[
  \det H^0(L_C)
  \simeq\det H^0(\mathcal O_E)\otimes\det I,
\]

\[
  \det H^0(L_C|_{D_C})
  \simeq\det I\otimes\det H^1(\mathcal O_E).
\]

Eliminating `det I` gives the boxed isomorphism.

The isomorphism is independent of the scalar choice of `f_C`: rescaling the
left injection rescales the kernel trivialization and the induced determinant
trivialization by inverse factors that cancel in the complete exact complex.

## 4. Relation with the Hodge line

For an elliptic curve,

\[
  H^0(E,\mathcal O_E)\cong k,
  \qquad
  H^1(E,\mathcal O_E)\cong H^0(E,\Omega^1_E)^\vee.
\]

Hence the correction to the singular evaluation determinant is exactly one
copy of the Hodge line.  This is the geometric location at which an
Arakelov/Hodge degree may enter the global estimate.

The corrected object is therefore the determinant of the perfect complex

\[
  R\Gamma(E,\mathcal O_E)
  \xrightarrow{\,f_C\,}
  R\Gamma(E,L_C),
\]

or equivalently the determinant of the exact evaluation complex above.  It is
nonzero by construction even though the ordinary square evaluation determinant
vanishes.

## 5. Local metric target

Equip the four determinant factors with integral metrics at finite places and
Arakelov/theta metrics at archimedean places.  The norm of the canonical exact
complex is a well-defined positive local number.  At a split Tate place the
next theorem to prove is:

### Target theorem 5.1 (corrected Tate slope)

For the canonical Tate cyclic subgroup,

\[
  -\log\|\tau_C\|_v
  =\frac{\ell-1}{12}(-\log|q_v|)+J_v,
\]

where `tau_C` is the determinant-of-cohomology torsion element and `J_v` is an
explicit integral/Hodge Jacobian.  For a noncanonical subgroup, the leading
coefficient should be

\[
  -\frac{\ell-1}{12\ell}(-\log|q_v|).
\]

Unlike the singular determinant, this statement is not contradicted by the
principal section: its kernel and cokernel are part of the determinant line.

## 6. Global obstruction that still remains

A fixed place-independent cyclic packet is still subject to the previously
proved Galois-average cancellation.  The determinant-of-cohomology correction
repairs nonvanishing, but not the full-orbit averaging problem.

A successful global construction must therefore combine this corrected local
complex with one of the following:

1. locally adaptive canonical-line filtrations in an adelic vector bundle;
2. the globally labelled three-cusp parabolic variation of the Legendre
   family;
3. a nonlinear norm or exterior-power construction whose Galois average is not
   the linear score already proved to vanish.

## 7. Formalization plan

The order of formalization is:

1. the abstract linear-algebra kernel and cokernel statement;
2. the determinant identity for a four-term exact sequence;
3. the elliptic divisor relation `D_C~(ell-1)O`;
4. the sheaf exact sequence and Riemann--Roch vanishing;
5. local Tate metric calculations for the determinant torsion;
6. only then, an adelic or parabolic global slope theorem.

No step above assumes the abc conjecture or the disputed IUT numerical source.
