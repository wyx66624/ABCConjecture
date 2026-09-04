# Endpoint residue cubes and proper-subface flagged CRT surplus

**Author:** ChatGPT  
**Date:** 2026-09-04  
**Status:** ordinary mathematics proved below before Lean formalization; the
uniform flagged-CRT estimate remains open, as does the standard \(abc\)
conjecture.

## Abstract

This note continues the shared CRT-incidence boundary `SCRT-0`.  It first
separates two superficially similar surplus rules.  If the unused capacity of
a saturated CRT block may be sent to an arbitrary residual source, the exact
finite optimum is always the scalar defect

\[
                 \Delta=(X-Y)_+.
\]

Thus that free-target rule is capacity-correct but arithmetically empty.  We
then define `FCRT-1`: a block surplus may create one indivisible, one-hop
token and may be sent to a residual source only when a nonempty proper
subface of the same sink block satisfies that source's full prime-power
congruence.  Its reusable mass is capped by both the block surplus and the
witness-face weight.  The rule preserves the once-charged height bridge.  It
strictly improves `SCRT-0` at \((1,675,676)\), attaining the scalar lower
bound, but does not collapse pointwise: at \((1,224,225)\) its exact boundary
is \(\log(3/2)>\log(15/14)=\Delta\).  At
\((1,65024,65025)\) the face cap is active and all four finite levels are
strict:
\(\Delta<B_{\rm FCRT}<B_{\rm SCRT}<B_{\rm PBT}\).

The arithmetic behind the flag has a higher-dimensional formulation.  For
each source face \(S\), unitary-divisor packets form a Boolean cube mapped to
a finite abelian endpoint residue group.  Compatible packets are exactly the
\(-1\)-fibre; equivalently, they are the set-theoretic complements of packets
in the identity fibre.  Differences of compatible packets give signed
\(\{-1,0,1\}\)-relations in a residue
lattice.  This supplies a genuine incidence object for future combinatorial
and Fourier analysis, while no uniform estimate is asserted here.

## 1. Endpoint notation

Let \(\mathcal P_{\rm prim}\) be the set of positive integer triples
\(P=(a,b,c)\) with \(a+b=c\) and \(\gcd(a,b)=1\), and fix
\(P\in\mathcal P_{\rm prim}\).  For a prime
\(p\mid c\), write \(e_p=v_p(c)\), and retain only the positive excess sources

\[
 I=\{p\mid c:e_p\ge2\},\qquad x_p=(e_p-1)\log p,
 \qquad X=\sum_{p\in I}x_p.
\]

Let \(J\) be the primes dividing \(ab\), with sink weights
\(y_q=\log q\), and put \(Y=\sum_{q\in J}y_q=\log\operatorname{rad}(ab)\).
For \(T\subseteq J\), define the unitary packet pieces

\[
 a_T=\prod_{\substack{q\in T\\q\mid a}}q^{v_q(a)},\qquad
 b_T=\prod_{\substack{q\in T\\q\mid b}}q^{v_q(b)},\qquad
 y(T)=\sum_{q\in T}\log q.
\]

For \(S\subseteq I\), set

\[
 m(S)=\prod_{p\in S}p^{e_p},\qquad x(S)=\sum_{p\in S}x_p.
\]

A pair \((S,T)\) with \(\varnothing\ne S\subseteq I\) and
\(\varnothing\ne T\subseteq J\) is a shared CRT block when

\[
                    m(S)\mid a_T+b_T.                 \tag{1.1}
\]

It is saturated when \(x(S)\le y(T)\).  As in `SCRT-0`, selected blocks have
pairwise disjoint source sets and pairwise disjoint sink sets.  Sinks outside
the selected blocks may be assigned exclusively to residual sources or left
unused.  Every logarithmic sink capacity is therefore charged at most once.
For such a selected block family and residual owner map \(o\), its SCRT
boundary is

\[
 \sum_{p\in I_0}
 \left(x_p-\sum_{\substack{q\in J_0\\o(q)=p}}y_q\right)_+.
\]

Write \(B_{\rm SCRT}(P)\) for the minimum of this quantity when every
selected block's surplus is discarded, and \(B_{\rm PBT}(P)\) for the
minimum under the additional restriction that the selected block family is
empty, so all credit comes from exclusive residual-sink ownership.

Prime factorization gives the exact endpoint identity

\[
 h(P)-r(P)=X-Y,                                      \tag{1.2}
\]

where \(h(P)=\log c\) and
\(r(P)=\log\operatorname{rad}(abc)\).

## 2. Free-target surplus and its exact collapse

Consider the following provisional relaxation.  Choose a finite set
\(\mathcal H=((S_\nu,T_\nu))_{\nu\in K}\) of distinct, pairwise
source-disjoint and sink-disjoint saturated blocks, and put

\[
 I_0=I\setminus\bigcup_{\nu\in K}S_\nu,
 \qquad
 J_0=J\setminus\bigcup_{\nu\in K}T_\nu.
\]

Each selected block produces the unused amount

\[
             \sigma_\nu=y(T_\nu)-x(S_\nu)\ge0.       \tag{2.1}
\]

Choose partial owner maps
\(o:J_0\to I_0\sqcup\{\varnothing\}\) and
\(t:K\to I_0\sqcup\{\varnothing\}\).  The latter may assign the entire
unsplit surplus token of a block to any one residual source, without any
further congruence condition.  Several tokens may go to the same source.
The first map is the exclusive `SCRT-0` assignment for residual sinks.  Put

\[
 C_p=\sum_{\substack{q\in J_0\\o(q)=p}}y_q
     +\sum_{\substack{\nu\in K\\t(\nu)=p}}\sigma_\nu.
\]

The boundary is

\[
                 B_{\rm free}=\sum_{p\in I_0}(x_p-C_p)_+. \tag{2.2}
\]

### Proposition 2.1 (free-target surplus is scalar pooling)

For every positive primitive point,

\[
                 \min B_{\rm free}=(X-Y)_+.           \tag{2.3}
\]

### Proof

Once-only charging gives \(X\le Y+B_{\rm free}\), so every boundary is at
least \((X-Y)_+\).

If \(I=\varnothing\), the empty configuration has boundary
\(0=(X-Y)_+\).  Suppose next that \(I\ne\varnothing\) and \(X\le Y\).
Then \(J\ne\varnothing\): otherwise positivity and the absence of prime
divisors of \(ab\) would give \(a=b=1\), \(c=2\), and hence
\(I=\varnothing\), a contradiction.  The full pair \((I,J)\) is therefore a
legal block.  It is compatible because \(m(I)\mid a+b=c\), and it is
saturated.  It covers every source, giving boundary zero.

Now suppose \(X>Y\).  Choose an inclusion-maximal subset \(S\subset I\) with
\(x(S)\le Y\); such a subset exists because the empty subset qualifies, and
\(S\ne I\).  If \(S\ne\varnothing\), select the full-sink block \((S,J)\).
It is compatible and saturated.  Choose any \(p\in I\setminus S\).  By
maximality,

\[
                 x_p>Y-x(S)=\sigma.                   \tag{2.4}
\]

Assign the one surplus token \(\sigma\) to \(p\).  No sinks remain.  The sum
of all residuals is then

\[
       x_p-\sigma+\sum_{u\in I\setminus(S\cup\{p\})}x_u
       =X-x(S)-(Y-x(S))=X-Y.                           \tag{2.5}
\]

If \(S=\varnothing\), maximality says \(x_p>Y\) for every source.  Choose one
source and assign every exclusive sink to it.  Its residual is \(x_p-Y\), so
the total boundary is again \(X-Y\).  This meets the lower bound in every
case.  QED.

This proposition retires only the proposed **free-target surplus rule** as a
source of new arithmetic information.  It does not refute `SCRT-0`, the
flagged successor below, or any parent incidence route.

## 3. Proper-subface flagged surplus

The collapse proof uses a full sink block and sends its surplus to a source
whose congruence need not be visible inside that block.  We retain arithmetic
information by forbidding precisely that step.

### Definition 3.1 (`FCRT-1` configuration)

Start with a finite set
\(\mathcal H=((S_\nu,T_\nu))_{\nu\in K}\) of distinct, pairwise
source-disjoint and sink-disjoint saturated CRT blocks, and put

\[
 I_0=I\setminus\bigcup_{\nu\in K}S_\nu,
 \qquad
 J_0=J\setminus\bigcup_{\nu\in K}T_\nu.
\]

Choose a partial residual-sink owner map
\(o:J_0\to I_0\sqcup\{\varnothing\}\).  At the reuse stage, a block may be
unused, or choose through a partial target map
\(t:K\to I_0\sqcup\{\varnothing\}\) one residual source \(p\in I_0\) and one
nonempty proper subface
\(U\subsetneq T_\nu\) such that

\[
                      p^{e_p}\mid a_U+b_U.             \tag{3.1}
\]

The reusable mass of that flag is

\[
     \rho_\nu=\min\{\sigma_\nu,y(U)\}.                  \tag{3.2}
\]

An unused block has \(\rho_\nu=0\).  A used block emits exactly one unsplit
token of mass \(\rho_\nu\); any remaining surplus
\(\sigma_\nu-\rho_\nu\) is discarded and may not be emitted as another
token.  The emitted token has one target and travels only one hop.  In
particular, unused credit at its target does not create a new token.  Residual
sinks are independently assigned exactly
as in `SCRT-0`: each is unused or assigned to one residual source.  Different
surplus tokens and different residual sinks may target the same source, but
no original sink weight is charged twice.  Allowing several independently
charged tokens to meet at one source introduces no duplication; forbidding
it would add a constraint with no accounting justification.

Write

\[
 M_p=\sum_{\substack{q\in J_0\\o(q)=p}}y_q,
 \qquad
 Z_p=\sum_{\substack{\nu\\t(\nu)=p}}\rho_\nu,
 \qquad
 R_p=(x_p-M_p-Z_p)_+,                                  \tag{3.3}
\]

and define

\[
             B_{\rm FCRT}(\mathcal C)=\sum_{p\in I_0}R_p, \tag{3.4}
\]

where \(\mathcal C=(\mathcal H,o,t,(U_\nu))\) denotes this configuration and
\(U_\nu\) is supplied exactly for the used blocks.  Let
\(\operatorname{Conf}_{\rm FCRT}(P)\) be the set of these admissible
configurations.  It is finite, has no repeated block labels, and is nonempty
because the empty block family with every residual sink unused is admissible.
Define the pointwise optimum

\[
 B_{\rm FCRT}(P)=
 \min_{\mathcal C\in\operatorname{Conf}_{\rm FCRT}(P)}
 B_{\rm FCRT}(\mathcal C).                              \tag{3.4a}
\]

### Proposition 3.2 (once-charged FCRT mass bridge)

Every `FCRT-1` configuration \(\mathcal C\) satisfies

\[
                   X\le Y+B_{\rm FCRT}(\mathcal C).    \tag{3.5}
\]

### Proof

Every covered block contributes \(x(S_\nu)\) to the source side.  For each
residual source, (3.3) gives

\[
                         x_p\le M_p+Z_p+R_p.            \tag{3.6}
\]

Exclusive residual assignment yields

\[
                         \sum_pM_p\le y(J_0),           \tag{3.7}
\]

and the cap \(\rho_\nu\le\sigma_\nu\), together with the one-target rule,
gives

\[
                         \sum_pZ_p\le\sum_\nu\sigma_\nu. \tag{3.8}
\]

Therefore

\[
\begin{aligned}
X
&=\sum_\nu x(S_\nu)+\sum_{p\in I_0}x_p\\
&\le\sum_\nu x(S_\nu)+y(J_0)
    +\sum_\nu\bigl(y(T_\nu)-x(S_\nu)\bigr)
    +B_{\rm FCRT}(\mathcal C)\\
&=Y+B_{\rm FCRT}(\mathcal C).
\end{aligned}                                           \tag{3.9}
\]

The proper-subface condition is not needed for this accounting inequality;
it is what prevents the admissible configurations from becoming the free
scalar model.  QED.

### Corollary 3.3 (height bridge and exact sandwich)

Every `FCRT-1` configuration \(\mathcal C\) satisfies

\[
             h(P)\le r(P)+B_{\rm FCRT}(\mathcal C).     \tag{3.10}
\]

\[
 (X-Y)_+\le B_{\rm FCRT}(P)\le B_{\rm SCRT}(P)
                                  \le B_{\rm PBT}(P).    \tag{3.11}
\]

### Proof

Equation (3.10) follows from (1.2) and Proposition 3.2.  The left inequality
of (3.11) follows from (3.5), boundary nonnegativity, and minimization.
Leaving every surplus unused embeds every `SCRT-0`
configuration into `FCRT-1`; taking no shared blocks embeds the exclusive
prime-packet problem.  QED.

### Definition 3.4 (uniform flagged gate)

`FCRT-1` is the quantified statement

\[
 \forall\varepsilon>0\quad \exists C_\varepsilon\in\mathbb R_{\ge0}\quad
 \forall P\in\mathcal P_{\rm prim}\quad
 \exists\mathcal C\in\operatorname{Conf}_{\rm FCRT}(P):\quad
 B_{\rm FCRT}(\mathcal C)\le\varepsilon r(P)+C_\varepsilon. \tag{FCRT-1}
\]

### Theorem 3.5 (conditional implication)

`FCRT-1` implies the standard logarithmic \(abc\) conjecture.

### Proof

Insert the boundary supplied by `FCRT-1` into (3.10):

\[
 h(P)\le r(P)+B_{\rm FCRT}(\mathcal C)
       \le(1+\varepsilon)r(P)+C_\varepsilon.
\]

The premise `FCRT-1` is not assumed or proved.  QED.

## 4. Exact strict-improvement witness

Take

\[
                         (a,b,c)=(1,675,676).
\]

The factorizations and weights are

\[
 675=3^3 5^2,\qquad676=2^2 13^2,
 \qquad I=\{2,13\},\quad J=\{3,5\},
\]

\[
 X=\log26,\qquad Y=\log15,
 \qquad\Delta=\log(26/15).                              \tag{4.1}
\]

The proper packet \(T=\{3\}\) has

\[
                 a_T+b_T=1+27=28,
\]

so it certifies the full source modulus \(2^2=4\).  The other proper packet
has \(1+25=26\), which is divisible by neither \(4\) nor \(13^2\).  The full
packet has sum \(1+675=676\) and certifies both sources.

Any unassigned residual sink packet can be assigned to a residual source
that is not yet full without increasing the boundary, so it suffices here to
enumerate complete residual-sink owner maps.  Surplus reuse remains restricted
by (3.1)--(3.2); it cannot be assigned to an arbitrary source.
With no block, the four sink partitions leave, respectively,

| owner of \(3\) | owner of \(5\) | boundary |
|---|---|---:|
| \(2\) | \(2\) | \(\log13\) |
| \(2\) | \(13\) | \(\log(13/5)\) |
| \(13\) | \(2\) | \(\log(13/3)\) |
| \(13\) | \(13\) | \(\log2\) |

The complete list of saturated compatible blocks is
\((\{2\},\{3\})\), \((\{2\},\{3,5\})\), and
\((\{13\},\{3,5\})\).  They intersect in a sink, so at most one can be
chosen.  Their best `SCRT-0` boundaries are
\(\log(13/5)\), \(\log13\), and \(\log2\), respectively.

Since \(\log2<\log(13/5)\), exact finite enumeration gives

\[
                         B_{\rm SCRT}=\log2.             \tag{4.2}
\]

For `FCRT-1`, choose the saturated block

\[
                 (S,T)=(\{13\},\{3,5\}).
\]

Its surplus is

\[
                 \sigma=\log15-\log13=\log(15/13).     \tag{4.3}
\]

The proper subface \(U=\{3\}\) satisfies \(4\mid28\).  Moreover
\(\log(15/13)<\log3\), so the cap is
\(\rho=\min\{\sigma,\log3\}=\sigma\).  The flag therefore permits the whole
reusable token to target the residual source \(2\).  Its boundary is

\[
 \log2-\log(15/13)=\log(26/15)=\Delta.                  \tag{4.4}
\]

The lower bound in (3.11) proves optimality.  Hence `FCRT-1` gives a strict
pointwise boundary improvement, and is a strict arithmetic relaxation of
`SCRT-0`, at this actual primitive triple.  At the level of quantified gates,
`SCRT-0` implies `FCRT-1`; the converse is unknown.

## 5. Exact noncollapse witness

Return to

\[
                         (a,b,c)=(1,224,225).
\]

Here

\[
 224=2^5\cdot7,\qquad225=3^2 5^2,
 \qquad I=\{3,5\},\quad J=\{2,7\},
\]

\[
 X=\log15,\qquad Y=\log14,
 \qquad\Delta=\log(15/14).                              \tag{5.1}
\]

The two proper packets give

\[
                 1+32=33,\qquad1+7=8.                  \tag{5.2}
\]

Neither number is divisible by \(3^2=9\) or \(5^2=25\).  The full packet has
sum \(225\), so the only nontrivial saturated blocks use the full sink set and
one singleton source.  Neither such block has a legal proper-subface surplus
flag.  Thus the FCRT surplus stage adds no credit at this point.

Again it suffices to enumerate complete owner maps.  With no block, the four
possibilities are

| owner of \(2\) | owner of \(7\) | boundary |
|---|---|---:|
| \(3\) | \(3\) | \(\log5\) |
| \(5\) | \(5\) | \(\log3\) |
| \(3\) | \(5\) | \(\log(3/2)\) |
| \(5\) | \(3\) | \(\log(5/2)\) |

Thus assigning sink \(2\) to source \(3\) and sink \(7\) to source \(5\)
gives

\[
             (\log3-\log2)+(\log5-\log7)_+=\log(3/2).   \tag{5.3}
\]

The only legal blocks are the full-sink singleton-source blocks.  They leave
\(\log5\) and \(\log3\), respectively, and neither has an activated flag.
Consequently

\[
 B_{\rm FCRT}=B_{\rm SCRT}=B_{\rm PBT}=\log(3/2)
       >\log(15/14)=\Delta.                              \tag{5.4}
\]

This proves that `FCRT-1` does not collapse pointwise to the scalar defect.
It does not prove the uniform gate.

### 5.1 A four-layer strict witness where the face cap binds

The point

\[
                         (a,b,c)=(1,65024,65025)
\]

separates every finite boundary in (3.11).  Its factorization is

\[
 65024=2^9\cdot127,\qquad
 65025=3^2\cdot5^2\cdot17^2.
\]

Thus the multiplicative source and sink masses are

\[
 e^X=3\cdot5\cdot17=255,\qquad e^Y=2\cdot127=254,
 \qquad e^\Delta=\frac{255}{254}.                       \tag{5.5}
\]

The proper packet \(\{2\}\) gives

\[
                  1+2^9=513=3^3\cdot19,                \tag{5.6}
\]

so it certifies source \(3\), but not \(5\) or \(17\).  The packet
\(\{127\}\) gives \(128\) and certifies none of the three sources.  The full
packet gives \(65025\) and certifies every source subset.

The only compatible proper-packet block is
\((\{3\},\{2\})\), and it is not saturated because \(\log3>\log2\).
Every nonempty proper source subset paired with the full sink set is
compatible and saturated: the largest such source factor is
\(5\cdot17=85<254\).  The full source set is not saturated because
\(255>254\).  All selectable saturated blocks use the same full sink set, so at most one can
be selected.

With no block, the nine complete owner maps for the two sinks and three
sources have residual factors among

\[
 \frac{15}{2},\ 15,\ \frac{51}{2},\ 51,\ \frac{85}{2},\ 85.
\]

The minimum \(15/2\) occurs, for example, by sending \(127\) to source \(17\)
and \(2\) to source \(3\) or \(5\).  Hence

\[
                         e^{B_{\rm PBT}}=\frac{15}{2}.  \tag{5.7}
\]

For `SCRT-0`, choose the full-sink block with \(S=\{5,17\}\).  It closes
source factor \(85\) and leaves source \(3\), so \(e^{B_{\rm SCRT}}=3\).
The complete block list above shows that every other legal block leaves at
least \(5\), \(15\), \(17\), \(51\), or \(85\); hence this is exact.

For `FCRT-1`, the same block has multiplicative surplus \(254/85>2\).
Its proper face \(U=\{2\}\) is compatible with residual source \(3\) by
(5.6), but the witness-face cap binds:

\[
             e^\rho=\min\left\{\frac{254}{85},2\right\}=2. \tag{5.8}
\]

The remaining boundary factor is therefore \(3/2\).  A block containing
source \(3\) cannot target \(3\); a block omitting it has no other activated
target and receives at most factor \(2\).  Among those blocks,
\(S=\{5,17\}\) closes the most other source mass.  The no-block case is PBT.
This proves the matching lower bound and hence

\[
 \boxed{\quad
 \frac{255}{254}
 <\frac32
 <3
 <\frac{15}{2}\quad}
\]

or, after taking logarithms,

\[
 \Delta<B_{\rm FCRT}<B_{\rm SCRT}<B_{\rm PBT}.          \tag{5.9}
\]

This one point proves simultaneously that reuse can improve `SCRT-0`, the
proper-face cap can be active, and the capped model can still remain strictly
above the scalar defect.  It does not show that the gap is unbounded on the
uniform scale required to separate `FCRT-1` logically from \(abc\).

## 6. Endpoint residue cube

The divisibility flags admit a group-theoretic encoding.  Fix a source face
\(S\subseteq I\) and define

\[
             G_S=\prod_{p\in S}(\mathbb Z/p^{e_p}\mathbb Z)^\times.
                                                                  \tag{6.1}
\]

For any integer \(n\) coprime to \(m(S)\), write

\[
 \overline n_S=
 \bigl(n\bmod p^{e_p}\bigr)_{p\in S}\in G_S              \tag{6.1a}
\]

for its diagonal system of unit residue classes.  In particular,
\(\overline{-1}_S\) is the tuple whose every coordinate is the residue class
of \(-1\).  For \(q\in J\), define \(g_{S,q}\in G_S\) by

\[
 g_{S,q}=\begin{cases}
 \overline{q^{v_q(a)}}_S,&q\mid a,\\
 \overline{q^{v_q(b)}}_S^{-1},&q\mid b.
 \end{cases}                                            \tag{6.2}
\]

All coordinates are units because \(\gcd(ab,c)=1\).  Define the Boolean-cube
map

\[
 \Phi_S:2^J\longrightarrow G_S,\qquad
 \Phi_S(T)=\prod_{q\in T}g_{S,q}.                       \tag{6.3}
\]

### Proposition 6.1 (fixed-fibre description)

For every \(T\subseteq J\),

\[
 \Phi_S(T)=\overline{a_T}_S\,\overline{b_T}_S^{-1},\qquad
 \Phi_S(J)=\overline{-1}_S,                             \tag{6.4}
\]

and the following are equivalent:

\[
 m(S)\mid a_T+b_T
 \quad\Longleftrightarrow\quad
 \Phi_S(T)=\overline{-1}_S
 \quad\Longleftrightarrow\quad
 \Phi_S(J\setminus T)=1.                               \tag{6.5}
\]

### Proof

The first identity follows by separating the primes of \(T\) between the two
coprime arms.  At every coordinate \(p^{e_p}\), the full product is the
residue class of \(ab^{-1}\).  Since
\(a+b=c\equiv0\pmod{p^{e_p}}\), this equals the residue class of \(-1\),
proving the second identity.  As \(b_T\) is a unit modulo every source
modulus, \(a_T+b_T\equiv0\) is equivalent in \(G_S\) to
\(\overline{a_T}_S\overline{b_T}_S^{-1}=\overline{-1}_S\).  Finally,

\[
 \Phi_S(T)\Phi_S(J\setminus T)=\Phi_S(J)=\overline{-1}_S,
\]

so cancellation gives the last equivalence.  QED.

For \(S'\subseteq S\), coordinate projection
\(\pi_{S,S'}:G_S\to G_{S'}\) satisfies

\[
                         \pi_{S,S'}\circ\Phi_S=\Phi_{S'}. \tag{6.6}
\]

Thus the source faces and their residue cubes form a finite inverse system.
For an actual flag, however, the block source \(S_\nu\) and the residual
target \(p\) are disjoint.  The large packet lies in
\(\Phi_{S_\nu}^{-1}(\overline{-1}_{S_\nu})\), while its proper face lies in
\(\Phi_{\{p\}}^{-1}(\overline{-1}_{\{p\}})\).  Both statements can be
compared through the two
coordinate projections from \(G_{S_\nu\cup\{p\}}\), but neither packet is
required to lie in the \(-1\)-fibre for the union source.  A flag is therefore
a cross-fibre incidence, not a fibre inclusion under (6.6).  This distinction
is essential: Proposition 7.1 below controls exchanges in one fixed source
fibre and does not yet control the cross-source flag.

## 7. Signed residue lattice and packet exchanges

Let

\[
 \Lambda_S=\left\{z\in\mathbb Z^J:
               \prod_{q\in J}g_{S,q}^{z_q}=1\right\}.   \tag{7.1}
\]

### Proposition 7.1 (compatible-packet exchange)

If \(T,T'\subseteq J\) are both compatible with the same source face \(S\),
then

\[
 \prod_{q\in T'\setminus T}g_{S,q}
     =\prod_{q\in T\setminus T'}g_{S,q},                \tag{7.2}
\]

and

\[
 y(T')-y(T)=y(T'\setminus T)-y(T\setminus T').          \tag{7.3}
\]

If \(T\ne T'\), define
\(z=\mathbf 1_{T'}-\mathbf 1_T\), so \(z_q=1\) on
\(T'\setminus T\), \(z_q=-1\) on \(T\setminus T'\), and \(z_q=0\)
elsewhere.  Then \(z\) is a nonzero vector of
\(\Lambda_S\cap\{-1,0,1\}^J\).

### Proof

Both packet products equal \(\overline{-1}_S\) by Proposition 6.1.  Factor each product
over \(T\cap T'\) and its disjoint remainder, then cancel the common factor;
this gives (7.2).  The same disjoint decompositions for the real weight sums
give (7.3).  Distinctness makes the resulting signed vector nonzero, and
(7.2) is exactly its membership in (7.1).  QED.

### Proposition 7.2 (Boolean collision criterion)

If

\[
                         2^{|J|}>|G_S|,                  \tag{7.4}
\]

then there are distinct packets \(T,T'\) for which
\(\mathbf 1_{T'}-\mathbf 1_T\) is a nonzero
\(\{-1,0,1\}\)-relation in \(\Lambda_S\).

### Proof

There are \(2^{|J|}\) packets and at most \(|G_S|\) labels.  Pigeonhole gives
distinct \(T,T'\) with equal image under \(\Phi_S\); cancel their common
intersection exactly as in
Proposition 7.1.  QED.

This criterion alone has no control over the sign of (7.3), the size of the
weight change, or the location of a collision inside the compatible
\(-1\)-fibre.  It is therefore not a proof of `FCRT-1` or `SCRT-0`.

## 8. Fourier and anchored-fibre bottlenecks

For a finite abelian group \(G_S\), \(g\in G_S\), and \(t\in\mathbb R\),
character orthogonality over the complex characters
\(\widehat G_S=\operatorname{Hom}(G_S,S^1)\) gives the weighted fibre
enumerator

\[
 \sum_{\Phi_S(T)=g}e^{t y(T)}
 =\frac1{|G_S|}\sum_{\chi\in\widehat G_S}
   \overline{\chi(g)}\prod_{q\in J}
   \left(1+e^{t y_q}\chi(g_{S,q})\right).               \tag{8.1}
\]

Since \(e^{t y_q}=q^t\), a nontrivial-character estimate in (8.1) would give
information about the distribution of logarithmic packet weights inside a
fixed congruence fibre.  FCRT needs more than separate estimates on individual
fibres: it needs a joint nested-pair estimate for
\(T\in\Phi_S^{-1}(\overline{-1}_S)\) and
\(U\subsetneq T\) with
\(U\in\Phi_{\{p\}}^{-1}(\overline{-1}_{\{p\}})\), followed by disjointness
across several blocks.  The missing result is a uniform bound with all of
these correlations.  Character orthogonality by itself supplies no such
cancellation.

A relevant new combinatorial input is Ji Ho Bae's revised paper on Erdős
Problem 684, arXiv:2604.23784v3 (revised 2026-09-03).  Its Lemma 5.1 proves
that a map \(\Phi:\{0,\ldots,J\}\to\Omega\), with \(|\Omega|\le C\), has two
equal-code points whose positive difference avoids a forbidden set
\(\mathcal F\), provided
\(J+1>C(|\mathcal F|+1)\).  The proof combines this anchored-fibre selection
with product-cell coding, truncated CRT, and an exponential high-power tail
estimate to obtain an unconditional theorem for that problem.  The source
also records a Lean verification and explicitly withdraws the unjustified
weighted argument in its earlier versions:
[arXiv abstract](https://arxiv.org/abs/2604.23784v3),
[full text](https://arxiv.org/html/2604.23784v3),
[formalization](https://github.com/jidodat/erdos684-lean).

The companion anchored-prefix analysis now gives an exact conditional bridge.
Let a jointly compatible block packet \(T\) have block source \(S\) and
residual target \(p\), and choose a nonempty ordered reservoir
\(K=(q_1,\ldots,q_m)\subseteq T\).  Put

\[
 H=\langle g_{p,q}:q\in K\rangle,\qquad
 W=y(K),\qquad N=\lceil W/L\rceil.
\]

If \(L>0\), \(\mathcal F\subseteq\{1,\ldots,m\}\), and

\[
 m+1>|H|N(|\mathcal F|+1),                              \tag{8.2}
\]

then coding each prefix by its target residue and logarithmic weight cell,
followed by Bae's lemma, gives a nonempty consecutive deletion
\(D\subseteq K\) with

\[
 \Phi_{\{p\}}(D)=1,qquad y(D)\le L,qquad |D|\notin\mathcal F.
\]

Thus \(U=T\setminus D\) is a nonempty proper target-compatible face and

\[
 \rho\ge
 \min\{y(T)-x(S),\,y(T)-L\}.                            \tag{8.3}
\]

When \(L\le x(S)\), the entire block surplus is reusable.  With \(T=J\) and
\(S=I\setminus\{p\}\), the resulting finite boundary is exactly
\((X-Y)_+\).  The ordinary proof and its finite Lean kernel are recorded in
[the anchored-prefix note](ABC_ANCHORED_PREFIX_FLAGGED_CRT_2026_09_04.md).
The unresolved arithmetic problem is to force (8.2) uniformly with useful
\(L\) and a sufficiently small forbidden set; Bae's application has separate
long-interval and tail estimates that endpoint packets do not yet possess.

Raw Boolean counting cannot replace this ordered condition.  At

\[
 (a,b,c)=(1,4715,4716),\quad
 4715=5\cdot23\cdot41,\quad4716=2^2\cdot3^2\cdot131,
\]

take \(p=3\).  Although \(2^{|J|}=8>|G_p|=\varphi(9)=6\), every target
generator is \(2\pmod9\).  Nonempty proper packets have one or two elements,
so their labels are \(2\) or \(4\), never \(-1=8\pmod9\).  The full block
with source \(\{2\}\) is compatible and saturated, but it has no proper
target-\(3\) flag.  This complete-premise counterexample retires only the
shortcut
\(2^{|J|}>|G_p|\Rightarrow\) ``a proper compatible target face exists.''
It does not refute (8.2), FCRT-1, SCRT-0, the parent residue-cube route, or
standard \(abc\).

Andrej Dujella's 2026-09-03 paper proves a uniform gap principle for reduced
\(D(\pm p^r)\)-tuples using an explicit toric elimination certificate valid
modulo prime powers.  Its hypotheses concern pairwise square conditions and
do not directly imply the packet-fibre estimate required here:
[arXiv:2609.03448](https://arxiv.org/abs/2609.03448).

The titles and abstracts of all 44 entries displayed on the official
`math.NT` new-listing page for Friday, 2026-09-04 were checked.  No displayed
entry claimed an unconditional proof or disproof of standard \(abc\), or a
theorem with the complete hypotheses of `FCRT-1` or `SCRT-0`.  The audit scope
is frozen in the
[44-entry title snapshot](literature/2026_09_04_mathNT_new_44_entries.tsv);
the source page itself is dynamic:
[arXiv math.NT new submissions](https://arxiv.org/list/math.NT/new).

## 9. Reproducible exact computation

The exact producer and an independent validator are frozen in
`research/computation/2026_09_04_shared_crt_exact/`.  They use integer
factorizations and rational multiplicative residuals; floating logarithms are
display fields only.  The exhaustive normalized domain

\[
 1\le a\le b,\qquad a+b=c,\qquad\gcd(a,b)=1,\qquad c\le3000
\]

contains 1,368,094 triples.  Three proved easy-stratum identities settle all
but six points in this domain: if \(I=\varnothing\), all three boundaries
vanish; if \(X\le Y\), the full block is saturated and the SCRT and FCRT
optima equal the scalar value zero (the indivisible PBT optimum need not
vanish); and if \(|I|=1\) with \(X>Y\), no block containing the sole source
can be saturated while assigning every sink to it gives all three boundaries
equal to \(X-Y\).  At the remaining six hard points, the producer exhaustively
enumerates reachable SCRT union states and FCRT block families, and optimizes
owners by an exact capped-state dynamic program.  The independent validator
instead recursively enumerates every disjoint block family and every residual
sink/reuse-token owner word.  The same two algorithms optimize the 154 fully
factored structured-family rows.  The validator does not import the producer
and also performs a deterministic byte replay of the complete output.

The exact forced comparisons are:

| point | \(e^\Delta\) | \(e^{B_{\rm FCRT}}\) | \(e^{B_{\rm SCRT}}\) | \(e^{B_{\rm PBT}}\) |
|---|---:|---:|---:|---:|
| \((1,675,676)\) | \(26/15\) | \(26/15\) | \(2\) | \(2\) |
| \((1,224,225)\) | \(15/14\) | \(3/2\) | \(3/2\) | \(3/2\) |
| \((343,625,968)\) | \(44/35\) | \(44/35\) | \(11/7\) | \(11/7\) |
| \((1,65024,65025)\) | \(255/254\) | \(3/2\) | \(3\) | \(15/2\) |

The last point is a forced out-of-range regression.  In the bounded domain,
five points have `SCRT-0` strictly above the scalar defect.  Capped FCRT
improves three of them to the scalar lower bound; the remaining fragmentation
points are \((1,224,225)\) and \((1,2303,2304)\).  The scan also includes 154
fully factored structured-family rows.  The validator reports `PASS` for the
full domain, all structured rows, 17 detailed certificates, and all four
forced comparisons.

The principal evidence is
[README](computation/2026_09_04_shared_crt_exact/README.md),
[exact output](computation/2026_09_04_shared_crt_exact/OUTPUT.json),
[independent validation log](computation/2026_09_04_shared_crt_exact/VALIDATION.log),
and [sealed checksums](computation/2026_09_04_shared_crt_exact/SHA256SUMS.txt).
The final `OUTPUT.json` SHA-256 is
`a454f05288a3e62fe64ae95ac7301e16d32c0bc2e9031f3aefaf569e51bf524c`.

This is finite exact evidence.  It neither proves a uniform estimate nor
provides an unbounded complete-premise counterfamily.  In particular, the
\(n=284\) member of \((2,15^n-2,15^n)\) is recorded only with the rigorous
fact \(v_{31}(15^{284}-2)=2\); its 335-digit external arm is not completely
factored, so no exact FCRT boundary is claimed.

## 10. Positive and adversarial programmes

The route remains active.  The next positive tasks are:

1. force the anchored entropy inequality (8.2) on actual endpoint reservoirs,
   with \(L\le x(S)\) or with a quantitatively useful partial credit;
2. prove a weighted fixed-fibre or zero-sum-radius bound, perhaps first when
   \(G_S\) is cyclic, the generated subgroup is proper, or \(S\) is a
   singleton;
3. replace pairwise-disjoint blocks by an explicitly signed chain only after
   proving a global once-charged identity;
4. connect the resulting packet exchange to the endpoint source demand
   without inserting the scalar defect as an assumption.

The adversarial tasks run in parallel:

1. exactly optimize `FCRT-1`, `SCRT-0`, and PBT on bounded primitive triples;
2. test prime-square, balanced two-prime, Pythagorean-square, Linnik-neighbour,
   smooth-neighbour, and mixed-power generalized-Fermat families;
3. seek an unbounded family that satisfies every FCRT premise and violates
   its quantified \(\varepsilon r+C_\varepsilon\) bound;
4. separately continue direct searches for standard \(abc\) counterexamples
   by tracking unbounded quality, never treating a large finite quality as a
   disproof.

The actual point \((1,4715,4716)\) has already eliminated the raw Boolean
cardinality shortcut to a proper face.  Future collision proposals must
exclude its incomparable same-label packets or add a premise that genuinely
forces a positive zero-sum deletion.

Only an exact complete-premise counterexample retires the corresponding
claim.  A bounded scan, a failed construction, or a missing estimate records
a bottleneck and leaves the parent route active.

## 11. Lean formalization and remaining boundary

The companion files are

* `Lean/IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904.lean`;
* `Lean/IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904AxiomAudit.lean`;
* `Lean/IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridge.lean`;
* `Lean/IUTThreeClosures/ABCFlaggedCRTSurplusResidueCube20260904IndependentBridgeAxiomAudit.lean`;
* `Lean/IUTThreeClosures/ABCAnchoredPrefixFlaggedCRT20260904.lean`;
* `Lean/IUTThreeClosures/ABCAnchoredPrefixFlaggedCRT20260904AxiomAudit.lean`.

The implementation formalizes the following unconditional results after the
ordinary proofs above.

1. The finite inclusion-maximal feasible-subset lemma and its residual-mass
   cancellation identity check the nontrivial numerical selection used in
   Proposition 2.1.  Lean also contains a separate aggregate-pooling optimum,
   but no typed free-target configuration or construction equating that
   aggregate model with every case of the model in Section 2 is claimed.
2. An explicit owner model proves that every residual sink and every reuse
   token is counted at most once even when several tokens meet at one source.
   The clipped residual discards overflow and cannot generate a second token.
3. The independent bridge caps raw owner credit by source demand, constructs
   the aggregate certificate, and proves that this conversion preserves the
   clipped boundary exactly; no aggregate-credit inequality is smuggled in.
4. Reuse credit is bounded both by block surplus and witness-face weight.  The
   resulting source-minus-sink mass bridge is kernel-checked.
5. An endpoint certificate gives the pointwise height bridge, and a separately
   supplied uniform arithmetic admissibility gate implies the unchanged
   `ABCConjecture`.  The gate has no inhabitant in the development.  The
   independent audit also constructs the tautological boundary
   \(\max\{h-r,0\}\), proving that bare existence of this deliberately weak
   certificate has no FCRT content; concrete admissibility and uniform
   smallness carry the mathematical burden.
6. The additive commutative-group abstraction of the residue cube (and hence
   its finite-group specialization), complement-fibre identity, packet
   decomposition, and same-fibre signed exchange are proved.  The
   multiplicative residue groups and Boolean collision count of Proposition
   7.2 are not yet formalized.
7. The integer factorizations, positive and negative proper-face congruences,
   cap comparisons, and logarithmic inequalities for
   \((1,675,676)\), \((1,224,225)\), and \((1,65024,65025)\) are checked.
8. The anchored module proves the finite code-fibre avoidance lemma, its
   residue-prefix and weight-cell consequence, the zero-deletion/proper-face
   dictionary, reuse-credit inequalities, and all eight Boolean packets in
   the \((1,4715,4716)\) counterexample to the raw count shortcut.

The primary module has 70 public declarations and 70 corresponding
`#print axioms` queries; the independent bridge has 18 declarations and 18
queries; the anchored module adds 28 declarations and 28 queries.  All six
files compile with warnings treated as errors; the audit union contains only
Lean's standard `propext`,
`Classical.choice`, and `Quot.sound`.  No `sorry`, `admit`, `unsafe`, or
`native_decide` escape is used.

The formal boundary remains important.  `ProperSubfaceFlag` is not yet
constructed from concrete endpoint unitary divisors, and the abstract owner
configuration does not encode block/source disjointness, residual-target
membership, or the identity between `witnessWeight` and the actual proper
face mass.  The independent bridge takes the endpoint decomposition
\(h-r=\text{sourceMass}-\text{sinkMass}\) as an explicit parameter.
Consequently no concrete arithmetic FCRT configuration is manufactured.  The
multiplicative residue-unit construction (6.1)--(6.5), the uniform gate
`FCRT-1`, the character-orthogonality identity (8.1), and especially the
nontrivial-character cancellation estimate that would have to follow it are
not postulated.  These are
explicit open obligations, not implicit axioms.

The anchored Lean theorem accepts a finite residue code, a finite weight-cell
code, and the implication that equal cells have weight diameter at most
\(L\).  It does not formalize the real-ceiling construction of those cells,
construct \(G_p\) for an arbitrary endpoint, or prove the uniform entropy
inequality (8.2).  These restrictions preserve the distinction between the
proved finite selection kernel and the open arithmetic input.
