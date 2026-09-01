# ABC multi-route research note v29h: unit-gap contact degeneracy

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Exact degeneration on `m=1`

Consider canonical data satisfying

\[
RA+1=SB.
\]

There is an immediate Bezout solution

\[
\boxed{x=-A,\qquad y=B,}
\]

because

\[
Rx+Sy=-RA+SB=1.
\]

The affine inverse parameter is

\[
t=yA+xB=AB-AB=0.
\]

The residual parametrization therefore returns

\[
A_t=-x=A,
\qquad
B_t=y=B.
\]

The two contact factors are

\[
f=t-xy=AB,
\qquad
g=t+xy=-AB.
\]

Thus the negative contact has

\[
H=-g=AB.
\]

Every scaled or quadratic contact identity reduces to the original equation.
For example,

\[
B+RH=B+RAB=B(1+RA)=SB^2,
\]

which is just `RA+1=SB` multiplied by `B`.

## 2. Consequence

The contact construction yields a genuine strong closure when `g>0`, and its
zero branch admits a square descent.  However the unit-gap locus always has a
natural strictly negative contact, and at that canonical contact the
transformation is tautological.

Therefore the remaining negative branch cannot be closed merely by iterating
the same affine contact identities.  Any purported proof that treats the
contact transformation as a strict descent on all solutions fails already on

\[
1+288=289,
\]

where

\[
A=6,\ R=48,\ B=17,\ S=17,
\qquad x=-6,\ y=17,\ t=0,
\qquad H=102=AB.
\]

## 3. Revised core

The most difficult sublocus is now explicit:

\[
\boxed{RA+1=SB}
\]

with

\[
A,B\text{ squarefree},
\quad\operatorname{rad}(R)\mid A,
\quad\operatorname{rad}(S)\mid B,
\quad\gcd(RA,SB)=1.
\]

Equivalently, one must control the exponent vectors in two consecutive
support-saturated integers.

This contains the classical problem of consecutive powerful numbers and the
high-quality examples `8,9` and `288,289`.  It is not resolved by radical-level
contact, Bezout reduction, or the quadratic contact discriminant.

## 4. Productive routes that remain

The contact no-go redirects effort to inputs that are not tautological on
`m=1`:

1. the simultaneous square/cube decomposition and moving Mordell curve;
2. the arithmetic Leibniz--Wronskian construction, where the missing datum is
   a small compatible nondegenerate weight vector;
3. a genuinely global p-adic/adelic determinant estimate for the total
   contact depth;
4. the source-derived IUT theta comparison, if its uniform coefficient can be
   independently certified.

The first two are already formalized up to their explicit nontrivial input.
The next attack should compare those inputs on the unit-gap canonical family
rather than extending the affine contact transform again.

## 5. Lean audit

The tautological unit-gap specialization is formalized in

```text
Lean/IUTThreeClosures/UnitGapContactDegeneracy.lean
```

without any height assumption or abc conclusion.
