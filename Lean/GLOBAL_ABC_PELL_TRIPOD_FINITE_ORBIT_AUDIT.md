# Global `abc` to Pell/tripod/finite-orbit bridge: an exact audit

## 0. Status and verdict

This is a standalone paper-side audit.  It does not assert `abc`, does not
start Lean, and does not modify the aggregate, `AxiomAudit`, or
`RESEARCH_STATUS`.  The external-literature search was refreshed on
2026-08-26; among the sources audited in Section 8 and the references below,
no accepted theorem matching the required global interface was located.

The global bridge sought here would have to take **every** positive primitive
triple

\[
 a+b=c
\]

to a Pell orbit, a rational tripod, or a finite elliptic packet in such a way
that an accepted theorem on the target recovers

\[
 \log c\le (1+\varepsilon)\log\operatorname {rad}(abc)
             +O_\varepsilon(1).                    \tag{0.1}
\]

The audit finds no such non-circular accepted bridge.  It gives four precise
obstructions and one exact fixed split-conic equivalence.

1. The rational tripod is a lossless global coordinate, but its required
   uniform height estimate is exactly equivalent to `abc`.
2. Selecting the best point in the six-element tripod orbit does not weaken
   the statement: the resulting selector bound is again equivalent to `abc`,
   with only an additive `log 2` change.
3. A finite catalogue of fixed Pell orbits cannot encode all primitive triples
   with bounded fibres and linear logarithmic-height distortion.  The endpoint
   family `(n,1,n+1)` gives an elementary counting contradiction.
4. There is a bounded-fibre global map to the fixed split conic of primitive
   Pythagorean triples.  However, the critical radical estimate on that conic
   is again exactly equivalent to `abc`; in a rational parameter it is the
   critical six-factor truncated-counting estimate.
5. The Frey construction is global, but the critical `j`-height/conductor
   inequality on the Frey locus is also exactly equivalent to `abc`.  Division,
   Kummer, or bounded-abscissa selectors move the missing source height into a
   branch discriminant, twist conductor, or complementary local-height term.

Thus, within the Pell/tripod/elliptic architectures audited below, two explicit
sufficient interfaces left open by this audit are a **moving-coefficient**
Pell or elliptic certificate whose total net cost is small enough to preserve
coefficient one (for example `o(log c)`), and a fixed split-conic certificate
carrying the critical six-factor truncated estimate of Section 4A.  This list
is not asserted to exhaust every possible arithmetic construction.  The
split-conic estimate is already equivalent to `abc`, rather than an accepted
shortcut.  Establishing either displayed target inequality would be new global
arithmetic content; no accepted theorem located in this audit supplies it.

## 1. A canonical lossless elementary global coordinate

For a primitive positive triple put

\[
 \lambda={a\over c},\qquad 1-\lambda={b\over c},
 \qquad 0<\lambda<1.
\]

Because the three entries are pairwise coprime, the reduced numerator and
denominator data give the exact identities

\[
 h(\lambda)=\log c,                                  \tag{1.1}
\]

and

\[
 \operatorname {Supp}_{\{0,1,\infty\}}(\lambda)
   =\operatorname {Supp}(abc),                       \tag{1.2}
\]

so that the truncated counting mass is

\[
 N^{(1)}_{0+1+\infty}(\lambda)
   =\log\operatorname {rad}(abc).                    \tag{1.3}
\]

Conversely every rational `0<lambda<1`, in lowest terms `a/c`, gives the
primitive point `(a,c-a,c)`.  Hence this is a bijective global encoding, not a
special family.

Define the uniform tripod assertion

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\
 \forall\lambda\in\mathbf Q\cap(0,1),\qquad
 h(\lambda)\le(1+\varepsilon)N^{(1)}(\lambda)
                  +C_\varepsilon.                   \tag{1.4}
\]

Equations (1.1)--(1.3) prove immediately that (1.4) is equivalent to
logarithmic `abc`.  This equivalence is already formalized as

```text
abcConjecture_iff_uniformRationalSUnitTripodBound
```

in `IUTThreeClosures/SUnitUniformTripod.lean`.

This quantifier order is the decisive point.  Classical `S`-unit theorems fix
the multiplicative group, hence the prime set, before counting or bounding
solutions.  In (1.4) the support moves with `lambda`, while the additive
constant is independent of that support.

## 2. Minimal-equivalence theorem for finite tripod-orbit selection

Let

\[
 \mathcal O(\lambda)=\left\{
 \lambda,1-\lambda,{1\over\lambda},{1\over1-\lambda},
 {\lambda\over\lambda-1},{\lambda-1\over\lambda}
 \right\}.                                          \tag{2.1}
\]

For `lambda=a/c` and `b=c-a`, these six values are represented by signed
permutations of `(a,b,c)`.  Therefore every `mu in O(lambda)` has exactly the
same tripod prime support:

\[
 N^{(1)}(\mu)=N^{(1)}(\lambda)
             =\log\operatorname {rad}(abc).          \tag{2.2}
\]

The ordinary rational Weil heights are

\[
\begin{array}{c|c}
\mu & h(\mu)\\ \hline
\lambda,1-\lambda,1/\lambda,1/(1-\lambda)&\log c\\
\lambda/(\lambda-1),(\lambda-1)/\lambda
       &\log\max(a,b).
\end{array}                                          \tag{2.3}
\]

Since `c=a+b`,

\[
 \log c-\log2\le h(\mu)\le\log c
 \quad(\mu\in\mathcal O(\lambda)).                 \tag{2.4}
\]

Now consider the apparently weaker statement

\[
\begin{split}
 \forall\varepsilon>0\ \exists C_\varepsilon\
 \forall\lambda\in\mathbf Q\cap(0,1)\ \exists\mu\in
 \mathcal O(\lambda),\qquad\\
 h(\mu)\le(1+\varepsilon)N^{(1)}(\mu)+C_\varepsilon.
                                                               \tag{FOS}
\end{split}
\]

### Proposition 2.1

`(FOS)` is equivalent to the logarithmic `abc` conjecture.

### Proof

If `abc` holds, choose `mu=lambda`.  Conversely, choose the point supplied by
`(FOS)`.  Equations (2.2) and (2.4) give

\[
 \log c\le h(\mu)+\log2
 \le(1+\varepsilon)\log\operatorname {rad}(abc)
      +C_\varepsilon+\log2.
\]

This is `abc`.  \(\square\)

If one uses the symmetric signed-triple height rather than the affine Weil
height of one coordinate, all six heights equal `log c`, and even the additive
`log 2` disappears.

This is a useful formal boundary: no theorem saying merely that one of the six
Legendre/modular branches is favourable can be imported as a weaker input.
At the critical coefficient it is already an `abc` theorem.

## 3. Rigidity of universal same-support rational descent

Suppose a nonconstant rational function

\[
 f:\mathbf P^1\longrightarrow\mathbf P^1
\]

is intended to create another tripod point without adding universal branch
factors.  Algebraically this requires `f` and `1-f` to be units in

\[
 \mathbf Q[t,t^{-1},(1-t)^{-1}],
\]

or equivalently

\[
 f^{-1}\{0,1,\infty\}\subseteq\{0,1,\infty\}.       \tag{3.1}
\]

Let `d=deg f`, and let `m` be the number of distinct geometric points above
the three target points.  The three fibres have total multiplicity `3d`, so
they contribute `3d-m` to ramification.  Riemann--Hurwitz gives

\[
 3d-m\le2d-2,
 \qquad m\ge d+2.                                   \tag{3.2}
\]

Condition (3.1) gives `m<=3`, hence `d=1`.  The map must permute the marked
tripod and is one of the six transformations in (2.1).  Iteration never
produces more than six points.  The finite-orbit closure is already formalized
in `SUnitAnchoredDescentBarrier.lean`.

Allowing new inverse images does not create a free coefficient gain.  If `r`
of the distinct inverse-image points lie in the old tripod and `s` are new,
then

\[
 s\ge d+2-r\ge d-1.                                \tag{3.3}
\]

The pullback height is `d h(lambda)+O_f(1)`, while the generic reduced
counting cost of the `s` new divisor components is at most
`s h(lambda)+O_f(1)`.  Thus the net geometric coefficient satisfies

\[
 d-s\le r-2\le1.                                   \tag{3.4}
\]

The value `1` is already the critical tripod coefficient.  To improve it, one
would need a new theorem proving that the specialized extra binary forms have
abnormally small radicals uniformly in the moving input.  Riemann--Hurwitz or
Belyi theory does not provide that arithmetic estimate.

Allowing the rational map to depend on the source point merely relocates this
cost.  For

\[
 M=\begin{pmatrix}\alpha&\beta\\ \gamma&\delta\end{pmatrix}
 \in\mathrm {GL}_2(\mathbf Z),
\]

the transformed triple is built from

\[
 A'=\alpha a+\beta c,\qquad
 C'=\gamma a+\delta c,\qquad B'=C'-A'.              \tag{3.5}
\]

Primitivity of the column is preserved, but the three new linear forms need
not be supported on the old primes.  Since `GL_2(Z)` is transitive on
primitive integer columns, choosing `M=M(P)` so that (3.5) is a second
same-support solution is equivalent to already choosing that solution; the
matrix action has not produced it.  Its coefficient height can also be of
source-height size.  The analogous Mason specialization
`t+(1-t)=1` at `t=a/c` has zero horizontal complexity but exactly the moving
section height `log c`.  Dropping the map/section coefficient height is the
same missing-coefficient error in a different gauge.

## 4. A counting no-go for a finite catalogue of fixed Pell orbits

The following statement rules out a common proposed global endgame without
making any conjectural assertion about Pell equations.

Consider finitely many fixed Pell-type orbits.  After choosing a fundamental
unit in each fixed real quadratic order, every orbit has the form

\[
 \alpha_j\varepsilon_j^k,
 \qquad \varepsilon_j>1,\quad k\in\mathbf Z,         \tag{4.1}
\]

up to finitely many signs/classes.  The absolute size of its Pell coordinates
therefore grows exponentially in `|k|`, while its logarithmic height grows
linearly; equivalently,

\[
 h(Q_{j,k})=|k|\log\varepsilon_j+O_j(1).             \tag{4.2}
\]

### Proposition 4.1 (controlled finite-Pell encoding no-go)

There do not exist constants `M,kappa,C`, a finite union `PellFix` of fixed
Pell orbits, and a map from all positive primitive `abc` points to `PellFix`
such that

1. every target has at most `M` source preimages; and
2. `h(Phi(P)) <= kappa log(P.c)+C` for every source point.

### Proof

Use the `N` distinct primitive endpoint points

\[
 P_n=(n,1,n+1),\qquad 1\le n\le N.                  \tag{4.3}
\]

Condition 2 puts all their images in the target ball

\[
 h(Q)\le\kappa\log(N+1)+C.
\]

By (4.2), a fixed Pell orbit contributes only `O(log N)` points to this
ball; a finite union still contributes `O(log N)`.  With fibres of size at
most `M`, these targets can cover only `O(M log N)` sources, contradicting
the `N` sources in (4.3) for large `N`.  \(\square\)

Consequently any reduction within the fixed-orbit model of Proposition 4.1
must pay at least one of the following prices:

* the quadratic discriminant, norm coefficient, or chosen orbit varies with
  the input;
* the fibres are unbounded, so a new inverse-height theorem is needed;
* the output logarithmic height is not `O(log c)`, destroying the desired
  coefficient transfer.

This proposition does not claim that every imaginable nonlinear arithmetic
construction is impossible.  It rigorously excludes a finite fixed-orbit
certificate with exactly the control required for a lossless endgame.

The same endpoint count excludes a finite catalogue of fixed elliptic
Mordell--Weil groups under the analogous hypotheses.  On a fixed elliptic
curve of rank `r`, the canonical height is a positive-definite quadratic form
on a rank-`r` lattice, so a ball of canonical height `O(log N)` contains only
`O((log N)^(r/2))` rational points.  A fixed finite union, with uniformly
bounded source fibres, still cannot cover the `N` points in (4.3).  A fixed
genus-at-least-two curve has only finitely many rational points.  A fixed
rational curve has enough points, but then one is back on `P^1`, where the
tripod-support rigidity of Section 3 applies.

## 4A. A fixed split-conic equivalence: Pythagorean `abc`

Proposition 4.1 excludes a finite union of exponential-index Pell orbits.  It
does not exclude a fixed rational conic, whose rational points have enough
height entropy.  In fact there is a loss-controlled global map to the fixed
Pythagorean conic.  The exact estimate required there is nevertheless another
form of `abc`.

Define **Pythagorean `abc`** to be the assertion that for every
\(\varepsilon>0\) there is a constant \(C_\varepsilon\) such that every
positive primitive Pythagorean triple

\[
 X^2+Y^2=Z^2,
 \qquad \gcd(X,Y)=1,
\]

satisfies

\[
 2\log Z\le(1+\varepsilon)
   \log\operatorname {rad}(XYZ)+C_\varepsilon.       \tag{PT}
\]

### Proposition 4A.1

`(PT)` is equivalent to the logarithmic `abc` conjecture.

### Proof

If `abc` holds, apply it to the primitive triple

\[
 X^2+Y^2=Z^2.
\]

Its radical is exactly \(\operatorname {rad}(XYZ)\), so `(PT)` follows.

Conversely, let \(a+b=c\) be a positive primitive triple.  If \(a=b\), then
coprimality forces \((a,b,c)=(1,1,2)\), which is absorbed in the final
constant.  Otherwise put

\[
 d=\begin{cases}
 1,&a,b\text{ have opposite parity},\\
 2,&a,b\text{ are both odd},
 \end{cases}
\]

and define

\[
 X={|a^2-b^2|\over d},\qquad
 Y={2ab\over d},\qquad
 Z={a^2+b^2\over d}.                                \tag{4A.1}
\]

Since \(a,b\) are coprime, they cannot both be even.  The standard identity

\[
 (a^2-b^2)^2+(2ab)^2=(a^2+b^2)^2                 \tag{4A.2}
\]

shows that (4A.1) is a Pythagorean triple.  It is primitive: before division,
every common divisor of \(a^2-b^2\) and \(a^2+b^2\) divides `2`, while a
prime common to \(ab\) and either sum or difference would divide both \(a\)
and \(b\).  In the odd--odd case division by the exact common factor `2`
leaves coprime coordinates.  The usual uniqueness of primitive Pythagorean
parameters, together with the two parity branches above, also makes this map
uniformly finite-to-one.

Put

\[
 H=\log c,
 \qquad R=\log\operatorname {rad}(abc).
\]

The elementary size and support ledgers are

\[
 Z\ge {c^2\over4},                                  \tag{4A.3}
\]

and

\[
 \begin{aligned}
 \operatorname {rad}(XYZ)
 &\le2\operatorname {rad}(abc)
       |a-b|(a^2+b^2)\\
 &\le2\operatorname {rad}(abc)c^3.                 \tag{4A.4}
 \end{aligned}
\]

Indeed, the prime support of `XYZ` is contained in that of
\(2abc(a-b)(a^2+b^2)\); division by `d` can only remove primes.  Apply `(PT)`
with a parameter \(0<\eta<1/3\).  Equations (4A.3)--(4A.4) give

\[
 4H-\log16
 \le2\log Z
 \le(1+\eta)(R+3H+\log2)+C_\eta,
\]

and hence

\[
 (1-3\eta)H\le(1+\eta)R+O_\eta(1).                \tag{4A.5}
\]

For a prescribed \(\varepsilon>0\), take

\[
 \eta={\varepsilon\over4+3\varepsilon}.
\]

Then \(0<\eta<1/3\) and

\[
 {1+\eta\over1-3\eta}=1+\varepsilon.              \tag{4A.6}
\]

Dividing (4A.5) by \(1-3\eta\) proves `abc`.  \(\square\)

This equivalence identifies the exact fixed-conic cost.  Write a primitive
Pythagorean triple in the usual form

\[
 X=m^2-n^2,\qquad Y=2mn,\qquad Z=m^2+n^2.
\]

After base change to \(\mathbf Q(i)\), its prime support is that of the six
geometric factors

\[
 2mn(m-n)(m+n)(m-in)(m+in),                       \tag{4A.7}
\]

or, over \(\mathbf Q\), of
\(2mn(m-n)(m+n)(m^2+n^2)\).  On the parameter line the reduced geometric
divisor is

\[
 [0]+[\infty]+[1]+[-1]+[i]+[-i].                 \tag{4A.8}
\]

Moreover \(2\log Z=4h(m:n)+O(1)\).  Thus `(PT)` is precisely the
coefficient \(6-2=4\) truncated-counting estimate for this six-point divisor.
The conic is fixed and split, but the needed theorem is still at the critical
`abc` coefficient.  This does not contradict Proposition 4.1: a rational
conic is not a finite union of exponential-index Pell orbits, and has far more
points in logarithmic-height balls.

## 5. What the universal squarebase/Pellization actually produces

Every triple has unique decompositions

\[
 a=A u^2,\qquad b=B v^2,\qquad c=C w^2,              \tag{5.1}
\]

where `A,B,C` are squarefree.  Pairwise coprimality of `a,b,c` makes these
three squarefree coefficients pairwise coprime.  The equation becomes the
moving ternary conic

\[
 A u^2+B v^2=C w^2.                                 \tag{5.2}
\]

Multiplying by `C` gives the Pell-type identity

\[
 (Cw)^2-ACu^2=BCv^2,                                \tag{5.3}
\]

When `AC>1`, the squarefree integer `AC` is nonsquare, and (5.3) is the field
norm identity

\[
 N_{\mathbf Q(\sqrt{AC})/\mathbf Q}
   (Cw+u\sqrt{AC})=BCv^2.                           \tag{5.4}
\]

When `AC=1`, necessarily `A=C=1`; there is no quadratic field in (5.4).
Instead use the split quadratic étale algebra

\[
 \mathbf Q[T]/(T^2-1)\simeq\mathbf Q\times\mathbf Q,
\]

where the element `(w+u,w-u)` has norm
`(w+u)(w-u)=Bv^2`.  For example, `(1,8,9)` has
`(A,u)=(1,1)`, `(B,v)=(2,2)`, `(C,w)=(1,3)` and lies in this split case.

This is a genuine global reduction, but it is **not** a fixed Pell equation.
On the non-split branch the quadratic field `Q(sqrt(AC))` and norm
coefficient `BC` can both move; on the split branch the coefficient `B` still
moves.

The exact radical ledger is

\[
 \operatorname {rad}(abc)
 =\operatorname {lcm}\bigl(ABC,\operatorname {rad}(uvw)\bigr)
 ={ABC\operatorname {rad}(uvw)\over
   \gcd(ABC,\operatorname {rad}(uvw))}.              \tag{5.5}
\]

Thus a theorem that retains only the parity coefficients `ABC`, or only the
square bases `uvw`, loses information.  The overlap term in (5.5) is also
essential.  Passing to a field in which the coefficients become squares
does not delete them: its ramification/discriminant is supported on
`2ABC`, and accepted fixed-field Pell/Thue--Mahler bounds have constants
depending on the moving field and norm data.

The fixed `D=3` Pell orbit studied elsewhere in this repository is much
narrower.  It concerns a special family `(1,b,b+1)` satisfying additional
square identities.  Even a complete CAS proof for every Chebyshev index in
that family would prove only its own radical statement.  No map from an
arbitrary `(a,b,c)` to that orbit with the controls of Proposition 4.1 exists
in the repository, and Proposition 4.1 rules out a finite fixed-orbit version
of such a map.

## 6. Exact Frey minimal-equivalence theorem

The Frey curve

\[
 E_P:y^2=x(x-a)(x+b)                                 \tag{6.1}
\]

does attach an elliptic curve to every primitive point.  Let `h_j(P)` be the
absolute Weil height of its `j`-invariant and let

\[
 R(P)=\log\operatorname {rad}(abc).
\]

The repository proves the two-sided corridor

\[
 H(P)-{\log8\over6}
 \le {h_j(P)\over6}
 \le H(P)+{\log256\over6},
 \qquad H(P)=\log c.                                \tag{6.2}
\]

Define the Frey radical statement

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\
 \forall P,\qquad
 h_j(P)\le6(1+\varepsilon)R(P)+C_\varepsilon.        \tag{FJ}
\]

### Proposition 6.1

`(FJ)` is equivalent to logarithmic `abc`.

### Proof

If `abc` holds, the upper half of (6.2) gives `(FJ)`, after multiplying the
constant by six and adding `log 256`.  Conversely `(FJ)` and the lower half
of (6.2) give

\[
 H(P)\le {h_j(P)\over6}+{\log8\over6}
 \le(1+\varepsilon)R(P)
   +{C_\varepsilon+\log8\over6}.
\]

This is `abc`.  \(\square\)

The same boundary appears in modified Szpiro language.  The displayed Frey
discriminant is

\[
 \Delta=16(abc)^2,                                  \tag{6.3}
\]

and its reduced prime support differs from the elementary radical only at
`2`.  This support identity must not be confused with a sufficient lower
height comparison: the plain displayed discriminant does not uniformly
contain a sixth power of `c`, and the direct exponent-six ledger loses a
coefficient.  The modified invariant height
`max(|c4|^3,|c6|^2)`, the `j`-height corridor (6.2), or a corresponding
modular covolume does have the required source-height scale.  A critical
uniform bound for one of those quantities on all Frey curves supplies `(FJ)`
or an equivalent inequality.  Such a theorem is a valid route **to prove**
`abc`, but it cannot be counted as an already weaker accepted input.

The rational `2`-isogeny graph, division points, and Kummer packets do not
alter this conclusion by formal averaging.  The repository audits show:

* displayed discriminants in the complete rational `2`-isogeny graph do not
  uniformly recover a sixth power of `c`;
* canonical height is conserved over a full division fibre;
* selecting a locally favourable branch requires global squareclass
  alignment and complementary finite/archimedean control;
* bounded-abscissa quadratic selectors introduce a field discriminant or
  twist conductor of positive source-height size;
* fixed finite selector universes admit CRT counterfamilies forcing this
  positive cost.

An unbounded adaptive selector is not logically ruled out, but it would need
a new theorem showing simultaneously that the retained local-height mass is
large and that the net contribution of all branch-field, twist-conductor, and
archimedean losses is absorbable in the `epsilon`-budget; an `o(log c)` total
loss would suffice.  No accepted theorem found in this audit provides that
package.

## 7. The repository's bridge types are conclusions, not inputs

Three interfaces require special care.

1. `UniformRationalSUnitTripodBound` is explicitly equivalent to
   `ABCConjecture`.
2. `ThreeClosureCertificate.actualIUTIVDownstream` has conclusion
   `ABCConjecture` in its field.  Constructing this field is the desired
   theorem, not a previously proved bridge.
3. Although `NonCircularIUTIVBridge` does not literally store a field named
   `ABCConjecture`, the repository proves, for inhabited input, that its
   inhabitation is equivalent to `ABCConjecture`:

```text
Nonempty (NonCircularIUTIVBridge F)
  iff Nonempty Input and ABCConjecture.
```

Therefore none of these types may be assumed merely because its definition
is available.  The exact-equivalence theorems are useful honesty checks, but
they do not inhabit the bridge.

## 8. Accepted-literature audit

The following accepted results are relevant, but none closes the global
bridge.

### 8.1 Restricted `abc` reductions

Ellenberg proved that, for a fixed integer `N`, `abc` restricted to triples
with `N | abc` implies full `abc`.  Van Frankenhuijsen proved number-field
versions of this and of a complementary **not-highly-divisible** restriction.
These are genuine reduction theorems, but their hypotheses are still uniform
coefficient-one `abc` estimates on restricted triples.  They do not turn the
hypothesis into a Pell theorem or a fixed finite computation.

### 8.2 `S`-unit counts

Beukers--Schlickewei and Evertse--Schlickewei--Schmidt give explicit bounds
for the number of solutions in a multiplicative group of fixed rank.  For a
fixed prime support this is powerful finiteness/counting information.  It
does not bound the height of an isolated largest solution uniformly as the
support varies.  A same-support descendant mechanism of multiplicity
exponential in the height excess would be needed to turn the count into
(0.1); the six symmetries and Euclidean/power descents do not provide it.

### 8.3 Belyi, Siegel, Faltings, and fixed-curve CAS

These theorems control a fixed curve, fixed divisor, fixed field, or fixed
finite collection of such data.  A Belyi pullback adds at least `d-1` new
punctures in degree `d`, as in (3.3).  A CAS certificate can close one fixed
curve or one fixed Pell index, but a finite catalogue cannot cover all
primitive triples under Proposition 4.1.  Letting coefficients or genus move
requires a new uniform theorem.

The Granville--Langevin binary-form formulation is another exact honesty
boundary, not an accepted shortcut.  Its conjectural estimate for a squarefree
binary form `F` of degree `d` has radical exponent `d-2-epsilon`; taking
`F(X,Y)=XY(X+Y)` recovers `abc` immediately, while the converse follows by
Belyi descent.  Thus importing the critical binary-form radical estimate would
again import an equivalent conjecture.

### 8.4 Frey, Szpiro, and modular degree

Modularity is accepted and gives modular parametrizations, but not the
critical polynomial conductor bound for their degree/covolume.  The
modified-Szpiro statement at the critical exponent is known to be equivalent
to `abc`; on the Frey locus this is also visible directly from (6.2)--(6.3).
Current unconditional height-in-conductor estimates are quantitatively far
from `(FJ)`.

Accordingly, accepted literature supplies several correct conditional
reductions and many fixed-family theorems, but no non-circular uniform
coefficient-one estimate for the moving data above.

## 9. One sufficient surviving global interface

Section 4A leaves one fixed-coefficient possibility: prove the critical
six-factor estimate `(PT)` on the split Pythagorean conic.  Proposition 4A.1
shows exactly that this is an equivalent formulation of `abc`, not a weaker
accepted theorem.  One sufficient template for a genuinely moving
Pell/elliptic bridge would instead provide, for every primitive point `P`,
target data `Q(P)` with all of the following properties.

1. **Inverse height:**

   \[
   H(P)\le A h(Q(P))+o(H(P))+O(1).                  \tag{9.1}
   \]

2. **Conductor budget:** every new prime, field discriminant, coefficient,
   and twist-conductor term appearing in the target theorem satisfies

   \[
   N_{\rm target}(Q(P))
      \le R(P)+o(H(P))+O(1).                        \tag{9.2}
   \]

3. **Budgeted dependence:** every dependence on the moving Pell discriminant,
   norm coefficient, Frey curve, Mordell--Weil rank, and prime support is
   explicitly included in (9.1)--(9.2) or in the allowed
   `O_epsilon(1)` term; no input-dependent constant is left unbudgeted.
4. **Critical target slope:** after multiplying (9.1) by the target estimate,
   the coefficient of `R(P)` is at most `1+epsilon`.

If (9.1)--(9.2) and the critical target estimate are proved, their composition
is a valid proof of `abc`.  Omitting any moving coefficient or treating a
fixed-family constant as uniform is precisely where those natural candidate
reductions lose the coefficient.  The fixed split-conic alternative avoids
moving coefficients only by retaining the full critical six-point truncated
count.

Within the rational-tripod/counting strategy, a different sufficient theorem
is the following anchored proliferation bound.  For a finite prime set
\(S\), let \(\mathcal T(S)\) be the set of positive primitive triples
supported in \(S\), and put \(R_S=\prod_{p\in S}p\).  There should exist
fixed constants \(A_0\ge1\) and \(B_0\ge0\) such that every
\((a,b,c)\in\mathcal T(S)\) satisfies

\[
 \#\mathcal T(S)\ge
 {c\over R_S A_0^{|S|}\prod_{p\in S}(1+\log p)^{B_0}}.
                                                               \tag{9.3}
\]

Combined with the accepted exponential-in-rank `S`-unit count and the
support-entropy lemma, (9.3) yields `abc`.  No such proliferation theorem is
known; standard tripod symmetries give at most six points, while Euclidean and
power chains introduce uncontrolled new primes.

## 10. Formalization-ready statements

Without invoking any new arithmetic theorem, the following are suitable next
Lean targets after this paper audit is independently checked.

1. For `mu in rationalTripodOrbit lambda`, prove exact tripod-support
   equality.
2. For `0<lambda<1`, prove
   `rationalTripodHeight lambda <= rationalTripodHeight mu + log 2`.
3. Define the existential finite-orbit selector bound and prove it equivalent
   to `ABCConjecture` (Proposition 2.1).
4. Define the uniform Frey `j`-radical bound `(FJ)` and prove it equivalent to
   `ABCConjecture` from the existing `FreyJHeightCorridor` lemmas
   (Proposition 6.1).
5. Record the two integral Pythagorean identities (including the odd--odd
   normalization) and the scalar transfer (4A.5)--(4A.6).  A full formal
   `(PT)` equivalence additionally requires the natural-radical support ledger.
6. Formalize Proposition 4.1 first for abstract sequences satisfying
   `h(Q_{j,k}) >= alpha_j |k|-beta_j`; instantiate Pell orbits only after an
   appropriate Pell API is available.

These theorems would be no-go/equivalence certificates.  They would not be a
proof of `abc`.

## References

1. J. S. Ellenberg, *Congruence ABC implies ABC*, Indagationes Mathematicae
   11 (2000), 65--74, <https://arxiv.org/abs/math/9909098>.
2. M. van Frankenhuijsen, *Two Restricted ABC Conjectures*, Journal of Number
   Theory 221 (2021), 424--446,
   <https://doi.org/10.1016/j.jnt.2020.10.020>.
3. F. Beukers and H. P. Schlickewei, *The equation x+y=1 in finitely
   generated groups*, Acta Arithmetica 78 (1996), 189--199,
   <https://doi.org/10.4064/aa-78-2-189-199>.
4. J.-H. Evertse, H. P. Schlickewei, and W. M. Schmidt, *Linear equations in
   variables which lie in a multiplicative group*, Annals of Mathematics 155
   (2002), 807--836, <https://annals.math.princeton.edu/2002/155-3/p04>.
5. H. Pasten, *Shimura curves and the abc conjecture*, Journal of Number
   Theory 254 (2024), 214--335,
   <https://doi.org/10.1016/j.jnt.2023.07.002>.
6. A. J. Barrios, *A constructive proof of Masser's theorem*, Contemporary
   Mathematics 759 (2020), 51--61,
   <https://doi.org/10.1090/conm/759/15265>.
7. M. Langevin, *Imbrications entre le théorème de Mason, la descente de
   Belyi et les différentes formes de la conjecture (abc)*, Journal de
   Théorie des Nombres de Bordeaux 11 (1999), 91--109,
   <https://numdam.org/item/JTNB_1999__11_1_91_0/>.
