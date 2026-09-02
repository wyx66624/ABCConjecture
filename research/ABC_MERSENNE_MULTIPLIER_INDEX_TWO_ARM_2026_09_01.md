# Multiplier-Index Compression and a Two-Arm Near-Square-Root Mersenne Gate

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional reduction and obstruction theorem; the standard
abc conjecture is neither proved nor disproved here.

## 1. Result

For an odd prime (p), write

\[
 d_p=\operatorname{ord}_p(2),\qquad
 w_p=v_p(2^{d_p}-1).
\]

The canonical exact-order loss at (d) is

\[
 a_d=\sum_{d_p=d}(w_p-1)\log p.                         \tag{1.1}
\]

Only primes with (w_p\ge2) contribute.  Previous work decomposed their
one-copy mass into small, transition and extreme ranges.  This note uses a
different invariant: the **order multiplier**

\[
                         r_p=\frac{p-1}{d_p}.             \tag{1.2}
\]

Exact order gives (d_p\mid p-1), so (r_p) is a positive integer and

\[
                         p=1+d_pr_p.                     \tag{1.3}
\]

For fixed (d), the map (p\mapsto r_p) is injective.  This elementary
observation controls all repeated exact-order primes below a moving
near-quadratic cutoff without Brun--Titchmarsh.

Put

\[
 L_m=\log\log(3m),\qquad
 \Lambda_m=\log(3m)L_m^2.                               \tag{1.4}
\]

For (d\mid m), split the one-copy repeated support into

\[
\begin{aligned}
 U_d(m)&=\sum_{\substack{d_p=d,\ w_p\ge2\\
                    p\le d^2/\Lambda_m}}\log p,\\
 B_d(m)&=\sum_{\substack{d_p=d,\ w_p\ge2\\
                    p>d^2/\Lambda_m}}\log p,
\end{aligned}                                            \tag{1.5}
\]

and retain the deep excess

\[
 G_d=\sum_{\substack{d_p=d\\w_p\ge3}}(w_p-2)\log p.     \tag{1.6}
\]

Prime by prime,

\[
                         a_d=U_d(m)+B_d(m)+G_d.           \tag{1.7}
\]

For every fixed positive integer (k), multiplier injectivity proves

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}U_d(m)=o(m).                       \tag{1.8}
\]

Consequently, failure of the Mersenne endpoint no longer needs three
uncontrolled one-copy ranges.  Along a subsequence it forces either linear
deep-lift mass or linear mass on primes satisfying

\[
             d_p<\sqrt{p\Lambda_m}.                      \tag{1.9}
\]

Thus the coefficient ceiling improves from (1/3) for the previous
three-arm ledger to (1/2) for a two-arm ledger.  The remaining second arm
is a weighted exact-order theorem in a polylogarithmic neighbourhood above
the square-root order threshold; current almost-all order results do not
control its Wieferich-weighted intersection.

## 2. The multiplier injection

### Lemma 2.1 (exact-order multiplier packet)

Let (d\ge1), and let (S_d) be any finite set of primes satisfying
(\operatorname{ord}_p(2)=d).  Then every (p\in S_d) has a unique positive
integer (r_p) for which (p=1+dr_p), and the (r_p) are pairwise distinct.

#### Proof

The element (2\bmod p) belongs to the group
((\mathbb Z/p\mathbb Z)^\times), which has order (p-1).  Lagrange's
theorem gives (d\mid p-1).  Hence (r_p=(p-1)/d\) is an integer.  It is
positive because an exact-order prime divisor of (2^d-1) is odd and
(p-1\ge d>0).  Equation (1.3) follows from Euclidean division.  If
(r_p=r_q), then (p=1+dr_p=1+dr_q=q).  This proves uniqueness and
injectivity.  \(\square\)

### Corollary 2.2 (finite low-multiplier capacity)

Let (H>0).  The number of primes in (S_d) with (r_p<H) is at most
(H), where the right side is interpreted as a real bound.  If all such
primes are at most (X\ge1), then

\[
       \sum_{\substack{p\in S_d\\r_p<H}}\log p
          \le H\log X.                                  \tag{2.1}
\]

#### Proof

Distinct positive integral multipliers below (H) inject into the positive
integers below (H), of which there are at most (H).  Every logarithmic
summand is at most (\log X); summing proves (2.1).  \(\square\)

The repeated-prime and Wieferich hypotheses are not needed for this counting
lemma.  They only select a subset of the exact-order fibre, so the same bound
applies to that subset.

## 3. Uniform low-multiplier mass in a fixed window

### Proposition 3.1 (elementary moving cutoff)

Fix (k\ge1).  With (U_d(m)) as in (1.5),

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}U_d(m)
 \le
 \frac{2m\log m}{\Lambda_m}
       \{1+kL_m\}                                      \tag{3.1}
\]

for all sufficiently large (m).  In particular, the left side is (o(m)).

#### Proof

Write (q=m/d).  The window condition is

\[
                  q<\{\log(3m)\}^{k}.                   \tag{3.2}
\]

If (p) is counted by (U_d(m)), Lemma 2.1 gives (p=1+dr_p), while

\[
 dr_p=p-1<p\le \frac{d^2}{\Lambda_m}.
\]

Thus (r_p<d/\Lambda_m).  Injectivity gives at most
(d/\Lambda_m) such primes.  For large (m), (\Lambda_m\ge1), so
(p\le d^2\le m^2) and (\log p\le2\log m).  Corollary 2.2 yields

\[
                         U_d(m)
                   \le \frac{2d\log m}{\Lambda_m}.       \tag{3.3}
\]

Summing over (d=m/q) and then enlarging from divisors (q\mid m) to all
positive integers below the right side of (3.2) gives

\[
\begin{aligned}
 \sum U_d(m)
 &\le \frac{2m\log m}{\Lambda_m}
       \sum_{\substack{q\mid m\\q<(\log(3m))^k}}\frac1q\\
 &\le \frac{2m\log m}{\Lambda_m}
       \left(1+\log\{(\log(3m))^k\}\right)\\
 &=\frac{2m\log m}{\Lambda_m}(1+kL_m),
\end{aligned}
\]

which is (3.1).  Since (\log m\le\log(3m)) and
(\Lambda_m=\log(3m)L_m^2), division by (m) bounds the result by

\[
                         \frac{2(1+kL_m)}{L_m^2}
                         \longrightarrow0.              \tag{3.4}
\]

This proves the little-oh statement.  \(\square\)

Unlike the earlier (S_d=o(\varphi(d))) estimate, Proposition 3.1 uses no
prime-distribution theorem.  Its price is that the controlled cutoff is
(d^2/\Lambda_m), rather than the larger totient-adapted cutoff used in the
Brun--Titchmarsh decomposition.

## 4. Two-arm obstruction

Let

\[
 P_k(m)=\sum_{\substack{d\mid m\\
             \log(m/d)<kL_m}}a_d.                       \tag{4.1}
\]

The preceding checkpoint proves

\[
 \log\frac{2^m-1}{\operatorname{rad}(2^m-1)}=o(m)
 \quad\Longleftrightarrow\quad
 \forall k\ge1,\ P_k(m)=o(m).                          \tag{4.2}
\]

### Theorem 4.1 (near-square-root two-arm alternative)

If the left side of (4.2) is not (o(m)), then there are fixed
(k\ge1), (\epsilon>0), and an unbounded sequence (m_j) such that

\[
                         P_k(m_j)\ge\epsilon m_j.        \tag{4.3}
\]

For every fixed (0<\gamma<1/2), after passing to a subsequence, one same
alternative holds for all sufficiently large (j):

1. **deep lifts**
   \[
    \sum_{\substack{d\mid m_j\\
          \log(m_j/d)<kL_{m_j}}}G_d
       \ge\gamma\epsilon m_j;                           \tag{4.4}
   \]
2. **near-square-root small order**
   \[
    \sum_{\substack{d\mid m_j\\
          \log(m_j/d)<kL_{m_j}}}B_d(m_j)
       \ge\gamma\epsilon m_j,                           \tag{4.5}
   \]
   and every prime counted in (4.5) satisfies
   \[
              \operatorname{ord}_p(2)
                    <\sqrt{p\Lambda_{m_j}}.             \tag{4.6}
   \]

#### Proof

The contrapositive of (4.2) supplies (4.3).  Sum the exact decomposition
(1.7) over the fixed window.  Proposition 3.1 removes the (U)-mass as
(o(m_j)), leaving

\[
  \sum G_d+\sum B_d(m_j)\ge(\epsilon-o(1))m_j.           \tag{4.7}
\]

If both sums were below (\gamma\epsilon m_j), their total would be below
(2\gamma\epsilon m_j).  Since (2\gamma<1), this contradicts (4.7) for
large (j).  Infinite pigeonhole fixes the same alternative on a
subsequence.  Finally, (p>d^2/\Lambda_{m_j}) gives
(d^2<p\Lambda_{m_j}), hence (4.6).  \(\square\)

The clean choice (\gamma=1/3) is available.  More generally, every strict
coefficient below one half is available; no fixed analytic loss is paid.

### Corollary 4.2 (two exact closure targets)

It is sufficient to prove, for every fixed (k\ge1),

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}G_d=o(m)                         \tag{4.8}
\]

and

\[
 \sum_{\substack{d\mid m\\
       \log(m/d)<kL_m}}B_d(m)=o(m).                     \tag{4.9}
\]

Indeed, Proposition 3.1 and (1.7) then give (P_k=o(m)) for every fixed
(k), and (4.2) closes the Mersenne endpoint.

## 5. Sharpness and counterexample pressure

The coefficient (1/2) is the exact ceiling of the abstract two-arm
ledger.  Under the full finite premises

\[
 R=U+G+B,\qquad U=0,\qquad R,U,G,B\ge0,                 \tag{5.1}
\]

take

\[
                         (R,U,G,B)=(2,0,1,1).            \tag{5.2}
\]

For every (c>1/2), both conclusions (cR\le G) and (cR\le B) fail.
Thus no larger coefficient follows from exactly (5.1).  This is an abstract
mass counterexample, not an exact-order prime packet and not a counterexample
to (4.8) or (4.9).

The sealed finite base-two Wieferich scan gives a useful scope test.  At
(m=d), the two known rows in the scan have

| (p) | (d) | (\Lambda_d) | (d^2/\Lambda_d) | arm |
|---:|---:|---:|---:|---|
| 1093 | 364 | 26.4734626 | 5004.86098 | (U) |
| 3511 | 1755 | 39.5406461 | 77895.1611 | (U) |

Both have (w_p=2).  They show that the controlled (U)-arm need not
vanish at a finite index, but they satisfy the proved moving bound and do
not meet the (B)-arm cutoff.  No full-premise actual counterexample to
(4.8) or (4.9) is known.  Absence of such a counterexample in a finite scan
does not justify deleting either route.

## 6. Relation to primary literature

Pomerance's exact-order description of primitive factors of
(\Phi_d(2)) and Murty--S\'eguin's valuation dictionary justify the
canonical block language used in (1.1).  The multiplier injection itself is
only Lagrange's theorem and does not import an analytic result.

Erd\H{o}s--Murty prove that, for each prescribed positive function
(\epsilon(p)\to0), all but (o(x/\log x)) primes (p\le x) satisfy

\[
 \operatorname{ord}_p(2)\ge p^{1/(2+\epsilon(p))}
 .                                                         \tag{6.1}
\]

Condition (4.6), after using the fixed-window lower bound on (d), is an
upper bound of shape (p^{1/2+o(1)}).  Indeed,
(d>m/(\log(3m))^k) and (p\ge d+1) imply
(\log\Lambda_m/\log p\to0).  The interval between
(p^{1/2-o(1)}) and (p^{1/2+o(1)}) is therefore real, and (6.1) is also
unweighted and global.  It does not imply the localized Wieferich-weighted
estimate (4.9).

Fellini--Murty's 2026 results give lower counts for non-Wieferich primes only
under Masser's number-field abc conjecture or finiteness of
super-Wieferich primes.  Neither hypothesis can be used in an unconditional
proof of abc, and neither supplies (4.8) or (4.9).

Primary sources:

1. P. Erd\H{o}s and M. Ram Murty, *On the order of (a\pmod p)*,
   CRM Proceedings and Lecture Notes **19** (1999), 87--97.
2. M. Ram Murty and F. S\'eguin, *Prime divisors of sparse values of
   cyclotomic polynomials and Wieferich primes*,
   *Journal of Number Theory* **201** (2019), 1--22.
3. Carl Pomerance, *Cyclotomic primes*, *Journal of Number Theory* **276**
   (2025), 198--208.
4. Nic Fellini and M. Ram Murty, *Wieferich primes in number fields and the
   conjectures of Ankeny--Artin--Chowla and Mordell*, *Journal of Number
   Theory* **285** (2026), 209--229.

## 7. Formalization boundary

The companion Lean module formalizes, after the proofs above:

* exact-order multiplier representation and injectivity on a finite fibre;
* the finite multiplier-cap cardinality and logarithmic-mass inequalities;
* exact two-arm subtraction and its fixed-window composition;
* the sharp full-premise abstract counterexample above one half.

The Lean cardinality theorem uses a natural-number multiplier threshold
(H).  The passage to the real threshold (d/\Lambda_m), the actual
number-theoretic realization of (U_d(m),B_d(m),G_d), the harmonic-sum
little-oh estimate, extraction of an unbounded failure subsequence, and the
near-square-root rearrangement remain paper mathematics.  The Lean module
does not insert an order-distribution, Wieferich-density or abc assertion as
an axiom.
