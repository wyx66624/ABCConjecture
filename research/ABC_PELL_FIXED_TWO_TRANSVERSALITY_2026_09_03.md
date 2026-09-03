# Fixed-parameter Pell transversality by a matrix Frobenius anchor

**Author:** ChatGPT
**Date:** 2026-09-03
**Status:** unconditional support transversality and an exact gate
equivalence; no proof or disproof of the standard abc conjecture.

## 0. Exact result and claim boundary

Write

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2,
\]

and let `F_n(T),L_n(T)` be the Fibonacci and companion polynomials from the
preceding polynomial-Hensel checkpoint, so that

\[
 F_n(2)=B_n,\qquad L_n(2)=2A_n.                       \tag{0.1}
\]

This note resolves the transversality component of item P-I1B without
assuming the previously cited rank-of-apparition theorem.  If
`ell=2m+1` is prime, then

\[
 A_\ell\equiv1\pmod\ell,\qquad
 B_\ell\equiv2^m\pmod\ell.                            \tag{0.2}
\]

Thus `ell` divides neither coordinate.  Coordinate coprimality and the
all-index derivative identities then imply that **every actual rational
support prime of either fixed coordinate is a simple polynomial root at
`T=2`**.  This closes the missing all-support transversality premise and
allows the conditional all-support theorem from the preceding checkpoint
to be instantiated on the actual Pell coordinates.

It does not prove that the first Hensel displacements cannot all vanish.
The new Lean theorem proves that this remaining assertion is exactly the
odd-prime-index squarefull exclusion.  That exclusion remains open.  The
rank-of-apparition identity `z(q)=ell` is still useful for the sharper
channel residue and depth packet, but it is no longer needed to justify
derivative transversality.

## 1. Matrix Frobenius anchor

Put

\[
 M=\begin{pmatrix}1&2\\1&1\end{pmatrix},\qquad
 K=\begin{pmatrix}0&2\\1&0\end{pmatrix}.
\]

Then

\[
 M=I+K,\qquad K^2=2I.                                  \tag{1.1}
\]

### Lemma 1.1 (orbit as a first column)

For every `n>=0`,

\[
 M^n\binom10=\binom{A_n}{B_n}.                         \tag{1.2}
\]

#### Proof

At `n=0` both sides are `(1,0)`.  Left multiplication by `M` sends a
column `(A,B)` to `(A+2B,A+B)`, which is precisely multiplication of
`A+B sqrt(2)` by `1+sqrt(2)`.  Induction proves (1.2).  □

### Theorem 1.2 (prime-index Frobenius anchor)

Let `ell=2m+1` be prime.  There are integers `r_A,r_B` such that

\[
 A_\ell=1+\ell r_A,\qquad
 B_\ell=2^m+\ell r_B.                                 \tag{1.3}
\]

In particular,

\[
 \ell\nmid A_\ell B_\ell.                             \tag{1.4}
\]

#### Proof

The identity matrix commutes with `K`.  In the integral matrix ring, every
intermediate binomial coefficient `binom(ell,j)`, `0<j<ell`, is divisible
by `ell`.  Hence for some integral matrix `R`,

\[
 M^\ell=(I+K)^\ell=I+K^\ell+\ell K R.                 \tag{1.5}
\]

Since `ell=2m+1`, equation (1.1) gives

\[
 K^\ell=(K^2)^mK=2^mK.                                \tag{1.6}
\]

Taking the first column in (1.5), using (1.2), yields (1.3).  If `ell`
divided `A_ell`, the first equality would force `ell|1`, impossible for a
prime.  If `ell` divided `B_ell`, the second would force `ell|2^m`; primality
would then force `ell=2`, contradicting `ell=2m+1`.  This proves (1.4).  □

This is the same arithmetic content as the binomial expansion in the older
paper proof, but the matrix form exposes the structural reason: the Pell
step is an identity plus a square root of the scalar operator `2I`.

## 2. All-support transversality at `T=2`

The fixed norm identity and coordinate recurrence give

\[
 A_n^2-2B_n^2=(-1)^n,\qquad \gcd(A_n,B_n)=1.           \tag{2.1}
\]

For odd `n`, both coordinates are odd.  The polynomial identities already
proved for all indices specialize to

\[
 L_n'(2)=nB_n,                                         \tag{2.2}
\]

and

\[
 4F_n'(2)+B_n=nA_n.                                    \tag{2.3}
\]

### Theorem 2.1 (fixed-two all-support transversality)

Let `ell` be an odd prime.

1. If a prime `q` divides `A_ell`, then

   \[
   \gcd(L_\ell'(2),q)=1.
   \]

2. If a prime `p` divides `B_ell`, then

   \[
   \gcd(F_\ell'(2),p)=1.
   \]

#### Proof

Suppose `q|A_ell`.  Coprimality in (2.1) gives `q` coprime to `B_ell`, and
Theorem 1.2 gives `q!=ell`.  Thus `q` is coprime to `ell B_ell`.
Equation (2.2) proves the first assertion.

Now suppose `p|B_ell`.  Then `p` is coprime to `A_ell`, is unequal to
`ell`, and is odd because `B_ell` is odd.  Reducing (2.3) modulo `p` gives

\[
 4F_\ell'(2)\equiv\ell A_\ell\not\equiv0\pmod p.
\]

All three factors `4,ell,A_ell` are units modulo `p`; hence the derivative
is a unit modulo `p`.  □

The proof establishes the exact Bezout-coprimality statements used in
Lean, not merely nonzero residues.  It also proves that the scale factor
`2` in `L_ell(2)=2A_ell` is coprime to every support prime of `A_ell`.

## 3. Exact simultaneous-zero gate

For an integral polynomial `f`, integer `t`, and rational prime `p`, define

\[
 Z_1(f,t,p)\quad\Longleftrightarrow\quad
 p\mid f(t),\quad \gcd(f'(t),p)=1,\quad p^2\mid f(t).  \tag{3.1}
\]

By the one-digit Taylor-Hensel theorem, (3.1) says exactly that the unique
first lift of the simple root keeps the old representative `t`; equivalently
its first displacement is zero.

### Theorem 3.1 (fixed squarefull/zero-displacement equivalence)

For every odd prime `ell`,

\[
 \begin{aligned}
 A_\ell B_\ell\text{ is squarefull}
 \quad\Longleftrightarrow\quad&
 Z_1(L_\ell,2,q)\quad\text{for every prime }q\mid A_\ell,\\
 &Z_1(F_\ell,2,p)\quad\text{for every prime }p\mid B_\ell.
 \end{aligned}                                         \tag{3.2}
\]

#### Proof

Theorem 2.1 supplies the simple-root condition at every support prime.  At
an odd `q|A_ell`, equation (0.1) and `q` coprime to `2` show

\[
 q^2\mid L_\ell(2)\Longleftrightarrow q^2\mid A_\ell.
\]

At `p|B_ell`, equation (0.1) gives the same statement without a scale
factor.  Finally, `A_ell` and `B_ell` are coprime, so their product is
squarefull exactly when both factors are squarefull.  Combining these facts
proves (3.2).  □

Consequently the following two universal propositions are equivalent:

* no odd prime index has all support displacements zero;
* no odd prime index has squarefull `A_ell B_ell`.

The Lean theorem
`fixed_zero_displacement_exclusion_iff_squarefull_exclusion` proves this
equivalence.  Neither side is asserted.  This prevents an exact
reformulation from being mistaken for a solution of the arithmetic gate.

## 4. Exact refutation of an overstrong local claim

Consider the strictly stronger statement:

> **H-no-individual-zero.** At every odd prime index, no individual support
> prime in either channel has zero first displacement at `T=2`.

### Proposition 4.1

`H-no-individual-zero` is false.

#### Proof

At prime index seven,

\[
 A_7=239,\qquad B_7=169=13^2,
\]

and

\[
 F_7'(2)=376\equiv-1\pmod {13}.
\]

Thus `13` is a genuine support prime, the root is simple, and
`13^2|F_7(2)`.  All three premises in (3.1) hold, so its first displacement
is zero.  □

This counterexample retires only `H-no-individual-zero`.  It does not
contradict (or prove) the all-support exclusion, because `239` occurs to
exponent one in the opposite channel.

## 5. Positive search and counterexample search in a finite rectangle

The new computation bundle independently enumerates all pairs satisfying

\[
 \ell\le20000,\qquad q\le10^7,
\]

where `ell` is an odd prime and `q` is prime in one of the necessary support
classes `q=+/-1 mod 2ell` proved in the earlier rank/channel theorem.  The
producer computes powers in `Z[U]/(U^2-2)`; the verifier instead powers the
matrix `M`.  Both work modulo `q^3`, so they distinguish a simple factor,
zero first displacement, and zero second displacement exactly.

The independent replay returns `PASS` with:

* 2,261 prime indices;
* 3,091,963 candidate prime tests;
* 2,373 actual in-bound support hits;
* 1,472 indices with an in-bound exponent-one certificate;
* 789 bounded unresolved indices;
* exactly one repeated hit, `(ell,q,channel)=(7,13,B)`, of valuation two;
* no valuation-three hit; and
* no index with repeated support primes in both channels inside the
  rectangle.

This is a rigorous finite result.  An unresolved row is not a squarefull
hit, and support primes above `10^7` remain untested.  Therefore the no-hit
for opposite-channel repetitions is not promoted to Theorem 3.1's global
exclusion.

## 6. Formal and remaining boundary

The Lean module

`Lean/IUTThreeClosures/PellFixedTwoTransversality20260903.lean`

kernel-checks the matrix identities, the integral prime-index expansion,
index nondivisibility, coordinate parity, polynomial-coordinate bridges,
both all-support transversality theorems, the scale-unit theorem, the exact
equivalence (3.2), the equivalence of the two remaining exclusion
propositions, and the complete index-seven counterexample to
`H-no-individual-zero`.  Its separate axiom audit reports only Mathlib's
standard `propext`, `Classical.choice`, and `Quot.sound` dependencies.

The exact surviving obligations are:

1. prove the global fixed-prime-index squarefull exclusion, equivalently
   exclude simultaneous zero first displacement at every support prime;
2. formalize the stronger rank-of-apparition statement `z(q)=ell` if it is
   needed downstream for the channel residue and depth-three packet; and
3. couple the rank, character, factor-quotient, all-order-tail, and curvature
   constraints strongly enough to contradict a hypothetical all-zero
   packet.

No full-premise counterexample to these surviving statements is known.
They remain active irrespective of difficulty.  Nothing in this note proves
or disproves the standard abc conjecture.

