# Near-singular height matrices versus short Mordell--Weil vectors

## Abstract

This note audits the remaining same-character height-lattice proposal for
the Frey curve

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c.
\]

The first conclusion is a correction to the proposed target.  The least
ordinary eigenvalue of the Gram matrix of a displayed Mordell--Weil basis is
not a lattice invariant.  Starting with two orthogonal points of height
\(H\), replace the second point by

\[
 Q_N=NP+R.
\]

The new Gram matrix is

\[
 H\begin{pmatrix}1&N\\N&N^2+1\end{pmatrix}.
\]

Its least real eigenvalue is at most \(H/(N^2+1)\), although the integral
lattice, its regulator, and its shortest nonzero height are unchanged.  This
is not merely an abstract warning.  Applying the shear to the fixed-twist
Pell/Frey family from the companion rank-two audit preserves the common
quadratic field, the conductor, and every favorable identity-component
condition, while producing a normalized Gram eigenvalue tending to zero.
Nevertheless every nonzero integral combination still has canonical height
at least \((1/4-o(1))\log b\).  Thus the spectral surrogate is rigorously
retired.

The invariant target is instead the first integral successive minimum

\[
 \mu_1(\Lambda)=
 \min_{0\ne z\in\mathbf Z^r} z^{\!T}Gz,
\]

or an explicitly exhibited integral vector with controlled coefficients.
The note also records why rational 2-isogenies and pullback under a fixed
finite base change do not decrease this invariant relative to the source
scale.  New sections after base change remain a genuine possibility, but
their field, discriminant, conductor, and local-component costs must be
counted.  No general regulator bound, Lang height bound, abc estimate, or
unconditional short point is claimed.

## 1. The correct invariant

Let \(\Lambda\) be a rank-\(r\) subgroup of the free part of a
Mordell--Weil group, with Neron--Tate pairing and Gram matrix \(G\) in a
chosen integral basis.  Three quantities must be distinguished.

1. The least real eigenvalue \(\lambda_{\min}(G)\) is minimized over unit
   vectors in \(\mathbf R^r\).  It changes under an integral change of basis.
2. The first integral successive minimum

   \[
   \mu_1(\Lambda)=\min_{0\ne z\in\mathbf Z^r}z^TGz
   \tag{1.1}
   \]

   is the least canonical height of a nonzero point of the lattice and is
   invariant under \(GL_r(\mathbf Z)\).
3. The regulator \(\det G\) is also invariant under an integral change of
   basis, but by itself it does not determine \(\mu_1\): it controls a
   product of successive minima only after geometry-of-numbers constants and
   the other minima are included.

For an abc application, (1.1), not \(\lambda_{\min}\), is the relevant
quantity.  If coefficients are required to be bounded for local or
denominator reasons, then one needs the still stronger restricted minimum

\[
 \mu_1(\Lambda;B)=
 \min_{\substack{0\ne z\in\mathbf Z^r\\\|z\|_\infty\le B}}z^TGz.
\tag{1.2}
\]

A small real eigenvalue can be useful only after a quantitative rounding
argument controls the expanding eigenvalues, the integral denominator of the
eigendirection, and all local effects of the resulting coefficients.

## 2. Exact unimodular-shear counterexample

Let \(P,R\) be independent, write

\[
 A=\widehat h(P),\qquad
 B=\langle P,R\rangle,\qquad
 C=\widehat h(R),
\]

and set \(Q_N=NP+R\), for \(N\in\mathbf Z\).  The Gram matrix in the
displayed pair \((P,Q_N)\) is

\[
 G_N=
 \begin{pmatrix}
 A&NA+B\\
 NA+B&N^2A+2NB+C
 \end{pmatrix}.
 \tag{2.1}
\]

For every \((m,n)\), bilinearity gives the exact identity

\[
 (m,n)G_N(m,n)^T
 =A(m+Nn)^2+2B(m+Nn)n+Cn^2.                 \tag{2.2}
\]

The coefficient map

\[
 (m,n)\longmapsto(m+Nn,n)                    \tag{2.3}
\]

is an automorphism of \(\mathbf Z^2\), with inverse
\((u,v)\mapsto(u-Nv,v)\).  Therefore

\[
 \mathbf ZP+\mathbf ZQ_N=\mathbf ZP+\mathbf ZR,
 \qquad
 \mu_1(P,Q_N)=\mu_1(P,R).                    \tag{2.4}
\]

The determinant calculation is equally exact:

\[
 \det G_N=AC-B^2.                             \tag{2.5}
\]

Thus neither the lattice nor its regulator changes.

Now take the orthogonal case \(A=C=H>0, B=0\).  The coefficient vector
\((-N,1)\) has Euclidean norm squared \(N^2+1\), but (2.2) gives

\[
 (-N,1)G_N(-N,1)^T=H.
\]

The Rayleigh principle therefore yields

\[
 \lambda_{\min}(G_N)\le\frac{H}{N^2+1}.       \tag{2.6}
\]

On the other hand, for every nonzero integral pair,

\[
 (m,n)G_N(m,n)^T
 =H\big((m+Nn)^2+n^2\big)\ge H.              \tag{2.7}
\]

Hence \(\mu_1=H\) for every \(N\), while the displayed real eigenvalue can
be made arbitrarily small.  The vector used in (2.6) does not produce a
shorter lattice point: it simply recovers \(R=Q_N-NP\).

This also explains why a nearly dependent pair of sections is not by itself
evidence for cancellation.  If the near dependence comes from a large
integral shear, the condition number records a bad basis rather than new
Mordell--Weil geometry.

## 3. An actual Pell/Frey realization with favorable components

The companion note `FREY_SAME_CHARACTER_RANK_TWO_OBSTRUCTION.md` constructs
the fixed twist

\[
 \mathcal E_b:Y^2=X(X-6)(X+6b),
 \qquad b=3r^2-2,
\]

with Pell relation \(s^2-3r^2=1\) and points

\[
 \mathcal P=(12,36r),\qquad
 \mathcal R=(18,36s).                         \tag{3.1}
\]

Over the Pell parameter \(u\), their function-field canonical-height Gram
matrix is exactly \(I_2\).  Along

\[
 q^2-3p^2=1,\qquad
 r=2pq,\qquad s=q^2+3p^2,
\]

the specialized Gram matrix has the uniform form

\[
 G_0(u)=h(u)I_2+E(u),\qquad \|E(u)\|_{\rm op}\le C,
 \qquad \log b=4h(u)+O(1).                    \tag{3.2}
\]

Consequently every nonzero integral combination of
\(\mathcal P_u,\mathcal R_u\) has height at least

\[
 h(u)-C=\left(\frac14-o(1)\right)\log b.      \tag{3.3}
\]

Choose any integers \(N(u)\to\infty\), even after seeing the
specialization, and put

\[
 \mathcal Q_u=N(u)\mathcal P_u+\mathcal R_u.  \tag{3.4}
\]

This is a parameter-dependent displayed pair, so one must not apply a fixed-
section specialization error to \(\mathcal Q_u\).  Instead, use the exact
identity (2.2) on each specialized curve.  The Rayleigh vector
\((-N(u),1)\) gives

\[
 \lambda_{\min}G(\mathcal P_u,\mathcal Q_u)
 \le \frac{\widehat h(\mathcal R_u)}{N(u)^2+1}
 =\frac{h(u)+O(1)}{N(u)^2+1}
 =o(\log b),                                     \tag{3.5}
\]

whereas (2.4) and (3.3) give

\[
 \mu_1(\mathbf Z\mathcal P_u+
        \mathbf Z\mathcal Q_u)
 \ge\left(\frac14-o(1)\right)\log b.          \tag{3.6}
\]

At every odd bad prime outside \(6\), both original points lie in the Neron
identity-component subgroup.  This subgroup is closed under integral linear
combinations, so \(\mathcal Q_u\) and every point in the sheared lattice
retain the same favorable component condition.  Moreover:

* the curve is unchanged;
* the quadratic twist remains the constant \(D=6\);
* the field remains \(\mathbf Q(\sqrt6)\);
* the conductor and bad-prime support are unchanged.

Thus (3.5)--(3.6) retire the least-eigenvalue target under strictly better
cost control than the proposed route requested.  The failure is integral,
not analytic or conductor-theoretic.

The continued-fraction nature of the Pell sequence is also instructive.
The rational parameters \(u=p/q\) approach the pole
\(1/\sqrt3\) in the real topology, but \(h(u)=\log q\) and
\(\log b=4\log q+O(1)\).  Archimedean proximity to a collision or pole is
therefore not an arithmetic small-height statement; its denominator is part
of the global height ledger.

## 4. Fixed sections cannot acquire a vanishing normalized minimum

Let \(\mathscr E\to\mathbf P^1\) be a fixed non-isotrivial elliptic surface
over a number field and let \(P_1,\ldots,P_r\) be fixed sections independent
modulo torsion.  Write \(G_K\) for their positive-definite function-field
height Gram matrix.  Tate--Silverman variation of canonical height, applied
to the finitely many sections \(P_i\) and \(P_i+P_j\), gives

\[
 G(t)=h(t)G_K+O(1)                              \tag{4.1}
\]

entrywise on the smooth fibers; in fixed dimension the error has bounded
operator norm.  Hence

\[
 \lambda_{\min}(G(t))
 \ge h(t)\lambda_{\min}(G_K)-C.                 \tag{4.2}
\]

More importantly, positive definiteness of the fixed function-field lattice
and the same bounded-error estimate for a fixed reduced basis prevent any
fixed nonzero direction from having sublinear height.  If a fixed source map
has

\[
 \log c(t)=d\,h(t)+O(1),\qquad d>0,             \tag{4.3}
\]

then the normalized fixed-section matrix has a positive limiting least
eigenvalue \(\lambda_{\min}(G_K)/d\).

The word *fixed* is indispensable.  Applying (4.1) separately to infinitely
many sections whose coefficients depend on \(t\) does not give a uniform
\(O(1)\).  Section 3 avoided this mistake by using an exact lattice identity
and the already uniform lower bound (3.3).

The relevant primary sources are Tate's height-variation theorem and
Silverman's global boundedness refinement; see
[Silverman, JNT 48 (1994), 330--352](https://doi.org/10.1006/jnth.1994.1070).

## 5. Base change does not shrink the pullback lattice

Let \(C'\to C\) be a finite morphism of degree \(d\), and pull back a fixed
elliptic surface and fixed sections.  The function-field height pairing
satisfies

\[
 \langle P,Q\rangle_{k(C')}=
 d\langle P,Q\rangle_{k(C)}.                   \tag{5.1}
\]

If a source-height divisor also pulls back, its degree is multiplied by the
same \(d\).  Therefore both the first minimum of the pullback sublattice and
the source scale are multiplied by \(d\); their ratio is unchanged.  Fiber
splitting, ramification, and minimalization may redistribute the individual
Shioda correction terms, but cannot contradict the intrinsic equality
(5.1).

This is Proposition 11.14 in the survey
[Schuett--Shioda, *Elliptic Surfaces*](https://arxiv.org/abs/0907.0298),
which also gives the intersection-theoretic height formula used below.

This closes only the proposal “pull back old sections and hope ramification
makes their lattice nearly singular.”  A cover may create genuinely new
sections.  Those are not governed by (5.1) as pullbacks, and remain a valid
search direction.  For an abc application one must then bound:

1. the degree and arithmetic discriminant of the specialization field;
2. new bad fibers and the conductor of the auxiliary curve;
3. the integral first minimum, not the eigenvalue of a chosen basis;
4. the local component and theta/intersection terms of the new short point.

Division points are an instance of this distinction: their canonical heights
can fall by \(m^{-2}\), but the branch packet and field/discriminant ledger is
exactly the separate division-height problem.

## 6. Rational 2-isogenies preserve, rather than manufacture, directions

Let \(\phi:E\to E'\) be a rational 2-isogeny and \(\widehat\phi\) its dual.
Canonical heights satisfy

\[
 \widehat h_{E'}(\phi P)=2\widehat h_E(P),
 \qquad
 \langle\phi P,\phi Q\rangle_{E'}
 =2\langle P,Q\rangle_E,                         \tag{6.1}
\]

and \(\widehat\phi\phi=[2]\).  Consequently:

* transporting an independent rank-\(r\) lattice through \(\phi\) multiplies
  its Gram matrix and its first minimum by \(2\); it does not improve the
  condition relative to a fixed source scale;
* following a single point around the isogeny-dual graph gives
  \(P\) and \([2]P\), whose scalar Gram matrix is

  \[
  \widehat h(P)
  \begin{pmatrix}1&2\\2&4\end{pmatrix};          \tag{6.2}
  \]

  it has determinant zero because the two displayed points span rank one;
* points on \(E\) and \(E'\) cannot be combined in one Mordell--Weil lattice
  until one is transported, at which point (6.1) applies.

Over \(\mathbf Q\), isogenous elliptic curves have the same conductor, so
the obstruction is not a conductor loss.  A 2-isogeny is useful for descent
and for moving local component data, but it does not create a second short
integral direction.  A genuinely independent second point must enter from
outside the orbit; after that, its first minimum must be audited directly.

The explicit Frey two-quotient equations and displayed discriminants are
already checked in `FreyFullTwoIsogenyGraph.lean`.  They likewise do not
assert that a point orbit creates rank.

## 7. Shioda's formula exposes the auxiliary-fiber cost

For a relatively minimal elliptic surface \(S\to C\) and a nonzero section
\(P\ne O\), Shioda's self-pairing formula is

\[
 \langle P,P\rangle_{\mathrm{Sh}}
 =2\chi(S)+2(P\cdot O)-
  \sum_v\operatorname{contr}_v(P).              \tag{7.1}
\]

At a multiplicative fiber \(I_n\), a section meeting component \(i\) has

\[
 \operatorname{contr}_v(P)=\frac{i(n-i)}n\le\frac n4,     \tag{7.2}
\]

while the identity component \(i=0\) contributes zero.  Therefore, on a
semistable surface, if \(P\) is in the identity component at a chosen target
set \(T\), then

\[
 \langle P,P\rangle_{\mathrm{Sh}}
 \ge 2\chi(S)-\frac14
       \sum_{v\notin T}n_v.                    \tag{7.3}
\]

Since \(\sum_v n_v=12\chi(S)\) in the semistable case, a section with
\(o(\chi)\) height and identity behavior on \(T\) requires

\[
 \sum_{v\notin T}n_v\ge 8\chi(S)-o(\chi).       \tag{7.4}
\]

Thus almost all of the \(2\chi\) baseline must be cancelled by nonidentity
components at auxiliary fibers.  In particular, a nonzero section in the
narrow Mordell--Weil group, identity at every reducible fiber, satisfies

\[
 \langle P,P\rangle_{\mathrm{Sh}}\ge2\chi(S)
 =\frac16\deg\Delta_{\min}.                    \tag{7.5}
\]

These are geometric function-field statements.  They do not by themselves
identify the arithmetic conductor of every number-field specialization.
They do show exactly where a proposed elliptic-surface construction must pay:
if the desired bad fibers give no Shioda correction, near-zero height needs a
large correction budget elsewhere, whose specialized conductor and field
cost cannot be omitted.

The Pell surface makes (7.3) sharp.  Its configuration is
\(8I_2+2I_4\), so \(\chi=2\).  The two generators are identity at the eight
\(I_2\) fibers, while at the two \(I_4\) fibers each meets component 2 and
receives correction 1.  Hence

\[
 \langle P,P\rangle_{\mathrm{Sh}}=4-2=2,
\]

or standard function-field canonical height 1.  The continued-fraction
specializations do not evade this exact fiber ledger.

There is a complementary regulator check.  Shioda's discriminant formula,
up to the harmless sign convention for the Neron--Severi intersection form,
is

\[
 |\operatorname{disc}\operatorname{NS}(S)|
 =\frac{|\operatorname{disc}\operatorname{Triv}(S)|
          \operatorname{Reg}\operatorname{MW}(S)}
        {|\operatorname{MW}(S)_{\rm tors}|^2}.            \tag{7.6}
\]

An integral shear changes none of the four terms in (7.6).  A genuinely
small Mordell--Weil regulator must therefore come from different surface
geometry, a different Mordell--Weil sublattice/index, or new sections; it
cannot come from presenting the old lattice by nearly parallel generators.
Conversely, even a small regulator controls only the product of successive
minima.  Without an upper bound on the remaining minima it is not, by itself,
a certificate that the first minimum is below the abc scale.

## 8. What remains genuinely open

The following shortcuts are now closed.

1. A displayed Gram matrix with
   \(\lambda_{\min}=o(\log c)\) need not contain any point of height
   \(o(\log c)\); the Pell/Frey shear is an actual counterexample with zero
   field or conductor cost and favorable local components.
2. Transporting points through a rational 2-isogeny scales the existing
   lattice and a one-point isogeny orbit stays rank one.
3. Pulling fixed sections through a finite base change scales both their
   heights and a pulled-back source divisor by the degree.
4. Approaching a collision or pole through Pell/continued-fraction
   parameters does not suppress arithmetic parameter height.

The strict surviving target is:

> Construct, for every relevant Frey input (or on a reduction sufficient for
> abc), an actual non-torsion integral combination \(R\) in one controlled
> character space such that
> \(\widehat h(R)=o(\log c)\), while \(R\) lies in the favorable identity
> component on a set carrying the required high-weight bad-prime mass and
> while all auxiliary field, discriminant, conductor, finite theta, and
> archimedean terms are bounded within the radical budget.

Equivalently, one may prove a bound for the invariant
\(\mu_1\) of a controlled lattice, together with a coefficient bound strong
enough for the local ledger.  Possible mechanisms not eliminated here are
new sections created by varying covers, genuinely small narrow or partially
narrow sections on specially designed surfaces, or a global Kummer selector
which produces a short point directly.  Each requires new arithmetic input;
none follows from rank, regulator, a small real eigenvalue, or isogeny alone.

## 9. Lean boundary

`IUTThreeClosures/FreyNearSingularHeightLatticeAudit.lean` formalizes only
the unconditional scalar and group-theoretic core:

1. the exact Gram transformation under the integral shear;
2. invariance of its determinant and coefficient lattice;
3. the arbitrarily small displayed Rayleigh quotient in the orthogonal case;
4. the unchanged lower bound for every nonzero integral combination;
5. the rank-one doubled-orbit determinant and relation;
6. cancellation of a common finite-base-change scale;
7. the elementary scalar form of the Shioda correction-budget implication;
8. preservation of a chosen additive subgroup under the shear.

Lean does not model canonical heights, elliptic curves, isogenies, elliptic
surfaces, specialization, Neron components, conductors, field
discriminants, or Shioda corrections.  The geometric interpretations of the
scalar variables remain explicitly paper-only, and no abc conclusion is
declared.
