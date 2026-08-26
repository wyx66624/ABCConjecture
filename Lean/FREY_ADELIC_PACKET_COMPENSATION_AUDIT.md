# Adelic compensation for a single Frey division branch

**Author: ChatGPT**

## Abstract

Let

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

and follow one algebraic branch \(Q\) with \([m]Q=P\).  At an odd
multiplicative place, a small identity packet can retain more of the Tate
Bernoulli term than the branch average.  This note determines exactly where
the compensating negative contribution can occur.

There is a useful unconditional positive statement.  In a fundamental Tate
annulus the complete finite theta/intersection term is nonnegative.  Hence,
on the odd semistable part of a Frey curve, every finite negative contribution
comes from a nonidentity Bernoulli component.  If \(S\) is a set of identity
packets of sizes \(d_p\), then

\[
 \sum_{v\nmid 2\infty}w_v\lambda_v(Q)
 \ge {1\over6}\sum_{p\in S}{e_p\over d_p^2}\log p
      -{1\over12}\sum_{p\notin S}e_p\log p.               \tag{A}
\]

Thus an unspecified "finite theta loss" is not the missing theorem.  The
remaining loss is the explicitly signed component mass outside \(S\), the
places over 2, and the archimedean Green sum.

The archimedean problem is strict, even for a non-torsion single packet and
a fixed branch field.  On an infinite Pell--Frey family over
\(K=\mathbf Q(\sqrt6)\), whose discriminant is 24, a point \(Q\) is in the
identity component at every odd bad place and is a half of \(P=2Q\) over
the same field.  Its packet size is \(d_p=1\), its finite bad contribution is

\[
 {1\over3}\log b+O(1),
\]

but

\[
 \widehat h(Q)={1\over4}\log b+O(1).
\]

Consequently its degree-normalized archimedean contribution is

\[
 \boxed{\Lambda_\infty(Q)=-{1\over12}\log b+O(1).}        \tag{B}
\]

The finite theta terms vanish in this calculation and the branch-field
discriminant is constant.  Therefore neither Hodge positivity, the product
formula, nor a field-discriminant term bounds the adverse complement by a
constant or by the radical with a subcritical coefficient.  In fact, on
this family a lower bound

\[
 \Lambda_\infty(Q)\ge-\kappa\log\operatorname{rad}
       (6b(b+1))-O(1)
\]

is equivalent, with the exact coefficient \(12\kappa\), to

\[
 \log b\le12\kappa\log\operatorname{rad}(6b(b+1))+O(1).
\]

At \(\kappa=(1+\varepsilon)/12\), this is precisely the abc inequality on
the Pell subfamily \((1,b,b+1)\).  This does not disprove a new
radical-scale archimedean theorem; it proves that the critical version of
that theorem already contains abc-strength arithmetic.

## 1. Normalizations

For a number field \(F\), use the following single product-formula
convention.  At a finite place \(v\), normalize

\[
 |\pi_v|_v=(Nv)^{-1}
\]

and multiply the resulting local Neron function by
\(w_v=1/[F:\mathbf Q]\).  At a real place put
\(w_v=1/[F:\mathbf Q]\), and at a complex place put
\(w_v=2/[F:\mathbf Q]\), using the ordinary complex modulus.  Thus the
residue degree is already present in \(\log Nv\) and must **not** be inserted
a second time through \([F_v:\mathbf Q_p]\).

All sums below use these weights.  For example, if a rational Tate parameter
has \(v_p(q)=n_p\), then after base change

\[
 {1\over[F:\mathbf Q]}\sum_{v\mid p}v(q)\log Nv
 ={1\over[F:\mathbf Q]}\sum_{v\mid p}e_vn_p f_v\log p
 =n_p\log p,                                               \tag{1.0}
\]

because \(\sum_{v\mid p}e_vf_v=[F:\mathbf Q]\).  This identity is the
degree normalization used in every rational-prime formula below.  A local
degree is a multiplicity inside its packet; it is not an additional packet.

At a split multiplicative nonarchimedean place write

\[
 E(\overline F_v)=\overline F_v^\times/q^{\mathbf Z},
 \qquad n=v(q)>0.
\]

Choose the representative \(z\) with \(0\le v(z)<n\), put
\(t=v(z)/n\), and normalize \(|\pi|=(Nk)^{-1}\).  The local Neron function
is

\[
 \lambda_v([z])=\Theta_v(z)+{n\over2}B_2(t)\log Nk,       \tag{1.1}
\]

where

\[
 B_2(t)=t^2-t+{1\over6}
       =\left(t-{1\over2}\right)^2-{1\over12}             \tag{1.2}
\]

and

\[
 \Theta_v(z)= -\log|1-z|
 -\sum_{\nu\ge1}\log|(1-q^\nu z)(1-q^\nu z^{-1})|.       \tag{1.3}
\]

The formula is unchanged after an unramified extension when it is written
with the weights just fixed: the residue-degree factor in \(\log Nv\) is
cancelled by the enlarged global degree.  A nonsplit multiplicative place is
handled after the unramified quadratic splitting extension and descent of
the resulting Galois-invariant multiset.

The canonical local Green normalization is used at every place, so

\[
 \widehat h(Q)=\sum_v w_v\lambda_v(Q).                    \tag{1.4}
\]

Changing all local Neron functions by compatible constants changes the
individual display but not any global conclusion.  Formula (1.1) fixes the
constants used in this note.

## 2. The finite theta term has the favorable sign

The sign in (1.3) is completely elementary.  Since
\(0\le v(z)<v(q)\), for every \(\nu\ge1\),

\[
 v(q^\nu z)>0,\qquad v(q^\nu z^{-1})>0.
\]

Therefore all factors in the infinite product have absolute value one.  In
addition, \(|1-z|\le1\).  Hence

\[
 \boxed{\Theta_v(z)=-\log|1-z|\ge0.}                      \tag{2.1}
\]

It is zero unless the identity-component representative specializes to the
identity of the residual torus.  Thus a horizontal collision can increase a
finite local height, but it cannot supply the negative compensation sought
here.

Equation (1.2) gives the sharp universal component bound

\[
 {n\over2}B_2(t)\log Nk\ge-{n\over24}\log Nk.             \tag{2.2}
\]

For a rational prime \(p\) with Frey fibre \(I_{2e_p}\), multiply (2.2)
by \(w_v\) and sum over every \(v\mid p\).  Equation (1.0) then gives the
degree-normalized rational-prime bound

\[
 \Lambda_{p,\mathrm{comp}}(Q)\ge-{e_p\over12}\log p.     \tag{2.3}
\]

At an identity packet this same degree-normalized \(v\mid p\) total is
\(e_p\log p/6\).  If the conjugates of one branch occupy a uniformly
weighted identity coset of size \(d_p\), the Bernoulli multiplication formula
gives instead

\[
 \Lambda_{p,\mathrm{comp}}(Q)
 ={e_p\over6d_p^2}\log p.                                 \tag{2.4}
\]

Combining (2.1)--(2.4) proves (A).  Good-reduction integral points also have
nonnegative local height in the standard minimal normalization.  For the
displayed Frey model every odd bad place is multiplicative, so only the
places over 2 must be kept outside (A).

This is a genuine reduction of the open problem:

* finite theta/intersection terms need no adverse lower bound;
* unfavorable component cosets have the explicit sharp cost \(-e_p/12\);
* after those terms are booked, only the 2-adic and archimedean terms remain.

The word *sharp* matters.  The opposite packet for halving attains (2.3), so
no better pointwise constant is possible.

## 3. Torsion translations give a doubly centered adelic ledger

Let \(P=[m]Q\).  First choose one finite extension \(L\) of the original
ground field over which \(Q\) and every point of \(E[m]\) are defined.  In
this section \(v\) always runs over the places of this one common field
\(L\), and \(w_v\) denotes the weights of Section 1 for \(L\).  Use
canonical mean-zero Green functions.  The distribution relation is

\[
 \sum_{T\in E[m]}\lambda_v(Q+T)=\lambda_v(P).             \tag{3.1}
\]

One proof pulls back the divisor \((O)\) under \([m]\):
\([m]^*(O)=\sum_{T\in E[m]}(T)\).  Both sides of the resulting local Green
identity have mean zero against the canonical invariant measure, so the
otherwise possible additive constant is zero.  With a noncanonical local
normalization a constant must be inserted and carried through every place.

Define

\[
 \delta_v(T)=w_v\left(\lambda_v(Q+T)-{1\over m^2}\lambda_v(P)\right).
\]

Then (3.1) says

\[
 \sum_{T\in E[m]}\delta_v(T)=0\qquad\text{for every }v.   \tag{3.2}
\]

Since torsion translation does not change canonical height, and all columns
are now defined over the same field \(L\),

\[
 \widehat h(Q+T)=\widehat h(Q)={1\over m^2}\widehat h(P),
\]

and hence

\[
 \sum_v\delta_v(T)=0\qquad\text{for every }T.             \tag{3.3}
\]

Thus the matrix with rows indexed by places and columns by torsion
translations has both row sums and column sums zero.  A locally favorable
translation merely chooses a positive entry in one row.  Choosing a
different translation independently at every place does not define one
global point.  For any fixed global column, (3.3) forces the exact identity

\[
 \sum_{v\in S}\delta_v(T)
 =-\sum_{v\notin S}\delta_v(T).                            \tag{3.4}
\]

Neither Faltings--Hriljac nor the arithmetic Hodge index changes (3.4).
They geometrize this same canonical-height identity after the vertical and
archimedean corrections have been restored.  In particular, deleting the
negative column entries is not an application of positivity.

## 4. The field discriminant is not part of the height identity

The absolute canonical height is invariant under finite base extension;
equation (1.0) is the finite-place calculation behind this invariance in the
present normalization.
Accordingly, no term involving \(\operatorname{Disc}(F)\) occurs in
(1.4), (3.1), or (3.3).  Field discriminants can enter a separate Arakelov
comparison theorem, but then their coefficient and sign have to be proved;
they cannot be inserted as missing local heights.

The local identity-root construction already shows that an identity packet
can be unramified at a selected prime.  The global family in the next section
is stronger for the compensation question: the entire branch field is the
fixed quadratic field \(\mathbf Q(\sqrt6)\).  Therefore its normalized field
discriminant is the constant \(\frac12\log24\), while the negative
archimedean term tends to minus infinity linearly in the source height.

It follows that every putative estimate of the form

\[
 \Lambda_\infty(Q)+\Theta_{\rm fin}(Q)
 \ge-C_1{\log|\operatorname{Disc}F|\over[F:\mathbf Q]}-C_2 \tag{4.1}
\]

is false, even for non-torsion single-packet Frey points.  Adding a stable
Faltings or Hodge height can make an inequality true, but that height is of
depth scale on the family.  It does not produce a radical-scale estimate.

## 5. A strict non-torsion, single-packet counterledger

Take positive integers \(r,s\) satisfying

\[
 s^2-3r^2=1,
 \qquad b=3r^2-2,
 \qquad c=b+1=3r^2-1.                                    \tag{5.1}
\]

There are infinitely many such pairs.  To keep the small primes uniform,
use the infinite subfamily

\[
 q^2-3p^2=1,\qquad r=2pq,\qquad s=q^2+3p^2.              \tag{5.2}
\]

Then \(v_2(b)=1\), neither \(b\) nor \(c\) is divisible by 3, and
\((1,b,c)\) is a primitive abc triple.

On

\[
 E_b:y^2=x(x-1)(x+b)
\]

over the fixed field \(K=\mathbf Q(\sqrt6)\), put

\[
 Q=(2,r\sqrt6).                                           \tag{5.3}
\]

Indeed,

\[
 2(2-1)(2+b)=2\cdot3r^2=6r^2.
\]

Set \(P=2Q\).  Then \([2]Q=P\) over the same controlled base field.  Thus
the branch field adds neither degree nor discriminant, and at every place its
component packet has size \(d_p=1\).  The two rational embeddings of \(K\)
send \(Q\) to \(Q\) and \(-Q\); both are in the identity component whenever
\(Q\) is.

Let \(\ell\nmid6\) divide \(b\).  The colliding roots are \(0,-b\), while
\(x(Q)=2\) is a nonsingular reduction.  If \(\ell\mid c=b+1\), the colliding
roots are \(1,-b\), and again \(x(Q)=2\) is nonsingular.  Hence \(Q\) lies in
the Neron identity component at every odd bad place.  It does not reduce to
the identity of the residual torus, so its finite theta term is zero there.
Degree normalization over the split or inert primes of \(K\) gives

\[
 \begin{aligned}
 \Lambda_{\rm fin}(Q)
 &= {1\over6}\sum_{\ell\nmid6}
       v_\ell(bc)\log\ell+O(1)\\
 &= {1\over6}\log{b(b+1)\over2}+O(1)\\
 &= {1\over3}\log b+O(1).                                \tag{5.4}
 \end{aligned}
\]

The \(O(1)\) contains only the fixed places over 2 and 3.

For completeness, the height coefficient can be computed without a rank or
BSD conjecture.  Parametrize the Pell conic by

\[
 r={2u\over1-3u^2},\qquad s={1+3u^2\over1-3u^2}.
\]

The associated elliptic surface has singular fibres

\[
 8I_2+2I_4,\qquad\chi=2.
\]

The section \(Q\) meets the identity component at the eight \(I_2\) fibres
and component 2 at both \(I_4\) fibres.  It is disjoint from \(O\).  Shioda's
formula therefore gives

\[
 \langle Q,Q\rangle_{\rm Sh}=2\chi-2=2,
 \qquad \widehat h_{\mathbf Q(u)}(Q)=1.                  \tag{5.5}
\]

For \(u=p/q\) in (5.2), \(h(u)=\log q\) and

\[
 \log b=4\log q+O(1).
\]

Tate's bounded-error specialization theorem yields

\[
 \boxed{\widehat h(Q)={1\over4}\log b+O(1).}             \tag{5.6}
\]

In particular, \(Q\) is non-torsion for every sufficiently large member of
the family.  Subtracting (5.4) from (5.6) in the global identity (1.4) gives

\[
 \boxed{\Lambda_\infty(Q)=-{1\over12}\log b+O(1),}       \tag{5.7}
\]

where the two real embeddings of \(K\) have already been degree normalized.
This proves (B).  It is an actual division branch with \(d_p=1\), not a
branch average; the branch is \(Q\) above the selector \(P=2Q\).

The ledger also explains why no contradiction with global quadraticity is
present:

\[
 \underbrace{{1\over3}\log b}_{\text{finite identity packets}}
 +\underbrace{\left(-{1\over12}\log b\right)}
             _{\text{archimedean Green}}
 =\underbrace{{1\over4}\log b}_{\widehat h(Q)}+O(1).     \tag{5.8}
\]

## 6. Exact coefficient equivalence with the abc subfamily

Put

\[
 H=\log b,\qquad R=\log\operatorname{rad}(6b(b+1)).
\]

Equation (5.7) means that there is an absolute constant \(C_0\), depending
only on the fixed surface and local normalizations, such that

\[
 \left|\Lambda_\infty(Q)+{H\over12}\right|\le C_0.       \tag{6.1}
\]

Suppose

\[
 \Lambda_\infty(Q)\ge-\kappa R-C.                         \tag{6.2}
\]

Then (6.1) gives, with the direction and coefficient retained,

\[
 \boxed{H\le12\kappa R+12(C+C_0).}                       \tag{6.3}
\]

Conversely, if

\[
 H\le12\kappa R+C',                                      \tag{6.4}
\]

then

\[
 \boxed{\Lambda_\infty(Q)
        \ge-\kappa R-(C'/12+C_0).}                        \tag{6.5}
\]

Thus (6.2) and (6.4) are equivalent up to an explicitly transformed bounded
constant.  There is no hidden factor 2 from \(K\): all quantities are degree
normalized.

Taking \(12\kappa=1+\varepsilon\), equation (6.3) is

\[
 \log b\le(1+\varepsilon)
       \log\operatorname{rad}(6b(b+1))+O_\varepsilon(1),  \tag{6.6}
\]

which is the abc inequality for the primitive triples \((1,b,b+1)\), with
the harmless fixed factor 6 absorbing the places where the chosen model and
twist are not uniform.  Conversely, (6.6) proves the critical archimedean
lower bound on this family through (6.5).

This equivalence has a precise scope.  It does not show that the full abc
conjecture follows from an estimate proved only for this Pell family.  It
does show that the needed critical radical-scale compensation estimate is
already an abc-strength statement on a genuine infinite subfamily, even
after degree, branch discriminant, finite theta terms, and component packets
have all been made favorable.

## 7. What survives

The audit proves two positive facts and one no-go.

1. The odd finite complement has the unconditional sharp lower bound (A).
   Finite theta terms are favorable, so they should be removed from the list
   of unknown adverse inputs.
2. Torsion-translation deficits form the doubly centered ledger
   (3.2)--(3.3).  This precisely identifies the global compatibility that a
   simultaneous branch selector must satisfy.
3. A critical radical-scale lower bound for the archimedean complement does
   not follow from Hodge positivity or field-discriminant control.  The Pell
   family makes the field discriminant constant and converts that lower bound
   into (6.6) with exact coefficient.

The smallest remaining positive target is consequently narrower than the
one stated before this audit.  One needs either:

* a branch selector for which the selected component surplus is accompanied
  by an independently proved archimedean cancellation mechanism not present
  on the Pell surface; or
* a new truncated/radical inequality for the archimedean Green function,
  with the recognition that its critical coefficient is abc-strength; or
* several globally compatible branches whose **sum of archimedean deficits**
  cancels while their selected finite component surpluses add.

Bounded degree, unramified local divisibility, a bounded branch-field
discriminant, or torsion translation alone cannot supply this theorem.

## 8. Lean boundary

The companion module
`IUTThreeClosures/FreyAdelicPacketCompensationAudit.lean` checks only the
assumption-free scalar core:

1. the completed-square formula and sharp lower bound for \(B_2\);
2. the Frey component values \(e/6\) and \(-e/12\);
3. the finite selected-versus-adverse lower ledger;
4. exact selected/complement conservation;
5. the point radicand and double Pell parametrization used in Section 5;
6. absorption of a fixed discriminant cost into the bounded constant;
7. both directions of the coefficient-12 equivalence (6.2)--(6.5), including
   a bounded error in (6.1).

Lean does not formalize local fields, Tate uniformization, Neron functions,
canonical Green metrics, number-field degree normalization, elliptic
surfaces, Kodaira fibres, Shioda's pairing, specialization of canonical
heights, Faltings--Hriljac, the arithmetic Hodge index, or abc.  None of
those statements is hidden in a structure field or introduced as an axiom.

## References

1. J. H. Silverman, *Advanced Topics in the Arithmetic of Elliptic Curves*,
   Graduate Texts in Mathematics **151**, Springer, 1994, Chapter VI.
2. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. **105** (1983), 287--294,
   DOI 10.2307/2374389.
3. T. Shioda, *On the Mordell--Weil lattices*, Comment. Math. Univ. St.
   Pauli **39** (1990), 211--240.
4. G. Faltings, *Calculus on arithmetic surfaces*, Ann. of Math. **119**
   (1984), 387--424.
5. P. Hriljac, *Heights and Arakelov's intersection theory*, Amer. J. Math.
   **107** (1985), 23--38.
