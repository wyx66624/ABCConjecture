# Shared CRT-incidence boundary after exclusive prime packets

**Author:** ChatGPT

**Date:** 2026-09-03

**Status:** ordinary proof of a new conditional reduction.  The exact
uniform estimate `SCRT-0` is neither assumed nor proved, and no
complete-premise counterexample to it is known here.  Two nearby formulations
are eliminated below: duplicated shared capacity fails the pointwise height
bridge, while unrestricted partial sharing is exactly the scalar defect.  A
saturated-only formulation without the retained exclusive partial packets is
refuted by an explicit infinite family.  None of these results proves or
disproves the standard abc conjecture.

## 1. Design constraint left by the Linnik obstruction

The exclusive packet gate treated every external radical prime as an
indivisible object owned by at most one endpoint source.  That rule is false
for arithmetic reasons.  In the Linnik family

\[
 P_k=(1,\ell_k,\ell_k+1),\qquad
 \ell_k\equiv-1\pmod {M_k^2},
\]

the sole external prime `ell_k` records, at the same time, the congruences

\[
 \ell_k\equiv-1\pmod {p_i^2}\qquad(p_i\mid M_k).
\]

It must therefore be possible for one external prime to occur in a joint
incidence certificate for many endpoint prime powers.  Its logarithmic
capacity may nevertheless be charged only once.  Repeating `log ell_k` once
for every incidence destroys the elementary mass inequality from which the
height bridge is obtained.

There is a second constraint.  If an arbitrary joint relation may distribute
its capacity partially among arbitrary endpoint sources, then the full
relation `a+b=c` is always available and the optimization becomes exactly
the positive scalar abc defect.  The construction below separates complete
CRT closure from partial transport:

* a compatible hyperedge may serve many sources when its once-charged sink
  capacity closes every source in that hyperedge;
* sinks outside those closed hyperedges retain the old one-owner rule, so
  several sinks may partially fill one source but one sink cannot be split
  among several sources.

This is the first shared-incidence candidate `SCRT-0`.  Its all-or-nothing
condition concerns only genuinely shared hyperedges.  Partial filling of a
single source is retained and is essential.

## 2. Endpoint masses and truncated arm factors

Let

\[
 P=(a,b,c),\qquad a+b=c,qquad
 \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1
\]

be a positive primitive abc point.  Write `e_p=v_p(c)`.  Its endpoint source
set and external sink set are

\[
 I(P)=\{p:p\mid c,\ e_p\ge2\},\qquad
 J(P)=\{q:q\mid ab\}.
\]

The weights are

\[
 x_p=(e_p-1)\log p\quad(p\in I(P)),\qquad
 y_q=\log q\quad(q\in J(P)).                         \tag{2.1}
\]

Set

\[
 X=\sum_{p\in I(P)}x_p=\log\operatorname{core}(c),
 \qquad
 Y=\sum_{q\in J(P)}y_q=\log\operatorname{rad}(ab).   \tag{2.2}
\]

For a source subset `S` and a sink subset `T`, define

\[
 \begin{aligned}
 m(S)&=\prod_{p\in S}p^{e_p},\\
 a_T&=\prod_{\substack{q\in T\\q\mid a}}q^{v_q(a)},
 &
 b_T&=\prod_{\substack{q\in T\\q\mid b}}q^{v_q(b)},\\
 x(S)&=\sum_{p\in S}x_p,
 &
 y(T)&=\sum_{q\in T}y_q.
 \end{aligned}                                             \tag{2.3}
\]

Empty products are one.  Thus `a_T` and `b_T` are actual unitary divisors of
the two arms: every selected external prime occurs with its complete
valuation on its arm.

### Definition 2.1 (shared CRT block)

A pair `(S,T)` of nonempty subsets is **CRT compatible** when

\[
                         m(S)\mid a_T+b_T.                    \tag{2.4}
\]

It is **saturated** when, in addition,

\[
                         x(S)\le y(T).                        \tag{2.5}
\]

Condition (2.4) says that the same truncated two-arm relation certifies all
the prime-power congruences indexed by `S`.  Condition (2.5) is exactly the
once-charged capacity condition: the union `T` supplies `y(T)` once, not once
for each member of `S`.

When `I(P)` is nonempty, one has `c>=4`; hence the positive summands `a,b`
cannot both be one and `J(P)` is nonempty as well.  The full pair is then a
legal compatible block.  Indeed, for `S=I(P)` and `T=J(P)`, one has
`a_T=a`, `b_T=b`, and `m(S)|c=a+b`.  It is saturated precisely when `X<=Y`.
If `I(P)` is empty, there is no source boundary to cover.

## 3. SCRT-0 configurations

### Definition 3.1 (configuration and boundary)

An `SCRT-0` configuration consists of the following data.

1. A finite family of saturated shared CRT blocks `(S_nu,T_nu)` whose source
   sets are pairwise disjoint and whose sink sets are pairwise disjoint.
2. Write

   \[
   I_0=I(P)\setminus\bigcup_\nu S_\nu,
   \qquad
   J_0=J(P)\setminus\bigcup_\nu T_\nu.
   \]

   An exclusive assignment

   \[
                         o:J_0\longrightarrow I_0\sqcup\{\varnothing\}.
                                                               \tag{3.1}
   \]

   A sink outside the shared blocks is unused or belongs to one source, but
   any number of different sinks may belong to the same source.

For `p in I_0`, put

\[
 M_p(o)=\sum_{o(q)=p}y_q,
 \qquad
 R_p(o)=\max\{x_p-M_p(o),0\}.                       \tag{3.2}
\]

Sources in a saturated block have zero boundary.  The configuration boundary
is

\[
                    B(\mathcal H,o)=\sum_{p\in I_0}R_p(o).     \tag{3.3}
\]

The empty block family and the total assignment sending every residual sink
to `unused` are always allowed, so the configuration space is nonempty and
contains a boundary of size `X`.  Since all underlying sets are finite, the
minimum

\[
                    B_{\rm SCRT}(P)=\min_{(\mathcal H,o)}
                    B(\mathcal H,o)                            \tag{3.4}
\]

exists.

The disjointness in Definition 3.1 is bookkeeping with mathematical force.
If a prime `q` belongs to one `T_nu`, then `log q` occurs in exactly that
block's capacity and nowhere else.  If it remains in `J_0`, it occurs in at
most one packet mass `M_p(o)`.  There is no duplicated sink capacity.

The present model consumes all of `y(T_nu)` when a saturated block is chosen,
including any surplus above `x(S_nu)`.  This is a deliberate first-design
rule, not a consequence of CRT.  A later refinement may reuse surplus through
a proved fractional-cover or signed-chain identity, but it must preserve
once-only global charging and must not silently admit the unrestricted full
partial pooling eliminated in Section 4.2.

### Proposition 3.2 (once-charged mass inequality)

Every `SCRT-0` configuration satisfies

\[
                              X\le Y+B(\mathcal H,o).          \tag{3.5}
\]

### Proof

For each saturated block,

\[
                         x(S_\nu)\le y(T_\nu).
\]

The source and sink sets of the blocks are separately disjoint, so summing
does not repeat either mass.  For every remaining source, (3.2) gives

\[
                         x_p\le M_p(o)+R_p(o).
\]

The exclusive assignment makes the packet masses disjoint, hence

\[
                         \sum_{p\in I_0}M_p(o)\le y(J_0).
\]

Adding these three inequalities yields

\[
 \begin{aligned}
 X
 &=\sum_\nu x(S_\nu)+\sum_{p\in I_0}x_p\\
 &\le\sum_\nu y(T_\nu)+y(J_0)+B(\mathcal H,o)\\
 &=Y+B(\mathcal H,o).
 \end{aligned}
\]

QED.

### Proposition 3.3 (pointwise height bridge)

Every `SCRT-0` configuration satisfies

\[
                   h(P)\le r(P)+B(\mathcal H,o),              \tag{3.6}
\]

where

\[
 h(P)=\log c,
 \qquad
 r(P)=\log\operatorname{rad}(abc).
\]

### Proof

Prime factorization and pairwise coprimality give

\[
 c=\operatorname{rad}(c)\operatorname{core}(c),
 \qquad
 \operatorname{rad}(abc)
 =\operatorname{rad}(ab)\operatorname{rad}(c).
\]

Consequently

\[
                         h(P)-r(P)=X-Y.                        \tag{3.7}
\]

Apply Proposition 3.2.  QED.

Let `B_PBT(P)` denote the minimum residual in the earlier exclusive
prime-packet problem, with no shared blocks.  Restricting that optimization
to the positive-weight sources `I(P)` does not change its value: any sink
assigned to a zero-weight source can instead be declared unused without
altering a positive residual.

### Proposition 3.4 (exact sandwich and easy strata)

For every positive primitive point,

\[
 \Delta(P):=\max\{X-Y,0\}
 \le B_{\rm SCRT}(P)\le B_{\rm PBT}(P).                       \tag{3.8}
\]

Moreover:

1. if `X<=Y`, then `B_SCRT(P)=0=Delta(P)`;
2. if `I(P)` has at most one member, then

   \[
                         B_{\rm SCRT}(P)=\Delta(P).           \tag{3.9}
   \]

Hence an additional shared-CRT gap beyond the scalar defect can occur only
when `X>Y` and at least two endpoint primes have positive excess weight.

### Proof

Every configuration boundary is nonnegative, and Proposition 3.2 gives
`X-Y<=B`.  Taking the minimum proves the left inequality in (3.8).  The
empty shared-block family leaves precisely the old exclusive assignment
problem, so minimizing over the larger SCRT-0 configuration space proves the
right inequality.

If `X<=Y` and there is a source, the always-compatible full block is
saturated.  It covers every source, has boundary zero, and the left side of
(3.8) is also zero.  If there are no sources the same conclusion is
immediate.  If there is one source,
use the empty shared-block family and assign every sink to that source.  Its
residual is `max(X-Y,0)`, which attains the lower bound in (3.8).  QED.

### Definition 3.5 (uniform SCRT-0 gate)

`SCRT-0` is the statement

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\ \forall P\
 \exists(\mathcal H,o):
 B(\mathcal H,o)\le\varepsilon r(P)+C_\varepsilon.           \tag{SCRT-0}
\]

### Theorem 3.6 (conditional implication)

`SCRT-0` implies the standard logarithmic abc conjecture.

### Proof

Choose the configuration supplied by `SCRT-0` and substitute its boundary
bound into (3.6):

\[
 h(P)\le r(P)+B(\mathcal H,o)
       \le(1+\varepsilon)r(P)+C_\varepsilon.
\]

No instance of `SCRT-0` is assumed in this report.  QED.

## 4. The two forbidden relaxations

### 4.1 Duplicating shared capacity breaks the bridge

Suppose a shared sink union of weight `y(T)` were allowed to contribute that
entire quantity independently to every incident source.  The proof of
Proposition 3.2 would then be false: total credited source mass could exceed
the once-charged sink mass.

There is an actual abc witness, not just an abstract two-bin example.  Take

\[
                         P=(1,224,225).
\]

Here

\[
 225=3^2 5^2,\qquad 224=2^5\cdot7,
\]

so the source masses are `log 3` and `log 5`, while the full external sink
mass is `log 14`.  The full relation `1+224=225` is compatible with both
endpoint prime powers.  If `log 14` were separately available to each source,
both would be declared covered and the reported boundary would be zero.
But

\[
 h(P)-r(P)=\log15-\log14=\log(15/14)>0.                       \tag{4.1}
\]

Thus the claimed height bridge would read a positive number as at most zero.
This complete-premise example eliminates repeated-per-incidence capacity.
SCRT-0 instead permits at most `log 14` total credit from this sink union.

### 4.2 Unrestricted partial sharing is exactly scalar

Consider the opposite relaxation.  Keep once-only charging, but let every
compatible block distribute arbitrary partial credits `z_p>=0` satisfying

\[
 z_p\le x_p,
 \qquad
                         \sum_{p\in S}z_p\le y(T).             \tag{4.2}
\]

Do not require all sources in a genuinely shared block to close.  Apply this
rule to the always-compatible full block `S=I(P), T=J(P)`.  It can deliver
any total credit up to `min(X,Y)`, distributed among the finite source bins.
Its least boundary is therefore

\[
 X-\min(X,Y)=\max(X-Y,0).                                    \tag{4.3}
\]

Conversely, once-only sink capacity makes every boundary at least
`max(X-Y,0)` by the same mass calculation as Proposition 3.2.  Hence (4.3)
is the exact global optimum of unrestricted partial sharing.

By (3.7), this is

\[
                         \max\{h(P)-r(P),0\}.
\]

The corresponding uniform gate is just the standard abc conjecture in new
notation (in the reverse implication one may replace an abc additive constant
by its maximum with zero before taking positive parts).  This is why SCRT-0
allows a multi-source CRT block to share only
when all sources listed by that block are saturated.  Partial transport has
not been deleted: it remains available through the exclusive one-owner
packets (3.1), where it cannot duplicate one sink across several sources.

## 5. A strict arithmetic noncollapse witness

The saturated rule does not reduce pointwise to the two totals `X,Y`.  Take

\[
                         P_*=(343,625,968).
\]

The premises are exact:

\[
 343+625=968,\qquad
 343=7^3,\quad625=5^4,\quad968=2^3\cdot11^2,
\]

and the three coordinates are pairwise coprime.  The source and sink data are

\[
 \{x_2,x_{11}\}=\{\log4,\log11\},\qquad
 \{y_5,y_7\}=\{\log5,\log7\}.                               \tag{5.1}
\]

Thus

\[
 X=\log44>\log35=Y,
 \qquad
 \Delta:=\max(X-Y,0)=\log(44/35).                            \tag{5.2}
\]

No shared block can saturate both sources, since even the complete sink set
has mass `log 35 < log 44`.  A block that saturates the source at `11` must
use both sinks because each of `log 5,log 7` is smaller than `log 11`; it
then leaves boundary `log 4` at the other source.  A block that saturates the
source at `2` cannot improve on assigning one sink exclusively to that
source.  For reference, the nontrivial proper congruence is

\[
                         8\mid343+1,
\]

coming from `S={2},T={7}`; it consumes the `7` sink and leaves at least
`log(11/5)` at the other source.

It remains to enumerate the exclusive assignments of the two sinks.  Giving
`5` to the source `2` and `7` to the source `11` yields

\[
 B=0+\bigl(\log11-\log7\bigr)=\log(11/7).                    \tag{5.3}
\]

The reverse split gives `log(11/5)`.  Giving both sinks to the source `11`
leaves `log 4`; giving both to the source `2` leaves `log 11`; unused-sink
cases are no better.  The preceding shared-block discussion exhausts the
additional possibilities.  Therefore

\[
                         B_{\rm SCRT}(P_*)=\log(11/7).         \tag{5.4}
\]

Finally

\[
 {11\over7}>{44\over35}
\]

because `385>308`.  Equations (5.2)--(5.4) prove

\[
 B_{\rm SCRT}(P_*)>\max\{h(P_*)-r(P_*),0\}.                  \tag{5.5}
\]

This is an actual arithmetic, strict noncollapse certificate.  It also
shows the limitation honestly: SCRT-0 is a stronger uniform problem than abc,
and its uniform estimate remains to be proved or refuted.

## 6. Audit against the recorded infinite families

### 6.1 Prime-square neighbours `(1,p^2-1,p^2)`

There is only one endpoint source, of weight `log p`.  Shared splitting is
irrelevant.  Assign every external sink to that one source.  The boundary is

\[
 \max\{\log p-\log\operatorname{rad}(p^2-1),0\}
 =\max(X-Y,0).                                                \tag{6.1}
\]

Thus the hard-order obstruction to CT-3C and the per-edge drop obstruction to
BEP create no extra SCRT-0 loss.  This does not prove that (6.1) is uniformly
small; it proves that this family produces only the genuine scalar abc
defect, with no new transport penalty.

### 6.2 Prime-hypotenuse Pythagorean squares

Let `p=m^2+n^2` be prime, put

\[
 X_0=m^2-n^2,\qquad Y_0=2mn,
\]

and consider `(X_0^2,Y_0^2,p^2)`.  Again the endpoint has one source, of
weight `log p`.  All primes of `X_0Y_0` may be assigned exclusively to it,
so

\[
 B_{\rm SCRT}
 =\max\{\log p-\log\operatorname{rad}(X_0Y_0),0\}.           \tag{6.2}
\]

The facts that every external prime is smaller than the source and that every
individual relative drop is bounded below do not enter (6.2).  Hence the
complete counterexample to BEP does not refute SCRT-0.

### 6.3 The Linnik primorial-square neighbour family

Let `M_k` be the product of the first `k` primes and let

\[
 \ell_k\equiv-1\pmod {M_k^2}
\]

be the prime supplied by Linnik's theorem.  At

\[
                         P_k=(1,\ell_k,\ell_k+1),
\]

take `S=I(P_k)` and the singleton `T={ell_k}`.  The block is CRT compatible
because `m(S)|ell_k+1`.  It is saturated as well.  The prime `ell_k` is odd,
so `ell_k+1` is even and

\[
 \operatorname{core}(\ell_k+1)
 \le{\ell_k+1\over2}\le\ell_k.
\]

Therefore

\[
                         x(S)=X\le\log\ell_k=y(T).             \tag{6.3}
\]

One shared block closes every forced endpoint source while charging
`log ell_k` exactly once.  Its SCRT-0 boundary is zero.  This directly repairs
the complete-premise counterexample to exclusive PBT.

The same audit works for the shifted Linnik class suggested by the
adversarial review.  Let `M_k` be a product of odd primes and choose

\[
 \ell_k\equiv-2\pmod {M_k^2},\qquad
                         P_k'=(2,\ell_k,\ell_k+2).
\]

The full sink set is `T={2,ell_k}` and its truncated arm relation is the
actual identity `2+ell_k=ell_k+2`, so it is compatible with every forced
source.  Since `rad(ell_k+2)>=3`,

\[
 \operatorname{core}(\ell_k+2)
 \le{\ell_k+2\over3}\le\ell_k<2\ell_k.
\]

Thus `X<Y=log(2ell_k)`, and the full block is saturated.  The two sinks are
charged once as the union `T`; they are not charged once for every prime in
`M_k`.

### 6.4 Fixed-base powers

For the recorded fixed-prime family

\[
                         (1,p^N-1,p^N),
\]

there is one endpoint source.  Assigning every external sink to it gives

\[
 B_{\rm SCRT}
 =\max\{(N-1)\log p-\log\operatorname{rad}(p^N-1),0\},       \tag{6.4}
\]

again exactly the scalar defect.

More generally, for a fixed composite base `A`, the full block at
`(1,A^N-1,A^N)` is compatible.  It closes all sources whenever `X<=Y`; if
`X>Y`, several endpoint source bins may compete for the distinct prime sinks
of `A^N-1`.  No theorem recorded in the repository supplies an infinite
complete-premise fragmentation lower bound for those prime-log weights.
Accordingly the composite-base case is a live adversarial test, not a reason
to discard SCRT-0.  Proving either a suitable partition theorem or a complete
counterexample is a concrete next obligation.

### 6.5 The balanced two-prime family

For

\[
                         (4^r,3^r,4^r+3^r),                  \tag{6.5}
\]

the external sink set is exactly `{2,3}` and has total mass `log 6`.  Put

\[
 c_r=4^r+3^r,
 \qquad X_r=\log\operatorname{core}(c_r).
\]

The full block is compatible and is saturated whenever `X_r<=log 6`.  If
there is only one positive endpoint source, assigning both sinks to it gives
the exact scalar residual `max(X_r-log 6,0)`.  A new SCRT-0 obstruction could
therefore arise only along an infinite subsequence with several powerful
endpoint primes and a quantitatively bad two-bin partition or absence of
saturated proper CRT blocks.

The earlier VIC-1R obstruction for (6.5) proves that the **powerful input
arms** at `2` and `3` force a large selected-face defect.  It does not prove
that the endpoint `c_r` has several powerful prime divisors, nor does it prove
the required SCRT-0 fragmentation lower bound.  Thus all premises of an
SCRT-0 counterexample have not been established.  The family remains an
active test.

## 7. A refuted child model and why SCRT-0 survives its counterfamily

It is tempting to delete the exclusive assignment (3.1) and allow only
fully saturated shared blocks.  Call that harder child model `SCRT-SAT`.
Its uniform gate inherits exactly the quantifier order of SCRT-0,

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\ \forall P\
 \exists\mathcal H:
 B_{\rm SAT}(\mathcal H)\le\varepsilon r(P)+C_\varepsilon,
\]

but it has no exclusive stage and every source outside the saturated blocks
contributes its full weight.  This gate is false for an unconditional
elementary family.

Let

\[
 n=284+310t,\qquad
                         P_n=(2,15^n-2,15^n),\qquad t\ge0.    \tag{7.1}
\]

Direct modular exponentiation gives

\[
 15^{284}\equiv2\pmod {31^2},
 \qquad
 15^{310}\equiv1\pmod {31^2}.                               \tag{7.2}
\]

For reproducibility, successive squaring modulo `961` gives

\[
\begin{array}{c|rrrrrrrrr}
j&0&1&2&3&4&5&6&7&8\\ \hline
15^{2^j}\bmod961&15&225&653&686&667&907&33&128&47.
\end{array}
\]

Multiplying the entries for `284=256+16+8+4` gives `2`, while multiplying
those for `310=256+32+16+4+2` gives `1`.  Hence

\[
                         31^2\mid15^n-2.                      \tag{7.3}
\]

The point (7.1) is positive and primitive: `15^n` is odd,
`gcd(15^n-2,15^n)=gcd(2,15^n)=1`, and the other pairwise gcds are immediate.
Its two endpoint source weights are

\[
                         (n-1)\log3,\qquad(n-1)\log5,        \tag{7.4}
\]

so `X=(n-1)log15=log(15^n/15)`.  From (7.3),

\[
 \operatorname{rad}(15^n-2)\le{15^n-2\over31}.
\]

Consequently

\[
 Y=\log\bigl(2\operatorname{rad}(15^n-2)\bigr)
 <\log{2\cdot15^n\over31}
 <\log{15^n\over15}=X,                                     \tag{7.5}
\]

where the last strict inequality is `30<31`.

Precisely, `SCRT-SAT` has no exclusive stage at all: every source not lying
in a saturated shared block contributes its complete weight `x_p` to the
boundary.  In this model, disjoint once-charged sink unions cannot fully close
both sources because their total mass is smaller than `X`.  At least one
complete source must remain, so the boundary is at least

\[
                         (n-1)\log3.                          \tag{7.6}
\]

Also

\[
 r(P_n)=\log\bigl(30\operatorname{rad}(15^n-2)\bigr)
 <\log15^n=n\log15.                                         \tag{7.7}
\]

Taking any fixed

\[
                         0<\varepsilon<\frac{\log3}{\log15},
\]

equations (7.6)--(7.7) contradict a uniform `epsilon r+C` bound as `t` tends
to infinity.  This is a
complete-premise counterexample, so `SCRT-SAT` is retired.

It does **not** refute SCRT-0.  In SCRT-0, every distinct prime divisor of
`15^n-2` which is not used by a saturated block may be assigned exclusively
to either source, and several such primes may fill the same source.  Equation
(7.5) gives only the universal lower bound

\[
                         B_{\rm SCRT}(P_n)\ge X-Y
                         >\log(31/30),                        \tag{7.8}
\]

which is constant, not linear in `n`.  To turn (7.1) into an SCRT-0
counterexample one would need a new theorem showing that the prime-log
weights of `(15^n-2)/31^2` cannot be partitioned between the two demands in
(7.4), even after all compatible saturated proper blocks are included.
Neither (7.2) nor the radical bound proves that statement.

Notice also that (7.3) gives

\[
 \operatorname{rad}(2(15^n-2)15^n)
 =30\operatorname{rad}(15^n-2)<15^n.
\]

The resulting scalar defect is bounded below by the fixed number
`log(31/30)`.  This is not an abc counterexample: abc permits an additive
constant, and no unbounded quality or unbounded scalar defect has been
proved.

## 8. What remains open

The exact surviving question is now neither an ordered matching problem nor
an unrestricted flow problem.  It is a finite arithmetic hypergraph problem:

* vertices on the source side are repeated endpoint prime powers;
* a sink hyperedge is labelled by an actual truncated two-arm congruence;
* the union of its radical primes is charged once;
* a genuinely shared hyperedge must close all source boundary it claims;
* unused sink primes may still form exclusive partial packets.

The first proof obligations are concrete.

1. Compute `B_SCRT(P)` exactly on bounded primitive triples by enumerating
   unitary-divisor CRT blocks and then solving the residual finite assignment
   problem.  A second independent optimizer should replay every optimum.
2. Resolve the prime-log partition problem exposed by `(2,15^n-2,15^n)`.
   A counterexample satisfying every SCRT-0 premise would retire this exact
   gate, while a distribution theorem could remove its sharpest current
   stress test.
3. Audit mixed-power generalized Fermat points.  The strict witness
   `(7^3,5^4,2^3 11^2)` shows where SCRT-0 adds information beyond the scalar
   defect; finiteness and uniformity on such mixed signatures are therefore
   directly relevant.
4. If overlapping CRT blocks become necessary, replace disjointness only
   with a proved fractional-cover or signed-chain inequality that preserves
   the once-charged mass bound.  Repeating a sink's full logarithm per
   incidence is already ruled out by (4.1).

Difficulty in these tasks is not evidence against the parent shared-CRT or
incidence route.  SCRT-0 remains active until its exact quantified gate is
proved or a complete-premise counterexample is obtained.  Its uniform bound
is not asserted here, and the standard abc conjecture remains open.

## 9. Lean formalization boundary

The companion files are

* `Lean/IUTThreeClosures/ABCSharedCRTIncidenceSuccessor20260903.lean`;
* `Lean/IUTThreeClosures/ABCSharedCRTIncidenceSuccessor20260903AxiomAudit.lean`.

They formalize the abstract finite once-charged certificate, nonnegative
boundary, the inequality `sourceMass-sinkMass <= boundary`, the exact endpoint
source and sink identities, the pointwise height bridge, and the conditional
implication from any explicitly supplied arithmetic admissibility predicate's
uniform boundary gate to `ABCConjecture`.  They also formalize the duplicated
capacity failure and the exact scalar optimum of unrestricted aggregate
pooling.

The formal module intentionally stops at that capacity kernel.  It does not
yet encode the unitary-divisor CRT block family, the exact optimum at
`(343,625,968)`, or the `SCRT-SAT` counterfamily.  Those results have complete
ordinary proofs above and remain explicit future formalization obligations;
they are not smuggled into Lean as axioms or opaque inhabitants.  The module
has 30 public declarations and the audit has exactly 30 matching
`#print axioms` queries.  Both files compile with warnings treated as errors,
and the audit union is only Lean's standard `propext`, `Classical.choice`, and
`Quot.sound`.
