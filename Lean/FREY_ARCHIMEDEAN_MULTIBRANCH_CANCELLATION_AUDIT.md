# Archimedean cancellation across the four Frey half-branches

**Author: ChatGPT**

## Abstract

Let

\[
 E_b:y^2=x(x-1)(x+b),\qquad b=3r^2-2,
\]

and over the fixed field \(K=\mathbf Q(\sqrt6)\) put

\[
 Q=(2,r\sqrt6),\qquad P=2Q.
\]

The preceding adelic audit showed that \(Q\) is a globally compatible
one-packet half-branch, lies in the identity component at every odd bad
place, and has archimedean Green slope \(-1/12\) relative to
\(H=\log b\).  A natural proposal is to add other globally defined halves
\(Q+T\), with \(T\in E[2]\), so that their archimedean deficits cancel
while the selected odd finite mass remains.

The complete calculation gives the four abscissae

\[
 2,\qquad -{b\over2},\qquad b+2,\qquad -{b\over b+2}.
\]

The last denominator is decisive.  Since \(b+2=3r^2\), the fourth branch
has a good-reduction finite contribution
\(\frac12\log b+O(1)\).  Omitting it produces a false two-row ledger.
With columns ordered as

\[
 Q,\qquad Q+T_0,\qquad Q+T_1,\qquad Q+T_{-b},
\]

the leading coefficients of \(H\) are

\[
\begin{array}{c|rrrr}
 &Q&Q+T_0&Q+T_1&Q+T_{-b}\\ \hline
 \text{odd bad finite}&1/3&1/12&1/12&-1/6\\
 \text{good finite}&0&0&0&1/2\\
 \text{archimedean}&-1/12&1/6&1/6&-1/12\\ \hline
 \widehat h&1/4&1/4&1/4&1/4.
\end{array}                                                    \tag{A}
\]

Centering each row at one quarter of the corresponding row for \(P\)
gives

\[
\begin{array}{c|rrrr}
 &Q&Q+T_0&Q+T_1&Q+T_{-b}\\ \hline
 \text{odd bad deficit}&1/4&0&0&-1/4\\
 \text{good finite deficit}&-1/8&-1/8&-1/8&3/8\\
 \text{archimedean deficit}&-1/8&1/8&1/8&-1/8.
\end{array}                                                    \tag{B}
\]

Every row and every column sums to zero.  Formula (B) separates two
operations which must not be conflated:

* averaging all four global columns kills the selected odd-bad gain;
* cancelling the archimedean deficit of a fixed collection forces its
  odd-bad surplus to reappear with the opposite sign in the good-finite
  deficit.

Give the four columns arbitrary nonnegative weights \(u,v,w,z\).  If their
actual archimedean leading sum is nonnegative, then

\[
 \Lambda_{\mathrm{bad}}(u,v,w,z)
 \le \widehat h(u,v,w,z).                               \tag{C}
\]

Equality is possible only when \(z=0\), the archimedean leading sum is
zero, and \(u=2(v+w)\).  The formal weighted mixture consisting of two
copies of \(Q\) and one copy of \(Q+T_0\) reaches equality, but never a
strict gain.  Hence positive multibranch summation cannot yield a
subcritical coefficient on this actual infinite family.

Signed combinations do not evade the result.  All four points have the
same class in \(E(K)\otimes\mathbf Q\), so their Neron--Tate Gram matrix
has rank one.  This is a strict no-go for torsion translations and
isomorphic relabellings of the full-two-torsion Frey motive.  It does not
rule out a genuinely different auxiliary motive carrying a new
cross-motive height inequality.

## 1. One common field and one normalization

All four branches and all of \(E[2]\) are rational over the same fixed
field

\[
 K=\mathbf Q(\sqrt6),\qquad |\operatorname{Disc}K|=24.
\]

At a finite place use \(|\pi_v|_v=(Nv)^{-1}\) and weight the local Neron
function by \(1/[K:\mathbf Q]\).  At the two real places use weight
\(1/[K:\mathbf Q]\).  Thus residue degrees occur in \(\log Nv\), not a
second time in the weight.  With canonical mean-zero normalization,

\[
 \widehat h(R)=\sum_v w_v\lambda_v(R).                  \tag{1.1}
\]

For every \(T\in E[2]\), the distribution relation and quadraticity are

\[
 \sum_{T\in E[2]}\lambda_v(Q+T)=\lambda_v(P),
 \qquad
 \widehat h(Q+T)={1\over4}\widehat h(P).                \tag{1.2}
\]

Both identities must be written over one common field.  Mixing branch
fields or local normalizations between columns destroys the invariant
meaning of a row sum.

Use the infinite Pell subfamily

\[
 q^2-3p^2=1,\qquad r=2pq,\qquad b=3r^2-2.               \tag{1.3}
\]

For a uniform 2-adic error, restrict further to

\[
 q+p\sqrt3=(2+\sqrt3)^{2j+1}.                           \tag{1.4}
\]

Then \(p\) is odd, \(v_2(q)=1\), and \(v_2(r)=2\).  This remains an
infinite family.  Consequently every term at a place above \(2\) which
occurs below is uniformly bounded.  Moreover

\[
 v_2(b)=1,\qquad 3\nmid b(b+1),\qquad \gcd(b,b+1)=1.
\]

Put \(H=\log b\).  Then

\[
 \log(b+1)=H+O(1),\qquad \log r={1\over2}H+O(1).         \tag{1.5}
\]

All \(O(1)\) constants below are uniform on (1.4).

## 2. The four global columns

Write

\[
 T_0=(0,0),\qquad T_1=(1,0),\qquad T_{-b}=(-b,0).
\]

For \(y^2=(x-e_i)(x-e_j)(x-e_k)\), the chord formula gives

\[
 x(R+T_i)=e_i+
 { (e_i-e_j)(e_i-e_k)\over x(R)-e_i}.                  \tag{2.1}
\]

At \(x(Q)=2\), this becomes

\[
\begin{aligned}
 x(Q)&=2,\\
 x(Q+T_0)&=-{b\over2},\\
 x(Q+T_1)&=b+2,\\
 x(Q+T_{-b})&=-{b\over b+2}.
\end{aligned}                                           \tag{2.2}
\]

The tangent formula also gives

\[
 x(P)=x(2Q)={ (b+4)^2\over 8(b+2)}.                    \tag{2.3}
\]

These are four fixed global points, not columns chosen independently at
each place.  The denominator

\[
 b+2=3r^2                                                     \tag{2.4}
\]

is forced by the group law.

## 3. The odd bad-fibre row

Let an odd prime \(\ell\nmid6\) divide \(b\), with exponent \(e\).  The
roots \(0\) and \(-b\) collide.  The points \(T_0,T_{-b}\) meet the
unique order-two component of the \(I_{2e}\) fibre, whereas \(T_1\) lies
in the identity component.  Since \(Q\) lies in the identity component,
the four component values are

\[
 {e\over6},\quad -{e\over12},\quad {e\over6},
 \quad -{e\over12}.                                    \tag{3.1}
\]

If \(\ell\mid b+1\), the colliding roots are \(1\) and \(-b\), and the
values are

\[
 {e\over6},\quad {e\over6},\quad -{e\over12},
 \quad -{e\over12}.                                    \tag{3.2}
\]

The identity-component points in (3.1)--(3.2) reduce to finite
nonsingular points different from the identity and from the unique
nontrivial two-torsion point of the residual torus.  Their doubles also
avoid the identity.  Hence their finite theta terms vanish.  A
nonidentity-component representative has theta term zero automatically
in the fundamental Tate annulus.

Let \(B=\log b\) and \(C=\log(b+1)\).  Summing (3.1)--(3.2) with the
degree normalization of Section 1 gives

\[
\begin{array}{c|rrrr}
 &Q&Q+T_0&Q+T_1&Q+T_{-b}\\ \hline
 \Lambda_{\mathrm{bad}}
 &(B+C)/6&-B/12+C/6&B/6-C/12&-(B+C)/12.
\end{array}                                             \tag{3.3}
\]

Since \(B=C+O(1)=H+O(1)\), its leading row is

\[
 \left({1\over3},{1\over12},{1\over12},-{1\over6}\right)H.
                                                               \tag{3.4}
\]

## 4. The product-formula row at good primes

Let \(\ell\) be an odd prime dividing \(r\).  Then

\[
 b\equiv-2\pmod\ell,\qquad b+1\equiv-1\pmod\ell,
\]

so \(E_b\) has good reduction at \(\ell\).  The numerator of
\(-b/(b+2)\) is an \(\ell\)-adic unit, while

\[
 v_\ell(b+2)=2v_\ell(r)+\mathbf1_{\ell=3}.              \tag{4.1}
\]

For a minimal good-reduction equation,

\[
 \lambda_\ell(R)={1\over2}
       \log\max\{1,|x(R)|_\ell\}.                       \tag{4.2}
\]

Equations (4.1)--(4.2), summed over the odd primes and degree normalized
over \(K\), give

\[
 \Lambda_{\mathrm{good}}(Q+T_{-b})
 =\log r+O(1)={1\over2}H+O(1).                         \tag{4.3}
\]

The same calculation applies to \(P\) using (2.3), because \(b+4\) is
prime to every odd divisor of \(r\).  The first three columns have no
growing denominator at a good prime.  Therefore

\[
 \Lambda_{\mathrm{good}}
 =\left(0,0,0,{1\over2}\right)H+O(1),                  \tag{4.4}
\]

and

\[
 \Lambda_{\mathrm{good}}(P)={1\over2}H+O(1).           \tag{4.5}
\]

This is the product-formula correction missed by a bad-fibre-only
calculation.  The rational function in (2.1) has a pole at \(x=-b\);
evaluating it at \(Q\) produces \(b+2=3r^2\).  Its nonarchimedean
denominator mass cannot be deleted while retaining the archimedean size
of the translated abscissa.

## 5. The archimedean row

The elliptic-surface calculation from the preceding adelic audit gives

\[
 \widehat h(Q)={1\over4}H+O(1).                         \tag{5.1}
\]

Torsion translation preserves canonical height exactly, so (5.1) holds
for all four columns.  Also

\[
 \widehat h(P)=4\widehat h(Q)=H+O(1).                   \tag{5.2}
\]

Subtracting (3.4) and (4.4) from (5.1), using (1.1), gives

\[
 \Lambda_\infty=
 \left(-{1\over12},{1\over6},{1\over6},-{1\over12}\right)H+O(1).
                                                               \tag{5.3}
\]

Similarly,

\[
 \Lambda_\infty(P)={1\over6}H+O(1).                    \tag{5.4}
\]

The fourth branch does not provide the positive archimedean complement
suggested by the bad-fibre row alone.  Its good-prime denominator raises
its finite height by \(H/2\), and its archimedean slope returns to
\(-1/12\).

## 6. The centered deficit matrix

For a set of places \(S\), define

\[
 \delta_S(T)=\Lambda_S(Q+T)-{1\over4}\Lambda_S(P).      \tag{6.1}
\]

The distribution relation gives zero row sums, and equality of the four
canonical heights gives zero column sums.  The leading coefficient matrix
is

\[
\begin{array}{c|rrrr}
 &Q&Q+T_0&Q+T_1&Q+T_{-b}\\ \hline
 \delta_{\mathrm{bad}}&1/4&0&0&-1/4\\
 \delta_{\mathrm{good}}&-1/8&-1/8&-1/8&3/8\\
 \delta_\infty&-1/8&1/8&1/8&-1/8.
\end{array}                                             \tag{6.2}
\]

The average of all four columns has zero deficit in every row, so it does
not inherit the first column's \(1/4\) odd-bad surplus.

Now suppose a fixed global weighted collection has
\(\delta_\infty=0\).  Column conservation gives

\[
 \boxed{\delta_{\mathrm{good}}=-\delta_{\mathrm{bad}}.} \tag{6.3}
\]

Thus cancelling the archimedean deficit transfers the entire compensation
to the good-finite row.  For example, the collection
\(Q+(Q+T_0)\) has

\[
 \delta_{\mathrm{bad}}={1\over4}H,\qquad
 \delta_\infty=0,\qquad
 \delta_{\mathrm{good}}=-{1\over4}H.                   \tag{6.4}
\]

A place-dependent choice of columns is not a global algebraic point and
(1.2) supplies no height for it.  A global multibranch construction must
instead fix one collection of columns which is used at every place.

## 7. The sharp positive-weight optimization

Assign nonnegative weights \((u,v,w,z)\) to
\(Q,Q+T_0,Q+T_1,Q+T_{-b}\), respectively.  Rational weights are
multisets after clearing denominators.  Table (A) gives

\[
\begin{aligned}
 L_{\mathrm{bad}}
   &={u\over3}+{v+w\over12}-{z\over6},\\
 L_{\mathrm{good}}&={z\over2},\\
 L_\infty&=-{u\over12}+{v+w\over6}-{z\over12},\\
 L_{\widehat h}&={u+v+w+z\over4}.
\end{aligned}                                           \tag{7.1}
\]

The complete ledger is

\[
 L_{\mathrm{bad}}+L_{\mathrm{good}}+L_\infty
 =L_{\widehat h}.                                       \tag{7.2}
\]

If archimedean cancellation means \(L_\infty\ge0\), then
\(L_{\mathrm{good}}\ge0\), and (7.2) gives

\[
 \boxed{L_{\mathrm{bad}}\le L_{\widehat h}.}            \tag{7.3}
\]

Equality forces

\[
 z=0,\qquad L_\infty=0,\qquad u=2(v+w).                 \tag{7.4}
\]

The formal weighted mixture \((u,v,w,z)=(2,1,0,0)\) has

\[
 L_{\mathrm{bad}}=L_{\widehat h}={3\over4},\qquad
 L_{\mathrm{good}}=L_\infty=0.                         \tag{7.5}
\]

This boundary case is critical, not subcritical.  A height argument needs
a strict coefficient margin before radical-sized errors can bound \(H\).
If \(z>0\) or \(L_\infty>0\), (7.3) is strict in the wrong direction.
Moreover, (7.4) cannot hold for an honest subset of distinct columns
containing \(Q\): then \(u=1\) and \(v+w\) is an integer.  The equality
case uses a repeated weighted copy of the same Mordell--Weil direction and
adds no independent information.

Thus the four globally compatible half-branches have no positive weighting
whose archimedean leading term is nonnegative and whose selected odd-bad
coefficient strictly exceeds the height coefficient.  This is an actual
infinite-family obstruction, not an abstract matrix counterexample.

## 8. Canonical height and Faltings--Hriljac

In \(E(K)\otimes\mathbf Q\), torsion disappears:

\[
 [Q+T_0]=[Q+T_1]=[Q+T_{-b}]=[Q].                       \tag{8.1}
\]

The Neron--Tate Gram matrix of the four points has every entry equal to
\(\widehat h(Q)\) and rank one.  For integers \(n_T\),

\[
 \widehat h\!\left(\sum_Tn_T(Q+T)\right)
 =\left(\sum_Tn_T\right)^2\widehat h(Q).                \tag{8.2}
\]

If the coefficients sum to zero, the combination is torsion and (8.2)
contains no height.  Otherwise it is a scalar multiple of the original
Mordell--Weil direction.  A signed combination therefore creates neither
a rank-two regulator nor a new positive quadratic form.

Faltings--Hriljac represents this same pairing by an arithmetic
intersection only after all vertical corrections and archimedean Green
terms are included.  It does not make individual rows of (6.2) positive.
Applying the arithmetic Hodge index to a signed difference of columns
cannot justify deleting its good-finite or archimedean correction.

The field discriminant also contributes no term to the canonical-height
identity.  Here

\[
 {1\over[K:\mathbf Q]}\log|\operatorname{Disc}K|
 ={1\over2}\log24
\]

is constant, while every nonzero entry of (A)--(B) grows linearly with
\(H\).  A bounded discriminant cost changes only \(O(1)\), not a slope.

## 9. Isogenous or genuinely different motives

Permuting the three roots of the full-two-torsion Frey model only permutes
the columns and the two bad supports.  It preserves (7.2)--(7.3).
Similarly, the three cyclic two-isogeny quotients do not create a new
average local budget: at an \(I_{2e}\) fibre their multiplicative depths
are \(4e,e,e\), whose mean is \(2e\).  Canonical heights under an isogeny
scale by its degree, so summing ordinary height identities counts the
global height for every motive which was added.

This is not a theorem about every conceivable auxiliary motive.  A
successful cross-motive construction would need a new inequality in which
several independently positive odd local terms share one global height
cost, together with a proof controlling every remaining finite and
archimedean term.  Such sharing is not a consequence of the
torsion-translation distribution relation, the product formula, or
Faltings--Hriljac.

The surviving target is therefore precise: construct points in distinct
Mordell--Weil directions or genuinely different motives, prove a
non-diagonal global comparison, and test it against good-denominator rows
before claiming archimedean cancellation.  Reusing the four halves of one
point cannot work.

## 10. Lean boundary

The companion module
IUTThreeClosures/FreyArchimedeanMultibranchCancellationAudit.lean verifies
only cycle-free scalar and rational-function consequences:

1. the three translated abscissae and the doubled abscissa;
2. the Pell denominator identity \(b+2=3r^2\);
3. the complete bad/good/archimedean slope ledger;
4. the explicit centered deficit matrix;
5. full-average cancellation and the transfer identity (6.3);
6. the positive-weight no-strict-gain theorem and its equality case;
7. the critical \(2:1\) boundary mixture.

Lean does not formalize elliptic-curve addition, Neron models, local height
formulas, the component tables, the elliptic-surface height calculation,
Faltings--Hriljac, or abc.  These paper-level inputs are stated explicitly
and are not introduced as axioms or structure fields.

## References

1. J. H. Silverman, *Advanced Topics in the Arithmetic of Elliptic Curves*,
   Graduate Texts in Mathematics **151**, Springer, 1994, Chapter VI.
2. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. **105** (1983), 287--294.
3. P. Hriljac, *Heights and Arakelov's intersection theory*, Amer. J. Math.
   **107** (1985), 23--38.
4. G. Faltings, *Calculus on arithmetic surfaces*, Ann. of Math. **119**
   (1984), 387--424.
5. J. H. Silverman, *The Arithmetic of Elliptic Curves*, second edition,
   Graduate Texts in Mathematics **106**, Springer, 2009, Chapters III and
   VIII.
