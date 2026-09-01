# Balanced persistence after the first global sieves

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** three unconditional reductions, replayed finite certificates, and
kernel-checked elementary boundaries; the standard abc conjecture remains
neither proved nor disproved

## 1. Claim discipline and route-persistence rule

This increment pursues proof and counterexample directions simultaneously.
It applies the following rule to every research branch.

1. A route is not abandoned because its remaining theorem is difficult, is
   outside the present library, or has resisted finite computation.
2. A proposition is refuted only by an example satisfying every hypothesis of
   that proposition and violating its conclusion.
3. A proved impossibility theorem may close the exact mechanism it addresses.
   It does not close a broader parent route unless its quantifiers cover that
   route.
4. A finite search with no hit supplies a certified finite exclusion only.
5. Conditional implications are retained with their premises visible.  They
   are never reported as unconditional proofs of `ABCConjecture` or its
   negation.

Under this rule, all three principal routes below remain active.  Two local
models have been refuted: same-prime independence in the affine model, and the
claim that every Danilov remainder is squarefull.  Neither refutation closes
its parent construction.

## 2. Affine route: a sharp seed-sensitive upper gate

Let

\[
 a+b=c,\qquad \gcd(a,b)=1,\qquad P=abc,\qquad R=\operatorname{rad}(P),
\]

and, for positive integral parameters \(h,k\), set

\[
 U=1+Ph,\quad V=1+P(h+ck),\quad W=1+P(h+bk).
\]

On the already proved admissible locus, the output \((aU,bV,cW)\) is a
primitive abc point, the three cofactors are pairwise coprime and avoid
\(P\), and its height is \(H=cW\).  Therefore

\[
 \operatorname{rad}(aUbVcW)
 =R\operatorname{rad}(U)\operatorname{rad}(V)\operatorname{rad}(W).
 \tag{2.1}
\]

### Theorem 2.1 (pair-projection radical barrier)

Fix \(0<\mu<1\).  The number \(\mathcal E(X)\) of admissible outputs with
\(H\le X\) and

\[
 \operatorname{rad}(aUbVcW)<H^\mu
\]

satisfies, for every \(\varepsilon>0\),

\[
 \#\mathcal E(X)\ll_{\mu,\varepsilon}
 R^{-2/3}X^{2\mu/3+\varepsilon}.             \tag{2.2}
\]

The implied constant is independent of the seed.

**Proof.**  Every two-coordinate projection is injective.  The pair \((U,V)\)
recovers \(h=(U-1)/P\) and \(k=(V-U)/(cP)\); \((U,W)\) recovers the same
parameters using \(k=(W-U)/(bP)\); and \((V,W)\) first recovers
\(k=(V-W)/(aP)\), then \(h=(V-1)/P-ck\).

The fixed-exponent de Bruijn estimate, in the uniform finite-mesh form used by
Bernert--Browning--Lichtman--Teravainen, gives

\[
 \#\{m\le X:\operatorname{rad}(m)\le Y\}
 \ll_\varepsilon YX^\varepsilon
\]

in the needed range.  Dyadic decomposition consequently yields

\[
 \#\{(m,n):m,n\le X,\ 
   \operatorname{rad}(m)\operatorname{rad}(n)<Y\}
 \ll_\varepsilon YX^\varepsilon.             \tag{2.3}
\]

For a triple with radical product below \(Y\), the identity

\[
 (r_Ur_V)(r_Ur_W)(r_Vr_W)=(r_Ur_Vr_W)^2<Y^2
\]

shows that one pair product is below \(Y^{2/3}\).  Apply (2.3) to that pair
and use the corresponding injective projection.  A union over the three pairs
gives \(O_\varepsilon(Y^{2/3}X^\varepsilon)\).  Positivity of
\(aU+bV=cW=H\) gives \(U,V,W\le H\le X\), while (2.1) permits
\(Y=X^\mu/R\).  This proves (2.2). \(\square\)

At the current amplification scale \(X=c^8\), \(\mu=3/4\), this becomes

\[
 \#\mathcal E_c\ll_\varepsilon R^{-2/3}c^{4+\varepsilon}. \tag{2.4}
\]

Thus a positive proof through this route may target a uniform lower bound
larger than \(R^{-2/3}c^{4+\eta}\).  For seed shape
\(R=c^{\sigma+o(1)}\), its exponent is
\(4-2\sigma/3+\eta\).  No such lower bound is proved here, so the affine
route remains active.

The local counterexample search closes only one heuristic.  Conditioned on
admissibility, the events \(p^2\mid U\), \(p^2\mid V\), and \(p^2\mid W\)
each have probability \(1/(p(p+1))\), but any two are disjoint for the same
prime \(p\).  Hence same-prime independence is false.  For distinct primes,
finite collections of local conditions remain exactly independent by the
Chinese remainder theorem.

## 3. Pell route: every hypothetical squarefull term carries a rare packet

Let

\[
 u_0=0,\quad u_1=1,\quad u_{n+2}=6u_{n+1}-u_n,
\]

and write

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2.
\]

Taking norms and conjugates gives

\[
 A_n^2-2B_n^2=(-1)^n,qquad \gcd(A_n,B_n)=1,qquad u_n=A_nB_n. \tag{3.1}
\]

For odd \(n\), both factors are odd, so \(u_n\) is squarefull exactly when
both \(A_n\) and \(B_n\) are squarefull.

### Theorem 3.1 (prime-index four-prime, two-depth-three dichotomy)

For every odd prime \(\ell\), either some prime \(q\) satisfies
\(q\parallel u_\ell\), or \(u_\ell\) is squarefull and the following hold:

1. \(\ell\ne7\);
2. \(A_\ell\) and \(B_\ell\) contain at least two distinct support primes
   each, hence at least four distinct primes altogether;
3. every selected prime has rank of apparition exactly \(\ell\) and is a
   balancing-Wieferich prime;
4. in each of the two coprime channels, at least one selected prime has
   first-occurrence valuation at least three.

**Proof.**  If no support valuation equals one, \(u_\ell\) is squarefull,
and (3.1) transfers squarefullness to both channels.  Cohn's associated-Pell
theorem says that \(A_\ell>1\) is never a perfect power.  Cohn's Pell theorem
together with Ljunggren's square classification says that the only possible
nontrivial perfect-power value of \(B_\ell\) is
\(B_7=169\).  But

\[
 u_7=40391=13^2\cdot239,qquad239^2\nmid u_7,
\]

so \(\ell=7\) is not squarefull.  For every other prime index, each
squarefull channel is not a perfect power.  A squarefull non-perfect-power
integer has at least two distinct support primes and has an odd exponent,
which is at least three, at one of them.  Coprimality separates the channels.

The rank-of-apparition lemmas force every support prime at a prime index to
have rank \(\ell\).  Sanna's Lucas valuation formula then identifies its
valuation in \(u_\ell\) with its first-occurrence valuation.  Valuation at
least two is precisely the balancing-Wieferich condition, and the odd
channel exponent supplies depth at least three. \(\square\)

The largest-prime descent is unconditional: if \(N>1\) and \(u_N\) is
squarefull, then the largest prime divisor \(\ell\mid N\) is odd and
\(u_\ell\) is squarefull.  Thus every hypothetical squarefull term at any
index forces the packet in Theorem 3.1 at a prime index.

Selecting the depth-three primes \(p_A,p_B\) in the two channels gives the
sharpened radical estimate

\[
 \operatorname{rad}(2A_\ell^2B_\ell^2)
 \le2\sqrt{\frac{u_\ell}{p_Ap_B}}
 \le2\sqrt{\frac{u_\ell}{4\ell^2-1}}.       \tag{3.2}
\]

An unbounded squarefull subsequence would therefore contradict standard abc;
one isolated term or a finite collection would not.

The exact finite campaign scanned all 183,071 odd primes
\(q\le2{,}500{,}000\).  The only balancing-Wieferich hits were
\(13,31,1546463\), all of first-occurrence valuation exactly two; no
depth-three prime occurred.  Local exponent-one certificates now settle
seven formerly open indices, leaving only \(1873\) and \(1951\) unresolved
among \(2\le n\le2000\).  Those two are not squarefull hits.  These finite
facts strongly constrain the packet but do not prove its global absence.

## 4. Danilov--Hall route: an all-index congruence sieve

Put

\[
 \alpha_0=682+305\sqrt5,
 \qquad \eta=(9+4\sqrt5)^{10}
 =1730726404001+774004377960\sqrt5,
\]

and write \(\alpha_t=\alpha_0\eta^t=z_t+w_t\sqrt5\) for \(t\ge0\).  Define

\[
 L_t=2z_t+11,qquad K_t=\frac{27L_t}{125}.                 \tag{4.1}
\]

The norm identities preserve the Pell equation; the orbit has
\(z_t\equiv57\pmod{125}\), so \(K_t\) is a positive integer and the
associated primitive point satisfies \(X_t^3+K_t=Y_t^2\).

### Theorem 4.1 (global Danilov index sieve)

For every nonnegative integer \(t\),

\[
 K_t\text{ squarefull}\Longrightarrow
 t\equiv
 122136955032565025967809449110840347537827
 \pmod{183205432548847538951714173666260521306741}.       \tag{4.2}
\]

**Proof.**  From \(125K_t=27L_t\), any prime
\(p\nmid3375\) occurring exactly once in \(L_t\) occurs exactly once in
\(K_t\).  Squarefullness therefore forces \(p^2\mid L_t\) whenever such a
prime divides \(L_t\).

Modulo \(11^2\), nilpotent binomial linearization gives
\(L_t=11(t+4)\), so squarefullness forces \(t=7+11s\).  Modulo \(89^2\),

\[
 L_{7+11s}=89(1+46s),
\]

so \(s\equiv29\pmod{89}\) and \(t=326+979r\).  Ten independently certified
prime-square linearizations then force

\[
\begin{array}{c|rrrrrrrrrr}
p&179&199&331&661&1069&9791&39161&68531&474541&1801361\\
r\bmod p&119&66&110&220&356&6527&26107&45687&158180&1200907.
\end{array}
\]

Exact CRT gives

\[
 r\equiv124756848858595532142808426058059599119
 \pmod{187135273287893298214212639087089398679}.
\]

Substitution into \(t=326+979r\) yields (4.2). \(\square\)

In particular, no \(0\le t<T_0\) is squarefull, where the displayed
representative in (4.2) is \(T_0\).  The surviving arithmetic progression is
not shown to contain a squarefull remainder and is not shown to contain none.
The route therefore remains active; its next exact problem is the restriction
of the orbit to that progression.

## 5. Lean boundary and independent checks

The mathematical proofs above were written before their elementary Lean
boundaries.  The formalization consists of:

- `AffineExcessUpperBound20260831.lean`: the three pair injections,
  same-prime exclusion, and integer geometric-mean step;
- `PellPrimeIndexDichotomy20260831.lean`: odd depth-three logic, the exact
  index-seven obstruction, and the elementary numerical bound;
- `DanilovGlobalIndexSieve20260831.lean`: the quadratic recurrence, modular
  linearizations, ten lift certificates, exact CRT, and lower-index exclusion.

The three modules contain 57 theorems and 30 definitions or structures, 87
counted declarations in total.  Four direct elaborations and the aggregate
9151-job library build pass.  Source scans find no `sorry`, `admit`,
`native_decide`, declared axiom, opaque declaration, or unsafe declaration.
The reported kernel dependencies are subsets of `propext`,
`Classical.choice`, and `Quot.sound`.

The analytic de Bruijn/BBLT estimate and the external theorems of Cohn,
Ljunggren, and Sanna are cited mathematical inputs.  They have not been
inserted as Lean axioms.  The exact validation record is
`Lean/verification/2026_09_01_balanced_persistence_continuation/VALIDATION.md`.

## 6. Active route ledger

| Route | Unconditional progress | Surviving exact gate | Status |
|---|---|---|---|
| Affine shear | seed-sensitive upper bound (2.2) | prove or refute a matching uniform exceptional-output lower bound | active |
| Pell balancing | prime-index descent and forced four-prime packet | exclude the packet globally or construct an unbounded packet family | active |
| Danilov--Hall | all-index progression (4.2) | decide squarefullness along the surviving progression | active |
| Elliptic powerful coordinates | conditional strict signatures | prove finiteness or construct an unbounded powerful-coordinate subsequence | active |
| Frey/modular | verified local and conductor interfaces | obtain the uniform global height/conductor inequality | active |
| IUT | formalized local dictionaries and finite layers | justify the global comparison/uniformity passage without a new assumption | active |

No row is closed for difficulty.  A future counterexample will close only the
statement whose full hypotheses it satisfies.  The terminal goal remains an
unconditional Lean term of `ABCConjecture`, or a rigorous unconditional
disproof and formalized counterexample family.  This increment has not reached
either terminal condition.
