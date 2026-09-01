# Alternative explicit counterexample families for abc: a primary-source and arithmetic audit

Author: ChatGPT. Date: 2026-08-31.

## 0. Outcome

No unconditional counterexample to the standard abc conjecture was found.
In particular, this note does not turn a finite computation, a primitive-divisor
theorem, or an abc-conditional result into a claimed counterexample.

The search nevertheless produces three precise advances.

1. The Pell sequence already present in the repository admits a strict
   upgrade gate and a sharper adjacent-factor conversion.  Let

   \[
   U_0=0,\quad U_1=1,\quad U_{n+2}=6U_{n+1}-U_n.
   \]

   If infinitely many `U_n` are powerful, then the associated Pell triples have
   the strict fixed fullness signature `(7,3,2)` and disprove abc.  Factoring
   `U_n=A_nB_n` into coprime square-root Pell coordinates gives primitive
   neighboring-factor points with the still stronger radical slope `1/2`; on
   even indices they have signature `(3,4,4)`.  This is an exact reformulation
   and improved conversion of the same powerful-term premise, not a new source
   of indices.  The implication is unconditional; existence of the powerful
   subsequence is open.  The strongest directly relevant finiteness theorem in
   the literature assumes abc.
2. The Mordell curve

   \[
                         E:y^2=x^3-2,\qquad P=(3,5)
   \]

   gives an explicit unbounded primitive family

   \[
                         C_n^2+2B_n^6=A_n^3
   \]

   on the critical signature `(2,6,3)`.  Three exact strict upgrade gates are
   isolated below.  Primitive divisors and valuation lifting do not prove any of
   the required upgrades.
3. Danilov's Hall family can be normalized to an explicit unbounded primitive
   family

   \[
                         X^3+K=Y^2,
        \qquad K\asymp X^{1/2}.
   \]

   It reaches the critical abc scale but does not cross it.  A uniform radical
   saving in `K`, for example squarefullness, would cross the line.  Exact perfect
   powers in the moving linear factor occur only finitely often for every fixed
   exponent, by a direct hyperelliptic reduction and Siegel's theorem.  This does
   not settle squarefull values, whose square and cube kernels may both move.

The negative conclusions are also exact.  Consecutive powerful numbers alone
give only the critical radical slope.  Cohn--Nitaj and Walsh give genuine infinite
3-full families, but their signature is `(3,3,3)`, again on the critical line.
Darmon--Granville rules out every fixed strict generalized-Fermat equation, while
Mason--Stothers rules out polynomial identities whose three coprime entries carry
the strict fullness multiplicities algebraically.  Rational or polynomial
specializations can survive only through moving residual kernels or through
arithmetic fullness at a sparse set of parameter values.

The primary PDFs and hashes used for this audit are recorded in
`research/sources/alternative_counterexample_2026_08_31/source-metadata.json`.

## 1. Audit protocol

For a positive integer `N`, write

\[
  \operatorname{rad}(N)=\prod_{p\mid N}p.
\]

Call `N` **m-full** if every prime divisor has valuation at least `m`.
The integer `1` is `m`-full for every `m`, since it has no prime divisors.
For a primitive positive abc point

\[
                         a+b=c,\qquad \gcd(a,b)=1,
\]

put

\[
 H=\log c,\qquad R=\log\operatorname{rad}(abc).
\]

Every proposed family is checked against five conditions.

1. **Primitivity:** after all denominator clearing and cancellation, the three
   integer entries must be pairwise coprime.
2. **Fixed signature:** the fullness exponents must not depend on the member of
   the family.
3. **Strictness:** for a pure mixed-full argument, the exponents must satisfy

   \[
                    \frac1p+\frac1q+\frac1r<1.
   \]

   A more refined construction may instead prove a direct bound
   `R <= sigma H + O(1)` with one fixed `sigma<1`.
4. **Unbounded height:** isolated examples, however good, cannot contradict abc.
5. **Residual-kernel escape:** define

   \[
   \kappa_m(N)=\prod_{\ell\mid N}\ell^{v_\ell(N)\bmod m},
   \qquad
   \rho_m(N)=\prod_{\ell\mid N}\ell^{\lfloor v_\ell(N)/m\rfloor}.
   \]

   Then `N=kappa_m(N) rho_m(N)^m`.  An unbounded primitive strict
   mixed-full family must have infinitely many triples of residual kernels.
   Otherwise it lies in a finite union of fixed equations

   \[
                         AX^p+BY^q=CZ^r,
   \]

   each of which has only finitely many proper solutions by Darmon--Granville,
   Theorem 2.

The familiar mixed-full estimate is

\[
 R\le
 \left(\frac1p+\frac1q+\frac1r\right)H.                    \tag{1.1}
\]

Thus a height-unbounded family passing all five tests disproves the unchanged
standard abc conjecture for a single fixed positive epsilon.

## 2. Consecutive powerful numbers: a critical construction, not a strict one

### Proposition 2.1 (the property alone is critical)

If `N` and `N+1` are powerful, then the primitive triple `(1,N,N+1)` satisfies

\[
 \operatorname{rad}(N(N+1))
    \le \sqrt{N(N+1)}<N+1.                                  \tag{2.1}
\]

**Proof.**  Powerfulness gives `rad(N)^2<=N` and
`rad(N+1)^2<=N+1`.  Consecutive integers are coprime, so their radicals
multiply.  This proves (2.1).  \(\square\)

The bound has asymptotic logarithmic slope one:

\[
 \frac{\tfrac12\log N+\tfrac12\log(N+1)}{\log(N+1)}\longrightarrow1.
\]

Equivalently, assigning the unit any finite exponent `M` gives signature
`(M,2,2)` and reciprocal sum `1+1/M>1`.  Consequently, an infinite family
of consecutive powerful pairs is not by itself an abc counterexample.  It could
become one only if the actual radicals enjoy an additional uniform saving.

Walker proves that Pell equations produce infinitely many type-I consecutive
powerful pairs and characterizes type II through equations

\[
                         mX^2-nY^2=\pm1.
\]

His property `Q` makes the primes in the squarefree coefficients `m,n` occur
to exponent at least three, but primes newly introduced through `X,Y` still
occur with exponent two.  Hence the entire endpoints are guaranteed only to be
2-full.  For example, a fixed cubefull coefficient does not make `mX^2`
3-full when `X` acquires a new prime to its first power.

If one endpoint in an unbounded consecutive powerful family were 3-full, the
unit could be assigned exponent 7 and the signature would become `(7,3,2)`,
whose reciprocal sum is `41/42`.  The missing input is therefore an actual
arithmetic upgrade of one endpoint, not another parametrization of ordinary
powerful pairs.

Primary source: David T. Walker, [*Consecutive Integer Pairs of Powerful
Numbers and Related Diophantine Equations*](https://www.fq.math.ca/Scanned/14-2/walker.pdf),
*Fibonacci Quarterly* 14 (1976), 111--116.

## 3. The Lucas/balancing-number escape gate

### 3.1 Pell realization

Let

\[
 \alpha=3+\sqrt8,\qquad \beta=3-\sqrt8=\alpha^{-1},
\]

and define the companion sequence `V_0=2,V_1=6` with the same recurrence.
Then

\[
 U_n=\frac{\alpha^n-\beta^n}{\alpha-\beta},\qquad
 V_n=\alpha^n+\beta^n.
\]

Since `V_n` is even, put `X_n=V_n/2`.  The standard Lucas identity gives

\[
 V_n^2-32U_n^2=4,
 \qquad\text{hence}\qquad
 X_n^2-8U_n^2=1.                                             \tag{3.1}
\]

Both `U_n` and `X_n` increase without bound for positive `n`.

### 3.2 Strong divisibility, ranks, and exact valuations

The sequence is a strong divisibility sequence:

\[
                         \gcd(U_m,U_n)=U_{\gcd(m,n)}.          \tag{3.2}
\]

An elementary proof uses

\[
 U_{m+n}=U_mU_{n+1}-U_{m-1}U_n                              \tag{3.3}
\]

and `gcd(U_n,U_{n-1})=1`.  Reducing (3.3) modulo `U_n` performs the
Euclidean algorithm on the indices and proves (3.2).

Sanna writes a Lucas recurrence as `u_n=a u_{n-1}+b u_{n-2}`.  Here

\[
                         a=6,\qquad b=-1,\qquad \Delta=a^2+4b=32.
\]

For every prime `p`, since `p` does not divide `b`, its rank of apparition

\[
                         \tau(p)=\min\{j\ge1:p\mid U_j\}
\]

exists, and

\[
                         p\mid U_n\quad\Longleftrightarrow\quad\tau(p)\mid n.
                                                                    \tag{3.4}
\]

For every odd prime, `p` does not divide \(\Delta\), and Sanna's Corollary 1.6
specializes to

\[
 v_p(U_n)=
 \begin{cases}
 v_p(n)+v_p(U_{\tau(p)}),&\tau(p)\mid n,\\
 0,&\tau(p)\nmid n.
 \end{cases}                                                     \tag{3.5}
\]

For `p=2`, Theorem 1.5 and `v_2(U_2)=v_2(6)=1` give

\[
 v_2(U_n)=
 \begin{cases}
 0,&n\text{ odd},\\
 v_2(n),&n\text{ even}.
 \end{cases}                                                     \tag{3.6}
\]

There is also an elementary law of apparition for odd `p`:

\[
                         \tau(p)\mid p-\left(\frac2p\right).  \tag{3.7}
\]

Indeed, in \(\mathbb F_{p^2}\) put \(\gamma=\alpha/\beta\).  Divisibility by
`p` is equivalent to \(\gamma^n=1\).  If \(\Delta\) is a square modulo `p`,
then \(\gamma\) lies in \(\mathbb F_p^\times\) and has order dividing
`p-1`.  If \(\Delta\) is a nonsquare, Frobenius exchanges the two roots, so
\(\gamma^p=\gamma^{-1}\) and
the order divides `p+1`.  Since `(32/p)=(2/p)`, (3.7) follows.

### 3.3 What primitive-divisor theorems do and do not say

Yabuta's presentation of Carmichael's theorem uses the following definition:
`p` is primitive for `U_n` when it divides `U_n` and no earlier positive-index
term.  It does not separately exclude the discriminant or prime divisors of the
index.  For a real Lucas sequence generated by `z^2-Lz+M`, with coprime
nonzero `L,M` and `L>0`, Carmichael's theorem gives a primitive divisor for
every `n` outside `{1,2,6}`, except for the single case
`n=12,L=1,M=-1`.  Our pair is `(L,M)=(6,1)`, so the exception is irrelevant.
Moreover

\[
 U_6=6930,
\]

and `11` divides no earlier term.  Thus every `U_n` for `n>=3` has a
primitive divisor.

Bilu--Hanrot--Voutier prove the more general theorem that every Lucas or
Lehmer number of index `n>30` has a primitive divisor.  Their Lucas
definition is stricter: the prime must not divide
\((\alpha-\beta)^2U_1\cdots U_{n-1}\).  The theorem is indispensable for general
or complex-root sequences, but Carmichael is sharper for this positive
discriminant sequence.

If an odd prime `p` is primitive for `U_n`, then `tau(p)=n`.  Equation
(3.7) shows that `n` divides `p-(2/p)`, so `p` cannot divide `n`.  The
only general mechanism for a natural primitive divisor also to divide its
index is \(p\mid\Delta\), when Sanna's Lemma 2.1 gives
\(\tau(p)=p\); here that is
only the exceptional pair `p=n=2`.

None of these facts bounds the first valuation `v_p(U_{tau(p)})`.  For a
concrete warning,

\[
                         U_7=40391=13^2\cdot239,
\]

and `13` is a primitive divisor appearing with exponent two.  The same term
also has the exponent-one primitive divisor `239`, but Carmichael's theorem
does not guarantee that second fact.  Formula (3.5) merely propagates the
initial exponent:

\[
 v_p(U_{k\tau(p)})=v_p(U_{\tau(p)})+v_p(k),                  \tag{3.8}
\]

because `p` does not divide `tau(p)` for odd `p` in this sequence.

Consequently, primitive support is not squarefree support.  If `U_n` is
powerful, every primitive divisor at rank `n` must appear squared; the
primitive-divisor theorem gives no contradiction.

### 3.4 A strict counterexample theorem

**Theorem 3.1 (powerful balancing-number gate).**  If `U_n` is powerful
for infinitely many indices, then the standard abc conjecture is false.

**Proof.**  For every such index, (3.1) gives the positive primitive triple

\[
                         1+8U_n^2=X_n^2.                     \tag{3.9}
\]

Primitivity is automatic because the two nonunit entries are consecutive.
The unit is 7-full.  If an odd prime divides `U_n`, its valuation in
`8U_n^2` is at least four.  At the prime 2, the valuation is 3 when `U_n`
is odd and at least 7 when `U_n` is even and powerful.  Thus `8U_n^2` is
3-full, while `X_n^2` is 2-full.  The fixed signature is `(7,3,2)` and

\[
                         \frac17+\frac13+\frac12=\frac{41}{42}<1.
\]

The heights are unbounded because the indices in an infinite subset are
unbounded and `X_n` grows exponentially.  The mixed-full estimate (1.1)
therefore contradicts abc.  \(\square\)

There is a small unconditional pruning consequence.  If an even-index term
is powerful, (3.6) forces `4|n`.  Since `3|U_n` exactly when `2|n`, (3.5)
then forces `3|n`; hence every even index of a powerful term must be divisible
by 12.  This does not prove finiteness.

For the signature in Theorem 3.1, the residual-kernel triple is

\[
                         (1,\kappa_3(8U_n^2),1).              \tag{3.10}
\]

Darmon--Granville therefore forces the middle kernel to assume infinitely
many values along any hypothetical counterexample subsequence.  A proof that
the kernel lies in a fixed finite set would close this route negatively.

The exact literature boundary is important.  Ribenboim--Walsh prove, under
abc, that the powerful part of a broad class of positive-discriminant binary
recurrences is small.  Yabuta's Theorem 2.3 states directly that abc implies
that every nondegenerate Lucas `U`- and `V`-sequence with coprime nonzero
parameters has only finitely many powerful terms.  It applies to `(P,Q)=(6,1)`.
No unconditional theorem was found which proves that all sufficiently large
`U_n(6,1)` possess a prime of valuation one, or that the powerful terms of
this particular sequence are finite.  Classifications of perfect powers do
not imply this: a powerful number may have a varying squarefree/cubefree
kernel and need not be one exact power.

Primary sources:

* Minoru Yabuta, [*A Simple Proof of Carmichael's Theorem on Primitive
  Divisors*](https://www.fq.math.ca/Scanned/39-5/yabuta.pdf), *Fibonacci
  Quarterly* 39(5) (2001), 439--443.
* Carlo Sanna, [*The p-Adic Valuation of Lucas
  Sequences*](https://www.fq.math.ca/Papers1/54-2/Sanna02242016.pdf),
  *Fibonacci Quarterly* 54(2) (2016), 118--124.
* Yuri Bilu, Guillaume Hanrot, and Paul M. Voutier, [*Existence of Primitive
  Divisors of Lucas and Lehmer Numbers*](https://inria.hal.science/inria-00072867),
  *J. reine angew. Math.* 539 (2001), 75--122,
  [DOI 10.1515/crll.2001.080](https://doi.org/10.1515/crll.2001.080).
* Paulo Ribenboim and Gary Walsh, *The ABC Conjecture and the Powerful Part
  of Terms in Binary Recurring Sequences*, *J. Number Theory* 74 (1999),
  134--147, [DOI 10.1006/jnth.1998.2315](https://doi.org/10.1006/jnth.1998.2315).
* Minoru Yabuta, [*The ABC-Conjecture and the Powerful Numbers in Lucas
  Sequences*](https://www.fq.math.ca/Papers1/45-4/quartYabuta04_2007.pdf),
  *Fibonacci Quarterly* 45(4) (2007), 362--365.

### 3.5 The square-root factorization is a sharper gate, not a new premise

Define positive integers `A_n,B_n` by

\[
                    (1+\sqrt2)^n=A_n+B_n\sqrt2.
\]

Since `(1+sqrt(2))^2=3+sqrt(8)`, comparison with the Pell realization in
Section 3.1 gives

\[
 \boxed{X_n=A_n^2+2B_n^2,\qquad U_n=A_nB_n},                 \tag{3.11}
\]

and taking norms gives

\[
                         A_n^2-2B_n^2=(-1)^n.                \tag{3.12}
\]

Any common divisor of `A_n` and `B_n` divides the left side of (3.12), so

\[
                         \gcd(A_n,B_n)=1.                    \tag{3.13}
\]

Consequently

\[
 U_n\text{ is powerful}
 \quad\Longleftrightarrow\quad
 A_n\text{ and }B_n\text{ are both powerful}.              \tag{3.14}
\]

Indeed, the prime supports of the two factors are disjoint, so the
valuations in their product are exactly the valuations in the relevant
factor.  This proves that the factorization does not weaken the unresolved
premise in Theorem 3.1.  It exposes that premise as simultaneous
powerfulness of two coprime Pell coordinates.

The neighboring factors of `X_n` are exact squares or twice squares:

\[
 \left(\frac{X_n-1}{2},\frac{X_n+1}{2}\right)=
 \begin{cases}
   (2B_n^2,A_n^2),&n\text{ even},\\
   (A_n^2,2B_n^2),&n\text{ odd}.
 \end{cases}                                                 \tag{3.15}
\]

This follows by adding and subtracting (3.12) from
`X_n=A_n^2+2B_n^2`.  It gives the primitive abc point

\[
 Q_n=
 \begin{cases}
   (1,2B_n^2,A_n^2),&n\text{ even},\\
   (1,A_n^2,2B_n^2),&n\text{ odd}.
 \end{cases}                                                 \tag{3.16}
\]

If `U_n` is powerful, then (3.14) and radical submultiplicativity give

\[
 \begin{aligned}
 \operatorname{rad}(Q_n)
  &=\operatorname{rad}(2A_n^2B_n^2)\\
  &\le 2\operatorname{rad}(A_n)\operatorname{rad}(B_n)\\
  &\le 2\sqrt{A_nB_n}.
 \end{aligned}                                               \tag{3.17}
\]

Let `c_n` be the largest entry of `Q_n`.  When `n` is even,
`B_n<A_n` and `c_n=A_n^2`; when `n` is odd, `A_n<2B_n` and
`c_n=2B_n^2`.  Thus `A_nB_n<c_n` in both cases and

\[
 \log\operatorname{rad}(Q_n)
       <\frac12\log c_n+\log2.                               \tag{3.18}
\]

This improves the deterministic radical slope from Theorem 3.1, but it uses
exactly the same powerful-`U_n` hypothesis.  In particular, it is an improved
abc conversion of the Pell candidate, not a second source of candidate
indices.  On even indices, (3.6) forces `4|n`; then both nonunit entries in
(3.16) are 4-full and the point has the fixed strict signature

\[
                         (3,4,4),\qquad
            \frac13+\frac14+\frac14=\frac56.                 \tag{3.19}
\]

The exact-power literature does not close (3.14).  Cohn proves that the
standard Pell number `B_n` is never a `k`th power for `k>2`, except at the
trivial indices `n=0,1`; Ljunggren's square theorem adds the sole nontrivial
square `B_7=169`.  Ribenboim records that the associated Pell sequence
`2A_n` has no proper-power term.  Dey and Rout use precisely the coprime
factorization `U_n=A_nB_n` to prove that no balancing number `U_n`, `n>=2`,
is an exact perfect power.  None of these statements implies that `A_n`,
`B_n`, or their product has a prime of valuation one.  A powerful number
need not be an exact power.

Patra--Panda--Khemaratchatakumthorn prove the exact divisibility law
`v_2(U_n)=v_2(n)` and higher-power lifting laws for balancing and
Lucas-balancing terms.  These propagate a valuation already present at its
first rank; they do not bound that first valuation.  More generally,
Blomer--Schobel prove for fixed nonzero `l` and `k>2` the unconditional count

\[
 N_k(x;l)\ll_{\varepsilon,k}x^{2/(2k+1)+\varepsilon}         \tag{3.20}
\]

for pairs of `k`-full integers at distance `l`.  At `k=4`, this is a genuine
upper bound for the even-index neighboring pair in (3.15), but its exponent
is positive and it does not prove finiteness.

Additional primary sources:

* J. H. E. Cohn, [*Perfect Pell
  Powers*](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/FC63F15647E84273C77B910D003C0192/S0017089500031207a.pdf/perfect_pell_powers.pdf),
  *Glasgow Mathematical Journal* 38 (1996), 19--20,
  [DOI 10.1017/S0017089500031207](https://doi.org/10.1017/S0017089500031207).
* Paulo Ribenboim, [*Pell Numbers, Squares and
  Cubes*](https://publi.math.unideb.hu/paper/1189/download/10_5486_PMD_1999_1987.pdf),
  *Publicationes Mathematicae Debrecen* 54 (1999), 131--152,
  [DOI 10.5486/PMD.1999.1987](https://doi.org/10.5486/PMD.1999.1987).
* Pallab Kanti Dey and S. S. Rout, *Diophantine Equations Concerning
  Balancing and Lucas Balancing Numbers*, *Archiv der Mathematik* 108
  (2017), 29--43,
  [DOI 10.1007/s00013-016-0994-z](https://doi.org/10.1007/s00013-016-0994-z).
* Asim Patra, Gopal Krishna Panda, and Tammatada Khemaratchatakumthorn,
  [*Exact Divisibility by Powers of the Balancing and Lucas-Balancing
  Numbers*](https://www.fq.math.ca/Papers/59-1/khemarat08082020.pdf),
  *Fibonacci Quarterly* 59(1) (2021), 57--64.
* Valentin Blomer and Anita Schobel, *Twins of Powerful Numbers*,
  *Functiones et Approximatio Commentarii Mathematici* 49 (2013), 349--356,
  [DOI 10.7169/facm/2013.49.2.12](https://doi.org/10.7169/facm/2013.49.2.12).

### 3.6 Cross-audited descent to a prime index

The simultaneous factorization also supports a useful unconditional
reduction.

**Proposition 3.2 (largest-prime descent).**  Suppose `N>1` and `U_N` is
powerful.  If `ell` is the largest prime divisor of `N`, then `ell` is odd
and `U_ell` is powerful.

**Proof.**  If `N` were a power of two, then `tau(3)=2`, (3.5) would give

\[
                         v_3(U_N)=v_3(U_2)+v_3(N)=1,
\]

contradicting powerfulness.  Thus `N` has an odd prime divisor and its
largest prime divisor `ell` is odd.

Let `q` divide `U_ell`.  Equation (3.6) shows `U_ell` is odd.  Since `ell`
is prime, (3.4) and `U_1=1` force `tau(q)=ell`.  The rank bound (3.7) gives

\[
                         \ell\mid q-\left(\frac2q\right),
\]

so `q` is congruent to `1` or `-1` modulo `ell`.  The prime `q` is odd.
If `q<ell`, the only positive possibilities are `1` and `ell-1`, neither
an odd prime; hence `q>ell`.  By maximality of `ell`, `q` does not divide
`N`.  Since `ell|N`, (3.5) now yields

\[
                         v_q(U_N)=v_q(U_\ell)+v_q(N)
                                  =v_q(U_\ell).
\]

The left side is at least two.  This holds for every prime `q|U_ell`, so
`U_ell` is powerful.  \(\square\)

Accordingly, an exponent-one divisor theorem only for odd prime indices
would close the entire balancing-number route.  This proposition does not
supply that theorem.

The Carmichael source must be read with its own definition.  In Yabuta's
paper, a primitive divisor of `D_n` means a prime dividing `D_n` but no
earlier positive-index term; it is not separately required to avoid the
discriminant or the index.  Carmichael's theorem there assumes nonzero
coprime `L,M`, `L>0`, and real distinct roots of
`T^2-LT+M`.  It excludes indices `1,2,6`, with the additional exceptional
case `n=12,L=1,M=-1`.  All hypotheses hold for `(L,M)=(6,1)`, and the
omitted term `U_6` has the direct primitive divisor 11.  The stricter
Bilu--Hanrot--Voutier definition additionally excludes primes dividing
\((\alpha-\beta)^2U_1\cdots U_{n-1}\).  Neither definition imposes
valuation one.

## 4. An explicit elliptic-divisibility critical family

### 4.1 Construction and primitivity

Consider

\[
                         E:y^2=x^3-2,
 \qquad P=(3,5).
\]

The point `P` has infinite order.  Indeed, the discriminant of this integral
Weierstrass equation is `-1728`; the Nagell--Lutz theorem would force the
square of the nonzero `y`-coordinate of a torsion point to divide `1728`,
whereas `5^2` does not.

Write every positive multiple in lowest terms as

\[
             nP=\left(\frac{A_n}{B_n^2},\frac{C_n}{B_n^3}\right),
 \qquad B_n>0,
 \qquad \gcd(A_n,B_n)=\gcd(C_n,B_n)=1.                       \tag{4.1}
\]

Substitution into the curve equation gives

\[
                         C_n^2+2B_n^6=A_n^3.                 \tag{4.2}
\]

This triple is pairwise coprime for every `n`.  The only nontrivial point is
`gcd(A_n,C_n)`.  Any common prime divides `2B_n^6`, but cannot divide
`B_n`, so it must be 2.  If `A_n,C_n` were both even, then `B_n` would be
odd.  Reducing (4.2) modulo 8 would give

\[
                       C_n^2+2\equiv0\pmod 8,
\]

which is impossible because an even square is 0 or 4 modulo 8.  Thus
`gcd(A_n,C_n)=1`.

Doubling `P` gives the exact point

\[
                         2P=\left(\frac{129}{10^2},
                                  -\frac{383}{10^3}\right),              \tag{4.3}
\]

so `B_2=10`.  Elliptic divisibility implies `B_2|B_{2k}`.  Therefore
`B_n` is even on the infinite subsequence of even indices.  On that
subsequence, `2B_n^6` is 6-full: its 2-adic valuation is
`1+6v_2(B_n)>=7`, and every odd prime divisor has valuation at least 6.
The other two coordinates are respectively 2-full and 3-full.  We obtain an
explicit primitive family of fixed signature

\[
                         (2,6,3),\qquad
                         \frac12+\frac16+\frac13=1.           \tag{4.4}
\]

Its heights are unbounded.  The positive multiples of a nontorsion point are
distinct up to sign, and (4.2) shows that bounded `A_n` would bound both
`B_n` and `C_n`, leaving only finitely many triples.

### 4.2 Three strict upgrade gates

Equation (4.2) reaches the equality line exactly.  Each of the following
arithmetic statements on an unbounded even-index subsequence would turn it
into a standard abc counterexample.

1. If `|C_n|` is powerful, then `C_n^2` is 4-full.  The signature becomes

   \[
                            (4,6,3),\qquad \text{sum}=\frac34.
   \]
2. If `A_n` is powerful, then `A_n^3` is 6-full.  The signature becomes

   \[
                            (2,6,6),\qquad \text{sum}=\frac56.
   \]
3. If the odd part of `B_n` is powerful, then `2B_n^6` is 7-full: the
   prime 2 already has exponent at least 7, and each odd prime then has
   exponent at least 12.  The signature becomes

   \[
                            (2,7,3),\qquad \text{sum}=\frac{41}{42}.
   \]

These are deterministic implications, not existence claims.

The residual-kernel test is exact.  In the first gate the kernel triple is

\[
                         (\kappa_4(C_n^2),2,1),               \tag{4.5}
\]

and in the second it is

\[
                         (1,2,\kappa_6(A_n^3)).               \tag{4.6}
\]

In the third, the only potentially moving entry is
`kappa_7(2B_n^6)`.  Darmon--Granville forces the displayed moving kernel
to take infinitely many values in any hypothetical unbounded strict
subfamily.

### 4.3 Why EDS primitive divisors do not close the gates

Silverman proved that all but finitely many terms of an elliptic divisibility
sequence have a primitive divisor.  In the square-root denominator
normalization (4.1), Alfaraj records the exact lifting rule, for odd `p`,

\[
 v_p(B_{nm})=v_p(B_n)+v_p(m)\quad\text{when }p\mid B_n,       \tag{4.7}
\]

as well as the same rule at 2 when `2|a_1`, and strong divisibility

\[
                         \gcd(B_m,B_n)=B_{\gcd(m,n)}.          \tag{4.8}
\]

Our curve has `a_1=0`, so all these formulas apply.  They control when an
old prime reappears and how its valuation grows.  They do not control the
valuation at its first appearance.  Alfaraj's own Example 3.1 makes the
logical gap concrete: its denominator term `B_2=36` has primitive divisors
2 and 3, both already squared.

Alfaraj's Theorem 1.2 proves finiteness of **perfect powers** for a
nonintegral point on curves

\[
                         y^2=x(x^2+b),\qquad b>0.
\]

That theorem does not apply to the Mordell curve above, and even in its stated
class it does not prove finiteness of powerful terms.  A powerful term can
have exponents of mixed parity and need not be a perfect power.  Likewise,
primitive-divisor theorems cannot replace the missing exponent-one theorem.

Primary sources:

* Graham Everest, Gerard McLaren, and Thomas Ward, [*Primitive Divisors of
  Elliptic Divisibility Sequences*](https://arxiv.org/pdf/math/0409540),
  *J. Number Theory* 118 (2006), 71--89,
  [DOI 10.1016/j.jnt.2005.08.002](https://doi.org/10.1016/j.jnt.2005.08.002).
* Abdulmuhsin Alfaraj, [*On the Finiteness of Perfect Powers in Elliptic
  Divisibility Sequences*](https://jtnb.centre-mersenne.org/item/10.5802/jtnb.1244.pdf),
  *J. Theorie des Nombres de Bordeaux* 35 (2023), 247--258,
  [DOI 10.5802/jtnb.1244](https://doi.org/10.5802/jtnb.1244).

## 5. Hall--Pillai identities and the exact radical gate

### 5.1 A size-sensitive abc criterion

**Proposition 5.1 (Hall radical gate).**  Let `(X_j,Y_j,K_j)` be positive
integers with

\[
                         |X_j^3-Y_j^2|=K_j,
 \qquad \gcd(X_j,Y_j)=1,                                    \tag{5.1}
\]

where `X_j` is unbounded and `K_j=O(X_j^{1/2})`.  If for some fixed
`eta>0`

\[
                         \operatorname{rad}(K_j)
                            \ll X_j^{1/2-\eta},               \tag{5.2}
\]

then the corresponding primitive abc triples disprove abc.

**Proof.**  Equation (5.1) and coprimality imply pairwise coprimality of
`X_j`, `Y_j`, and `K_j`.  Also

\[
 Y_j\ll X_j^{3/2},
 \qquad
 H_j=3\log X_j+O(1).
\]

Therefore

\[
 \begin{aligned}
 R_j
  &=\log\operatorname{rad}(X_jY_jK_j)\\
  &\le \log X_j+\log Y_j+\log\operatorname{rad}(K_j)\\
  &\le (3-\eta)\log X_j+O(1)\\
  &=\left(1-\frac\eta3\right)H_j+O(1).
 \end{aligned}                                               \tag{5.3}
\]

The coefficient of `H_j` is strictly below one, which contradicts abc for
one fixed epsilon.  \(\square\)

The condition `K=O(X^{1/2})` alone is critical: the trivial bound
`rad(K)<=K` gives coefficient one in (5.3).  If `K` is squarefull, however,

\[
 \operatorname{rad}(K)\le K^{1/2}\ll X^{1/4},
\]

so one may take `eta=1/4`, giving slope `11/12` up to an additive constant.
For a pure fullness proof, making `K` 7-full gives signature `(3,7,2)` and
reciprocal sum `41/42`.

For any one fixed nonzero `K`, the Mordell curve \(Y^2=X^3\pm K\) has only
finitely many integral points by Siegel's theorem.  Thus every unbounded
Hall construction must let `K` move.

### 5.2 Danilov's family, normalized and proved primitive

Dujella records the identity equivalent to Danilov's construction:

\[
 \begin{aligned}
 &(z^2+6z+4)^3\\
 &\quad -(z^2+1)(z^2+9z+19)^2
       =-27(2z+11).                                          \tag{5.4}
 \end{aligned}
\]

Take a positive solution

\[
                         z^2-5w^2=-1,
 \qquad z\equiv57\pmod {125}.                               \tag{5.5}
\]

There are infinitely many such solutions.  One is `(z,w)=(682,305)`.
If \(\varepsilon_0=9+4\sqrt5\), then \(\varepsilon_0\) is a norm-one unit.
Its residue has finite multiplicative order in the finite ring
\((\mathbb Z[\sqrt5]/125\mathbb Z[\sqrt5])^\times\); multiplying the displayed
solution by powers of \(\varepsilon_0\) of that order preserves (5.5) and gives unbounded
positive solutions.

Put

\[
 \begin{aligned}
 A&=z^2+6z+4,\\
 B&=z^2+9z+19,\\
 L&=2z+11.
 \end{aligned}
\]

The congruence in (5.5) gives these divisibilities explicitly:

\[
 125\mid L,\qquad
 A\equiv20\pmod{25},\qquad
 125\mid z^2+1=5w^2.
\]

Thus `v_5(A)=1` and `5|w`.
Consequently

\[
                         X=\frac A5,\qquad
                         Y=\frac{wB}{5},\qquad
                         K=\frac{27L}{125}                   \tag{5.6}
\]

are positive integers, and (5.4) becomes

\[
                         X^3+K=Y^2.                           \tag{5.7}
\]

The pair `(X,Y)` is coprime.  First,

\[
 B-A=3(z+5),\qquad A\equiv-1\pmod{z+5},
\]

so `gcd(A,B)` divides 3; but \(A\equiv z^2+1\pmod 3\) is never zero,
and hence `gcd(A,B)=1`.  If a prime `q` divides both `A` and `w`, then
\(z^2\equiv-1\pmod q\) and

\[
                         A\equiv3(2z+1)\pmod q.
\]

The prime `q=3` is impossible; for \(q\ne3\), squaring
\(2z+1\equiv0\pmod q\) and using \(z^2\equiv-1\pmod q\) gives
`q|5`.  Thus every common prime divisor of `A` and `wB` is 5.  Since
`v_5(A)=1`, their full gcd is exactly 5, and division in (5.6) leaves
`X` coprime to `Y`.  Equation (5.7) then gives

\[
 \gcd(X,K)=\gcd(X,Y^2)=1,
 \qquad
 \gcd(Y,K)=\gcd(Y,X^3)=1,
\]

so the abc triple `(X^3,K,Y^2)` is pairwise coprime.

Finally,

\[
 X\sim\frac{z^2}{5},\qquad
 K\sim\frac{54z}{125}
      \sim\frac{54\sqrt5}{125}\sqrt X.                       \tag{5.8}
\]

This proves that Danilov supplies a genuine unbounded primitive family at
the Hall critical scale.  For the first displayed Pell solution it gives the
exact identity

\[
                         93844^3+297=28748141^2,
\]

included only as an algebra check.

What is missing is now completely localized.  Write

\[
                         s=\frac{2z+11}{125},\qquad K=27s.
\]

The identity gives no nontrivial upper bound for `rad(s)`.  If `K` were
squarefull along an unbounded subsequence, Proposition 5.1 would disprove
abc.  Since the fixed factor `27` is already cubefull, this amounts to
requiring every prime other than 3 in `s` to occur at least twice.  If `K`
were 7-full, the fixed strict signature `(3,7,2)` would apply and
Darmon--Granville would force `kappa_7(K)` to escape through infinitely
many values.

Squarefullness here is a size-sensitive Hall gate and need not itself give a
strict three-coordinate fullness signature.  Thus the strict residual-kernel
theorem is not applicable to the squarefull version unless one imposes the
stronger 7-full condition.

### 5.3 Exact perfect powers in the moving factor are a no-go

Fix `m>=2` and impose the stronger condition `s=t^m`.  Substituting

\[
                         z=\frac{125t^m-11}{2}
\]

into the Pell equation in (5.5) gives

\[
                         (2w)^2
                           =3125t^{2m}-550t^m+25.             \tag{5.9}
\]

The polynomial on the right is squarefree.  Indeed, put

\[
                         g(u)=3125u^2-550u+25.
\]

Its discriminant is `-10000`, so its two roots are distinct, and its
nonzero constant term shows neither root is zero.  If `g(t^m)` and its
derivative had a common root, then `t` would be nonzero and both
`g(t^m)` and `g'(t^m)` would vanish, contradicting the distinctness of the
roots of `g`.  Thus the degree-`2m` polynomial in (5.9) is squarefree.
The smooth projective completion of (5.9) consequently has genus

\[
                         \left\lfloor\frac{2m-1}{2}\right\rfloor=m-1\ge1.
\]

Siegel's theorem therefore gives only finitely many integral pairs `(t,w)`
for each fixed `m`.

This rules out the simplest proposal of forcing the Danilov remainder to be
one exact square, cube, or higher fixed power.  It does not prove finiteness
of squarefull `s`: the representation `s=a^2b^3` has two independently
moving variables and is not a fixed-exponent specialization of (5.9).

### 5.4 Apparent polynomial savings can be common gcd

Dujella's general polynomial construction has

\[
 x=(t^2+1)X,\qquad y=(t^2+1)^2Y,
\]

and its difference contains `(t^2+1)^3`.  Cancelling the common factor from
the three abc entries leaves

\[
                         X^3-(t^2+1)Y^2=-27(2z+11).           \tag{5.10}
\]

Thus the conspicuous repeated factor in the raw identity is not radical
compression in a primitive abc triple.  It is common scaling and disappears
under normalization.  The remaining moving coefficient and linear factor
still require arithmetic control.

Dujella proves unconditionally that, for every even positive `delta`, there
are integer polynomials of degrees `2delta` and `3delta` whose difference
has degree `delta+5`.  This approaches Davenport's optimal polynomial
exponent.  Degree cancellation controls the size of `K`; it does not control
`rad(K)` and does not supply primitivity at every specialization.

Primary sources:

* L. V. Danilov, [*The Diophantine Equation x^3-y^2=k and Hall's
  Conjecture*](https://www.mathnet.ru/eng/mzm6024), *Mathematical Notes* 32
  (1982), 617--618,
  [DOI 10.1007/BF01140190](https://doi.org/10.1007/BF01140190).
* Andrej Dujella, [*On Hall's
  Conjecture*](https://web.math.pmf.unizg.hr/~duje/pdf/hall3.pdf), *Acta
  Arithmetica* 147 (2011), 397--402,
  [DOI 10.4064/aa147-4-5](https://doi.org/10.4064/aa147-4-5).

## 6. Fixed equations and algebraic parametrizations: two genuine no-go results

### 6.1 A finite residual-kernel packet cannot work

Fix integers `p,q,r>=2` with

\[
                         \frac1p+\frac1q+\frac1r<1.          \tag{6.1}
\]

For an `m`-full integer `N`, the decomposition in Section 1 writes it
uniquely as

\[
                         N=\kappa_m(N)\rho_m(N)^m,            \tag{6.2}
\]

with `kappa_m(N)` `m`th-power-free.  Hence a primitive mixed-full point
`a+b=c` produces

\[
 AX^p+BY^q=CZ^r,                                             \tag{6.3}
\]

where `(A,B,C)` is its residual-kernel triple and
`gcd(X,Y,Z)=1`.  Darmon--Granville, Theorem 2, says that for fixed nonzero
coefficients and (6.1), equation (6.3) has only finitely many proper
solutions.  Therefore an unbounded strict mixed-full family must use
infinitely many residual-kernel triples.

This is a rigorous no-go for one fixed generalized-Fermat equation and for
every finite packet of such equations.  It does not refute a fixed Pell or
elliptic source curve: points on one source curve may induce infinitely many
triples `(A,B,C)`.  The necessary escape of those kernels is precisely the
arithmetic issue left open in Sections 3--5.

Primary source: Henri Darmon and Andrew Granville,
[*On the Equations `z^m=F(x,y)` and
`Ax^p+By^q=Cz^r`*](https://www.math.mcgill.ca/darmon/pub/Articles/Research/12.Granville/pub12.pdf),
*Bulletin of the London Mathematical Society* 27 (1995), 513--543,
[DOI 10.1112/blms/27.6.513](https://doi.org/10.1112/blms/27.6.513),
Theorem 2 on printed page 515.

### 6.2 Mason--Stothers excludes a full polynomial tripod

Call a nonzero polynomial `F` over a characteristic-zero field
**polynomial-`m`-full** when every irreducible factor occurs with
multiplicity at least `m`.  Then

\[
              \deg\operatorname{rad}(F)\le\frac{\deg F}{m}. \tag{6.4}
\]

**Theorem 6.1 (polynomial-full no-go).**  Let `A,B,C` be nonzero pairwise
coprime polynomials, at least one nonconstant, satisfying `A+B=C`.  If they
are respectively polynomial-`p`-, `q`-, and `r`-full, then

\[
                         \frac1p+\frac1q+\frac1r>1.          \tag{6.5}
\]

**Proof.**  Put

\[
                         D=\max\{\deg A,\deg B,\deg C\}>0.
\]

Mason--Stothers gives

\[
                         D+1\le\deg\operatorname{rad}(ABC). \tag{6.6}
\]

By pairwise coprimality and (6.4),

\[
 \begin{aligned}
 \deg\operatorname{rad}(ABC)
 &\le \frac{\deg A}{p}+\frac{\deg B}{q}+\frac{\deg C}{r}\\
 &\le D\left(\frac1p+\frac1q+\frac1r\right).
 \end{aligned}                                               \tag{6.7}
\]

If the reciprocal sum were at most one, (6.6)--(6.7) would give
`D+1<=D`.  This contradiction proves (6.5).  \(\square\)

Thus a one-parameter polynomial identity cannot build the strict
multiplicities into all three primitive entries.  The same conclusion
applies to a rational identity after common-denominator clearing, primitive
gcd cancellation, and verification that the resulting three polynomial
entries themselves have the claimed multiplicities.

This theorem has an exact boundary.  It does not rule out sparse integer
parameters at which polynomials with simple algebraic factors happen to take
powerful values.  It also does not rule out rational parametrizations whose
denominator clearing introduces moving residual kernels.  Those are
arithmetic-specialization problems, not polynomial-full identities.

Primary polynomial-abc sources are W. W. Stothers, *Polynomial Identities
and Hauptmoduln*, *Quarterly Journal of Mathematics* 32 (1981), 349--370,
[DOI 10.1093/qmath/32.3.349](https://doi.org/10.1093/qmath/32.3.349), and
R. C. Mason, *Diophantine Equations over Function Fields*, London
Mathematical Society Lecture Note Series 96, Cambridge University Press,
1984.

## 7. Fermat--Catalan and Campana families at the critical line

### 7.1 Cohn--Nitaj: infinitely many primitive 3-full triples

Nitaj proved Erdos's conjecture that there are infinitely many positive
solutions

\[
                              a+b=c                          \tag{7.1}
\]

in pairwise-coprime 3-full integers.  Cohn strengthened this by proving that
infinitely many such triples can be chosen with none of `a,b,c` a perfect
cube.  Cohn starts from an explicit solution associated with

\[
                         32X^3+49Y^3=81Z^3,\qquad 7\mid Y,   \tag{7.2}
\]

and gives an elementary iteration that increases the product of the base
variables while preserving the needed coprimality after removal of a
possible common factor 3.

This is a genuine primitive, height-unbounded, fixed-signature family, but
its signature is

\[
                         (3,3,3),\qquad
                         \frac13+\frac13+\frac13=1.          \tag{7.3}
\]

The standard fullness estimate therefore has slope one.  The fact that none
of the coordinates is an exact cube shows why an exact-power search is too
narrow; it does not provide the uniform radical saving required to disprove
abc.

Primary sources:

* Abderrahmane Nitaj, *On a Conjecture of Erdos on 3-Powerful Numbers*,
  *Bulletin of the London Mathematical Society* 27 (1995), 317--318,
  [DOI 10.1112/blms/27.4.317](https://doi.org/10.1112/blms/27.4.317).
* J. H. E. Cohn, *A Conjecture of Erdos on 3-Powerful Numbers*,
  *Mathematics of Computation* 67 (1998), 439--440,
  [DOI 10.1090/S0025-5718-98-00881-3](https://doi.org/10.1090/S0025-5718-98-00881-3).

### 7.2 Walsh: an elliptic critical family and exact strict upgrades

Walsh proves the following.  If `p` is an odd prime for which

\[
                         E_p:Y^2=X^3-432p^2                  \tag{7.4}
\]

has positive Mordell--Weil rank, then there are infinitely many pairwise
coprime integer solutions

\[
                         x^3+y^3=p^4z^3.                     \tag{7.5}
\]

The equation itself shows `p` cannot divide `x` or `y`; hence the three
absolute integer endpoints in (7.5) are pairwise coprime.  Normalize the
overall sign so the right side is positive.  If one cubic summand is
negative, move it to the other side; this turns every nonzero solution into
a positive primitive abc point.  The two pure cubes are 3-full, and
`p^4z^3` is also 3-full.  Infinitely many distinct solutions have unbounded
height.  This is another genuine `(3,3,3)` family and is again critical.

It has three transparent strict upgrade gates:

* if `|x|` is powerful on an unbounded subfamily, `x^3` is 6-full and the
  signature is `(6,3,3)`;
* the same statement holds with `x` and `y` exchanged;
* if `|z|` is powerful, `p^4z^3` is 4-full and the signature is
  `(3,3,4)`.

Their reciprocal sums are respectively `5/6`, `5/6`, and `11/12`.
The third endpoint is guaranteed only to be 4-full in the last gate because
the fixed prime `p` may be absent from `z`, leaving its exponent equal to
four.  No cited theorem supplies any of these powerful-coordinate
subsequences.  If one existed, Darmon--Granville would force the appropriate
residual kernel to take infinitely many values.

Primary source: P. G. Walsh,
[*A Question of Erdos on 3-Powerful Numbers and an Elliptic Curve Analogue
of the Ankeny--Artin--Chowla
Conjecture*](https://arxiv.org/pdf/2404.03970), arXiv:2404.03970v1 (2024),
Theorem 1.1.

### 7.3 The August 2026 Campana count does not decide either side

Browning and Verzobio count primitive positive mixed-full points of bounded
height.  For fixed weights `p>=q>=r`, their baseline is

\[
                         N(B)\ll_{p,q}B^{1/p+1/q}.            \tag{7.6}
\]

For `p=r+u`, `q=r+v`, with fixed `u>=v>=0` and all sufficiently large `r`,
their Theorem 1.1 proves

\[
 N(B)\ll_{\varepsilon,u,v,r}
 B^{1/p+1/q-\eta_{u,v}(r)+\varepsilon},
 \qquad
 \eta_{u,v}(r)=\frac1{r^2}+O_{u,v}(r^{-5/2})>0.             \tag{7.7}
\]

This is a genuine unconditional power saving.  Its exponent remains
positive.  It neither bounds the total number of strict Campana points nor
constructs an unbounded family.  It therefore leaves both the abc-consistent
finiteness direction and the counterexample direction active.

Primary source: Tim Browning and Matteo Verzobio,
[*Sums of Three Powerful Numbers*](https://arxiv.org/pdf/2608.24512),
arXiv:2608.24512v1, submitted 25 August 2026.

## 8. Five-condition route ledger

| Mechanism | Primitive? | Fixed strict signature or slope? | Unbounded? | Kernel status | Verdict |
|---|---|---|---|---|---|
| Walker consecutive powerful pairs | Yes | Only the critical 2-full bound | Yes | No strict kernel packet | **Critical; not a counterexample** |
| Balancing/Pell `U_n` powerful | Yes, deterministically | `(7,3,2)`, and adjacent slope `1/2`; even indices `(3,4,4)` | Conditional on infinitely many powerful terms | Must escape infinitely | **Active arithmetic gate** |
| Mordell EDS `C_n^2+2B_n^6=A_n^3` | Yes | Base signature `(2,6,3)` is critical; three strict upgrades in Section 4.2 | Yes | Upgrade kernel must move | **Critical family; upgrades active** |
| Danilov Hall family | Yes after (5.6) | Base Hall estimate is critical; squarefull `K` gives slope `11/12` | Yes | Moving `K`; exact fixed powers finite | **Critical family; squarefull-remainder gate active** |
| Cohn--Nitaj 3-full family | Yes | `(3,3,3)`, reciprocal sum one | Yes | No strict kernel packet | **Critical; not a counterexample** |
| Walsh elliptic family | Yes | `(3,3,3)`; strict only after a powerful-coordinate upgrade | Yes under positive rank | Upgrade kernel must move | **Critical family; upgrades active** |
| Fixed strict generalized-Fermat equation | Proper solutions only | Strict signature fixed | Finitely many | Kernel fixed | **Refuted as a family mechanism** |
| Finite residual-kernel packet | Yes | Strict signature fixed | Cannot be unbounded | Kernel set finite | **Refuted as a family mechanism** |
| Polynomial-full identity | Yes after primitive cancellation | Strict/already critical multiplicities impossible | No such nonconstant identity | Algebraic factors fixed | **Refuted as a family mechanism** |
| Sparse powerful polynomial values | Must be checked case by case | Potentially strict | Unknown | Values may have moving kernels | **Active; Mason does not refute it** |

Here **refuted** applies only to the stated construction mechanism.  It does
not label a route refuted merely because its required valuation theorem is
difficult or presently unknown.

## 9. Conclusions and research priorities

No genuine counterexample family was found.  The audit does, however,
separate four mathematically different frontiers.

1. The balancing-number premise remains the sharpest explicit Pell gate.
   Its square-root factorization is exact and improves the resulting radical
   slope to `1/2`, but the existence question is unchanged: two coprime Pell
   coordinates must be powerful simultaneously.  Primitive-divisor and
   perfect-power theorems do not decide this.
2. Danilov's normalized Hall identity is an unconditional primitive family
   with optimal-size remainder.  A radical saving in that moving remainder,
   such as squarefullness on an unbounded subsequence, would cross the abc
   line.  Fixed exact powers are finite for each exponent and therefore do
   not supply that saving.
3. Elliptic divisibility and Walsh families give abundant critical points.
   They become strict only through a new valuation statement for a moving
   numerator, denominator, or base coordinate.  Existing primitive-divisor
   theorems control support novelty, not first-occurrence exponent.
4. Fixed coefficient packets and full polynomial identities are closed
   negatively by Darmon--Granville and Mason--Stothers.  Sparse arithmetic
   specializations with moving kernels remain outside those no-go theorems.

The most useful positive-proof targets are therefore eventual
valuation-one theorems for the balancing sequence and for selected elliptic
divisibility coordinates.  The most useful counterexample targets are
simultaneous powerful Pell coordinates, a squarefull Danilov remainder, or a
powerful-coordinate subsequence in Walsh's family.  Each target already has
primitivity, unboundedness, and a quantified strict abc conversion; only the
stated arithmetic input is missing.

## 10. Formalization boundary

This report deliberately contains no new Lean code.  The mathematical layer
must be settled before formalization.  Suitable future kernel-checked targets
are the elementary deterministic implications:

* the factorization `U_n=A_nB_n`, coprimality, parity split, adjacent point,
  and radical bound (3.18);
* the explicit Mordell identity (4.2), its pairwise primitivity, and the
  three conditional strict signatures;
* the Danilov algebraic identity after assuming the Pell congruence and the
  elementary gcd lemmas used in (5.6)--(5.7);
* the general mixed-full radical inequality and the implication from an
  explicitly unbounded strict family to the negation of the unchanged
  standard `ABCConjecture`.

Darmon--Granville, Mason--Stothers, Siegel, Carmichael, Sanna, Silverman,
Browning--Verzobio, and the existence theorems of Nitaj, Cohn, and Walsh are
external mathematical inputs.  They must be cited as such rather than
introduced into Lean as unproved project axioms.  In particular, no future
Lean file may assert an unbounded powerful Pell subsequence, a squarefull
Danilov remainder, or a powerful elliptic coordinate unless a separate
mathematical proof has first been supplied.
