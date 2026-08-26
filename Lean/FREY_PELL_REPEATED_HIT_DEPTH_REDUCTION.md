# Prime-power first depth in the repeated-hit Pell tail

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad b_n=s_n^2-3,
 \qquad c_n=s_n^2-2,
 \qquad X_n=b_nc_n,
\]

and put

\[
 \lambda=97+56\sqrt3,
 \qquad \gamma_b=5+2\sqrt6,
 \qquad \gamma_c=3+2\sqrt2.
\]

The residual-order audit leaves primes in the medium range

\[
 p>Y_n,
 \qquad T_n<t_p\le2n,
 \qquad
 T_n={n^{1/3}\over\log n}.                         \tag{0.1}
\]

Their support has appeared earlier in the selected inverse-target pair.  This
note does **not** prove that the base-depth super-square mass is small.  It
shows instead that, after separating that base-depth mass, the lifted
super-square layers contain at most one transition layer that has appeared
earlier in the same pair; every remaining lifted layer is first there.  If

\[
 e_p=v_p(X_n),
 \qquad
 h_p=v_{\mathfrak p}(\lambda^{t_p}-1),             \tag{0.2}
\]

then the exact order of \(\lambda\) modulo \(p^\ell\) is

\[
 M_{p,\ell}=t_p p^{(\ell-h_p)_+}.                  \tag{0.3}
\]

A target hit of depth \(\ell\) has occurred at a positive index below \(n\)
if and only if \(M_{p,\ell}<2n\).  This gives an exact decomposition

\[
 (e_p-2)_+=B_p+J_p+D_p,                            \tag{0.4}
\]

where

\[
 \begin{aligned}
 B_p&=(\min(e_p,h_p)-2)_+,\\
 J_p&=\mathbf1_{\{2\le h_p<e_p,\;p t_p<2n\}},
 \end{aligned}                                    \tag{0.5}
\]

and every layer counted by \(D_p\) is a first positive hit of its selected
inverse-target pair at its own prime-power depth.  The transition term has
only one copy per prime, and

\[
 \sum_{\substack{p\mid X_n\\p>Y_n\\T_n<t_p\le2n}}
 J_p\log p
 \le \sum_{p<2n/T_n}\log p
 =O(n/T_n)=o(n).                                   \tag{0.6}
\]

The base term is fully visible to a prime-power norm carrier, not merely to
its radical: \(p^{\min(e_p,h_p)}\) divides the appropriate fixed-unit norm
at order \(t_p\).  It is also a recycled first-depth layer from the first
positive hit \(\rho_p<t_p/2\).  Nevertheless, the available order-by-order
norm budget sums to quadratic size, and neither this base-Wieferich mass nor
the new first-depth mass is known to be \(o(n)\) pointwise.

An earlier hit of the *other* Pell target is possible.  Splitting those
layers once more gives a complete cross-target prime-power carrier plus a
genuinely four-target-first remainder.  Thus the medium-order problem is
reduced, up to \(o(n)\), to complete moving carriers and first-depth
phenomena at the current or an earlier index.  This is a strict positive
reduction, but it does not prove the required super-square/exponent-one
balance and hence does not prove abc.

## 1. Fixed local setting

The toric factorizations are

\[
 \begin{aligned}
 4\lambda^n b_n
   &=(\lambda^n-\gamma_b)(\lambda^n-\gamma_b^{-1}),\\
 4\lambda^n c_n
   &=(\lambda^n-\gamma_c)(\lambda^n-\gamma_c^{-1}).
 \end{aligned}                                    \tag{1.1}
\]

Every odd support prime is \(1\) or \(23\pmod {24}\), so it splits
completely in \(L=\mathbf Q(\sqrt2,\sqrt3)\).  At a chosen prime
\(\mathfrak p\mid p\), exactly one of the four roots is selected.  Write it
as \(\gamma^\varepsilon\), where

\[
 \gamma\in\{\gamma_b,\gamma_c\},
 \qquad \varepsilon\in\{1,-1\}.
\]

Root simplicity gives

\[
 e:=v_p(X_n)
   =v_{\mathfrak p}(\lambda^n\gamma^{-\varepsilon}-1). \tag{1.2}
\]

Put

\[
 t=t_p=\operatorname {ord}_{\mathbf F_p^\times}(\bar\lambda),
 \qquad h=v_{\mathfrak p}(\lambda^t-1).            \tag{1.3}
\]

Here \(p\) is odd, \(t\mid p-1\), and hence \(p\nmid t\).  The value of
\(h\) is unchanged if the chosen split embedding replaces \(\lambda\) by
\(\lambda^{-1}\).  Therefore it is intrinsic to the rational support prime
for the present purpose.

The target roots remain distinct modulo every \(p^\ell\) because they are
already distinct modulo \(p\).  This excludes the half-period equality used
below.

## 2. Exact lifting of the residual order

### Proposition 2.1

For every integer \(\ell\ge1\),

\[
 \operatorname {ord}_{(\mathcal O_L/\mathfrak p^\ell)^\times}(\lambda)
 =t p^{\max(\ell-h,0)}.                            \tag{2.1}
\]

### Proof

Let \(D=\lambda^t\).  Then \(D\in1+p\mathbf Z_p\) and
\(v_p(D-1)=h\).  If \(\lambda^m\equiv1\pmod {\mathfrak p^\ell}\), reduction
modulo \(p\) first gives \(t\mid m\), say \(m=tq\).  Since \(p\) is odd,
the ordinary lifting formula gives

\[
 v_{\mathfrak p}(D^q-1)=h+v_p(q).                  \tag{2.2}
\]

The least positive \(q\) making the right side at least \(\ell\) is
\(p^{\max(\ell-h,0)}\).  This proves (2.1).  Notice that both oddness and
the unit condition are used; (2.1) is not being asserted at a ramified or
nonunit place. \(\square\)

Formula (2.1) separates two kinds of depth.  The first \(h\) layers are
already present at the residual order \(t\).  Each subsequent layer multiplies
the exact period by one further copy of \(p\).

## 3. The two hit classes at depth \(\ell\)

Fix \(1\le\ell\le e\), and put \(M=M_{p,\ell}\), as in (0.3).  Since the
current congruence exists, all solutions for the selected target are

\[
 m\equiv n\pmod M.
\]

The inverse target gives the second class

\[
 m\equiv-n\pmod M.                                \tag{3.1}
\]

Let \(r\) be the representative of \(n\) in \([1,M-1]\).  It cannot be
zero, since neither target is \(1\) modulo a support prime.  It also cannot
equal \(M/2\): that would identify the two inverse roots modulo \(p\),
contrary to the discriminant certificates for (1.1).  The first positive
depth-\(\ell\) hit is therefore

\[
 \rho_{p,\ell}=\min(r,M-r)<M/2.                   \tag{3.2}
\]

This proves the exact criterion

\[
 \boxed{
 \rho_{p,\ell}<n
 \quad\Longleftrightarrow\quad
 M_{p,\ell}<2n.}                                  \tag{3.3}
\]

Indeed, if \(M<2n\), (3.2) is strictly below \(n\).  If \(M>2n\), then
\(n<M/2\), so \(r=n\) and the first positive representative is \(n\)
itself.  Equality \(M=2n\) is the excluded half-period case.  This argument
uses both the neighboring class and its inverse mirror; looking only at
indices \(n-M,n-2M,\ldots\) would miss the mirror hit \(M-n\).

At the residual level, the first positive support hit is

\[
 \rho_p=\rho_{p,1}<t/2.                            \tag{3.4}
\]

Thus \(t\le2n\) is exactly the repeated-support range, while (3.3) determines
repetition separately at every higher prime-power layer.

## 4. Exact decomposition of super-square layers

For one exponent \(e\), the super-square copies are the levels

\[
 3,4,\ldots,e,
 \qquad\#\{\ell:3\le\ell\le e\}=(e-2)_+.          \tag{4.1}
\]

Define

\[
 B_p=(\min(e,h)-2)_+.                              \tag{4.2}
\]

These are precisely the super-square levels at or below the base depth
\(h\).  There can then be one candidate super-square layer at \(h+1\), but
only when \(h\ge2\) and \(e>h\).  Its period is \(pt\), so define

\[
 J_p=
 \mathbf1_{\{2\le h<e,\;pt<2n\}}.                 \tag{4.3}
\]

Finally put

\[
 D_p=(e-2)_+-B_p-J_p.                              \tag{4.4}
\]

All quantities in (4.2)--(4.4) are nonnegative integers, and (0.4) is an
identity.  More explicitly, before deciding whether the first lifted layer
repeats, one has the elementary decomposition

\[
 \begin{aligned}
 (e-2)_+
 ={}&(\min(e,h)-2)_+\\
 &+\mathbf1_{\{2\le h<e\}}
 +(e-\max(h+1,2))_+.                               \tag{4.5}
 \end{aligned}
\]

The companion Lean file verifies (4.5), its transition/first-depth form, and
the corresponding finite weighted identity.

### Proposition 4.1

For all sufficiently large \(n\), if (0.1) holds, then every super-square
layer counted by \(D_p\) is a first positive hit of the selected inverse-
target pair at that depth.

### Proof

A layer at or below \(h\) was placed in \(B_p\).  The layer \(h+1\), when it
is a super-square layer, was placed in \(J_p\) exactly when \(pt<2n\);
otherwise (3.3) makes it a first-depth hit.

Every remaining lifted layer has \(\ell\ge h+2\), hence period at least
\(p^2t\).  In the large-prime range,

\[
 p^2t>Y_n^2T_n>2n                              \tag{4.6}
\]

for all sufficiently large \(n\).  Equation (3.3) again makes the current
index the first positive hit at that layer. \(\square\)

The generic case is particularly stark.  If \(h=1\), the first lifted layer
is the neutral square layer \(\ell=2\).  Every layer counted by
\((e-2)_+\), starting with the cube layer, has period at least \(p^2t>2n\).
Thus a prime may be old as support while **all of its super-square mass is
new in depth for its selected target pair**.

The same conclusion has an affine-logarithm formulation.  Choose the signed
base representative \(r_0\in\{\rho_p,-\rho_p\}\) lying in the current branch
and write

\[
 n=r_0+kt,
 \qquad
 A=\lambda^{r_0}\gamma^{-\varepsilon},
 \qquad D=\lambda^t.
\]

If \(e>h\), which is necessary for \(D_p\) to be nonzero, the current
congruence implies \(v_{\mathfrak p}(\log A)\ge h\).  Hence
\(\kappa_{p,\gamma}\in\mathbf Z_p\), and the affine formula is

\[
 v_p(X_{r_0+kt})=h+v_p(k-\kappa_{p,\gamma}),
 \qquad
 \kappa_{p,\gamma}=-{\log A\over\log D}\in\mathbf Z_p. \tag{4.7}
\]

Moreover

\[
 0\le k<{n\over T_n}+1<p^2                         \tag{4.8}
\]

for all sufficiently large \(n\).  Hence, when \(h=1\), a cube forces
\(k\) to be the least nonnegative representative of the fixed-unit residue
\(\kappa_{p,\gamma}\pmod {p^2}\).  For \(h\ge2\), the first lifted
super-square layer outside \(J_p\) similarly has no smaller representative
modulo \(p\).  Deeper layers use the corresponding higher powers of \(p\).
Thus \(D_n\) is precisely a weighted small-representative problem for the
fixed collection of affine \(p\)-adic numbers \(\kappa_{p,\gamma}\), not a
vague failure of same-target support counting.  A different target may have
its own earlier residue class; that cross-target case is separated in
Section 8.

## 5. The transition layer is sublinear

The term \(J_p\) is at most one.  If it is nonzero, then

\[
 T_n<t_p,
 \qquad pt_p<2n,
\]

and therefore

\[
 p<{2n\over t_p}<{2n\over T_n}.                    \tag{5.1}
\]

Consequently the Chebyshev bound for the first prime moment gives

\[
 \begin{aligned}
 \sum_{\substack{p\mid X_n\\p>Y_n\\T_n<t_p\le2n}}
 J_p\log p
 &\le \sum_{p<2n/T_n}\log p\\
 &\ll {n\over T_n}
 =O(n^{2/3}\log n)=o(n).                           \tag{5.2}
 \end{aligned}
\]

No density statement is used: (5.2) is pointwise for every sufficiently
large \(n\).  PNT is unnecessary; the elementary Chebyshev estimate
\(\sum_{p\le x}\log p=O(x)\) suffices.  Lean treats the resulting small
support budget as a hypothesis and verifies only its finite-sum absorption.

## 6. The complete base-depth carrier

The base term is stronger than radical divisibility.  Put

\[
 m_p=\min(e_p,h_p).
\]

At the selected split prime,

\[
 \lambda^n\equiv\gamma^\varepsilon\pmod{\mathfrak p^{m_p}},
 \qquad
 \lambda^{t_p}\equiv1\pmod{\mathfrak p^{m_p}}.
\]

Raising the first congruence to \(t_p\) and the second to \(n\) gives

\[
 \gamma^{\varepsilon t_p}\equiv1
       \pmod{\mathfrak p^{m_p}}.                  \tag{6.1}
\]

Inversion changes the relevant algebraic integer only by a unit.  Hence

\[
 p^{m_p}\mid
 N_{L/\mathbf Q}(\gamma_b^{t_p}-1)
 N_{L/\mathbf Q}(\gamma_c^{t_p}-1).               \tag{6.2}
\]

Thus every copy counted by \(B_p\) is carried in full.  This corrects any
argument that records only one radical copy.  At a fixed order \(t\), (6.2)
gives

\[
 \sum_{\substack{p\mid X_n\\t_p=t}}
  \min(e_p,h_p)\log p\ll t.                        \tag{6.3}
\]

The coefficient problem remains when the order moves.  Summing the right
side of (6.3) over \(T_n<t\le2n\) costs \(\Theta(n^2)\).  Restricting to the
actual support and using \(\log X_n=2H_n+O(1)\) improves this only to the
trivial \(O(n)\), not to \(o(n)\).

There is a second exact interpretation.  At the first positive residual hit
\(\rho_p<t_p/2\), all layers up to \(m_p\) already occur.  Therefore every
base super-square layer at the current index was a first-depth super-square
layer at \(\rho_p\), where

\[
 t_p>2\rho_p.                                      \tag{6.4}
\]

The base-Wieferich term is recycled large-order first-depth mass for the same
selected target.  A
pointwise theorem at \(\rho_p\), however, would pair it with exponent-one
mass at \(X_{\rho_p}\), not with the exponent-one mass of \(X_n\).  No
audited carrier transports that compensating mass between the two indices.

## 7. Fixed-target order compatibility

The first hit is not a freely chosen residue class.  The fixed targets impose
an additional global restriction that must be retained in any method model.
If

\[
 \bar\lambda^{\rho}=\bar\gamma^\varepsilon,
 \qquad \operatorname {ord}_p(\bar\lambda)=t,
\]

then

\[
 \operatorname {ord}_p(\bar\gamma)
 ={t\over\gcd(t,\rho)}.                            \tag{7.1}
\]

Suppose, for example, that the current hit is in the inverse class, so
\(t\mid n+\rho\).  Write

\[
 n=ga,
 \qquad \rho=gb,
 \qquad (a,b)=1,
 \qquad b<a.                                      \tag{7.2}
\]

Put \(u=t/\gcd(t,\rho)\).  A direct gcd calculation from
\(t\mid g(a+b)\) shows

\[
 u\mid a+b.                                       \tag{7.3}
\]

For completeness, let \(d=\gcd(t,\rho)\).  Since \(d\mid t\),
\(d\mid\rho\), and \(t\mid n+\rho\), one has \(d\mid n\), hence \(d\mid g\).
Write \(g=dc\).  Then \(t=du\), \(\rho=dbc\), and
\((u,bc)=1\).  Dividing \(du\mid dc(a+b)\) by \(d\) gives
\(u\mid c(a+b)\); coprimality with \(c\) proves (7.3).

The same-class branch gives \(u\mid a-b\).  The exact target order also gives

\[
 p\mid N_{L/\mathbf Q}(\Phi_u(\gamma)),
\]

because \(u\mid p-1\), so \(p\nmid u\).  Fixed-unit cyclotomic norm growth
yields

\[
 \log p\ll u\le a+b<2a.                           \tag{7.4}
\]

For \(p>Y_n\), this forces

\[
 a\gg\log n,
 \qquad
 \gcd(n,\rho)=g\ll {n\over\log n}.                \tag{7.5}
\]

In particular a fixed rational ratio \(n/\rho=a/b\) permits only primes
from a fixed norm and cannot support the large-prime tail.  For example, the
tempting profile \(n=3\rho,t=4\rho\) would force the fixed target to have
order four; for the present targets this leaves only fixed small primes.  It
is not a valid large-prime method model.

The restriction (7.5) is a genuine positive refinement, but it does not make
either (6.3) or the first-depth mass summable with an \(o(n)\) coefficient.
Reduced ratios with denominator \(\gg\log n\) remain available to the
existing inequalities.

## 8. The smallest remaining statement

For the medium range define

\[
 \begin{aligned}
 W_n&=
 \sum_{\substack{p\mid X_n\\p>Y_n\\T_n<t_p\le2n}}
 B_p\log p,\\
 D_n^{\rm med}&=
 \sum_{\substack{p\mid X_n\\p>Y_n\\T_n<t_p\le2n}}
 D_p\log p.
 \end{aligned}                                    \tag{8.1}
\]

Equations (0.4) and (5.2) give the pointwise identity with error

\[
 \sum_{\substack{p\mid X_n\\p>Y_n\\T_n<t_p\le2n}}
 (e_p-2)_+\log p
 =W_n+D_n^{\rm med}+o(n).                          \tag{8.2}
\]

The word “first” in \(D_n^{\rm med}\) still refers to the selected inverse-
target pair.  Split its individual prime-power layers once more.  Put a layer
in \(C_n^{\rm cross}\) if some \(m<n\) hits the other target at the same
depth, and put it in \(F_n^{\rm four}\) otherwise.  Then exactly

\[
 D_n^{\rm med}=C_n^{\rm cross}+F_n^{\rm four}.     \tag{8.3}
\]

The cross part has a complete prime-power carrier.  If

\[
 \lambda^n\equiv\gamma_i^\varepsilon,
 \qquad
 \lambda^m\equiv\gamma_j^\delta
 \pmod {\mathfrak p^\ell},
 \qquad i\ne j,
\]

then

\[
 \begin{aligned}
 p^\ell&\mid
 N_{L/\mathbf Q}
   (\lambda^{n-m}\gamma_j^\delta-\gamma_i^\varepsilon),\\
 p^\ell&\mid
 N_{L/\mathbf Q}
   (\gamma_i^{\varepsilon m}-\gamma_j^{\delta n}). \tag{8.4}
 \end{aligned}
\]

Both algebraic integers are nonzero by the multiplicative independence of
the three fixed units.  The first is one factor of the fixed-gap carrier
\(R_{n-m}\) and has logarithmic size \(O(n-m)\); the second has size \(O(n)\).
Thus a depth-\(\ell\) layer shared across targets is transported in full.
Equivalently, a gcd sees exactly the minimum of the two target depths: it
contains every layer present at both indices, but no deeper current layer.

This does not make the cross mass sublinear.  Grouping (8.4) over the moving
earlier index \(m\) gives at best
\(\sum_{m<n}O(n-m)=O(n^2)\).  A fixed-window version is strong, but allowing
the window to grow reintroduces this quadratic budget.

For \(t_p>2n\), every layer is already a first positive hit in its selected
target pair.  Add its super-square mass after making the same possible
cross-target split, and call the two resulting totals \(C_n\) and \(F_n\).
After the small-prime and small-order estimates from the previous audits,
equation (8.1) of the cubeful-tail audit is reduced to

\[
 \boxed{
 W_n+C_n+F_n
 \le
 \sum_{\substack{p\mid X_n\\v_p(X_n)=1}}\log p
 +2\eta H_n+o_\eta(n).}                            \tag{8.5}
\]

This is the minimum boundary reached here.

* \(W_n\) is complete prime-power carrier mass, but only order-by-order; it
  is recycled first-depth mass from earlier indices.
* \(C_n\) is complete cross-target prime-power carrier mass, but its earlier
  index moves and the aggregate carrier budget is quadratic.
* \(F_n\) consists of genuine four-target-first super-square layers.  Its
  primes need not be first as residual support before the target split is
  imposed.
* The right side contains exponent-one mass at the **current** index.  An
  exponent-one copy at an earlier first hit cannot be used without a new
  cross-index mass-transport theorem.

Neither available gcd carriers, order stratification, Yu's moving-prime
bound, nor the current exponent-one ledger proves (8.5).  If one does not
need the cross-target distinction, \(D_n=C_n+F_n\) recovers the shorter
equivalent form \(W_n+D_n\).

## 9. Conditional fixed-unit method boundaries

The following are conditional profiles, not constructions.  They keep the
actual fixed units and state hypothetical congruences involving those units;
they do not choose new local lifts.  All valuations of algebraic units below
are taken at a chosen split place above the displayed rational prime.  Their
purpose is only to show exactly what the audited inputs still fail to exclude.

### 9.1 Exceptional lifted depth

Take

\[
 \rho=m,
 \qquad n=3m+1,
 \qquad t=4m+1=n+\rho.                             \tag{9.1}
\]

Then \((t,\rho)=1\), \(2\rho<t\le2n\), and the target order in (7.1) is the
moving order \(t\), not a fixed small integer.  Suppose, separately for the
two actual targets, that a distinct split prime \(q_i\) satisfies

\[
 \begin{aligned}
 &\operatorname {ord}_{q_i}(\bar\lambda)=t,
 \qquad
 v_{q_i}(\lambda^\rho\gamma_i^{-1}-1)=1,\\
 &v_{q_i}(\lambda^n\gamma_i-1)=3,
 \qquad
 \log q_i=m\log\lambda+O(1).                      \tag{9.2}
 \end{aligned}
\]

Because the target order is exactly \(t\), this profile also requires

\[
 q_i\mid N_{L/\mathbf Q}(\Phi_t(\gamma_i)),
 \qquad
 \log q_i\le \log|N_{L/\mathbf Q}(\Phi_t(\gamma_i))|=O(t). \tag{9.3}
\]

This fixed-unit cyclotomic budget does not contradict the last scale in
(9.2).  At index \(\rho\), one copy of \(q_i\) can occupy one component
height.  At index \(n\), its cube occupies

\[
 3\log q_i=n\log\lambda+O(1),                      \tag{9.4}
\]

again one component height.  For two targets the current super-square mass is
\(2H_n/3+O(1)\), while the leftover exponent-one mass may be only bounded.
The min-depth gcd sees just the earlier single copy.  No theorem audited in
the three predecessor notes excludes (9.2).  Explicitly,
\(n-\rho=2m+1\), so the shared single copy has
\(q_i\mid R_{2m+1}\) and \(\log q_i=O(2m+1)\); the two extra current layers
are absent from that minimum-depth carrier.

### 9.2 Recycled base depth

Take instead

\[
 \rho=m,
 \qquad n=2m+1,
 \qquad t=3m+1=n+\rho.                             \tag{9.5}
\]

Again \((t,\rho)=1\) and \(2\rho<t\le2n\).  Suppose that for each target a
distinct split prime \(q_i\) has order \(t\), base depth at least three, and

\[
 v_{q_i}(\lambda^\rho\gamma_i^{-1}-1)
 =v_{q_i}(\lambda^n\gamma_i-1)=3,
 \qquad
 3\log q_i=\rho\log\lambda+O(1).                  \tag{9.6}
\]

Root simplicity then gives
\(v_{q_i}(X_\rho)=v_{q_i}(X_n)=3\), now explicitly in the same inverse-target
pair.

Exact target order again includes the fixed-unit condition

\[
 q_i\mid N_{L/\mathbf Q}(\Phi_t(\gamma_i)),
 \qquad \log q_i=O(t).                             \tag{9.7}
\]

The shared cube fills the earlier component.  At the current index it occupies
height \(H_\rho\).  As part of this conditional method profile, allow the
remaining height

\[
 H_n-H_\rho=(m+1)\log\lambda+O(1)                 \tag{9.8}
\]

in each current component to be carried by exponent-two primes, up to a
bounded cofactor.  Those square layers are neutral in the critical ledger, so
the possible exponent-one compensation is bounded.  The two base layers then
give

\[
 2\log q_i={2H_\rho\over3}+O(1)={H_n\over3}+O(1)  \tag{9.9}
\]

in total, where the notation on the left means the sum over the two distinct
target primes.  Thus, for every fixed \(\eta<1/6\) and all sufficiently large
\(m\), this mass exceeds \(2\eta H_n\) plus the bounded exponent-one slack.

Unlike a consecutive-index profile, this one also respects the complete
fixed-gap carrier.  Here \(n-\rho=m+1\), and the shared depth gives

\[
 q_i^3\mid R_{m+1},
 \qquad 3\log q_i=m\log\lambda+O(1)=O(m+1).        \tag{9.10}
\]

Thus its full common depth fits the audited \(O(n-\rho)\) carrier budget.  The
tempting choice \(n=m+1\) would instead put an unbounded \(q_i^3\) into the
fixed integer \(R_1\), so it is invalid and is not used here.

Profiles (9.2) and (9.6) respect:

1. the actual fixed \(\lambda,\gamma_b,\gamma_c\);
2. the target-order constraint (7.1);
3. the medium-order hit classes and their inverse mirrors;
4. the separate height of each Pell factor at both relevant indices;
5. full prime-power norm and gcd carriers, with their minimum-depth rule.

They do **not** assert that the required primes exist, that the remaining
cofactors have the displayed shape, or that both target conditions occur
simultaneously in the Pell sequence.  In particular they are not Pell or abc
counterexamples.  Their exact conclusion is methodological:

> The audited marginal consequences of the fixed units, even after retaining
> target order and both component heights, do not imply (8.5).  A proof must
> exclude the fixed-unit exceptional lifts, control fixed-unit base-Wieferich
> mass, or transport compensating exponent-one mass across indices.

The simultaneous occurrence in both consecutive factors is precisely the
cross-target global compatibility not supplied by the local and norm inputs.

## 10. An actual fixed-unit depth witness at \(p=23\)

There is a small exact example showing that the min-depth loss is real for the
fixed Pell units.  Choose

\[
 \sqrt3\equiv7,
 \qquad \sqrt2\equiv5\pmod {23}.
\]

Then

\[
 \bar\lambda=\bar\gamma_b=6,
 \qquad \operatorname {ord}_{23}(6)=11.           \tag{10.1}
\]

At the first hit \(r=1\), let

\[
 A=\lambda\gamma_b^{-1},
 \qquad D=\lambda^{11}.
\]

Direct computation in \(\mathbf Q_{23}\) gives

\[
 v_{23}(\log A)=v_{23}(\log D)=1,
 \qquad
 \kappa=-{\log A\over\log D}
   =3+6\cdot23+20\cdot23^2+\cdots.                \tag{10.2}
\]

Now

\[
 1552=1+141\cdot11,
 \qquad 141\equiv\kappa\pmod {23^2},
 \qquad 141\not\equiv\kappa\pmod {23^3}.         \tag{10.3}
\]

The affine lifting formula therefore gives

\[
 v_{23}(b_1)=1,
 \qquad v_{23}(b_{1552})=1+2=3.                   \tag{10.4}
\]

The square layer of the selected \(b\)-target pair has period
\(23\cdot11=253<2\cdot1552\) and already occurs at index \(34\), where
\(v_{23}(b_{34})=2\).  Its cube layer has period
\(23^2\cdot11=5819>2\cdot1552\), so its first positive hit in that target
pair is exactly \(1552\).  In the notation above,

\[
 B_{23}=J_{23}=0,
 \qquad D_{23}=1.                                 \tag{10.5}
\]

At the residual level the same prime also hits the other target:
\(\bar\gamma_c=\bar\lambda^2\), and indeed \(23\mid c_2\).  This is why the
selected-target qualifier is essential.  It does not alter the fact that the
cube layer in (10.5) is first in the selected \(b\)-target pair; deciding
whether another target shares that *cube depth* is a separate cross-carrier
question of the kind isolated in (8.4).

This finite witness carries negligible asymptotic mass and proves no
negative result about the Pell radical.  It does prove that replacing the
minimum depth of a same-target gcd carrier by the current depth is false even
for the actual fixed units.

## 11. Formalization boundary

The companion module
`IUTThreeClosures/FreyPellRepeatedHitDepthReduction.lean` proves only:

* the per-exponent identity (4.5) and its exact
  base/transition/first-depth refinement;
* the corresponding finite weighted identity;
* that a transition copy is bounded by one support copy and is absorbed once
  a small support budget is supplied;
* the cleared-denominator cutoff implication behind (5.1);
* the two moving-ratio index profiles, including their coprimality; and
* scalar two-component conditional-profile ledgers with a bounded height gap.

Lean does not formalize or assume local fields, LTE, prime-power orders,
splitting, target hit classes, norm divisibility, Chebyshev estimates, the
actual \(23\)-adic computation, existence of primes in the conditional
profiles, or (8.5).  No missing number-theoretic assertion is introduced as
an axiom.
