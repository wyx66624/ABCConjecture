# Cross-motive cancellation for the three cyclic Frey two-isogenies

**Author: ChatGPT**

## Abstract

Consider the fixed-field Pell--Frey family

\[
 E_b:y^2=x(x-1)(x+b),\qquad
 b=3r^2-2,\qquad Q=(2,r\sqrt6)
\]

over \(K=\mathbf Q(\sqrt6)\).  The three nonzero rational two-torsion
points define three cyclic quotient isogenies

\[
 \phi_0:E_b\to E_0,\qquad
 \phi_1:E_b\to E_1,\qquad
 \phi_{-b}:E_b\to E_{-b}.
\]

This note tests whether the three target motives can cancel their
archimedean Green deficits while retaining more selected odd multiplicative
mass than their correctly counted global height cost.

At a split Tate fibre \(I_{2e}\), the identity-component kernel gives

\[
 E_q/\mu_2\simeq E_{q^2},\qquad [u]\longmapsto[u^2],
\]

and changes the identity-component Bernoulli value from \(e/6\) to
\(e/3\).  Each of the two nonidentity kernels gives

\[
 E_q/\langle\pm\sqrt q\rangle\simeq E_{\pm\sqrt q},
 \qquad [u]\longmapsto[u],
\]

and changes that value to \(e/12\).  The target fibre depths are
\(4e,e,e\), so their mean contact and mean identity-component value return
to those of the source.

For the Pell point, the three quotient-image abscissae are

\[
 {b+2\over2},\qquad 2(b+2),\qquad {2\over b+2}.          \tag{A}
\]

The last coordinate has a growing denominator because \(b+2=3r^2\).
After including its good-reduction local height, the complete leading
coefficient table relative to \(H=\log b\) is

\[
\begin{array}{c|ccc}
 &\phi_0(Q)&\phi_1(Q)&\phi_{-b}(Q)\\ \hline
 \text{odd bad finite}&5/12&5/12&1/6\\
 \text{good finite}&0&0&1/2\\
 \text{archimedean}&1/12&1/12&-1/6\\ \hline
 \text{canonical height}&1/2&1/2&1/2.
\end{array}                                             \tag{B}
\]

Thus all three motives used once do exhibit genuine archimedean
cancellation, but only with ledger

\[
 1+{1\over2}+0={3\over2}.
\]

Their selected odd mass is only \(2/3\) of their total target-height cost.
More generally, for nonnegative weights \(u,v,w\),

\[
\begin{aligned}
 L_{\rm bad}&={5(u+v)\over12}+{w\over6},\\
 L_{\rm good}&={w\over2},\\
 L_\infty&={u+v\over12}-{w\over6},\\
 L_{\widehat h}&={u+v+w\over2}.
\end{aligned}                                           \tag{C}
\]

Every nonzero positive combination satisfies

\[
 L_{\rm bad}<L_{\widehat h},\qquad
 L_{\rm bad}\le {5\over6}L_{\widehat h}.                \tag{D}
\]

If \(L_\infty=0\), then \(u+v=2w\) and

\[
 L_{\rm bad}:L_{\widehat h}=2:3.                        \tag{E}
\]

There is consequently no cross-motive coefficient gain on this actual
infinite family.  The apparent cancellation is real, but the
good-denominator row and the degree-two scaling of each target canonical
height more than consume it.

## 1. Common field and family

Use the same degree-normalized local heights as in the adelic
packet-compensation audit.  At a finite place \(v\) of a number field
\(F\), normalize

\[
 |\pi_v|_v=(Nv)^{-1}
\]

and give the local Neron function weight \(1/[F:\mathbf Q]\).  At a real
place use weight \(1/[F:\mathbf Q]\), and at a complex place use
\(2/[F:\mathbf Q]\).  The global identity is

\[
 \widehat h_E(R)=\sum_vw_v\lambda_{E,v}(R).              \tag{1.1}
\]

Take Pell solutions

\[
 q_0^2-3p_0^2=1,\qquad
 r=2p_0q_0,\qquad b=3r^2-2,\qquad c=b+1.                \tag{1.2}
\]

For uniform terms over \(2\), restrict to

\[
 q_0+p_0\sqrt3=(2+\sqrt3)^{2j+1}.                       \tag{1.3}
\]

Then \(v_2(r)=2\), \(v_2(b)=1\), and \(3\nmid bc\).  This is an infinite
subfamily.  Put

\[
 H=\log b.
\]

Then

\[
 \log c=H+O(1),\qquad \log r={1\over2}H+O(1),            \tag{1.4}
\]

with uniform bounded error.

The point

\[
 Q=(2,r\sqrt6)\in E_b(K),\qquad K=\mathbf Q(\sqrt6),
\]

satisfies

\[
 \widehat h_{E_b}(Q)={1\over4}H+O(1).                   \tag{1.5}
\]

It lies in the identity component at every odd bad place and its bad-place
theta term is zero.  It is non-torsion for every sufficiently large member
of the family.

## 2. The exact local Tate quotient ledger

Let \(E_q=\overline F_v^\times/q^{\mathbf Z}\) have split multiplicative
reduction of type \(I_n\), with \(n=v(q)\).  For a representative \(u\)
in the fundamental annulus, put

\[
 t={v(u)\over n}\in[0,1).
\]

The local Neron function is

\[
 \lambda_q([u])
 =\Theta_q(u)+{n\over2}B_2(t)\log Nv,                   \tag{2.1}
\]

where

\[
 B_2(t)=t^2-t+{1\over6}.                                \tag{2.2}
\]

All distribution identities below use canonical mean-zero Green
normalization.  With another normalization, compatible constants must be
carried through every place.

### 2.1 Identity-component kernel

The order-two point \([-1]\) belongs to the identity component.  Quotienting
by it gives

\[
 E_q/\langle-1\rangle\simeq E_{q^2},
 \qquad [u]_q\longmapsto[u^2]_{q^2}.                    \tag{2.3}
\]

The target has depth \(2n\), and

\[
 {v(u^2)\over v(q^2)}=t.
\]

The Bernoulli part is therefore doubled:

\[
 {2n\over2}B_2(t)
 =2\left({n\over2}B_2(t)\right).                        \tag{2.4}
\]

The theta terms obey the exact product identity

\[
 \Theta_{q^2}(u^2)=\Theta_q(u)+\Theta_q(-u).             \tag{2.5}
\]

At \(t=0\), its first factor is simply
\(-\log|1-u^2|=-\log|1-u|-\log|1+u|\); the remaining
factors split in the same way.  Equivalently, (2.5) is the local Green
distribution relation for the kernel \(\{1,-1\}\).

For a Frey fibre \(I_{2e}\), an identity source point with vanishing theta
terms consequently maps to an identity point of \(I_{4e}\) with value

\[
 {4e\over2}B_2(0)={e\over3}.                            \tag{2.6}
\]

### 2.2 The two nonidentity kernels

After a splitting extension containing a square root of \(q\), the other
two kernels are generated by \(\sqrt q\) and \(-\sqrt q\).  Their quotients
are

\[
\begin{aligned}
 E_q/\langle\sqrt q\rangle&\simeq E_{\sqrt q},\\
 E_q/\langle-\sqrt q\rangle&\simeq E_{-\sqrt q},
\end{aligned}
\qquad [u]\longmapsto[u].                               \tag{2.7}
\]

Both targets have depth \(n/2\).  Their normalized component parameter is

\[
 t'=\{2t\}.
\]

On \(0\le t<1/2\), the Bernoulli distribution identity is

\[
 B_2(t)+B_2(t+1/2)={1\over2}B_2(2t).                   \tag{2.8}
\]

On the other half of the circle, replace \(t+1/2\) by \(t-1/2\) and
\(2t\) by \(2t-1\).  Thus

\[
 {n\over2}B_2(t)+{n\over2}B_2(\{t+1/2\})
 ={n\over4}B_2(\{2t\}),                                 \tag{2.9}
\]

which is the target component term.  The theta terms satisfy the
corresponding kernel distributions

\[
\begin{aligned}
 \Theta_{\sqrt q}(u)
   &=\Theta_q(u)+\Theta_q(u\sqrt q),\\
 \Theta_{-\sqrt q}(u)
   &=\Theta_q(u)+\Theta_q(-u\sqrt q).
\end{aligned}                                           \tag{2.10}
\]

For an identity source point whose two kernel translates avoid the
residual identity, all terms in (2.10) vanish.  On an \(I_{2e}\) fibre,
either target is then an identity point of \(I_e\) with value

\[
 {e\over2}B_2(0)={e\over12}.                            \tag{2.11}
\]

Combining (2.6) and (2.11) gives

\[
 {e\over3}+{e\over12}+{e\over12}
 =3\,{e\over6}.                                         \tag{2.12}
\]

This is both the contact conservation \(4e+e+e=3(2e)\) and the exact
identity-component Bernoulli conservation.

The calculation was made after splitting the Tate fibre.  For a nonsplit
multiplicative fibre, pass to the unramified quadratic splitting extension
and descend the Galois-invariant weighted sum.  Degree normalization removes
the extra local degree.

## 3. The three global quotient images

Write

\[
 T_0=(0,0),\qquad T_1=(1,0),\qquad T_{-b}=(-b,0).
\]

For a model

\[
 y^2=u^3+Au^2+Bu
\]

with kernel at \(u=0\), the standard quotient map has target abscissa

\[
 X={y^2\over u^2}.                                      \tag{3.1}
\]

Applying (3.1) after shifting each of the three roots to zero gives

\[
\begin{aligned}
 X_0(\phi_0(Q))
   &={6r^2\over2^2}={b+2\over2},\\
 X_1(\phi_1(Q))
   &={6r^2\over(2-1)^2}=2(b+2),\\
 X_{-b}(\phi_{-b}(Q))
   &={6r^2\over(2+b)^2}={2\over b+2}.
\end{aligned}                                           \tag{3.2}
\]

The quotient models can be written

\[
\begin{aligned}
 E_0:\quad
  Y^2&=X^3+2(1-b)X^2+c^2X,\\
 E_1:\quad
  Y^2&=X^3-2(b+2)X^2+b^2X,\\
 E_{-b}:\quad
  Y^2&=X^3+2(2b+1)X^2+X.
\end{aligned}                                           \tag{3.3}
\]

Their displayed discriminants are

\[
 -256bc^4,\qquad 256cb^4,\qquad 256bc.                  \tag{3.4}
\]

At an odd prime dividing \(b\), the identity-component kernel is \(T_1\);
the quotient depths for \(T_0,T_1,T_{-b}\) are \(e,4e,e\).  At an odd
prime dividing \(c\), the identity kernel is \(T_0\), and the depths are
\(4e,e,e\).  Equations (3.3)--(3.4) independently confirm this table.

## 4. The odd bad row

The point \(Q\) avoids the kernel point in the residual identity torus.
Consequently none of its three quotient images reduces to the identity of
the residual torus, and all bad-place theta terms remain zero by the local
distribution relations.

Let

\[
 B_{\rm odd}=\log(b/2),\qquad C=\log c.
\]

Here \(v_2(b)=1\) on the chosen Pell subfamily, so \(B_{\rm odd}\) is
exactly the logarithmic mass of the odd primes dividing \(b\), counted with
multiplicity.  From (2.6), (2.11), and the kernel table of Section 3,

\[
\begin{array}{c|ccc}
 &\phi_0(Q)&\phi_1(Q)&\phi_{-b}(Q)\\ \hline
 \Lambda_{\rm bad}
 &B_{\rm odd}/12+C/3&B_{\rm odd}/3+C/12
   &(B_{\rm odd}+C)/12.
\end{array}                                             \tag{4.1}
\]

Since \(B_{\rm odd}=C+O(1)=H+O(1)\), the leading row is

\[
 \left({5\over12},{5\over12},{1\over6}\right)H.         \tag{4.2}
\]

The first target selects the \(c\)-collision support, the second selects
the \(b\)-collision support, and the third selects neither.  The sum of
the three leading values is \(H\), and their average is the source value
\(H/3\).

## 5. The good-denominator row

The first two abscissae in (3.2) are integral away from the fixed place over
\(2\).  The third has denominator

\[
 b+2=3r^2.
\]

Every odd prime \(\ell\mid r\) is a good-reduction prime for all three
isogenous curves, because \(b\equiv-2\) and \(c\equiv-1\pmod\ell\).
Moreover the numerator \(2\) is an \(\ell\)-adic unit.  The good-reduction
local-height formula therefore gives

\[
 \Lambda_{\rm good}(\phi_{-b}(Q))
 =\log r+O(1)={1\over2}H+O(1).                          \tag{5.1}
\]

The other two images have no growing good denominator.  Hence

\[
 \Lambda_{\rm good}
 =\left(0,0,{1\over2}\right)H+O(1).                    \tag{5.2}
\]

This term is not a new conductor: isogenous elliptic curves have the same
Neron conductor.  It is the horizontal intersection contribution of the
specific quotient image point.  Deleting it would violate both the local
height formula and the product formula.

## 6. Canonical heights and the archimedean row

For every degree-two isogeny,

\[
 \widehat h_{E_i}(\phi_i(Q))
 =2\widehat h_{E_b}(Q)
 ={1\over2}H+O(1).                                      \tag{6.1}
\]

This is also the global sum of the local distribution relation

\[
 \lambda_{E_i,v}(\phi_i(Q))
 =\sum_{T\in\ker\phi_i}\lambda_{E_b,v}(Q+T).             \tag{6.2}
\]

Subtracting (4.2) and (5.2) from (6.1) gives

\[
 \Lambda_\infty
 =\left({1\over12},{1\over12},-{1\over6}\right)H+O(1).
                                                               \tag{6.3}
\]

Thus the sum of all three archimedean leading terms is zero.  The
cancellation is genuine; what fails is the hoped-for coefficient gain:

\[
\begin{array}{c|c}
 \text{three-motive odd bad mass}&H\\
 \text{three-motive good finite mass}&H/2\\
 \text{three-motive archimedean mass}&0\\
 \text{three correctly counted target heights}&3H/2.
\end{array}                                             \tag{6.4}
\]

The three target points live on different elliptic curves.  Their heights
cannot be replaced by a single copy of \(2\widehat h_E(Q)\).  Pulling the
three symmetric height line bundles back along the three isogenies gives
three degree-two bundles; their tensor product has degree six.  Its height
is

\[
 6\widehat h_E(Q)=
 \sum_i\widehat h_{E_i}(\phi_i(Q)),                     \tag{6.5}
\]

not \(2\widehat h_E(Q)\).

## 7. Positive weights and the strict no-go

Give the three quotient motives nonnegative weights \(u,v,w\).  Equations
(4.2), (5.2), (6.3), and (6.1) give (C), including the exact identity

\[
 L_{\rm bad}+L_{\rm good}+L_\infty=L_{\widehat h}.      \tag{7.1}
\]

Two quantitative obstructions follow.

First,

\[
 {5\over6}L_{\widehat h}-L_{\rm bad}={w\over4}\ge0.     \tag{7.2}
\]

Thus \(5/6\) is the best possible bad-to-height ratio among positive
combinations: it is attained precisely by combinations of the first two
targets with \(w=0\).  Even this boundary has positive archimedean slope
\((u+v)/12\); it is not a cancellation.

Second,

\[
 L_{\widehat h}-L_{\rm bad}
 ={u+v\over12}+{w\over3}>0                              \tag{7.3}
\]

for every nonzero positive combination.  Hence the selected odd mass never
reaches, much less exceeds, the correctly counted target-height cost.

If exact archimedean cancellation is imposed, then

\[
 u+v=2w.
\]

Substitution yields

\[
 L_{\rm bad}=w,\qquad
 L_{\rm good}={w\over2},\qquad
 L_{\widehat h}={3w\over2}.                             \tag{7.4}
\]

The ratio drops from its unconstrained maximum \(5/6\) to \(2/3\).
Equal weights \((1,1,1)\) realize this boundary.

There is also a centered formulation.  Subtract the three-column row
average from each target.  For a weighted collection, the three deviations
are

\[
\begin{aligned}
 D_{\rm bad}&={u+v-2w\over12},\\
 D_{\rm good}&={-u-v+2w\over6},\\
 D_\infty&={u+v-2w\over12}.
\end{aligned}                                           \tag{7.5}
\]

Therefore

\[
 \boxed{D_{\rm bad}=D_\infty,\qquad
 D_{\rm good}=-2D_{\rm bad}.}                           \tag{7.6}
\]

Cancelling the archimedean deviation automatically kills every selected
odd-bad deviation above the three-motive average.  This is stronger than a
mere total-height conservation statement.

## 8. Product formula, discriminants, and Faltings--Hriljac

All three quotient curves are defined over \(\mathbf Q\), all three points
over the same fixed field \(K=\mathbf Q(\sqrt6)\), and

\[
 |\operatorname{Disc}K|=24.
\]

Consequently field degree and normalized field discriminant are bounded
constants throughout the family.  They cannot alter a coefficient in
(B)--(E).

The quotient discriminants (3.4) redistribute the odd contact exponents as
\(4e,e,e\), but their sum is exactly three copies of the source exponent
\(2e\).  Stable Faltings heights of fixed-degree isogenous curves differ
only by a bounded isogeny term.  Adding three target motives nevertheless
adds three metrized height bundles.  Neither Faltings height nor an
isogeny comparison theorem licenses counting their point-height cost once.

Faltings--Hriljac gives the same conclusion from arithmetic intersections:
each target canonical height is a complete global self-intersection, after
its vertical and archimedean corrections are restored.  A positive sum of
three such identities has the sum of three global self-intersections.
There is no cross term with a proved sign which subtracts two of them.

The fixed discriminant, contact conservation, product formula, and
arithmetic Hodge index therefore all agree with (7.1).  None supplies the
missing shared-height inequality.

## 9. Exact scope

The audit proves a strict no-go for:

1. the three canonical cyclic two-isogeny quotients of one full-two-torsion
   Frey curve;
2. their natural degree-two image points \(\phi_i(Q)\);
3. every fixed nonnegative weighting of their canonical local heights;
4. cancellation inferred only from Tate distribution, contact conservation,
   the product formula, fixed field discriminant, or ordinary addition of
   canonical-height identities.

It does not exclude a genuinely non-diagonal correspondence among different
motives whose global height is proved to occur only once, or points on the
quotient curves not obtained as \(\phi_i(Q)\).  Either would be new input.
Any such proposal must be tested against the good-denominator row and must
state the metrized line bundle whose global height is being counted.

Thus the cyclic-isogeny route does produce archimedean cancellation, but
not usable cancellation.  On the explicit infinite family it converts

\[
 \text{odd bad }1+\text{ good }1/2+\text{ arch }0
 =\text{ height }3/2,
\]

with no positive margin from which an abc inequality could follow.

## 10. Lean boundary

The companion module
IUTThreeClosures/FreyCyclicIsogenyCrossMotiveAudit.lean verifies only:

1. the scalar Bernoulli distribution identities for identity and
   nonidentity kernels;
2. the three identity-component values \(e/3,e/12,e/12\);
3. the three quotient-image abscissae in (A);
4. the complete leading-slope ledger (B)--(C);
5. the centered rigidity (7.6);
6. the \(5/6\) upper ratio, strict no-gain theorem, and exact
   archimedean-cancellation boundary.

Lean does not formalize Tate curves, theta products, elliptic curves,
isogenies, quotient models, local heights, canonical heights, the Pell
specialization theorem, Faltings--Hriljac, or abc.  These are explicit
paper-level inputs, not introduced as axioms or hidden structure fields.

## References

1. J. H. Silverman, *Advanced Topics in the Arithmetic of Elliptic Curves*,
   Springer GTM 151, 1994, Chapter V.
2. J. H. Silverman, *The Arithmetic of Elliptic Curves*, second edition,
   Springer GTM 106, 2009, Chapters III and VIII.
3. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. **105** (1983), 287--294.
4. P. Hriljac, *Heights and Arakelov's intersection theory*, Amer. J. Math.
   **107** (1985), 23--38.
5. G. Faltings, *Calculus on arithmetic surfaces*, Ann. of Math. **119**
   (1984), 387--424.
