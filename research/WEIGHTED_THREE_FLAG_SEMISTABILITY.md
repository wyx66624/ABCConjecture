# Uniform semistability of the three Legendre boundary weights

## 1. Set-up

Let `a,b,c` be positive integers with

\[
 a+b=c.
\]

Attach the logarithmic boundary weights

\[
 W_0=\log a,
 \qquad
 W_1=\log b,
 \qquad
 W_\infty=\log c.
\]

They are assigned to the three globally labelled Picard--Lefschetz lines of
the Legendre family.  Put

\[
 W=W_0+W_1+W_\infty.
\]

For a weighted three-line configuration in a two-dimensional vector space,
the Hilbert--Mumford excess of a line is its captured weight minus `W/2`.
Since the three lines are distinct, the only possible positive excesses are

\[
 W_i-\frac W2.
\]

## 2. Exact imbalance formula

Because `c>=a,b`, the largest weight is `W_infinity`.  Thus the total
instability is

\[
 \operatorname{Inst}(a,b,c)
 =\max\left\{0,
   W_\infty-\frac W2\right\}
 =\frac12\max\left\{0,
   \log\frac{c}{ab}\right\}.
\tag{2.1}
\]

### Theorem 2.1 (uniform bounded instability)

For every positive integral solution `a+b=c`,

\[
 \boxed{
  \operatorname{Inst}(a,b,c)\le\frac12\log2.}
\tag{2.2}
\]

If `a,b>=2`, the configuration is exactly semistable:

\[
 \boxed{\operatorname{Inst}(a,b,c)=0.}
\tag{2.3}
\]

#### Proof

For positive integers,

\[
 a+b\le2ab.
\]

Indeed,

\[
 2ab-a-b=(a-1)b+a(b-1)\ge0.
\]

Hence

\[
 \frac{c}{ab}\le2,
\]

which proves (2.2).  If `a,b>=2`, then

\[
 ab-(a+b)=(a-1)(b-1)-1\ge0,
\]

so `c<=ab`, proving (2.3).

In the only unstable integral cases one of `a,b` equals one.  If, for example,
`a=1`, then

\[
 \operatorname{Inst}(1,c-1,c)
 =\frac12\log\frac{c}{c-1},
\]

which tends to zero and is always at most `log 2/2`.

## 3. Parabolic interpretation

Let `L_0,L_1,L_infinity` be three distinct lines in a rank-two vector space.
Give `L_i` parabolic weight `W_i`.  For every line `M`, the total weight
captured by `M` is either zero or one of the three `W_i`; therefore

\[
 \operatorname{wt}(M)
 \le\frac W2+\frac12\log2.
\tag{3.1}
\]

Thus the parabolic rank-two object determined by the three Legendre boundary
directions is semistable up to one absolute additive constant, independently
of the multiplicities in `a,b,c`.

This is stronger than a generic full-projective-orbit selector.  It uses the
three globally labelled boundary lines before specialization, and hence is not
refuted by the `1/(ell+1)` projective-dimension barrier.

## 4. Research consequence

The remaining arithmetic Hodge--Arakelov theorem may be split into two parts.

1. **Directional stability.**  The weighted three-line filtration contributes
   at most `log 2/2` to the maximal parabolic slope; this note closes that
   scalar Hilbert--Mumford term.
2. **Metric and descent comparison.**  One must still compare the actual
   determinant/theta metric with the parabolic model, and bound the level,
   different, and archimedean Jacobian terms.

The theorem does not by itself replace multiplicity by radical support.  It
shows, however, that failure of global line selection is not caused by an
unbounded imbalance among the three Legendre directions.  Any remaining loss
must come from the arithmetic metric comparison rather than from the weighted
configuration's geometric instability.

## 5. Formalization target

The scalar inequalities

\[
 a+b\le2ab
\]

and, for `a,b>=2`,

\[
 a+b\le ab
\]

are elementary Lean targets.  They imply the logarithmic instability bounds
after applying monotonicity of `Real.log` to positive real casts.
