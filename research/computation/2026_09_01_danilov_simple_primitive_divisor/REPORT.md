# Simple primitive divisors at the Danilov Fibonacci indices

**Date:** 2026-09-01  
**Author:** ChatGPT  
**Status:** rigorous mathematical report, primary-source audit, bounded exact
computation, and Lean-checked elementary no-go and powerful-part cores

## 0. Verdict and logical scope

This attack does **not** prove or disprove the standard abc conjecture. It
also does not prove that every adaptively generated Danilov index has a
valuation-one primitive Fibonacci divisor. The route remains active.

The investigation gives the following unconditional conclusions.

1. Let $n>5$ be divisible by $5$, and let $p$ be a primitive prime divisor
   of $F_n$. Then

   \[
                         z(p)=n,\qquad p\equiv1\pmod n.       \tag{0.1}
   \]

2. Such a primitive divisor is repeated in $F_n$ if and only if it is a
   Fibonacci--Wieferich, or Wall--Sun--Sun, prime:

   \[
       v_p(F_n)\ge2
       \quad\Longleftrightarrow\quad
       p^2\mid F_{p-1}.                                    \tag{0.2}
   \]

   Here the standard Wall--Sun--Sun index
   $p-\left(\frac5p\right)$ equals $p-1$ because every primitive divisor at
   such an $n$ is split.

3. The Fibonacci cyclotomic factor $C_n$ has at most one nonprimitive prime
   divisor. That exceptional prime, if present, is the greatest prime factor
   of $n$ and occurs in $C_n$ to exponent one. At the current 4398-digit
   Danilov modulus $Q_*$, with $n_*=10Q_*$, the exception is impossible.
   Consequently every prime factor of $C_{n_*}$ is primitive.

4. Therefore, if $F_{n_*}$ has no simple primitive divisor, then $C_{n_*}$
   is a powerful integer supported entirely on Wall--Sun--Sun primes
   $p\equiv1\pmod {n_*}$. Haojie Hong's explicit
   large-primitive-divisor theorem, combined with this split congruence,
   forces at least one such prime to satisfy

   \[
                              p\ge41n_*+1.                  \tag{0.3}
   \]

   This is an explicit necessary condition, not a contradiction.

5. There is a complete counterexample to a tempting sequence-uniform
   generalization. For the real, nondegenerate, coprime-parameter Lucas
   sequence

   \[
      U_0=0,\quad U_1=1,\quad U_{m+2}=2U_{m+1}+3U_m,
   \]

   the only primitive prime divisor of $U_{10}$ is $11$, and
   $11^2\parallel U_{10}$. This closes only the assertion that the standard
   real-Lucas hypotheses force a simple primitive divisor at every index
   $10Q$. It does not refute the Fibonacci-specific assertion needed by the
   Danilov route.

6. A bounded exact search certifies a simple primitive divisor for 207 of the
   252 squarefree $Q\le1000$ with $\gcd(Q,30)=1$, using primes
   $p\le50{,}000{,}000$. The other 45 cases are unresolved by this bound;
   none is a counterexample.

The labels used below are strict:

* **Theorem** means an unconditional mathematical consequence with a proof.
* **Conditional** means that every extra hypothesis is displayed.
* **Finite certificate** means an exact assertion only over the stated finite
  range.
* **Open bottleneck** means neither a proof nor a disproof was obtained.

## 1. Fibonacci notation and the exact target

Let

\[
 F_0=0,\quad F_1=1,\quad F_{m+2}=F_{m+1}+F_m,
 \qquad
 L_0=2,\quad L_1=1,\quad L_{m+2}=L_{m+1}+L_m.             \tag{1.1}
\]

For a prime $p$, its Fibonacci rank of apparition is

\[
                   z(p)=\min\{m\ge1:p\mid F_m\}.           \tag{1.2}
\]

A prime $p$ is a **primitive divisor** of $F_n$ if $p\mid F_n$ and
$p\nmid F_m$ for $1\le m<n$. For $p\ne5$, this is equivalent to
$z(p)=n$. It is **simple primitive** when in addition $v_p(F_n)=1$.

For $p\ne2,5$, put

\[
                         \epsilon_p=\left(\frac5p\right).
\]

Following the primary computational literature, call $p$ a
Fibonacci--Wieferich or Wall--Sun--Sun prime when

\[
                         p^2\mid F_{p-\epsilon_p}.          \tag{1.3}
\]

The recursive Danilov lift report proves that a simple divisor of
$F_{10Q}$ supplies a nonzero local slope and a fresh prime-square digit. A
primitive divisor is automatically fresh. The exact unresolved assertion is:

> **SPD(10Q).** For every squarefree modulus $Q$ occurring in the adaptive
> Danilov recursion, $F_{10Q}$ has a primitive divisor $p$ with
> $v_p(F_{10Q})=1$.

Carmichael's theorem, in the exact Fibonacci form proved by Yabuta, gives a
primitive divisor of $F_n$ for every $n\notin\{1,2,6,12\}$. It proves
existence at $n=10Q$, but contains no multiplicity-one conclusion.

## 2. Rank, splitting, and the congruence \(p\equiv1\pmod n\)

### Theorem 2.1 (rank divides the Frobenius exponent)

Let $p\ne2,5$ be prime. Then

\[
                            z(p)\mid p-\epsilon_p.          \tag{2.1}
\]

#### Proof

Let

\[
             \alpha=\frac{1+\sqrt5}{2},\qquad
             \beta =\frac{1-\sqrt5}{2},\qquad
             \gamma=\frac{\alpha}{\beta}.
\]

Work in the splitting field of $X^2-X-1$ over $\mathbf F_p$. If
$\epsilon_p=1$, Frobenius fixes $\alpha,\beta$, so
$\gamma^{p-1}=1$. If $\epsilon_p=-1$, Frobenius exchanges the two roots,
so $\gamma^p=\gamma^{-1}$ and hence $\gamma^{p+1}=1$. Since

\[
                       F_m=\beta^m\frac{\gamma^m-1}{\alpha-\beta},
\]

and $\beta(\alpha-\beta)$ is a unit modulo $p$, it follows that
$p\mid F_{p-\epsilon_p}$. If $p\mid F_m$, strong divisibility
$\gcd(F_a,F_b)=F_{\gcd(a,b)}$ and the minimality of $z(p)$ imply
$z(p)\mid m$. Applying this to $m=p-\epsilon_p$ proves (2.1). \(\square\)

### Corollary 2.2 (all primitive primes split at a multiple of five)

Let $n>5$ with $5\mid n$, and let $p$ be a primitive divisor of $F_n$. Then

\[
                            p\equiv1\pmod n.                \tag{2.2}
\]

#### Proof

The primitive primes $2$ and $5$ first occur at indices $3$ and $5$, so the
hypothesis $n>5$ excludes them. Thus $z(p)=n$, and Theorem 2.1 gives
$n\mid p-\epsilon_p$. Reducing modulo $5$ gives
$p\equiv\epsilon_p\pmod5$. Quadratic reciprocity gives
$\epsilon_p=(5/p)=(p/5)$, since $5\equiv1\pmod4$. If
$\epsilon_p=-1$, then $p\equiv-1\pmod5$, but $-1$ is a quadratic residue
modulo $5$, forcing $(p/5)=1$, a contradiction. Thus
$\epsilon_p=1$, and $n\mid p-1$. \(\square\)

This removes the inert congruence $p\equiv-1\pmod n$ completely at the
Danilov indices $n=10Q$.

## 3. Multiplicity is exactly a Wall--Sun--Sun condition

### Theorem 3.1 (valuation transfer to the Wall exponent)

Let $n>5$ with $5\mid n$, and let $p$ be primitive at $F_n$. Then

\[
                        v_p(F_n)=v_p(F_{p-1}).              \tag{3.1}
\]

Consequently

\[
 p\parallel F_n
 \quad\Longleftrightarrow\quad
 p^2\nmid F_{p-1},                                        \tag{3.2}
\]

and $v_p(F_n)\ge2$ if and only if $p$ is Wall--Sun--Sun.

#### Proof

By Corollary 2.2, $z(p)=n\mid p-1$, and $p>n$, so
$v_p(n)=v_p(p-1)=0$. The exact Fibonacci valuation formula recorded as
Theorem 1.1 in Sanna's paper is

\[
 v_p(F_m)=
 \begin{cases}
 v_p(m)+v_p(F_{z(p)}),&z(p)\mid m,\\
 0,&z(p)\nmid m,
 \end{cases}                                               \tag{3.3}
\]

for $p\ne2,5$. Applying it first to $m=n=z(p)$ and then to $m=p-1$
gives (3.1). Since here $\epsilon_p=1$, definition (1.3) is precisely
$p^2\mid F_{p-1}$. \(\square\)

Thus a failure of SPD(10Q) is stronger than the existence of one
Wall--Sun--Sun prime: **every** primitive divisor of $F_{10Q}$ would have to
be Wall--Sun--Sun.

### Proposition 3.2 (unit and Lucas-quotient forms)

Under the hypotheses of Theorem 3.1, assume in addition that $n$ is even, and
put

\[
                   k=\frac{p-1}{n},\qquad
                   s=\overline{\frac{L_n}{2}}\in\mathbb F_p.
\]

Then $s\in\{1,-1\}$, and

\[
 \frac{F_{p-1}}p
 \equiv
 k s^{\,k-1}\frac{F_n}p\pmod p.                            \tag{3.4}
\]

In particular the coefficient $ks^{k-1}$ is nonzero modulo $p$, so (3.4)
is an exact valuation-one test, rather than a one-way implication.
Equivalently, with $\gamma=\alpha/\beta=-\alpha^2$,

\[
 p^2\mid F_n
 \Longleftrightarrow \gamma^n\equiv1\pmod {p^2}
 \Longleftrightarrow \gamma^{p-1}\equiv1\pmod {p^2}.       \tag{3.5}
\]

#### Proof

Because $n$ is even, $\alpha^n\beta^n=1$. Modulo $p$, the congruence
$p\mid F_n$ makes $\alpha^n$ and $\beta^n$ equal to a common value $s$,
and hence $s^2=1$ and $L_n\equiv2s\pmod p$.

The standard composition identity is

\[
                    \frac{F_{kn}}{F_n}=U_k(L_n,1),         \tag{3.6}
\]

where $U_k(P,Q)$ denotes the first Lucas sequence attached to roots of
$X^2-PX+Q$. When its two roots coincide at $s$,
$U_k(2s,1)=ks^{k-1}$. Divide the integer identity (3.6) by $p$, reduce
modulo $p$, and use $kn=p-1$ to obtain (3.4). Neither $p\mid k$ nor
$p\mid s$, so its coefficient is nonzero.

For (3.5), $p\ne5$ makes all denominators in Binet's formula units. Write
$\gamma^n=1+pa\pmod {p^2}$. Since $k<p$,
$(1+pa)^k\equiv1+kpa\pmod {p^2}$, and $k$ is a unit modulo $p$.
This proves both equivalences. \(\square\)

The Lucas quotient therefore reformulates the obstruction but does not make
it disappear: its vanishing is exactly the Wall--Sun--Sun congruence.

The added parity hypothesis is necessary for the displayed unit form.  The
omitted odd-index extension is false under all of its formerly stated
hypotheses: take $n=15$ and $p=61$.  Since
$F_{15}=610$, while $F_1=1,F_3=2,F_5=5$, the strong divisibility property
gives $z(61)=15$; thus $61$ is primitive at index $15$.  On the other hand,

\[
  s\equiv L_{15}/2\equiv 11\pmod {61},
  \qquad s^2\equiv-1\pmod {61},
\]

so $s\notin\{1,-1\}$.  In general the correct identities use
$s^2=(-1)^n$ and
$F_{kn}/F_n=U_k(L_n,(-1)^n)$.  This counterexample closes only the
parity-free formulation of Proposition 3.2.  Every Danilov index used here is
$n=10Q$ and hence even, so the route and all subsequent applications are
unchanged.

## 4. The Fibonacci cyclotomic factor and the powerful-part constraint

Define the $n$-th Fibonacci cyclotomic factor by

\[
 C_n=
 \left|
   \prod_{\substack{1\le j\le n\\(j,n)=1}}
       (\alpha-\zeta_n^j\beta)
 \right|.                                                   \tag{4.1}
\]

It is an integer, and the usual cyclotomic factorization of $F_n$ is the
product of the $C_d$ over divisors $d\mid n$, with the harmless initial
factor suppressed.

### Theorem 4.1 (one possible nonprimitive correction)

Let $n>2$ be divisible by $10$. There is a factorization

\[
                              C_n=\delta_n M_n              \tag{4.2}
\]

with the following properties.

1. Every prime factor of $M_n$ is primitive at $F_n$, with the same
   exponent in $M_n$, $C_n$, and $F_n$.
2. Either $\delta_n=1$, or $\delta_n=P(n)$, the greatest prime factor of
   $n$.
3. If $\delta_n=P(n)$, it occurs to exponent exactly one in $C_n$ and is
   nonprimitive.

#### Proof

Yabuta's Lemma 1 states the needed local fact. If a prime $q$ divides
$C_n$ and also an earlier cyclotomic factor, then

\[
                    q^2\nmid C_n,\qquad n=q^a z(q)         \tag{4.3}
\]

for some $a\ge1$. Hence any nonprimitive divisor occurs exactly once.

The cases $q=2$ and $q=5$ are incompatible with $10\mid n$: their ranks
are $z(2)=3$ and $z(5)=5$, while (4.3) would make $n$ respectively of
the form $2^a3$ or $5^{a+1}$. Thus $q\ne2,5$, and Theorem 2.1 gives
$z(q)\mid q\pm1$. Every prime divisor $r\ne q$ of $n=q^az(q)$ divides
$z(q)$. No such $r$ can exceed $q$: if $r\mid q+1$ and $r>q$, then
$r=q+1$, impossible because $q+1>2$ is even; the $q-1$ case is
immediate. Hence $q=P(n)$. There can therefore be at most one
nonprimitive divisor, and (4.2) follows. \(\square\)

### Corollary 4.2 (exact shape of total multiplicity degeneration)

Assume $n>2$ and $10\mid n$, and suppose $F_n$ has no simple primitive
divisor. In the factorization (4.2), $M_n$ is powerful, and every prime
$p\mid M_n$ satisfies

\[
                    p\equiv1\pmod n,\qquad p^2\mid F_{p-1}. \tag{4.4}
\]

There are unique integers $A_n,B_n\ge1$, with $B_n$ squarefree, such that

\[
                         M_n=A_n^2B_n^3,                   \tag{4.5}
\]

and the prime support of $A_nB_n$ consists entirely of the primes in
(4.4). Moreover

\[
                  \operatorname{rad}(C_n)^2
                  \le \delta_n C_n\le P(n)C_n.             \tag{4.6}
\]

If $\delta_n=1$, then also

\[
 C_n\equiv1\pmod n,\qquad
 \frac{C_n-1}{n}\equiv
 \sum_{p^e\parallel C_n}e\,\frac{p-1}{n}\pmod n.           \tag{4.7}
\]

#### Proof

Theorem 3.1 and Corollary 2.2 give (4.4). For every exponent $e\ge2$, write
$e=2a+3b$ uniquely with $a\ge0$ and $b\in\{0,1\}$; this gives (4.5).
Also $\operatorname{rad}(M_n)^2\le M_n$. Since the correction prime is
coprime to $M_n$ and occurs once,

\[
 \operatorname{rad}(C_n)^2
 =\delta_n^2\operatorname{rad}(M_n)^2
 \le\delta_n^2M_n=\delta_n C_n,
\]

which proves (4.6). If $\delta_n=1$, write every
$p=1+n k_p$; multiplying $(1+nk_p)^e$ modulo $n^2$ gives (4.7).
\(\square\)

Yabuta's proof also supplies the unconditional lower estimate

\[
                    C_n>\frac25\left(\frac32\right)^{\varphi(n)}
                    \qquad(n>2).                           \tag{4.8}
\]

This estimate proves primitive-divisor existence after the usual finite
exceptions. It does not contradict (4.5): large powerful integers are fully
compatible with an exponential lower bound. Thus cyclotomic size alone does
not control the multiplicity of any prime factor.

## 5. Specialization to the current 4398-digit Danilov state

Let $Q_*$ be the final exact modulus in
**research/computation/2026_09_01_danilov_recursive_lift/search_stage13_100m.json**,
and put

\[
                              n_*=10Q_*.                    \tag{5.1}
\]

The previously verified recursive chain gives

\[
\begin{aligned}
 &Q_*\text{ is squarefree},\qquad \gcd(Q_*,30)=1,\\
 &Q_*\text{ has 4398 decimal digits and 638 distinct prime factors},\\
 &\max\{q:q\mid Q_*\}=99{,}966{,}059<10^8.                 \tag{5.2}
\end{aligned}
\]

Consequently $n_*$ is squarefree, has 4399 digits and 640 distinct prime
factors, and all its prime factors are at most $10^8$.

### Theorem 5.1 (the cyclotomic correction vanishes)

Every prime divisor of $C_{n_*}$ is primitive at $F_{n_*}$; equivalently,

\[
                              \delta_{n_*}=1.               \tag{5.3}
\]

#### Proof

If a nonprimitive correction $q$ existed, (4.3), the fact
$q\nmid z(q)$, and squarefreeness would give $n_*=qz(q)$. Theorem 2.1 and
(5.2) would then give

\[
 n_*\le q(q+1)\le10^8(10^8+1).
\]

But $n_*\ge10^{4398}$, a contradiction. \(\square\)

### Theorem 5.2 (Hong plus splitting forces a large primitive prime)

The number $F_{n_*}$ has a primitive prime divisor $p$ with

\[
                              p\ge41n_*+1.                  \tag{5.4}
\]

#### Proof

Hong's Theorem 1.1 states that, for fixed $\kappa\le10^6$ and sufficiently
large explicitly bounded $n$, $F_n$ has a primitive divisor distinct from
$jn\pm1$ for every $1\le j\le\kappa$. His Table 2 gives $n_0=10036$ for
$\kappa=40$, with the hypothesis $n\ge\exp(n_0)$.

Here $n_*\ge10^{4398}$, and the elementary bound $\log10>2.3$ gives

\[
                         \log n_*>4398(2.3)=10115.4>10036.
\]

Hong therefore supplies a primitive $p$ outside the eighty values
$jn_*\pm1$, $1\le j\le40$. Hong alone gives the generic lower bound
$p\ge41n_*-1$. Corollary 2.2 additionally gives $p=k n_*+1$; avoiding
$jn_*+1$ for $j\le40$ forces $k\ge41$, and hence proves (5.4). \(\square\)

### Corollary 5.3 (the exact surviving bad case)

If SPD($n_*$) fails, then all of the following hold simultaneously:

1. $C_{n_*}$ itself is powerful; there is no correction factor.
2. Every $p\mid C_{n_*}$ is primitive, satisfies $p\equiv1\pmod {n_*}$,
   and is Wall--Sun--Sun.
3. At least one such Wall--Sun--Sun prime satisfies $p\ge41n_*+1$.
4. Equations (4.5)--(4.7) hold with $\delta_{n_*}=1$.

This is unconditional as an implication. Its antecedent has not been proved
or disproved. The conclusion is far outside every audited finite
Wall--Sun--Sun search, because already $p>10^{4398}$.

The independent replay of Hong's Appendix A1 numerically finds that
$\kappa=45$ also lies below the actual $\log n_*$, while $\kappa=46$ does
not. This floating-point replay is supporting computation only. Theorem 5.2
deliberately uses the published table entry $\kappa=40$, so its proof is not
dependent on that replay.

## 6. A complete no-go for the sequence-uniform shortcut

Consider the standard first Lucas sequence with parameters $P=2$, $Q=-3$:

\[
 U_0=0,\quad U_1=1,\quad U_{m+2}=P U_{m+1}-Q U_m
                         =2U_{m+1}+3U_m.                   \tag{6.1}
\]

Its characteristic polynomial is $X^2-2X-3$, with real roots $3,-1$.
The parameters are coprime, the discriminant is $16\ne0$, and the root
ratio $-3$ is not a root of unity. Thus this is a real, nondegenerate Lucas
sequence satisfying the standard coprime-parameter hypotheses.

Direct recurrence gives

\[
 (U_0,\ldots,U_{10})=
 (0,1,2,7,20,61,182,547,1640,4921,14762),                 \tag{6.2}
\]

and

\[
                    U_{10}=14762=2\cdot11^2\cdot61.        \tag{6.3}
\]

The factor $2$ already occurs at index $2$, and $61$ already occurs at
index $5$. No term $U_1,\ldots,U_9$ is divisible by $11$. Hence the only
primitive prime divisor at index $10$ is $11$, and its exponent is two. The
homogeneous cyclotomic factor makes the obstruction especially transparent:

\[
 \Phi_{10}(3,-1)
 =3^4-3^3(-1)+3^2(-1)^2-3(-1)^3+(-1)^4
 =121.                                                      \tag{6.4}
\]

This is a full counterexample to the following exact statement:

> Every real nondegenerate Lucas sequence with coprime parameters has a
> simple primitive prime divisor at every index $10Q$.

It proves that Carmichael/Bilu--Hanrot--Voutier existence, the rank
congruence, and a cyclotomic lower bound cannot by themselves imply
multiplicity one uniformly over real Lucas sequences. The example is **not**
a Fibonacci or Danilov full-hypothesis counterexample and gives no reason to
close SPD(10Q).

## 7. Bounded exact Fibonacci search

The script **search_small_fibonacci_simple_primitive.py** exhaustively treated

\[
 1\le Q\le1000,\qquad Q\text{ squarefree},\qquad\gcd(Q,30)=1,              \tag{7.1}
\]

and scanned primes $p\le50{,}000{,}000$. There are exactly 252 eligible
values of $Q$. For each saved certificate at $n=10Q$, it verifies

\[
\begin{aligned}
 &p\text{ is prime},\qquad p\equiv1\pmod n,\qquad F_n\equiv0\pmod p,\\
 &F_{n/r}\not\equiv0\pmod p\quad\text{for every prime }r\mid n,\\
 &F_n\not\equiv0\pmod {p^2}.                              \tag{7.2}
\end{aligned}
\]

The middle line proves $z(p)=n$: if the rank were a proper divisor of $n$,
it would divide $n/r$ for some prime $r\mid n$. Fibonacci residues are
computed by exact fast doubling, and certificate primality is independently
checked by trial division through $\lfloor\sqrt p\rfloor$.

The result is

\[
                  207\text{ certified},\qquad45\text{ unresolved}.        \tag{7.3}
\]

The unresolved $Q$'s are

\[
\begin{gathered}
29,37,67,71,89,133,161,203,269,287,329,331,341,353,389,\\
449,457,473,479,527,541,553,557,589,611,619,629,641,659,\\
671,713,719,721,773,793,817,839,869,877,887,899,907,913,919,941.
\end{gathered}                                              \tag{7.4}
\]

“Unresolved” means only that no simple primitive certificate was found below
the stated prime cutoff. It means neither that all primitive divisors are
repeated nor that any Wall--Sun--Sun prime was found. This finite search does
not close, weaken, or prove the infinite Danilov route.

## 8. Primary-literature audit through 2026-09-01

Only primary papers or publisher/author copies are used for mathematical
claims in this report.

1. **Primitive existence and the cyclotomic correction.** Minoru Yabuta,
   “A Simple Proof of Carmichael's Theorem on Primitive Divisors,” *The
   Fibonacci Quarterly* **39** (2001), 439--443. Theorem 3 gives a primitive
   divisor of $F_n$ exactly outside $n=1,2,6,12$. Lemma 1 gives (4.3),
   including exponent one for a nonprimitive cyclotomic divisor. The source
   does not assert that a primitive divisor occurs to exponent one.
   [Official PDF](https://www.fq.math.ca/Scanned/39-5/yabuta.pdf)

2. **Exact valuations.** Carlo Sanna, “The $p$-adic Valuation of Lucas
   Sequences,” *The Fibonacci Quarterly* **54** (2016), 118--124. Theorem
   1.1 records formula (3.3) for Fibonacci numbers; the more general Lucas
   formulas follow later in the paper.
   [Official PDF](https://www.fq.math.ca/Papers1/54-2/Sanna02242016.pdf)

3. **Wall--Sun--Sun equivalences and the first large search.** Richard J.
   McIntosh and Eric L. Roettger, “A Search for Fibonacci-Wieferich and
   Wolstenholme Primes,” *Mathematics of Computation* **76** (2007),
   2087--2094, proves several equivalent Lucas-Wieferich congruences in
   Theorem 1 and reports no Fibonacci-Wieferich prime below $2\cdot10^{14}$.
   [DOI](https://doi.org/10.1090/S0025-5718-07-01955-2)

4. **Independent period-lift search.** Andreas-Stephan Elsenhans and Jörg
   Jahnel, “The Fibonacci Sequence Modulo $p^2$ -- An Investigation by
   Computer for $p<10^{14}$,” proves that the exceptional period lift does
   not occur in that range.
   [Author preprint](https://arxiv.org/abs/1006.0824)

5. **Extended exhaustive search.** François G. Dorais and Dominic Klyve,
   “A Wieferich Prime Search up to $6.7\cdot10^{15}$,” *Journal of Integer
   Sequences* **14** (2011), Article 11.9.2, reports no Fibonacci-Wieferich
   prime below $9.7\cdot10^{14}$.
   [Journal PDF](https://cs.uwaterloo.ca/journals/JIS/VOL14/Klyve/klyve3.pdf)

6. **Current explicit statement of the open status.** Nicholas Bragman and
   Eric Rowland, “Limiting Density of the Fibonacci Sequence Modulo Powers of
   a Prime,” *Research in Number Theory* **11** (2025), Article 88, explicitly
   records that no Wall--Sun--Sun prime is known and gives modern $p$-adic
   characterizations. It does not prove their nonexistence.
   [Publisher article](https://doi.org/10.1007/s40993-025-00667-1)

7. **Large primitive divisors.** Haojie Hong, “On Big Primitive Divisors of
   Fibonacci Numbers,” *Ramanujan Journal* **67** (2025), Article 20, proves
   Theorem 1.1 used in Theorem 5.2. It forces a primitive divisor outside a
   prescribed finite list of linear candidates but does not force valuation
   one.
   [Author preprint](https://arxiv.org/abs/2312.04354),
   [published DOI](https://doi.org/10.1007/s11139-025-01068-9)

The audited literature therefore does not supply the unconditional
valuation-one statement required here. The recent large-divisor theorem
strengthens the location of a necessary bad prime, while the 2025
$p$-adic work confirms that the underlying Wall--Sun--Sun question remains
open. Any abc-conditional valuation-separation statement is ineligible for
an unconditional abc proof and has not been used.

## 9. What each attempted mechanism can and cannot prove

The logical boundary is now precise.

* **Rank of apparition:** proves freshness and the residue class
  $p\equiv1\pmod {10Q}$. It does not control $v_p(F_{10Q})$.
* **LTE / Sanna valuation lifting:** transfers the exponent exactly to the
  Wall exponent $v_p(F_{p-1})$. It identifies the obstruction but does not
  rule it out.
* **Lucas quotient:** gives the nonzero-coefficient identity (3.4). Its
  vanishing is exactly the same obstruction.
* **Cyclotomic primitive part:** removes all but one possible nonprimitive
  factor, and removes even that factor at the current index. Exponential
  size alone is compatible with a powerful cyclotomic value.
* **Hong's theorem:** forces one primitive prime beyond $41n_*$. It controls
  size, not exponent.
* **Finite Wall--Sun--Sun and direct Fibonacci searches:** exclude only their
  explicit finite ranges. The current forced primitive prime lies vastly
  beyond them.
* **General real-Lucas transfer:** is false under its full standard
  hypotheses by Section 6. This closes that exact shortcut only.

A sufficient next theorem remains

\[
 \boxed{\text{For each adaptive squarefree }Q,
        \text{ some primitive }p\mid F_{10Q}
        \text{ is not Wall--Sun--Sun.}}                    \tag{9.1}
\]

The negation for one $Q$ is not the existence of a single Wall--Sun--Sun
prime; it requires **all** primitive primes at that index to be
Wall--Sun--Sun. At the current state, Theorem 5.1 makes this equivalent to the
whole cyclotomic value $C_{10Q}$ being powerful. No full-hypothesis Fibonacci
counterexample was found. The route is unresolved and must not be abandoned
for difficulty or for the bounded no-hit at $10^8$ in the preceding
recursive search.

## 10. Lean formalization boundary

Only after the mathematical proof and exact counterexample were complete, the
module
`Lean/IUTThreeClosures/DanilovSimplePrimitiveNoGo20260901.lean` was written.
It kernel-checks the full standard real-Lucas counterexample at index ten:
the recurrence values, factorization, primitive-divisor classification, exact
square multiplicity of `11`, and negation of the sequence-uniform shortcut.
It separately checks the parity counterexample `n=15,p=61`, including the
complete earlier-term primitiveness test and the half-Lucas residue in
`ZMod 61`, and proves that every Danilov index `10Q` is even.  It also
formalizes abstract consequences saying that repeated primitive
factors make the primitive part powerful, that all exponent-one support is
confined to a finite correction set, and that a split primitive divisor which
avoids the first forty linear candidates is at least `41n+1`.

The companion module does not formalize Sanna's Fibonacci valuation theorem,
Yabuta's cyclotomic correction theorem, Hong's large-primitive-divisor
theorem, the 4399-digit Fibonacci index, or the bounded prime searches.  These
remain cited paper theorems and replayed computations; none is inserted as a
Lean axiom.  In particular, Lean proves neither SPD(`10Q`) nor its negation for
the adaptive Fibonacci states.

## 11. Reproducibility boundary

The permanent bundle
**research/computation/2026_09_01_danilov_simple_primitive_divisor/**
contains four independent checks.

1. **verify_small_fibonacci_certificates.py** rechecks all 207 saved
   prime/rank/valuation-one certificates and the 252-case partition.
2. **verify_real_lucas_counterexample.py** replays every term and factor in
   Section 6.
3. **verify_final_state_constraints.py** reconstructs the 638-factor modulus
   from the prior recursive-lift JSON certificates, checks the digit and
   prime-bound consequences, and verifies the elementary Hong threshold.
4. **replay_hong_threshold.py** independently replays the floating-point
   Appendix A1 calculation. It is supporting evidence only; the rigorous
   theorem uses Hong's printed $\kappa=40$ table entry.

Its **REPRODUCE.md**, **source-metadata.json**, **FILE_MANIFEST.json**, and
**SHA256SUMS** give the exact commands, source provenance, file sizes, and
hashes. None of these finite artifacts is a Lean formalization or a proof of
SPD(10Q), of a global Danilov sieve, or of abc.
