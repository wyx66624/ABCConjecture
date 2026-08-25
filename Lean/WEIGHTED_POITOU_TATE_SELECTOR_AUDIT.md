# Weighted Poitou--Tate selector audit

## 1. Verdict

Let

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

for a primitive positive abc triple.  At an odd multiplicative prime put
\(e_p=v_p(abc)\).  Among the three nonzero rational two-torsion points there
is a unique one, denoted \(T_p^+\), whose Tate local height is positive:

\[
 \lambda_p(T_p^+)=\frac{e_p}{6}\log p.
\]

The proposed universal statement

> globalize the local choices \(T_p^+\) to a non-torsion rational point and
> retain a fixed positive proportion of
> \(\sum_{p\ne2}(e_p-1)\log p\)

is **false as quantified over all primitive Frey curves**.  The actual Frey
curve

\[
 E_{1,8}:y^2=x(x-1)(x+8)
 \tag{1.1}
\]

has Mordell--Weil rank zero, while \(e_3=2\).  Its requested excess mass is
therefore at least \(\log 3>0\), but it has no non-torsion rational point at
all.  Section 5 gives an explicit full two-descent proof of rank zero; no
database rank declaration is used.

There are two further separations which survive after restricting to
positive-rank curves.

1. Poitou--Tate gives an exact *orthogonality criterion* for a tuple of local
   Kummer classes.  It does not assert that the particular positive selector
   satisfies that criterion.
2. Equality in \(E(\mathbf Q_p)/2E(\mathbf Q_p)\) does not preserve local
   Neron height.  Adding twice a local point can move the Tate component from
   Bernoulli parameter \(0\), where \(B_2=1/6\), to parameter \(1/2\), where
   \(B_2=-1/12\).

Thus the minimal surviving problem must assume positive rank (or construct
an auxiliary positive-rank curve), impose the Poitou--Tate reciprocity
conditions, kill the resulting Sha class, and control exact component/local
height data rather than only a mod-two Kummer class.  None of those missing
claims is abc, Szpiro, BSD, or a height estimate hidden in a definition.

## 2. Three distinct selector statements

Let \(S_o\) be the odd primes dividing \(abc\), and define

\[
 w_p=(e_p-1)\log p,\qquad
 W(E)=\sum_{p\in S_o}w_p.
 \tag{2.1}
\]

For \(P\in E(\mathbf Q)\), three possible meanings of “agree with
\(T_p^+\)” must not be conflated.

* **Kummer agreement:**
  \(P\equiv T_p^+\pmod {2E(\mathbf Q_p)}\).
* **Component agreement:** the images of \(P\) and \(T_p^+\) in the Neron
  component group \(\Phi_p\) agree.
* **Height retention:** \(\lambda_p(P)\) is bounded below by a fixed positive
  multiple of \(e_p\log p\).

Component agreement is stronger than the parity shadow relevant to the
Kummer class, and height retention is not a consequence of either one.
The strongest natural universal assertion would be the existence of
constants \(\kappa,\gamma>0\) such that every primitive Frey curve admits a
non-torsion \(P\) with

\[
 \sum_{\substack{p\in S_o\\
          \lambda_p(P)\ge \gamma e_p\log p}}
       w_p
 \ge \kappa W(E),
 \tag{2.2}
\]

together with an upper bound for all adverse finite and archimedean local
heights.  The rank-zero curve (1.1) refutes (2.2) before any choice of the
positive constants is made.

The same counterexample refutes the weaker assertion obtained by replacing
height retention with component or Kummer agreement, as long as the global
point is still required to be non-torsion.

## 3. What Poitou--Tate says with the correct quantifiers

Put \(M=E[2]\), identify \(M\simeq M^*\) by the Weil pairing, and let

\[
 L_v=\operatorname{im}\bigl(E(\mathbf Q_v)/2E(\mathbf Q_v)
       \longrightarrow H^1(\mathbf Q_v,M)\bigr).
\]

The local Kummer space \(L_v\) is self-annihilating for local Tate duality.
Fix a finite set \(A\) of places at which values are prescribed.  There are
three Selmer structures:

* ordinary: local condition \(L_v\) everywhere;
* strict at \(A\): local condition zero at \(A\), and \(L_v\) elsewhere;
* relaxed at \(A\): no local condition at \(A\), and \(L_v\) elsewhere.

The Poitou--Tate comparison sequence for the strict and ordinary structures
contains

\[
 0\longrightarrow \operatorname{Sel}_{2,A}^{\rm str}(E)
 \longrightarrow \operatorname{Sel}_2(E)
 \xrightarrow{\operatorname{loc}_A}
 \bigoplus_{v\in A}L_v
 \xrightarrow{\mathrm{PT}}
 \operatorname{Sel}_{2,A}^{\rm rel}(E)^\vee
 \longrightarrow \operatorname{Sel}_2(E)^\vee.
 \tag{3.1}
\]

For a local selector \(\tau=(\tau_v)_{v\in A}\), exactness gives the precise
criterion

\[
 \tau\in\operatorname{im}(\operatorname{loc}_A)
 \quad\Longleftrightarrow\quad
 \sum_{v\in A}\operatorname{inv}_v
    \langle\tau_v,\operatorname{loc}_v(s)\rangle_v=0
 \quad\text{for every }s\in
      \operatorname{Sel}_{2,A}^{\rm rel}(E).
 \tag{3.2}
\]

It is not enough to test only ordinary Selmer classes: termwise
self-annihilation already makes those pairings vanish.  The possible
obstructions live in the extra relaxed classes.  Thus Poitou--Tate decides a
reciprocity question; it does not make an arbitrary tuple global.

If (3.2) holds, one obtains a class \(s\in\operatorname{Sel}_2(E)\).  It is a
rational Mordell--Weil class exactly when its image under

\[
 0\longrightarrow E(\mathbf Q)/2E(\mathbf Q)
 \longrightarrow\operatorname{Sel}_2(E)
 \longrightarrow\Sha(E)[2]
 \longrightarrow0
 \tag{3.3}
\]

is zero.  A Cassels--Tate computation can test this obstruction in favorable
cases, but an everywhere locally soluble two-covering need not have a
rational point.  This is the second logically separate condition.

Finally, if \(E(\mathbf Q)\) has positive rank, every Mordell--Weil coset
modulo two contains a non-torsion representative: from a representative
\(P_0\) and any non-torsion \(R\), use \(P_0+2R\).  In rank zero no coset has
such a representative.  Therefore positive rank is a necessary hypothesis
for the proposed non-torsion selector, not an output of Poitou--Tate.

## 4. Kummer agreement does not retain the local height

On a split Tate curve \(E_q/\mathbf Q_p\), write

\[
 r(u)=\frac{v_p(u)}{v_p(q)}\pmod 1.
\]

The depth term of the local height is

\[
 \frac12 B_2(r(u))\log|q|_p^{-1},
 \qquad B_2(X)=X^2-X+\frac16.
 \tag{4.1}
\]

Take \(q=p^{4m}\).  The positive identity-component two-torsion point is
represented by \(u=-1\), so \(r=0\).  Let \(v=p^m=q^{1/4}\).  Multiplying
the representative by the square \(v^2=q^{1/2}\) gives

\[
 u'=-q^{1/2},\qquad [u']=[u]
       \text{ in }E_q(\mathbf Q_p)/2E_q(\mathbf Q_p),
\]

but \(r(u')=1/2\).  Consequently

\[
 B_2(0)=\frac16>0,
 \qquad B_2(1/2)=-\frac1{12}<0.
 \tag{4.2}
\]

This is a strict local counterexample to the implication “same Kummer class
as \(T_p^+\) implies positive local-height contribution.”  A successful
weighted theorem must prescribe sufficiently fine component/analytic data,
and must control how a global point realizes it.

There is also a harmless but instructive pigeonhole fact.  Sort the bad
primes according to which of the three global nonzero torsion points is
\(T_p^+\).  One of those three torsion points matches selector labels on at
least one third of the total nonnegative weight.  Hence coarse weighted
label agreement is easy; forcing a non-torsion point with favorable local
heights is the substantive part.

## 5. An explicit rank-zero Frey counterexample

### 5.1 Full two-descent map

For (1.1), the roots are \(0,1,-8\).  Away from the roots, the full descent
map is

\[
 \delta(P)=(x(P),x(P)-1,x(P)+8)
 \in(\mathbf Q^\times/\mathbf Q^{\times2})^3,
 \tag{5.1}
\]

with the usual limiting definitions at the two-torsion points.  The product
of the three entries is \(y(P)^2\), so it is a square.  At a prime outside
\(2\cdot3\), the three factors are pairwise coprime locally up to units
because their differences are \(1,8,9\); their valuations are therefore
even.  Each coordinate squareclass is supported on \(\{-1,2,3\}\).

Choose squarefree representatives \(b_1,b_2,b_3\in
\{\pm1,\pm2,\pm3,\pm6\}\), with \([b_3]=[b_1b_2]\).  There are 64 choices.
If a class comes from a rational point, the homogeneous covering

\[
 \begin{aligned}
 b_1z_1^2-b_2z_2^2&=z_0^2,\\
 b_3z_3^2-b_1z_1^2&=8z_0^2
 \end{aligned}
 \tag{5.2}
\]

has a nonzero rational solution.

### 5.2 Exact local sieve

Clear denominators in (5.2).  At each of 2 and 3, divide all four
coordinates by their largest common prime power.  The result is a primitive
solution modulo 16 and modulo 9 respectively.  The square and unit-square
sets are

\[
\begin{array}{c|c|c}
 &\text{squares}&\text{unit squares}\\ \hline
\mathbf Z/16&\{0,1,4,9\}&\{1,9\}\\
\mathbf Z/9&\{0,1,4,7\}&\{1,4,7\}.
\end{array}
\tag{5.3}
\]

Substitution in (5.2) gives the following complete primitive-solubility
lists.  Modulo 16 the surviving triples are

\[
\begin{gathered}
(1,1,1),(1,3,3),(-1,3,-3),(2,-1,-2),\\
(-2,-1,2),(-2,-3,6),(3,3,1),(-3,1,-3),\\
(-3,3,-1),(6,-1,-6),(6,-3,-2),(-6,-1,6).
\end{gathered}
\tag{5.4}
\]

Modulo 9 the surviving triples are

\[
\begin{gathered}
(1,1,1),(1,-1,-1),(1,2,2),(1,-2,-2),\\
(1,3,3),(1,-3,-3),(1,6,6),(1,-6,-6),\\
(-2,1,-2),(-2,-1,2),(-2,2,-1),(-2,-2,1),\\
(-2,3,-6),(-2,-3,6),(-2,6,-3),(-2,-6,3).
\end{gathered}
\tag{5.5}
\]

Their intersection is exactly

\[
 (1,1,1),\quad(1,3,3),\quad(-2,-1,2),\quad(-2,-3,6).
 \tag{5.6}
\]

The companion Lean theorem exhausts all 64 candidates and all square
residue quadruples in (5.3), so (5.4)--(5.6) are kernel-checked finite
arithmetic rather than a database lookup.

### 5.3 The four classes are torsion classes

The curve has the eight explicit points

\[
 O,(0,0),(1,0),(-8,0),(4,\pm12),(-2,\pm6).
 \tag{5.7}
\]

The point \((4,12)\) has double \((1,0)\); adding \((0,0)\) gives
\((-2,6)\), whose negative is \((-2,-6)\).  Thus all points in (5.7) are
torsion.  Their four classes
modulo doubling have descent images

\[
\begin{array}{c|c}
\text{representative}&\delta\\ \hline
O&(1,1,1)\\
(0,0)&(-2,-1,2)\\
(4,12)&(1,3,3)\\
(-2,-6)&(-2,-3,6).
\end{array}
\tag{5.8}
\]

The full descent map is injective on \(E(\mathbf Q)/2E(\mathbf Q)\).
Equations (5.4)--(5.6) show that its image has at most four elements, while
(5.8) supplies four.  Hence

\[
 |E(\mathbf Q)/2E(\mathbf Q)|=4.
\]

By the Mordell--Weil theorem and \(|E(\mathbf Q)[2]|=4\),

\[
 |E(\mathbf Q)/2E(\mathbf Q)|
 =2^{\operatorname{rank}E(\mathbf Q)}|E(\mathbf Q)[2]|
 =2^{r+2}.
\]

Therefore \(r=0\).  This completes the promised rank proof without assuming
BSD, analytic rank, or a database label.

Finally, for the abc point \((1,8,9)\),

\[
 v_3(abc)=v_3(72)=2,
 \qquad (e_3-1)\log3=\log3>0.
 \tag{5.9}
\]

There is positive selector mass but no non-torsion global point.  This is a
literal counterexample to every all-Frey non-torsion selector theorem,
regardless of its proposed retained proportion.

## 6. The minimal open statement after the no-go

The counterexample forces one of two repairs.

### Positive-rank version

Restrict to primitive Frey curves of positive Mordell--Weil rank.  For a
fixed \(\kappa>0\), seek a subset \(A\subseteq S_o\) with

\[
 \sum_{p\in A}w_p\ge\kappa W(E),
\]

such that the tuple \((\kappa_p(T_p^+))_{p\in A}\) satisfies (3.2), has a
preimage whose Sha class vanishes, and possesses a rational representative
whose exact local components give a favorable height sum while the adverse
places contribute at most
\(O_\varepsilon(\log N_E)+\varepsilon\log c\).

This statement is genuinely stronger than rank control and genuinely finer
than Kummer agreement.  It is not proved here.

### Auxiliary-curve version

For rank-zero Frey curves one must replace \(E\) by an auxiliary isogenous
curve, twist, or controlled cover with a non-torsion rational point, and
then transfer its height information back to \(E\).  A useful theorem would
have to bound the auxiliary conductor/discriminant and the transfer loss in
terms of the original reduced support.  Merely choosing a quadratic twist
does not supply positive algebraic rank, and an uncontrolled twist can add
new conductor whose logarithm pays for the entire desired mass.  No such
uniform auxiliary construction is presently established in this audit.

## 7. Lean boundary

`IUTThreeClosures/WeightedPoitouTateSelectorAudit.lean` formalizes only:

1. the actual primitive point `(1,8,9)`;
2. its exact exponent \(v_3(abc)=2\) and positive weighted excess;
3. the 64 supported squareclass candidates;
4. the primitive modulo-16 and modulo-9 covering tests via exact square
   residue enumeration;
5. the four surviving triples;
6. elementary logical no-go lemmas saying that an all-torsion group cannot
   furnish a non-torsion selector, with or without quantitative decoration.

Lean does not formalize the Kummer injection, Mordell--Weil finite
generation, the rank calculation, local fields, Poitou--Tate,
Cassels--Tate, Neron models, local heights, or the auxiliary-curve proposal.
Those are stated above with their exact hypotheses.  No theorem in the
module proves abc or assumes the desired height/radical inequality.
