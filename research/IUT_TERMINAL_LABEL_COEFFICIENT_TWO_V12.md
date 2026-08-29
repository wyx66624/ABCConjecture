# The terminal-label coefficient-two frontier in the IUT route

**Author:** ChatGPT  
**Date:** 2026-08-29  
**Base:** `main@ef2d07dda02fe02b60933c3f586df947c3ad5444`

## Abstract

This note attacks the remaining non-circular IUT interface rather than adding
another record whose inhabitance is equivalent to the abc conjecture.  It
identifies the precise scalar reason that the standard procession yields a
coefficient-three inequality for `log(abc)`, proves that the terminal square
label is the unique optimal nonnegative label weighting, and verifies that the
terminal label is already represented by an actual finite-positive local Haar
region in the source-faithful construction.

Let the admissible prime be

\[
\ell=2n+1,\qquad n=(\ell-1)/2.
\]

At square label `j`, subtraction of the q-pilot left side leaves q-gain
`j^2-1`, while the finite-support/different contribution is linear in `j+1`.
After the Frey q-divisor is identified with twice the symmetric-product
logarithm, the product coefficient is

\[
C_j=\frac{\ell(j+1)}{j^2-1}=\frac{\ell}{j-1}.
\]

It is therefore minimized at the terminal label `j=n`, where

\[
C_{\mathrm{term}}(n)
 =\frac{2n+1}{n-1}
 =2+\frac{3}{n-1}.
\]

By contrast, the standard uniform procession has

\[
C_{\mathrm{std}}(n)
 =\frac{3(2n+1)(n+3)}{(2n+5)(n-1)}
 =3+\frac{12(n+2)}{(n-1)(2n+5)}.
\]

Thus the standard coefficient stays above three and tends to three, whereas
the terminal coefficient stays above two and tends to two.  This is exactly
the coefficient required by the symmetric-product reduction already merged in
v11.

The result does not prove the missing global terminal-slice comparison.  It
turns that comparison into one sharply stated geometric theorem and proves
that it cannot be obtained by scalar manipulation of the standard procession
inequality.

## 1. Scalar derivation

Write `Q>0` for the positive q-divisor mass and `R` for the finite-support and
different contribution.  The q-pilot left side has coefficient

\[
-\frac{1}{2\ell}Q.
\]

A square-label local component at label `j` has q-part

\[
-\frac{j^2}{2\ell}Q
\]

and linear support cost `(j+1)R`.  A terminal-slice comparison of the form

\[
-\frac{1}{2\ell}Q
 \le
-\frac{j^2}{2\ell}Q+(j+1)R+O(1)
\]

rearranges to

\[
\frac{j^2-1}{2\ell}Q
 \le
(j+1)R+O(1).
\]

For the Frey normalization `Q=2 log|abc|+O(1)`, this gives

\[
\log|abc|
 \le
\frac{\ell(j+1)}{j^2-1}R+O(1)
 =
\frac{\ell}{j-1}R+O(1).
\]

The cancellation of `j+1` is the key observation.  It shows that later labels
are strictly stronger, with the terminal label optimal.

## 2. Standard procession coefficient

For the uniform distribution on `j=1,...,n`,

\[
\mathbb E(j^2)
 =\frac{(n+1)(2n+1)}6,
\qquad
\mathbb E(j+1)=\frac{n+3}{2}.
\]

The q-gain after subtracting the q-pilot left side is

\[
\mathbb E(j^2)-1
 =\frac{(2n+5)(n-1)}6.
\]

Hence

\[
\begin{aligned}
C_{\mathrm{std}}(n)
&=\frac{\ell\,\mathbb E(j+1)}{\mathbb E(j^2)-1}\\
&=\frac{3(2n+1)(n+3)}{(2n+5)(n-1)}\\
&=3+\frac{12(n+2)}{(n-1)(2n+5)}.
\end{aligned}
\]

In particular,

\[
C_{\mathrm{std}}(n)>3
\]

for every `n>1`.

## 3. Terminal coefficient and epsilon choice

At `j=n`,

\[
C_{\mathrm{term}}(n)
 =\frac{(2n+1)(n+1)}{n^2-1}
 =\frac{2n+1}{n-1}
 =2+\frac3{n-1}.
\]

Therefore, for any `epsilon>0`, every integer `n` satisfying

\[
3<\epsilon(n-1)
\]

obeys

\[
C_{\mathrm{term}}(n)<2+\epsilon.
\]

Since admissible primes can be chosen outside finite sets after the relevant
pointwise large-image input, the scalar coefficient itself creates no
asymptotic obstruction.  The obstruction is entirely the global realization
of the terminal slice.

## 4. Optimality among all nonnegative label weights

Let nonnegative weights `w_j` be placed on labels `1,...,n`.  Define

\[
G=\sum_{j=1}^n w_j(j^2-1),
\qquad
L=\sum_{j=1}^n w_j(j+1).
\]

Because

\[
j^2-1=(j-1)(j+1)\le(n-1)(j+1),
\]

one has

\[
G\le(n-1)L.
\]

If a weighted comparison yields

\[
\ell L\le C G,
\]

then, whenever `L>0`,

\[
C\ge\frac{\ell}{n-1}
 =C_{\mathrm{term}}(n).
\]

Thus terminal concentration is not merely one good choice.  It is the sharp
optimum over every nonnegative weighted label packet.  Equality requires the
weight to be supported where `j-1=n-1`, hence at the terminal label, apart from
zero-weight degeneracies.

This rules out improving the coefficient by changing only the convex weights
in the existing procession average.

## 5. The local terminal slice is already real

The source-faithful bad-place construction defines, for every bad place `w`
and every natural square label `j`, the finite-positive Haar region

\[
U_{j,w}=q_w^{j^2}\mathcal O_w
\]

and proves

\[
\log\mu_w(U_{j,w})
 =j^2\log\chi_w(q_w).
\]

The standard procession has indices `m=0,...,n-1` and distinguished label
`m+1`.  Hence its last index `m=n-1` is present and its distinguished label is
exactly `n`.  The accompanying Lean theorem proves

\[
L_{\mathrm{terminal}}
 =n^2 L_q
\]

and, coordinate by coordinate, identifies the component with the actual
finite-positive region `U_{n,w}`.  This is not a freely populated numerical
field.

## 6. Why the standard theorem does not imply the terminal theorem

For every `n>1`,

\[
C_{\mathrm{term}}(n)<C_{\mathrm{std}}(n),
\]

indeed

\[
C_{\mathrm{std}}(n)-C_{\mathrm{term}}(n)
 =\frac{(n+4)(2n+1)}{(n-1)(2n+5)}>0.
\]

Consequently an inequality with coefficient `C_std` does not imply one with
coefficient `C_term`.  The Lean module supplies an explicit scalar model by
choosing a value strictly between the two coefficients.

Geometrically, the terminal region is smaller and has more negative log-volume
than the procession average.  Monotonicity of hull volume therefore points in
the wrong direction for deriving the terminal comparison from the standard
one.

## 7. The exact remaining theorem

The remaining IUT task can now be stated without using `ABCConjecture` as a
field or conclusion.

For every primitive positive abc point and every requested epsilon, construct
an admissible prime `ell=2n+1` with `3<epsilon(n-1)`, together with the actual
source-derived Hodge-theater output, such that:

1. the terminal square-label regions `U_{n,w}` assemble into a genuine output
   of the theta possible-image system, rather than only a local diagnostic
   slice;
2. the mono-analytic hull or an equivalent source-faithful comparison gives
   the terminal-slice upper estimate with one additive constant uniform in the
   abc point;
3. different, conductor, archimedean and finite exceptional terms contribute
   only `o(log rad(abc))` or an epsilon-multiple of that conductor plus a fixed
   constant;
4. all choices are pointwise source-derived and preserve the quantifier order:
   the constant is selected before the abc point.

Items 1 and 2 are the new decisive geometric interface.  Item 3 is the
remaining global arithmetic error estimate.  None is supplied as a field in
the Lean module.

## 8. Formalization status

`IUTTerminalLabelCoefficientTwo.lean` formalizes:

- the exact terminal and standard coefficients;
- their expansions around two and three;
- terminal optimality among all nonnegative label weights;
- the scalar non-implication from the standard bound to the terminal bound;
- membership of the terminal capsule index in the standard procession;
- exact terminal packet volume;
- identification of every terminal component with the already constructed
  finite-positive local Haar region.

The module contains no `axiom`, `sorry`, `admit`, assumed Corollary 3.12,
modified-Szpiro estimate, or ABC conclusion.  It is eligible for `main` only
after the repository's Lean kernel and all-module workflows pass.
