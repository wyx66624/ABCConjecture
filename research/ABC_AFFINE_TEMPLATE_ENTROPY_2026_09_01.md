# Large-modulus separation and certificate entropy in the affine abc fibre

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional fixed-template theorem; the full affine route remains open

## 0. Result and exact scope

The minimal-support affine fibre attached to a primitive seed

\[
 a+b=c,\qquad R=\operatorname{rad}(abc)
\]

uses

\[
 U=1+Rh,\qquad V=1+R(h+ck),\qquad W=1+R(h+bk).       \tag{0.1}
\]

The previous fixed-template theorem gave the correct periodic main term but
left a large-modulus boundary error.  This note removes that boundary for a
single template strong enough to certify the full three-arm necessary excess
threshold for an exception.  The point is geometric: two points in the same template give a
short vector in a determinant-\(D\) congruence lattice, while the three
linear differences force the determinant to divide a cubic product.

In the canonical \(K=8\) box, every fixed prime-power divisibility template
that by itself certifies

\[
 E(U)E(V)E(W)>\frac{Rc^{14}}{8192}                  \tag{0.2}
\]

contains fewer than

\[
                         \frac{12c^4}{R^2}          \tag{0.3}
\]

parameter pairs.  Consequently, a union of such templates containing at
least

\[
                  \kappa R^{-2/3}c^{4+\eta}         \tag{0.4}
\]

pairs must use more than

\[
                  \frac{\kappa}{12}R^{4/3}c^\eta   \tag{0.5}
\]

templates.  Thus neither the periodic main term nor its large-modulus
boundary can make one fixed certificate deliver the matching lower bound.

This theorem does **not** close the affine route.  It leaves open an
unbounded, highly correlated family of templates, a certificate chosen from
the point itself, an algebraic parametrization, and excess coming from
unprescribed residual factors.  It also does not assert that the affine
matching lower bound is false: its negation on an unbounded subcritical seed
sequence would already contradict the desired abc boundedness.

## 1. A general three-form separation lemma

Let \(B,C,L,D,d_U,d_V,d_W,X_U,X_V,X_W\) be positive integers with
\(B<C\), and let \(T\) be a positive real number.  Put

\[
                         D=d_Ud_Vd_W.               \tag{1.1}
\]

Assume that the three moduli are pairwise coprime.  Consider two integer
pairs \((h,k)\) and \((h',k')\), and put

\[
 x=h-h',\qquad y=k-k',\qquad
 H=\max(|x|,|y|).                                   \tag{1.2}
\]

Suppose

\[
 d_U\mid x,\qquad d_V\mid x+Cy,\qquad
 d_W\mid x+By,                                      \tag{1.3}
\]

and suppose the cancellation conditions needed below hold:

\[
\begin{array}{lll}
 \gcd(d_V,C)=1,&\gcd(d_W,B)=1,\\
 \gcd(d_U,C)=1,&\gcd(d_W,C-B)=1,\\
 \gcd(d_U,B)=1,&\gcd(d_V,C-B)=1.
\end{array}                                         \tag{1.4}
\]

Finally assume

\[
 d_U\le X_U,\qquad d_V\le X_V,\qquad d_W\le X_W,  \tag{1.5}
\]

and choose a positive threshold \(T\) such that

\[
\begin{split}
 D&>T,\\
 (C+1)^2L^3&<T,\\
 LX_U<T,\qquad LX_V<T,\qquad LX_W<T.               \tag{1.6}
\end{split}
\]

### Theorem 1.1 (cubic-product separation, including zero differences)

Under (1.1)--(1.6), distinct pairs satisfying (1.3) obey

\[
                              H>L.                  \tag{1.7}
\]

### Proof

First suppose that none of

\[
                    x,\quad x+Cy,\quad x+By        \tag{1.8}
\]

is zero.  Pairwise coprimality and (1.3) give

\[
             D\mid x(x+Cy)(x+By).
\]

Therefore

\[
\begin{aligned}
 D
 &\le |x|\,|x+Cy|\,|x+By|\\
 &\le H(C+1)H(B+1)H\\
 &\le (C+1)^2H^3.
\end{aligned}                                       \tag{1.9}
\]

If \(H\le L\), then (1.9) contradicts
\(D>T>(C+1)^2L^3\).

It remains essential to treat the three possible zero factors.  If \(x=0\),
then (1.3) and (1.4) imply

\[
                       d_Vd_W\mid y.
\]

Distinctness gives \(y\ne0\), hence

\[
                         H\ge |y|\ge d_Vd_W.        \tag{1.10}
\]

If \(H\le L\), then
\(D=d_Ud_Vd_W\le X_UL<T\), contradicting \(D>T\).

If \(x+Cy=0\), then \(d_U\mid Cy\) and
\(d_W\mid(C-B)y\).  Cancelling with (1.4) and multiplying the
coprime divisibilities gives \(d_Ud_W\mid y\).  Thus

\[
                         H\ge |y|\ge d_Ud_W.        \tag{1.11}
\]

Under \(H\le L\), this would give
\(D\le X_VL<T\), again impossible.

The case \(x+By=0\) similarly gives
\(d_Ud_V\mid y\), and hence

\[
                         H\ge |y|\ge d_Ud_V.        \tag{1.12}
\]

Under \(H\le L\), this gives \(D\le X_WL<T\), the final
contradiction.

All cases give (1.7). ∎

The individual bounds in (1.5) are not cosmetic.  Section 5 gives a complete
counterexample to the stronger statement that the cubic determinant
inequality alone forces separation.

## 2. Packing a separated template

Let \(S\) be a set of integer pairs in

\[
                         1\le h,k\le M.             \tag{2.1}
\]

Assume every two distinct points have sup distance greater than \(L\).
Partition each coordinate interval into consecutive cells of length
\(L+1\).  Two points in the same product cell have both coordinate
differences at most \(L\), so every product cell contains at most one point.

### Proposition 2.1 (sup-norm packing)

\[
 |S|\le
 \left\lceil\frac{M}{L+1}\right\rceil^2
 \le\left(\frac{M}{L+1}+1\right)^2.                \tag{2.2}
\]

This argument is insensitive to the periodic location of the template.  It
therefore controls precisely the boundary range in which the earlier
estimate \(M^2/D+O(M+D)\) was too weak.

## 3. Application to the canonical affine fibre

Orient a positive primitive seed so that \(b\ge c/2\), take \(Q=R\), and put

\[
                         M=\left\lfloor
                              \frac{c^6}{4R}\right\rfloor. \tag{3.1}
\]

Assume \(c\ge6\) and \(R<c\).  The seed hypotheses automatically give
\(R\ge6\).  Indeed, if \(c\) is odd, then \(c\ge7\), the product \(abc\)
is even, and an odd prime divides \(c\).  If \(c\) is even, coprimality
forces \(a,b\) to be odd, while \(c\ge6\) forces one of them to be at least
three.  Thus in either case distinct primes \(2\) and \(q\ge3\) divide
\(abc\), so \(R\ge2q\ge6\).

On \(1\le h,k\le M\),

\[
                         U<c^6,\qquad V<c^7,\qquad W<c^7.  \tag{3.2}
\]

Let \((d_U,d_V,d_W)\) be a fixed divisibility template: its parameter set
consists of points satisfying the admissibility condition
\(\gcd(U,k)=1\) and the divisibilities
\(d_U\mid U\), \(d_V\mid V\), and \(d_W\mid W\).  Assume this set is
nonempty and that the template certifies (0.2) through

\[
 \Delta=\prod_{Z\in\{U,V,W\}}
                 \frac{d_Z}{\operatorname{rad}(d_Z)}
          >\frac{Rc^{14}}{8192}.                   \tag{3.3}
\]

Indeed, if \(d\mid n\), comparison of prime valuations gives
\(d/\operatorname{rad}(d)\le n/\operatorname{rad}(n)=E(n)\), so (3.3)
is a sufficient certificate for (0.2).

The cofactors of every admissible affine point are pairwise coprime and are
coprime to \(Rabc\).  Hence the three \(d_Z\) are pairwise coprime, all the
cancellations (1.4) hold, and

\[
 D=d_Ud_Vd_W\ge\Delta>\frac{Rc^{14}}{8192}.         \tag{3.4}
\]

Take the enlarged separation scale

\[
                         L=\left\lfloor\frac{c^4}{13}\right\rfloor. \tag{3.5}
\]

Since \(6(c+1)\le7c\),

\[
 (c+1)^2L^3
 \le \frac{49c^{14}}{36\cdot13^3}
 <  \frac{Rc^{14}}{8192}.                          \tag{3.6}
\]

The strict comparison follows from
\(49\cdot8192=401408<474552=36\cdot6\cdot13^3\le
36R13^3\).

The size bounds (3.2) also give

\[
 Ld_U<\frac{Rc^{14}}{8192},\qquad
 Ld_V<\frac{Rc^{14}}{8192},\qquad
 Ld_W<\frac{Rc^{14}}{8192},                        \tag{3.7}
\]

for \(c\ge6\); the weakest comparison is
\(c^4c^7/13<Rc^{14}/8192\), which reduces to
\(8192<13Rc^3\).  At the conservative endpoint \(R=c=6\), the
right-hand side is already \(16848\).

For two points of the template, subtraction of their three divisibilities
gives multiples of \(R x\), \(R(x+cy)\), and \(R(x+by)\).  Each template
modulus is coprime to \(R\), so cancellation gives exactly (1.3).
Theorem 1.1 therefore separates all distinct points of the template by more
than \(L\).  Moreover \(L+1>c^4/13\), so

\[
 \frac{M}{L+1}<\frac{13c^2}{4R}.                   \tag{3.8}
\]

Because \(R<c\), the last quantity is greater than one.  Moreover
\(R\le c-1\) and, for \(c\ge6\),

\[
 \frac{R}{c^2}\le\frac{c-1}{c^2}\le\frac5{36},
 \qquad
 \left(\frac{13}{4}+\frac5{36}\right)^2
   =\left(\frac{61}{18}\right)^2
   =\frac{3721}{324}<12.                           \tag{3.9}
\]

Proposition 2.1 now proves the announced bound

\[
 |S|<\left(\frac{13c^2}{4R}+1\right)^2
     <\frac{12c^4}{R^2}.                           \tag{3.10}
\]

### Theorem 3.1 (large-modulus boundary closure for one template)

Under the preceding hypotheses, every fixed divisibility template that
certifies the complete pointwise necessary threshold (0.2) contains fewer than
\(12c^4/R^2\) canonical parameter pairs.

The proof uses the full threshold, not either marginal two-arm gate.

## 4. The certificate-entropy lower bound

Fix real numbers \(\kappa,\eta>0\), and let
\(S_1,\ldots,S_N\) be fixed templates satisfying Theorem 3.1.  They need not
be disjoint.  The union bound and (3.10) give

\[
 \left|\bigcup_{i=1}^N S_i\right|
 <N\frac{12c^4}{R^2}.                               \tag{4.1}
\]

### Corollary 4.1 (template entropy forced by a matching lower bound)

If their union contains at least
\(\kappa R^{-2/3}c^{4+\eta}\) parameters, then

\[
                         N>\frac{\kappa}{12}
                              R^{4/3}c^\eta.        \tag{4.2}
\]

Thus a fixed finite list of prescribed prime-power patterns cannot prove the
matching lower bound.  Any successful template construction must have
unbounded certificate entropy at least on the scale (4.2), and it must also
control overlaps and admissibility uniformly.

## 5. A complete counterexample to determinant-only separation

It is tempting to omit (1.5) and reason only from
\(D>(C+1)^2L^3\).  The zero factor \(x=0\) makes that assertion false.

Take

\[
 B=1,\quad C=2,\quad L=1,\quad T=10,\quad
 d_U=31,\quad d_V=d_W=1,\quad X_U=X_V=X_W=1.       \tag{5.1}
\]

and the two points

\[
                         (h,k)=(30,1),(30,2).        \tag{5.2}
\]

For \(Q=1\), both have \(U=1+h=31\), so both lie in the template.
The moduli are pairwise coprime, and every cancellation condition in
(1.4) holds because \(31\) is coprime to \(B=1\), \(C=2\), and
\(C-B=1\).
Here

\[
 D=31>T=10>(C+1)^2L^3=9,\qquad LX_U=LX_V=LX_W=1<T.
                                                               \tag{5.3}
\]

But their sup distance is exactly one.  All displayed premises of the
determinant-only strengthening hold and its conclusion fails.  This
counterexample closes only that strengthening.  It fails precisely the
omitted inequality \(d_U\le X_U\) in (1.5), and it does not refute
Theorem 1.1 or the affine route.

## 6. Relation to existing work and next positive gates

Squarefree-value sieves for products of linear forms show that powerful
values are generally sparse, but their constants are not the seed-uniform
three-arm lower theorem required here.  The present argument instead uses
only exact congruence lattices and so is uniform in the seed once the
canonical size bounds are imposed.

The remaining positive possibilities are now narrower:

1. construct at least the entropy in (4.2) from a coherently indexed family
   of growing templates and prove a lower bound after overlaps;
2. prove a correlated powerful-value theorem in which the certificate is
   selected from each point rather than fixed in advance;
3. produce an algebraic parametrization whose powers do not pay the generic
   congruence-lattice separation cost;
4. obtain the affine matching lower bound by a non-template mechanism.

None is discarded.  A finite search without an exception cannot close any
of them.

## 7. Formalization scope

The Lean companion
`Lean/IUTThreeClosures/AffineTemplateEntropy20260901.lean` formalizes, after
this paper proof:

- the nonzero cubic-product divisor bound;
- the three zero-factor cancellation alternatives;
- the resulting separation certificate in direct integer form, avoiding any
  mismatch between the paper's real threshold and an integral threshold;
- cancellation of the common affine step from two template memberships;
- sup-norm cell injectivity and the finite packing bound;
- the finite-union entropy inequality;
- the exact cross-multiplied (8192/13) cubic and size-cap inequalities,
  the floor cell comparison, and the composed strict bound
  (|S|R^2<12c^4);
- the exact determinant-only counterexample (5.1)--(5.3).

The elementary seed lemma (Rge6), divisor-to-excess comparison in (3.3),
and the final real-valued cancellation yielding (4.2) remain the explicit
paper layer.  They are not hidden as Lean axioms.

## 8. Exact replay and interpretation

The bundle
`research/computation/2026_09_01_affine_template_entropy/` checks the
corrected counterexample, exhausts 6,244 bounded abstract parameter cases,
and verifies the cross-multiplied canonical inequalities for all 494,515
pairs

\[
                  6\le c\le1000,\qquad 6\le R<c.
\]

All arithmetic uses integers.  This replay checks constants and guards
against omitted zero-factor cases; it is not used as the proof of Theorem
1.1 or Theorem 3.1.  The finite absence of another counterexample closes no
statement and no route.
