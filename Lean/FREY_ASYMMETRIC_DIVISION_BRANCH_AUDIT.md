# Asymmetric division branches on the Frey--Tate family

**Author: ChatGPT**

## Abstract

Let \(E/K\) have split multiplicative reduction and let \(P\) be represented
on its Tate curve by \(u\). The average of all \(m^2\) points above \(P\)
has the same \(m^{-2}\) scaling as the global canonical height. That
averaged identity does **not** govern a single algebraic division branch.

This note gives the exact replacement for a non-torsion \(P\) lying in the
identity component at the place in question. If, above a fixed rational bad
prime, the conjugates of one global branch occupy a uniformly weighted
coset of \(d\mid m\) component packets, then an identity coset has normalized
Bernoulli coefficient \(d^{-2}\) times the original coefficient. Since
\(\widehat h(Q)=\widehat h(P)/m^2\), the local component-to-global-height
ratio gains the exact factor

\[
 \boxed{(m/d)^2.}
\]

Only the full image \(d=m\) recovers branch-average conservation. A single
identity packet \(d=1\) retains the entire positive component term.

This is not merely formal. If the residue characteristic \(p\) does not
divide \(m\), take a Tate parameter \(q=\pi^{me}\), a unit \(u\) with
\(\bar u\ne1\), and use Hensel's lemma in an unramified extension to choose
\(w^m=u\). Then \(Q=[w]\) satisfies \([m]Q=[u]\), its full nonarchimedean
Tate local height equals that of \(P=[u]\), and the relative different at
\(p\) is zero. Thus neither bounded degree nor local discriminant forces
the \(m^{-2}\) decay.

For the explicit fixed-abscissa Frey half, when its half-field is genuinely
quadratic, every sufficiently large bad rational prime under discussion
splits into two places carrying the identity and opposite packets. There
\(d=2\), and the normalized value is \(e_p/24\). If the defining squareclass
is already trivial over \(\mathbf Q\), the half-field degenerates and a
single packet \(d=1\) can occur instead. Globally collapsing the split pair
therefore requires precisely such a squareclass alignment. In the rational
square-root case, retaining a divisor \(A\) in one sign forces
\(j\ge A^2/4\); this is the elementary source of the height increase in the
known K3 alignment.

The surviving problem is therefore a genuine positive one: construct a
**simultaneous local \(m\)-divisibility/small-packet selector** for one
global division branch, and separately control every adverse finite
theta/intersection term and the archimedean sum. Ordinary weighted CRT on
the reduction abscissa does not yet provide this theorem.

## 1. One local branch really can escape the average

### 1.1 Tate normalization

Let \(K\) be a nonarchimedean local field with uniformizer \(\pi\), residue
field \(k\) of characteristic \(p\), and normalized absolute value
\(|\pi|=(Nk)^{-1}\). Let \(q\in K^\times\), \(0<|q|<1\), and write

\[
 E_q(\overline K)=\overline K^\times/q^{\mathbf Z}.
\]

For a representative \(z\) with
\(0\le v(z)<n=v(q)\), put \(r(z)=v(z)/n\). In the standard Neron
normalization the local height is

\[
 \lambda_q([z])=
 -\log|1-z|
 -\sum_{\nu\ge1}\log|(1-q^\nu z)(1-q^\nu z^{-1})|
 +\frac12B_2(r(z))\log|q|^{-1},
 \tag{1.1}
\]

where

\[
 B_2(X)=X^2-X+\frac16.
\]

The last summand is the component/Bernoulli term. The first two summands
are the theta, or intersection, term. They must not be identified.

### 1.2 An unramified identity packet

Assume

\[
 p\nmid m,\qquad q=\pi^{me},\qquad
 u\in\mathcal O_K^\times,\qquad \bar u\ne1.
 \tag{1.2}
\]

Choose a root \(\bar w\) of \(X^m-\bar u\) in a finite residue extension
\(k'/k\). Its degree is at most \(m\). Since
\(m\bar w^{m-1}\ne0\), Hensel's lemma lifts \(\bar w\) to a root
\(w^m=u\) in the unramified extension \(L/K\) with residue field \(k'\).
In particular,

\[
 [L:K]\le m,\qquad \mathfrak D_{L/K}=1.
 \tag{1.3}
\]

For \(0\le k<m\), define

\[
 z_k=\pi^{ek}w,\qquad Q_k=[z_k]\in E_q(L).
 \tag{1.4}
\]

Then

\[
 z_k^m=q^ku,\qquad [m]Q_k=[u]=P,\qquad r(z_k)=\frac{k}{m}.
 \tag{1.5}
\]

No theta term is hidden here. For \(k=0\), the hypothesis
\(\bar u\ne1\) implies \(\bar w\ne1\), so \(|1-w|=1\). For \(k>0\),
\(|z_k|<1\), so again \(|1-z_k|=1\). For every \(\nu\ge1\),

\[
 v(q^\nu z_k)>0,\qquad
 v(q^\nu z_k^{-1})=\nu me-ek>0.
\]

Thus all factors in the product in (1.1) are units, and

\[
 \boxed{
 \lambda_q(Q_k)=
 \frac{me}{2}B_2\!\left(\frac{k}{m}\right)\log Nk.}
 \tag{1.6}
\]

The same calculation for \(P=[u]\) gives

\[
 \lambda_q(P)=\frac{me}{12}\log Nk.
 \tag{1.7}
\]

Consequently the identity branch satisfies the full local equality

\[
 \boxed{\lambda_q(Q_0)=\lambda_q(P),}
 \tag{1.8}
\]

not merely an equality of component terms. Every \(K\)-embedding of
\(L\) into \(\overline K\) preserves the valuation and sends \(w\) to
another unit root of \(X^m-u\); because \(\bar u\ne1\), none of those
residue roots is \(1\). Hence every local conjugate remains in the same
identity packet and satisfies (1.8).

This is a strict counterexample to any assertion that a single division
branch must exhibit \(m^{-2}\) local decay. The base-changed Tate curve is
still split multiplicative, its conductor exponent is one, and the
unramified field contributes no local different. The depth \(e\) appears
in the retained local height but not in the extension discriminant.

If \(q/\pi^{me}\) is a unit rather than \(1\), the same statement holds
after adjoining an \(m\)-th root of that unit in a further unramified
extension. The clean choice in (1.2) already proves that no universal
ramification or discriminant obstruction exists.

### 1.3 What must compensate globally

Suppose now that the local configuration occurs as the completion of a
global point with \([m]Q=P\). Globally,

\[
 \widehat h(Q)=\frac1{m^2}\widehat h(P).
 \tag{1.9}
\]

Equations (1.8) and (1.9) are compatible because a local Neron function is
not quadratic by itself. If a collection of finite places retains the
full positive term, the exact identity

\[
 \sum_v n_v\lambda_v(Q)=\widehat h(Q)
 \tag{1.10}
\]

forces compensation among the complementary finite places and the
archimedean places. It does not force the selected local terms to decay.
This distinction is the central point of the audit.

## 2. The packet-image formula for one global algebraic branch

### 2.1 Embeddings, places, and packets

Let \(K\) now be a number field, let \(v\) be a split multiplicative place,
and suppose \(E,P\) are defined over \(K\), with \(P\) in the identity
component at \(v\). (For a nonidentity \(P\), its component parameter must
be added before applying the Bernoulli formula below.) Let \(F/K\) be a
finite field over which a chosen \(Q\) with \([m]Q=P\) is defined. Fix an
embedding of an algebraic closure of \(K\) into \(\overline{K_v}\).

For every \(K\)-embedding

\[
 \tau:F\hookrightarrow\overline{K_v},
\]

the point \(\tau Q\) lies in one of the \(m\) component packets above the
component of \(P\). Write its packet index as
\(k(\tau)\in\mathbf Z/m\mathbf Z\). The standard identity

\[
 \sum_{w\mid v}[F_w:K_v]=[F:K]
 \tag{2.1}
\]

means that the degree-normalized sum over places \(w\mid v\) is exactly
the average over this embedding multiset. A completion of degree \(r\)
contributes \(r\) embeddings, but these \(r\) embeddings have the same
valuation and hence the same component packet. Local degree is therefore
a multiplicity **inside** a packet; it is not the number of distinct
packets.

Assume that the packet multiset is a uniformly weighted coset of the
unique subgroup of order \(d\mid m\). Put \(s=m/d\). Then for some
\(0\le r<s\), its distinct indices are

\[
 r,\ r+s,\ldots,r+(d-1)s,
 \tag{2.2}
\]

and each occurs with the same multiplicity. This uniformity holds, for
example, when the packet index is the image of a finite Galois/Kummer
orbit under a homomorphism to the split Tate quotient
\(\mathbf Z/m\mathbf Z\). In applications it should be verified, not
silently inferred from the degree of \(F\).

### 2.2 Exact partial-orbit coefficient

The Bernoulli multiplication identity, applied only to the \(d\) packets
actually present, gives

\[
 \frac1d\sum_{t=0}^{d-1}
 B_2\!\left(\frac{r+ts}{m}\right)
 =\frac1{d^2}B_2\!\left(\frac r s\right).
 \tag{2.3}
\]

Every common local-degree or identity-direction multiplicity cancels
between numerator and denominator. If \(P\) is in the identity component
and the orbit is the identity coset \(r=0\), then

\[
 \boxed{
 \Lambda_v^{\rm comp}(Q)
 =\frac{v(q)}{12d^2}\log Nv.}
 \tag{2.4}
\]

There are three qualitatively different cases.

* \(d=1\): one identity packet, so the full positive component term is
  retained.
* \(1<d<m\): a partial orbit, with decay \(d^{-2}\) rather than \(m^{-2}\).
* \(d=m\): the full component image, giving the familiar \(m^{-2}\)
  branch-average coefficient.

If \(P\) is non-torsion, so that \(\widehat h(P)>0\), combining (2.4) with
global quadraticity (1.9) gives

\[
 \boxed{
 \frac{\Lambda_v^{\rm comp}(Q)}
      {\widehat h(P)/m^2}
 =\left(\frac md\right)^2
  \frac{\Lambda_v^{\rm comp}(P)}{\widehat h(P)}.}
 \tag{2.5}
\]

Thus the exact gain is \((m/d)^2\). The previous branch-average
conservation law is precisely the endpoint \(d=m\), not a theorem about
all single branches.

For a nonidentity coset, (2.3) gives instead

\[
 \Lambda_v^{\rm comp}(Q)
 =\frac{v(q)}{2d^2}
 B_2\!\left(\frac r s\right)\log Nv.
 \tag{2.6}
\]

It can be negative. A small packet image is useful only if the coset
itself is favorable.

### 2.3 Why \(m^2\), \(m\), \(d\), and the local degree are different

The full geometric fibre \([m]^{-1}P\) has \(m^2\) points. On a split Tate
curve it has \(m\) component values, each repeated \(m\) times in the
roots-of-unity direction. This proves the average over all geometric
branches.

A chosen algebraic branch need not have all \(m^2\) points as conjugates.
Its field can contribute:

* one or more completions above \(v\);
* arbitrary common local degrees inside the packets;
* only \(d\) distinct component values, where \(d\) can be smaller than
  \(m\).

Equation (2.1) cancels the first two multiplicities. Equation (2.4)
depends on the third. Replacing \(d\) by \([F:K]\), or automatically by
\(m\), is therefore incorrect.

## 3. Halving: the exact three-way dichotomy

For the Frey curve at an odd bad prime of depth \(e\), the multiplicative
fibre has type \(I_{2e}\). After the unramified quadratic splitting
extension when the reduction is nonsplit, its Tate parameter satisfies
\(v(q)=2e\). This unramified passage adds no depth-dependent different and
cancels from the degree-normalized local sum. If \(P\) is in the identity
component, a half has the following possibilities:

\[
\begin{array}{c|c|c}
 d&\text{packet coset}&\Lambda_p^{\rm comp}(Q)/\log p\\ \hline
 1&\{0\}&e/6\\
 1&\{1\}&-e/12\\
 2&\{0,1\}&e/24.
\end{array}
\tag{3.1}
\]

The first row is four times the two-packet average, exactly matching the
gain \((2/1)^2=4\). The second row is adverse. The third row is the
branch-averaged coefficient.

### 3.1 A genuinely quadratic fixed-abscissa half has \(d=2\)

On

\[
 E_{1,b}:y^2=x(x-1)(x+b),
\]

choose rational \(\alpha,\beta\) with
\(\alpha^2-\beta^2=1\), put \(j=\alpha^2\), and let
\(\gamma^2=b+j\). One half of \(P_j\) has

\[
 x(R)=j+\alpha\beta+(\alpha+\beta)\gamma.
 \tag{3.2}
\]

Assume here that \(b+j\) is not a rational square, so that
\(\mathbf Q(\gamma)/\mathbf Q\) is genuinely quadratic. At every
sufficiently large odd \(p\mid b\), its two places have
\(\gamma\equiv\alpha,-\alpha\), and the corresponding halves lie in the
identity and opposite packets. At \(p\mid b+1\), the two residues
\(\gamma\equiv\beta,-\beta\) give the same dichotomy. Hence the normalized
rational-prime contribution is

\[
 \frac12\left(\frac e6-\frac e{12}\right)\log p
 =\frac e{24}\log p.
 \tag{3.3}
\]

If instead \(b+j\) is a rational square, this two-place conclusion does not
apply: the half-field is \(\mathbf Q\), and one of the two single-packet
rows of (3.1) may occur. This degeneration is exactly the \(d=1\) mechanism
studied below, rather than a counterexample to the packet formula.

This is a useful warning about base fields. At each completion of the
quadratic field, the local branch occupies one packet. But the global
height above the rational prime includes both completions. Discarding the
adverse completion is not allowed. Translating by a rational two-torsion
point either preserves or exchanges the two packets; it never turns both
into the identity packet.

In the numerical choice

\[
 \alpha=5/4,\quad\beta=3/4,\quad d^2=16b+25,\quad
 x(R)=(5+d)/2,
\]

the two residues at \(p\mid b\) are \(x=5,0\), while those at
\(p\mid b+1\) are \(x=4,1\). Thus (3.3) is visible directly in the
coordinates.

## 4. Why global squareclass alignment becomes expensive

The preceding split pair is especially rigid for a Frey half. Write

\[
 r_0^2=j,\qquad r_a^2=j-a,\qquad r_b^2=j+b.
\]

At an odd prime \(p^e\parallel a\), with \(j(j-a)\) a unit, the ratio

\[
 \rho_a=\frac{j}{j-a}=1+\frac{a}{j-a}
 \tag{4.1}
\]

belongs to \(1+p^e\mathcal O\). It has a unique local square root
congruent to \(1\). In the half-point formula, the identity packet is the
sign for which \(r_0/r_a\equiv1\pmod {p^e}\); the other sign is the
opposite packet.

If \(\sqrt{\rho_a}\) is a nontrivial quadratic element over the ultimate
ground field whose rational-prime heights are being normalized, then every
such \(p\)-adic place splits in that quadratic extension, because
\(\rho_a\) is already a local square. Its two prolongations realize the
two signs. In any further finite field, the sums of the local degrees above
the two split primes are equal. Thus adjoining the square root does not
choose the favorable place; it creates the two-place average.

This ground-field clause matters for a quadratic selector point. It is not
enough that \(\sqrt{\rho_a}\) belongs to the selector field
\(K=\mathbf Q(\sqrt D)\). If it lies in \(K\setminus\mathbf Q\), its two
\(\mathbf Q\)-conjugates are still the two signs, and the normalized sum
above the rational prime still contains both. To obtain \(d=1\) by this
mechanism, the packet character must be trivial on the full
\(\mathbf Q\)-Galois orbit, including the conjugation \(P\mapsto-P\), and
one must choose a globally consistent sign.

The analogous principal-unit ratios are

\[
 \rho_b=\frac{j}{j+b}\quad(p\mid b),
 \qquad
 \rho_c=\frac{j-a}{j+b}\quad(p\mid c).
 \tag{4.2}
\]

This is why ordinary congruence control of \(j\) is not the same as
control of the global half packet.

This ratio really belongs to the field of any chosen half. Indeed, all
three nonzero two-torsion points are rational. If \(F\) contains one half
\(Q\), then it contains all four points \(Q+T\), \(T\in E[2]\). The four
abscissas recover, by a four-by-four linear system, the three products
\(r_0r_a,r_0r_b,r_ar_b\); division by a nonzero factor then recovers the
ratios in (4.1)--(4.2). No special choice of the explicit half formula is
being assumed.

For \(m=2\) this gives a strict dichotomy, outside the fixed exceptional
set. If the relevant ratio is a nontrivial squareclass over the ultimate
ground field, the quadratic subfield it generates is contained in every
half field, and the two split signs force the \(d=2\) coefficient. If that
packet squareclass is trivial, \(d=1\) is possible, but the one global sign
must satisfy all selected Hensel-sign conditions; the product-formula cost
below then applies. This dichotomy is stronger than a branch average, but
it is specific to the full-two-torsion halving geometry.

### 4.1 A strict elementary height ledger

Assume for clarity that two signed roots \(r,s\) are rational integers and

\[
 r^2=j,\qquad s^2=j-a,\qquad a>0.
 \tag{4.3}
\]

Let \(A\) be a positive divisor assembled from bad prime powers at which
one fixed global sign is required to be the identity sign. After excluding
the fixed denominator and \(2\)-adic set, the sign condition gives
\(A\mid r-s\). Since \(a>0\), one has \(r-s\ne0\) and
\(|s|\le|r|=\sqrt j\), and hence

\[
 \boxed{A^2\le(r-s)^2\le4j.}
 \tag{4.4}
\]

Thus \(j\ge A^2/4\). For the natural full alignment

\[
 j=\frac{(a+1)^2}{4},\qquad
 r=\frac{a+1}{2},\qquad s=\frac{1-a}{2},
\]

one has \(r-s=a\), so (4.4) is asymptotically sharp. This is the
elementary shadow of the fourfold global-height increase computed on the
associated K3 elliptic surface.

Over a number field the same phenomenon is expressed by the product
formula. Put

\[
 W_\eta=\sum_{\mathfrak p\in S}
 v_{\mathfrak p}(\eta-1)\log N\mathfrak p,
\]

where the valuations are integral ideal valuations. If a fixed algebraic
number \(\eta=r/s\ne1\) realizes the identity Hensel sign at every
\(\mathfrak p\in S\), then

\[
 h(\eta-1)\ge W_\eta/[K:\mathbf Q],\qquad
 h(\eta)\ge h(\eta-1)-\log2.
 \tag{4.5}
\]

The large \(p\)-adic alignment must reappear at other finite places or at
the archimedean places. Formula (4.5) is a naive-height/product-formula
statement. It is **not** by itself a lower bound for the canonical height
of the half; applying such a comparison without controlling the
curve-height error would be circular.

### 4.2 This is not a universal no-go

The bound (4.4) applies when a Frey half is made single-packet by globally
aligning these signed square roots. Section 1 shows that a general Tate
identity packet can instead live in an unramified extension and pay no
local different. Therefore (4.4) must not be promoted to a theorem that
every small-packet branch has source-height discriminant or canonical
height. It closes one mechanism and leaves the genuine small-packet
mechanism open.

## 5. The positive theorem that would advance the abc route

Define the odd multiplicative depth mass of a set \(S\) of Frey bad primes
by

\[
 W(S)=\sum_{p\in S}e_p\log p.
\]

A useful **simultaneous local \(m\)-divisibility/small-packet selector**
would provide, for every primitive abc triple in the intended range:

1. a non-torsion selector point \(P\) over a controlled base field \(K\);
2. one algebraic point \(Q\) with \([m]Q=P\);
3. a set \(S\) carrying a fixed positive proportion of the exponent depth;
4. at every \(p\in S\), an identity packet coset of order
   \(d_p\le d_0<m\) in the full degree-normalized set of places above \(p\);
5. bounded degree and a discriminant/conductor estimate on \(K(Q)\) whose
   selected-prime cost is radical-scale, not \(e_p\log p\)-scale;
6. a lower bound for the complementary finite and archimedean local-height
   sum.

The component conclusion alone would be

\[
 \sum_{p\in S}\Lambda_p^{\rm comp}(Q)
 \ge\frac1{6d_0^2}W(S)
 \tag{5.1}
\]

for the Frey normalization \(v_p(q)=2e_p\). Relative to
\(\widehat h(P)/m^2\), this is an improvement by at least
\((m/d_0)^2\) over full branch averaging. For \(m=2,d_0=1\), the selected
coefficient is \(e_p/6\), four times \(e_p/24\).

Section 1 makes conditions 4--5 locally plausible: an identity root of a
unit is unramified away from \(m\), and at good primes away from \(m\) the
fibre of multiplication by \(m\) extends as a finite etale torsor. What is
missing is one **global** branch satisfying the conditions simultaneously.

Condition 6 is equally indispensable. If (5.1) is much larger than
\(\widehat h(P)/m^2\), equation (1.10) forces a negative complementary sum.
The selected component lower bound proves nothing global until that adverse
sum is bounded from below. This is where theta/intersection terms,
nonidentity packets, additive places, and archimedean local heights must be
audited together.

## 6. Why ordinary weighted CRT does not yet globalize the branch

### 6.1 What reduction-group CRT can do

At a split multiplicative prime away from \(m\), the identity component is
a torus. After an unramified residue extension, the equation \(w^m=u\)
is solvable. If a selector parameter is free, CRT can prescribe finitely
many reductions of that parameter and can sometimes ensure that the local
unit lies in a desired residue \(m\)-power class.

This is useful local information. It does not specify which irreducible
global factor of the division fibre contains all of those local roots.

### 6.2 The Frey half shows the precise failure

For \(m=2\), equations (4.1)--(4.2) are already local squares at every odd
bad prime where \(P_j\) is smooth. Thus the local reduction-group
divisibility condition is automatically satisfied. Nevertheless, if the
corresponding global squareclass is nontrivial, each selected prime splits
and both signs occur in the global height. No congruence choice of \(j\)
can make this locally split quadratic polynomial inert.

To reduce \(d=2\) to \(d=1\), one must instead force an exact global
squareclass collapse such as

\[
 \frac{j}{j-a}=t^2,\qquad
 j=\frac{at^2}{t^2-1}.
 \tag{6.1}
\]

That is a Diophantine factorization condition, not a residue-avoidance
condition. Requiring it for several source supports couples several such
equations and invokes the height cost of Section 4.

### 6.3 Finite branch choice gives only the baseline in the worst case

Once \(P\) is fixed, its four halves differ by the four rational
two-torsion translations. At a one-packet \(I_{2e}\) place, exactly two
translations give the identity packet and two give the opposite packet.
Averaging over the four translations therefore guarantees that one branch
is at least as good as the full average, but it gives no uniform gain over
that average. At a two-packet place like Section 3.1, every translation is
already balanced.

Weighted owner-counting or CRT can choose among many **parameters** when
each prime excludes a small residue set. Here the property needed is that
a Kummer class globally collapses, or that one global irreducible branch
has small packet image at a prescribed input-dependent set of primes.
There is no established owner bound for that property. A successful
replacement would be a squareclass-valued or Selmer-valued weighted
selector theorem with simultaneous height and discriminant control.

The literature on local--global divisibility describes the cohomological
obstruction to turning local \(m\)-divisibility into a global divisible
point. It does not directly prove the weaker-but-quantitative statement
needed here: an algebraic division point of bounded orbit whose component
image is small at a high-weight, input-dependent set of places.

## 7. Verdict and exact boundary

The audit proves the following positive facts.

1. A single identity division branch can retain the full local Tate height
   in an unramified extension; there is no universal local discriminant or
   conductor payment proportional to multiplicative depth.
2. For a uniformly weighted packet coset, the exact invariant is its
   component-packet image size \(d\), not the total \(m^2\) geometric
   branches and not the local field degree. A nonuniform packet multiset
   retains its actual weights and is not classified by \(d\) alone.
3. An identity packet orbit gains \((m/d)^2\) relative to global canonical
   height. The full-average conservation law is only the case \(d=m\).
4. A genuinely quadratic fixed-\(j\) Frey half has \(d=2\) at the
   sufficiently large odd bad rational primes covered by Section 3.1;
   when the defining squareclass is rationally trivial, \(d=1\) may occur,
   and retaining a prescribed divisor through such an aligned square root
   incurs the quadratic naive-height cost of Section 4.

It does **not** prove any of the following.

1. that every Frey selector admits a global branch with \(d<m\) on a fixed
   proportion of the weighted bad support;
2. that bounded field degree alone bounds the absolute discriminant of that
   branch field;
3. that the theta/intersection and archimedean complement is harmless;
4. that the local gain already proves an abc inequality.

Accordingly, asymmetric division remains a genuine surviving direction.
The next theorem must be the simultaneous small-packet selector of Section
5, not another averaging identity.

## 8. Lean boundary

The companion module
IUTThreeClosures/FreyAsymmetricDivisionBranchAudit.lean checks:

1. the Bernoulli coefficient for an arbitrary uniformly weighted packet
   coset of order \(d\), including the identity coset;
2. cancellation of common packet multiplicity/local-degree weights;
3. the exact gain factor \((m/d)^2\) and its monotonicity for \(d\le m\);
4. the \(m=2\) values \(e/6,-e/12,e/24\);
5. the scalar Hadamard identities underlying recovery of the three pair
   products from four half-translation abscissas;
6. the elementary alignment inequality \(A^2\le4j\).

Lean does not formalize local fields, Tate uniformization, Hensel lifting,
Neron models, local or canonical heights, number-field embeddings,
division-field discriminants, or the proposed simultaneous selector. The
module therefore does not hide the open global assertion in a structure
field.

## References

1. J. H. Silverman, *Advanced Topics in the Arithmetic of Elliptic Curves*,
   Graduate Texts in Mathematics **151**, Springer, 1994, Chapter VI.
2. J. Tate, *A review of non-Archimedean elliptic functions*, in
   *Elliptic Curves, Modular Forms, and Fermat's Last Theorem*, International
   Press, 1995, 162--184.
3. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. **105** (1983), 287--294,
   DOI 10.2307/2374389.
4. R. Dvornicich and U. Zannier, *Local-global divisibility of rational
   points in some commutative algebraic groups*, Bull. Soc. Math. France
   **129** (2001), 317--338.
5. R. Dvornicich and U. Zannier, *On a local-global principle for the
   divisibility of a rational point by a positive integer*, Bull. London
   Math. Soc. **39** (2007), 27--34, DOI 10.1112/blms/bdl002.
6. B. Creutz, *On the local-global principle for divisibility in the
   cohomology of elliptic curves*, Math. Res. Lett. **23** (2016),
   377--387, arXiv:1305.5881.
