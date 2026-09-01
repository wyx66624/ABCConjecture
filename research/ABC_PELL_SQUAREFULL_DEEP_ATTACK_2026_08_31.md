# Squarefull balancing numbers and the Pell counterexample route: a half-slope gate, index descent, and the Wieferich frontier

Author: ChatGPT. Date: 2026-08-31.

## 0. Outcome and claim discipline

This report continues the counterexample search and the positive-proof search
in parallel.  It does **not** claim a counterexample to the standard abc
conjecture.  It also does **not** prove that the Pell route has only finitely
many squarefull terms.

Let

\[
 u_n=\frac{(3+\sqrt 8)^n-(3-\sqrt 8)^n}{2\sqrt 8},
 \qquad n\geq 0.                                             \tag{0.1}
\]

Thus

\[
 u_0=0,\quad u_1=1,\qquad u_{n+2}=6u_{n+1}-u_n.             \tag{0.2}
\]

This is the balancing-number sequence, equivalently the Lucas sequence
`U_n(6,1)`.  The requested dichotomy remains unresolved: no unbounded
squarefull subsequence of `(u_n)` was proved, and no theorem was found that
forces an exponent-one prime divisor in every sufficiently large `u_n`.

The unconditional progress is as follows.

1.  There is an exact coprime factorization `u_n=A_n B_n`, where
    `(1+sqrt(2))^n=A_n+B_n sqrt(2)`.  Consequently `u_n` is squarefull if
    and only if both `A_n` and `B_n` are squarefull.
2.  The two factors give a primitive adjacent abc point of radical slope
    `1/2`.  Hence an unbounded squarefull subsequence of `(u_n)` would imply
    the negation of the unchanged standard abc conjecture.  For even indices
    the same point has the fixed strict mixed-full signature `(3,4,4)`.
3.  Sanna's exact valuation formula turns squarefullness into an index
    saturation rule.  A fully checked finite propagation proves that every
    even squarefull index would be divisible by

    \[
      4\cdot3\cdot5\cdot7\cdot11\cdot17\cdot29\cdot41\cdot239
      =22{,}318{,}790{,}340.                                  \tag{0.3}
    \]

    This large divisor is a finite arithmetic certificate, not an
    asymptotic nonexistence theorem.
4.  A stronger structural descent holds.  If `u_N` is squarefull and
    `N>1`, and `ell` is the largest prime divisor of `N`, then `ell` is odd
    and `u_ell` itself is squarefull.  Thus it is enough, in order to close
    the whole route, to prove that `u_ell` is not squarefull for every odd
    prime `ell`.
5.  Every squarefull `u_n`, `n>=3`, requires a primitive divisor whose
    first occurrence is already squared, hence a balancing-Wieferich prime.
    Infinitely many squarefull terms would force infinitely many distinct
    balancing-Wieferich primes.  At a prime index `ell`, squarefullness is
    stronger still: it forces at least two distinct balancing-Wieferich
    primes having the same rank `ell`.

The archived primary sources and checksums are recorded in
`research/sources/pell_squarefull_deep_2026_08_31/source-metadata.json`.

## 1. Two Pell sequences inside the balancing sequence

Put

\[
                    \delta=1+\sqrt2,\qquad \delta'=1-\sqrt2
\]

and define integers `A_n,B_n` by

\[
                    \delta^n=A_n+B_n\sqrt2.                  \tag{1.1}
\]

Conjugation gives `delta'^n=A_n-B_n sqrt(2)`, so

\[
 A_n=\frac{\delta^n+\delta'^n}{2},\qquad
 B_n=\frac{\delta^n-\delta'^n}{2\sqrt2}.                    \tag{1.2}
\]

The sequence `(B_n)` is the standard Pell sequence and `(2A_n)` is its
usual Pell--Lucas companion.  Both satisfy

\[
                    T_{n+2}=2T_{n+1}+T_n,                    \tag{1.3}
\]

with `(A_0,A_1)=(1,1)` and `(B_0,B_1)=(0,1)`.

### Theorem 1.1 (exact square-root factorization)

Let `x_n,u_n` be defined by

\[
                  (3+\sqrt8)^n=x_n+u_n\sqrt8.                \tag{1.4}
\]

Then, for every `n>=0`,

\[
 \boxed{x_n=A_n^2+2B_n^2,\qquad u_n=A_nB_n}                  \tag{1.5}
\]

and

\[
                  A_n^2-2B_n^2=(-1)^n.                       \tag{1.6}
\]

Moreover `gcd(A_n,B_n)=1`, `A_n` is odd, and `B_n` has the same parity as
`n`.

**Proof.**  Since `(1+sqrt(2))^2=3+sqrt(8)`, squaring (1.1) gives

\[
 (3+\sqrt8)^n=(A_n+B_n\sqrt2)^2
 =A_n^2+2B_n^2+A_nB_n\sqrt8,
\]

which is (1.5).  Taking norms in (1.1) gives (1.6).  A common divisor of
`A_n` and `B_n` would divide the left side of (1.6), hence would divide 1.
The recurrences

\[
 A_{n+1}=A_n+2B_n,\qquad B_{n+1}=A_n+B_n
\]

show modulo 2 that every `A_n` is odd and that `B_n` alternates parity.
\(\square\)

### Corollary 1.2 (squarefull splitting)

For `n>=1`, the balancing number `u_n` is squarefull if and only if both
`A_n` and `B_n` are squarefull.

**Proof.**  Theorem 1.1 gives `u_n=A_nB_n` with coprime positive factors.
Their prime supports are disjoint, so every exponent in the product is at
least two exactly when every exponent in each factor is at least two.
\(\square\)

This equivalence makes the premise substantially more rigid than the phrase
"a Pell coordinate happens to be squarefull" suggests: two coprime Pell
coordinates must be squarefull simultaneously.

## 2. The adjacent abc point and the exact one-half slope

Equation (1.6) gives two parity-dependent identities:

\[
 \begin{array}{ll}
 n\text{ even}:&1+2B_n^2=A_n^2,\\[2mm]
 n\text{ odd}: &1+A_n^2=2B_n^2.
 \end{array}                                                  \tag{2.1}
\]

Thus define the positive abc point

\[
 Q_n=
 \begin{cases}
   (1,2B_n^2,A_n^2),&n\text{ even},\\
   (1,A_n^2,2B_n^2),&n\text{ odd}.
 \end{cases}                                                  \tag{2.2}
\]

The two nonunit entries differ by 1, so the point is primitive.  It is also
exactly the half-factor point from `x_n^2-8u_n^2=1`:

\[
 \left\{\frac{x_n-1}{2},\frac{x_n+1}{2}\right\}
                 =\{A_n^2,2B_n^2\}.                           \tag{2.3}
\]

### Theorem 2.1 (half-slope compression)

If `u_n` is squarefull and `c_n` is the largest entry of `Q_n`, then

\[
       \operatorname{rad}(Q_n)
       =\operatorname{rad}(2A_n^2B_n^2)
       \leq 2\sqrt{A_nB_n}<2\sqrt{c_n}.                       \tag{2.4}
\]

Consequently, for

\[
 H_n=\log c_n,\qquad
 R_n=\log\operatorname{rad}(Q_n),
\]

one has

\[
                       \boxed{R_n<\tfrac12H_n+\log2}.         \tag{2.5}
\]

**Proof.**  Corollary 1.2 makes `A_n` and `B_n` squarefull, hence

\[
 \operatorname{rad}(A_n)^2\leq A_n,\qquad
 \operatorname{rad}(B_n)^2\leq B_n.
\]

Radical submultiplicativity gives the weak inequality in (2.4).  If `n` is
even, then `c_n=A_n^2` and (1.6) gives `B_n<A_n`, so `A_nB_n<c_n`.  If `n`
is odd, then `c_n=2B_n^2` and (1.6) gives `A_n<2B_n`, again
`A_nB_n<c_n`.  Taking logarithms proves (2.5).  \(\square\)

### Corollary 2.2 (standard abc disproof gate)

If `(u_n)` has an unbounded squarefull subsequence, then the standard abc
conjecture is false.

**Proof.**  Along distinct unbounded indices the positive sequences
`A_n,B_n`, and hence `c_n`, are unbounded.  If standard abc held, use it
with, for example, `epsilon=1/2` on the primitive points (2.2).  Combining
it with (2.5) would give

\[
 H_n\leq\frac32R_n+C
      <\frac34H_n+\frac32\log2+C,
\]

which bounds `H_n`, a contradiction.  \(\square\)

This implication targets standard abc itself.  It does not replace abc by a
statement restricted to Pell points.

### Proposition 2.3 (a strict fixed signature on even indices)

If `n` is even and `u_n` is squarefull, then the entries of
`(1,2B_n^2,A_n^2)` are respectively 3-full, 4-full, and 4-full.  Thus the
fixed signature is

\[
                         (3,4,4),\qquad
             \frac13+\frac14+\frac14=\frac56<1.              \tag{2.6}
\]

**Proof.**  The unit is vacuously 3-full.  Both `A_n` and `B_n` are
squarefull.  Hence every prime in `A_n^2` has exponent at least four.  The
same holds for every odd prime in `2B_n^2`.  Since even `n` makes `B_n`
even, squarefullness gives `v_2(B_n)>=2`, and therefore
`v_2(2B_n^2)>=5`.  \(\square\)

For odd indices the coefficient 2 in `2B_n^2` has exponent one, so (2.2)
does not have a strict mixed-full signature with all exponents at least two.
The half-slope bound still applies.  Independently, the original Pell point

\[
                         (1,8u_n^2,x_n^2)                     \tag{2.7}
\]

has the fixed strict signature `(7,3,2)` for every squarefull `u_n`, of
either parity.  In that signature its residual-kernel triple is

\[
                    (1,\kappa_3(8u_n^2),1).                  \tag{2.8}
\]

The kernel-escape theorem from the preceding report therefore implies that
an unbounded hypothetical squarefull subfamily must make
`kappa_3(8u_n^2)` take infinitely many values.  A fixed Pell source is not
excluded: its coordinate values can produce infinitely many kernels.

## 3. Strong divisibility, ranks, and exact valuation lifting

The addition and Cassini identities for (0.2) are

\[
 \begin{aligned}
 u_{r+s}&=u_r u_{s+1}-u_{r-1}u_s,\\
 u_{r+1}u_{r-1}-u_r^2&=-1.                                  \tag{3.1}
 \end{aligned}
\]

They follow by induction from the recurrence.  The second identity gives
`gcd(u_r,u_{r+1})=1`; applying the first identity in the Euclidean algorithm
then gives

\[
                         \gcd(u_m,u_n)=u_{\gcd(m,n)}.          \tag{3.2}
\]

In particular `(u_n)` is a strong divisibility sequence.

For a prime `p`, let

\[
             z(p)=\min\{r\geq1:p\mid u_r\}                   \tag{3.3}
\]

be its rank of apparition.  Since the recurrence matrix has determinant
one, reduction modulo `p` is periodic and the rank exists.  Strong
divisibility gives

\[
                         p\mid u_n\quad\Longleftrightarrow
                         \quad z(p)\mid n.                    \tag{3.4}
\]

For odd `p`, both the constant term and the discriminant 32 are invertible
modulo `p`.  If `alpha,beta` are the roots of `T^2-6T+1` and
`gamma=alpha/beta`, then the order of `gamma` is `z(p)`.  If 32 is a square
modulo `p`, this order divides
`p-1`.  If it is a nonsquare, Frobenius exchanges `alpha` and `beta`, so
`gamma^p=gamma^{-1}` and the order divides `p+1`.  Hence

\[
       \boxed{z(p)\mid p-\left(\frac{32}{p}\right)
                    =p-\left(\frac2p\right).}                \tag{3.5}
\]

In particular `p` never divides `z(p)` for odd `p`.

Sanna's Theorem 1.5 and Corollary 1.6 specialize exactly as follows.

### Theorem 3.1 (valuation law for `U_n(6,1)`)

For an odd prime `p`,

\[
 v_p(u_n)=
 \begin{cases}
 v_p(u_{z(p)})+v_p(n)
    =v_p(u_{z(p)})+v_p(n/z(p)),&z(p)\mid n,\\
 0,&z(p)\nmid n.
 \end{cases}                                                  \tag{3.6}
\]

At the discriminant prime,

\[
 v_2(u_n)=
 \begin{cases}
 0,&n\text{ odd},\\
 v_2(n),&n\text{ even}.
 \end{cases}                                                  \tag{3.7}
\]

**Justification.**  Sanna writes the characteristic polynomial as
`T^2-aT-b`.  Here `(a,b)=(6,-1)` and `Delta=a^2+4b=32`.
For odd `p`, Corollary 1.6 gives (3.6); (3.5) explains why
`v_p(z(p))=0`.  For `p=2`, Theorem 1.5 gives
`v_2(u_n)=v_2(n)+v_2(u_2)-1=v_2(n)` when `2|n`, because `u_2=6`, and zero
otherwise.  \(\square\)

The theorem propagates the exponent present at first appearance.  It does
not bound that initial exponent.

## 4. The exact saturation rule

For an odd prime set

\[
                         e(p)=v_p(u_{z(p)}).                  \tag{4.1}
\]

### Theorem 4.1 (squarefull index criterion and saturation)

The term `u_N` is squarefull exactly when

\[
 \begin{aligned}
 &2\nmid N\quad\text{or}\quad v_2(N)\geq2,                  \tag{4.2}\\
 &e(p)+v_p(N)\geq2
       \quad\text{for every odd }p\text{ with }z(p)\mid N. \tag{4.3}
 \end{aligned}
\]

In particular, if `z(p)=r`, `e(p)=1`, and `r|N`, then squarefullness forces

\[
                              p\mid N/r.                      \tag{4.4}
\]

**Proof.**  Equations (4.2)--(4.3) are exactly (3.6)--(3.7) with the
definition of squarefullness.  If `e(p)=1`, (4.3) forces `v_p(N)>=1`.
Equation (3.5) gives `p` coprime to `r`, so this is equivalent to (4.4).
\(\square\)

It is useful to regard every exact exponent-one first occurrence as a
directed edge

\[
                         r\longrightarrow p
       \quad\text{when}\quad z(p)=r,\quad p\parallel u_r.   \tag{4.5}
\]

A squarefull index divisible by `r` must also be divisible by `p`.  This is
an exact closure rule, rather than a density heuristic.

### Proposition 4.2 (a certified obstruction for even indices)

If `N` is even and `u_N` is squarefull, then

\[
              22{,}318{,}790{,}340\mid N.                    \tag{4.6}
\]

**Proof.**  The following exact factorizations are enough:

\[
 \begin{array}{c|l}
 r&u_r\\ \hline
 2&2\cdot3\\
 3&5\cdot7\\
 4&2^2\cdot3\cdot17\\
 5&29\cdot41\\
 6&2\cdot3^2\cdot5\cdot7\cdot11\\
 7&13^2\cdot239.
 \end{array}                                                  \tag{4.7}
\]

All displayed nontrivial factors are prime.  Direct inspection of the
earlier terms, or (3.2), gives

\[
 \begin{gathered}
 z(3)=2,\quad z(5)=z(7)=3,\quad z(17)=4,\\
 z(29)=z(41)=5,\quad z(11)=6,\quad z(239)=7,                 \tag{4.8}
 \end{gathered}
\]

and every displayed prime in (4.8) occurs to exponent one at its rank.
First, (3.7) forces `4|N`.  The edge `2->3` forces `3|N`; the edge
`4->17` forces `17|N`.  Divisibility by 3 forces 5 and 7; divisibility by 5
forces 29 and 41; divisibility by 6 forces 11; and divisibility by 7 forces
239.  These integers are pairwise coprime except for the already isolated
factor 4, and their product is the number in (4.6).  \(\square\)

The factor `13^2` in `u_7` supplies no outgoing saturation edge: its
first-occurrence exponent is already two.  This is the first visible
Wieferich obstruction.  Iterating (4.5) with more exact factorizations raises
the numerical lower bound rapidly, but any finite iteration remains a finite
certificate and cannot prove eventual non-squarefullness.

## 5. Primitive divisors do not imply exponent one

Yabuta's formulation of Carmichael's 1913 theorem assumes nonzero coprime
integers `L,M`, `L>0`, and real roots of `T^2-LT+M`.  Under those hypotheses
the Lucas term

\[
             D_n=\frac{\alpha^n-\beta^n}{\alpha-\beta}
\]

has a prime divisor not dividing any earlier positive-index term whenever
`n` is not `1,2,6`, with the sole additional exception
`n=12,L=1,M=-1`, the Fibonacci case.  Our parameters are `(L,M)=(6,1)`,
so that exception is irrelevant.  At the omitted index,

\[
                         u_6=6930
\]

has the primitive divisor 11.  Therefore every `u_n` with `n>=3` has a
primitive divisor in Carmichael--Yabuta's sense, which excludes only primes
seen in earlier positive-index terms.  Bilu--Hanrot--Voutier prove the more
general uniform bound `n>30`, using the stronger definition that also
excludes primes dividing `(alpha-beta)^2`; for this positive-discriminant
sequence Carmichael is sharper.

Neither theorem gives a divisor of valuation one.  The explicit term

\[
                         u_7=13^2\cdot239                     \tag{5.1}
\]

is decisive: both 13 and 239 first occur at rank 7, but 13 already occurs
squared.  Thus the inference

```text
each primitive divisor  =>  exponent-one divisor
```

is false even in the exact sequence under study.  This example does not
refute the different existential statement that a term has at least one
exponent-one primitive divisor: the factor 239 supplies one for `u_7`.

If an odd primitive prime `p` of `u_n` is squared, then in the quadratic
algebra modulo `p^2`, with `alpha=3+sqrt(8)` and
`beta=alpha^{-1}`, one has

\[
  p^2\mid u_n
  \quad\Longrightarrow\quad
  \alpha^n\equiv\beta^n\pmod{p^2}
  \quad\Longrightarrow\quad
  \alpha^{2n}\equiv1\pmod{p^2}.                              \tag{5.2}
\]

This is a Lucas--Wieferich lifting condition.

## 6. Balancing-Wieferich primes and an injective obstruction

For an odd prime `p`, Dutta--Patel--Ray call `p` a
**balancing-Wieferich prime** when

\[
             u_{p-(8/p)}\equiv0\pmod{p^2},                   \tag{6.1}
\]

where `(8/p)` is the Legendre symbol.  Since
`(8/p)=(32/p)=(2/p)`, equation (3.5) shows that `z(p)` divides the index in
(6.1).

### Proposition 6.1 (first-exponent characterization)

For every odd prime `p`,

\[
       p\text{ is balancing-Wieferich}
       \quad\Longleftrightarrow\quad e(p)\geq2.              \tag{6.2}
\]

**Proof.**  Put `m=p-(8/p)`.  Then `z(p)|m` and `p` does not divide `m`.
The valuation law (3.6) gives

\[
                       v_p(u_m)=v_p(u_{z(p)})=e(p),
\]

which proves the equivalence.  \(\square\)

### Theorem 6.2 (squarefull terms force distinct Wieferich primes)

For every `n>=3` such that `u_n` is squarefull, there is a
balancing-Wieferich prime `p` with `z(p)=n`.  Consequently, infinitely many
squarefull terms would force infinitely many distinct balancing-Wieferich
primes.

**Proof.**  Carmichael's theorem, together with the direct check at `n=6`,
supplies a primitive prime `p|u_n`.  Since 2 already occurs at index 2,
this `p` is odd and its rank is exactly `n`.  Squarefullness gives
`e(p)=v_p(u_n)>=2`, so Proposition 6.1 applies.  A prime has only one rank,
so choices made at distinct indices are distinct.  \(\square\)

This necessary condition is not sufficient.  The prime 13 is
balancing-Wieferich with rank 7, but (5.1) also contains the exponent-one
prime 239, so `u_7` is not squarefull.  The literature records 13, 31, and
1546463 as the conjectured balancing-Wieferich examples in the cited
computations.  That statement is a conjectural and finite-computational
record, not a proof that no others exist.

## 7. Descent to a prime index

The strongest unconditional reduction found in this audit is the following.

### Theorem 7.1 (largest-prime descent)

Suppose `N>1` and `u_N` is squarefull.  Then `N` has an odd prime divisor.
If `ell` is the largest prime divisor of `N`, then

\[
                              u_\ell\text{ is squarefull}.    \tag{7.1}
\]

**Proof.**  If `N` were a power of 2, then `z(3)=2` and (3.6) would give
`v_3(u_N)=v_3(u_2)+v_3(N)=1`, contradicting squarefullness.  Hence the
largest prime divisor `ell` is odd.

Let `q` be any prime divisor of `u_ell`.  The term `u_ell` is odd.  Since
`ell` is prime, (3.4) and `u_1=1` give `z(q)=ell`.  The rank bound (3.5)
gives

\[
                          \ell\mid q\pm1.                    \tag{7.2}
\]

An odd prime satisfying (7.2) is strictly larger than `ell`: the first
positive representatives `ell-1` and `ell+1` are even (and `q` is odd),
while every remaining positive representative is larger than `ell`.  By
maximality of `ell`, therefore, `q` does not divide `N`.

Now `ell|N`, so (3.6) gives

\[
                     v_q(u_N)=v_q(u_\ell)+v_q(N)
                              =v_q(u_\ell).                  \tag{7.3}
\]

The left side is at least two.  This holds for every `q|u_ell`, proving
(7.1).  \(\square\)

### Corollary 7.2 (prime-index closure target)

If one proves that `u_ell` has an exponent-one prime divisor for every odd
prime `ell`, then `u_n` is not squarefull for every `n>1`.

Thus an eventual exponent-one theorem only at prime indices, together with
a finite check of the remaining prime indices, would close the entire Pell
route.  A theorem for all composite indices is unnecessary.

### Theorem 7.3 (double Wieferich packet at prime rank)

If `ell>=3` is prime and `u_ell` is squarefull, then there are at least two
distinct balancing-Wieferich primes with rank exactly `ell`.

**Proof.**  Theorem 1.1 and Corollary 1.2 give

\[
                  u_\ell=A_\ell B_\ell,\qquad
                  \gcd(A_\ell,B_\ell)=1,                    \tag{7.4}
\]

with both factors squarefull and greater than 1.  Choose primes
`p|A_ell` and `q|B_ell`.  They are distinct.  Each divides `u_ell`, so the
same prime-index argument used in Theorem 7.1 gives
`z(p)=z(q)=ell`.  Their valuations in `u_ell` are at least two, and
Proposition 6.1 makes both balancing-Wieferich.  \(\square\)

Equivalently, a hypothetical terminal prime rank cannot be supported by one
isolated Wieferich accident.  Every prime in each of the two coprime Pell
factors must be Wieferich at the same balancing rank.

## 8. What the original literature proves, and what it does not

The source audit gives a clean boundary.

* **Unconditional support novelty.**  Carmichael, in the convenient modern
  restatement and proof of Yabuta, gives a primitive divisor at every index
  `n>=3` for this sequence.  Bilu--Hanrot--Voutier gives a more general but
  numerically weaker `n>30` theorem.
* **Unconditional valuation propagation.**  Sanna gives (3.6)--(3.7).  The
  initial exponent `e(p)` remains an input and may be two, as at `p=13`.
* **Conditional powerful-term finiteness.**  Ribenboim--Walsh prove their
  1999 small-powerful-part theorem for the stated positive-discriminant
  binary recurrences under abc.  Ribenboim's 2001 Proposition 2.21--2.22 and
  Yabuta's 2007 Theorem 2.3 give the corresponding abc-conditional finiteness
  of powerful `U_n` and companion terms for the standard nondegenerate Lucas
  setting.  Our sequence has `gcd(P,Q)=1` and
  \(PQ\Delta\ne0\), so it satisfies these hypotheses.
* **Wieferich distribution.**  The balancing-Wieferich literature gives
  congruence and period criteria, and conditional results about infinitely
  many non-Wieferich primes.  The 2023 theorem of Anitha--Fathima--
  Vijayalakshmi gives \(\gg\log x\) Lucas non-Wieferich primes in specified
  arithmetic progressions, still assuming abc over number fields.  It does
  not give a non-Wieferich primitive divisor at every sufficiently large
  rank.

The abc-conditional finiteness theorem cannot be used inside a proof of an
abc counterexample.  Its contrapositive is consistent with Corollary 2.2:
an unbounded powerful subsequence here would itself negate abc.

No audited source proves either of the following statements:

\[
 \begin{aligned}
 &\text{every sufficiently large }u_n\text{ has a prime of valuation }1;
                                                               \tag{8.1}\\
 &\text{there are infinitely many squarefull }u_n.             \tag{8.2}
 \end{aligned}
\]

Both must remain open in this project.

## 9. Finite arithmetic and its exact scope

The first terms are

\[
 1,6,35,204,1189,6930,40391,235416,1372105,\ldots             \tag{9.1}
\]

and the factorizations used in (4.7) are exact.  Two additional checks show
why a single Wieferich prime is not enough:

\[
 \begin{aligned}
 u_7&=13^2\cdot239,\\
 u_{15}&=5^2\cdot7\cdot29\cdot31^2\cdot41\cdot269.           \tag{9.2}
 \end{aligned}
\]

Here 13 and 31 are balancing-Wieferich primes, while the same terms retain
exponent-one factors.  These computations test the normalization, ranks,
and valuation statements.  They do not show density zero, finiteness, or an
eventual exponent-one theorem.  No conclusion in Sections 1--8 depends on a
large numerical search.

## 10. Other fixed Pell sources

Let a fixed Pell unit be

\[
             \eta=x_1+y_1\sqrt D,\qquad x_1^2-Dy_1^2=1,
\]

and write

\[
             \eta^n=X_n+Y_n\sqrt D.
\]

Then

\[
             Y_n=y_1\,U_n(2x_1,1).                            \tag{10.1}
\]

The fixed factor `y_1` can control only finitely many primes.  Every new
prime supplied by primitive-divisor theory lies in the moving Lucas factor.
To improve the critical Pell identity

\[
                         1+DY_n^2=X_n^2                       \tag{10.2}
\]

to a strict mixed-full or strict radical slope, one must raise the
multiplicity of these moving primes.  This again asks for squarefullness, or
a comparable valuation condition, in a Lucas factor.  Primitive support
alone does not do it.

There is a rigorous no-go for replacing squarefullness by a fixed exact
power.

### Proposition 10.1 (fixed exact-power Pell upgrade is finite)

Fix nonzero `D` and an integer `k>=2`.  The equation

\[
                            1+DZ^{2k}=X^2                     \tag{10.3}
\]

has only finitely many proper integer solutions.

**Proof.**  Choose an integer `m` so large that

\[
                      \frac1m+\frac1{2k}+\frac12<1.
\]

Equation (10.3) is the fixed-coefficient generalized-Fermat equation

\[
                        1\cdot1^m+D Z^{2k}=1\cdot X^2.
\]

Darmon--Granville finiteness in the strict reciprocal range gives only
finitely many proper solutions.  \(\square\)

Thus taking a fixed power in a Pell coordinate is too rigid.  Squarefull
values evade Proposition 10.1 because their power-free kernels move.  This
is exactly the kernel-escape mechanism, and it is why a fixed Pell conic is
still a logically viable source curve.

No alternative fixed Pell recurrence was found that makes all newly
introduced primes occur twice automatically.  Each audited variant reaches
the same Lucas--Wieferich boundary.

## 11. Elliptic divisibility sequences

Let `E/Q` have an integral Weierstrass model and let `P` be nontorsion.
Write

\[
       nP=\left(\frac{A_n}{B_n^2},\frac{C_n}{B_n^3}\right),
       \qquad \gcd(B_n,A_nC_n)=1.                             \tag{11.1}
\]

The denominators `(B_n)` form a strong divisibility sequence.  Silverman's
theorem says that all sufficiently large `B_n` have a primitive divisor.
At primes other than 2, the formal-group law gives the exact lifting rule

\[
               v_p(B_{mn})=v_p(B_n)+v_p(m)                   \tag{11.2}
\]

once `p|B_n`; the standard model-dependent qualification at 2 is recorded in
Nowroozi--Siksek, Proposition 5.  This is the elliptic analogue of (3.6), and
it has the same limitation: it propagates the first exponent but does not
force that exponent to be one.

For a Mordell model `Y^2=X^3+k`, clearing (11.1) gives

\[
                         C_n^2=A_n^3+kB_n^6.                  \tag{11.3}
\]

After removing fixed bad-prime factors, its natural signature is
`(3,6,2)`, and

\[
                          \frac13+\frac16+\frac12=1.          \tag{11.4}
\]

It is again a critical genus-one source.  Crossing to a strict signature
requires an extra squarefull condition on a moving base coordinate, such as
`A_n`, `B_n`, or `C_n`, depending on which endpoint is promoted.

The exact-power literature does not supply that condition.  Everest,
Reynolds, and Stevens prove that for each fixed exponent `f>=2`, only
finitely many EDS terms are exact `f`th powers.  Nowroozi--Siksek prove
finiteness of all exact perfect powers under explicit real-component and
nonintegrality hypotheses, with a conditional extension under standard
Langlands conjectures.  A squarefull integer need not be an exact power, so
none of these results proves finiteness of squarefull EDS terms.

Consequently no fixed Pell or elliptic divisibility source examined here
produced a genuine, primitive, height-unbounded strict mixed-full family.
The source curves can generate infinitely varying residual kernels, so the
kernel-escape theorem does not rule them out; the unresolved obstruction is
valuation one at newly appearing primes.

## 12. Route ledger and next mathematical targets

The exact status is:

* **Standard abc counterexample:** not obtained.
* **Unbounded squarefull balancing subsequence:** not proved.
* **Eventual exponent-one divisor theorem:** not proved and not present in
  the audited literature.
* **Conditional disproof gate:** proved twice, through the fixed `(7,3,2)`
  Pell point and through the sharper adjacent slope `1/2`.
* **Even-index strict signature:** proved with signature `(3,4,4)`.
* **Strong divisibility and valuations:** unconditional and exact.
* **Index saturation:** unconditional; the finite divisor (0.3) is rigorous
  but has no asymptotic force.
* **Prime-index descent:** unconditional.  Every nontrivial squarefull term
  forces a squarefull term at its largest prime index.
* **Wieferich obstruction:** unconditional.  Infinite squarefull values force
  infinitely many balancing-Wieferich primes; a terminal prime index needs at
  least two such primes of the same rank.
* **Exact-power Pell variant:** rigorously finite by Darmon--Granville.
* **Elliptic alternative:** primitive divisors and exact-power finiteness do
  not decide squarefull denominators or coordinates; no strict family was
  found.

The most focused positive-proof target is now

> prove that for every odd prime `ell`, the balancing number `u_ell` has at
> least one prime divisor `p` with `p || u_ell`.

By Corollary 7.2 this closes all composite indices automatically.  The most
focused counterexample target is the opposite packet problem:

> construct infinitely many ranks at which every primitive support prime is
> balancing-Wieferich, while simultaneously satisfying the inherited
> saturation conditions from all proper divisor ranks.

Either target is substantially sharper than asking only for a primitive
divisor.

## 13. Formalization boundary

No Lean file was created or changed in this continuation, in accordance with
the instruction to finish the mathematics first.  The elementary
factorization (1.5), coprimality, parity split, squarefull transfer, and
half-slope deterministic gate are suitable future formalization targets.
The Carmichael primitive-divisor theorem, Sanna valuation formula,
Darmon--Granville finiteness, balancing-Wieferich distribution statements,
and elliptic primitive-divisor results remain external paper inputs and are
not represented as Lean axioms.

## References

* R. D. Carmichael, *On the Numerical Factors of the Arithmetic Forms
  `alpha^n +/- beta^n`*, Ann. of Math. (2) 15 (1913), 30--70,
  doi:10.2307/1967797.
* M. Yabuta, *A Simple Proof of Carmichael's Theorem on Primitive Divisors*,
  Fibonacci Quart. 39(5) (2001), 439--443.  The official journal scan is
  archived locally.
* C. Sanna, *The p-adic valuation of Lucas sequences*, Fibonacci Quart.
  54(2) (2016), 118--124.  Theorem 1.5 and Corollary 1.6 supply (3.6)--(3.7).
* U. K. Dutta, B. K. Patel, and P. K. Ray, *A brief remark on
  balancing-Wieferich primes*, Mathematica 60(83), no. 1 (2018), 48--53,
  doi:10.24193/mathcluj.2018.1.05.
* Y. Bilu, G. Hanrot, and P. M. Voutier, with an appendix by M. Mignotte,
  *Existence of Primitive Divisors of Lucas and Lehmer Numbers*, J. reine
  angew. Math. 539 (2001), 75--122, doi:10.1515/crll.2001.080.
* P. Ribenboim and G. Walsh, *The ABC Conjecture and the Powerful Part of
  Terms in Binary Recurring Sequences*, J. Number Theory 74(1) (1999),
  134--147, doi:10.1006/jnth.1998.2315.
* P. Ribenboim, *On square factors of terms of binary recurring sequences and
  the ABC Conjecture*, Publ. Math. Debrecen 59(3--4) (2001), 459--469,
  doi:10.5486/PMD.2001.2559.
* M. Yabuta, *The ABC-conjecture and the powerful numbers in Lucas
  sequences*, Fibonacci Quart. 45(4) (2007), 362--365.  Its powerful-term
  finiteness theorem is explicitly conditional on abc.
* K. Anitha, I. Mumtaj Fathima, and A. R. Vijayalakshmi, *Lucas
  non-Wieferich primes in arithmetic progressions and the abc conjecture*,
  Open Math. 21(1) (2023), article 20220563,
  doi:10.1515/math-2022-0563, arXiv:2101.04901.
* G. Everest, G. McLaren, and T. Ward, *Primitive divisors of elliptic
  divisibility sequences*, J. Number Theory 118(1) (2006), 71--89,
  doi:10.1016/j.jnt.2005.08.002, arXiv:math/0409540.
* M. Nowroozi and S. Siksek, *Perfect powers in elliptic divisibility
  sequences*, Bull. London Math. Soc. 56(11) (2024), 3331--3345,
  doi:10.1112/blms.13135, arXiv:2312.08997.
* J. H. Silverman, *Wieferich's criterion and the abc-conjecture*, J. Number
  Theory 30(2) (1988), 226--237,
  doi:10.1016/0022-314X(88)90019-4.

The exact local filenames, byte counts, URLs, and SHA-256 hashes are in the
source metadata JSON cited at the start of this report.
