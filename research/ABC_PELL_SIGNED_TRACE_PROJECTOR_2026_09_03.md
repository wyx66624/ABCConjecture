# Signed trace projectors for the fixed-parameter Pell gate

**Author:** ChatGPT  
**Date:** 2026-09-03  
**Status:** unconditional depth-doubling and an exact reformulation of the
simultaneous-zero gate; no proof or disproof of the standard abc conjecture.

## 0. Result and claim boundary

Write

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2,
 \qquad U_n=A_nB_n,
\]

and put

\[
 Z_n=A_{2n}.
\]

The preceding fixed-parameter checkpoint proved that every rational support
prime at an odd prime index is transverse at the polynomial parameter
`T=2`, and that simultaneous zero first Hensel displacement is equivalent to
squarefullness of `A_ell B_ell`.  This note gives that gate a new exact
encoding.

For odd `n`,

\[
 Z_n-1=2A_n^2,
 \qquad Z_n+1=4B_n^2.                                  \tag{0.1}
\]

Thus every odd support prime obeys an exact fourth-power dictionary in one of
the two signed trace shifts:

\[
 q^4\mid Z_n-1\Longleftrightarrow q^2\mid A_n,
 \qquad
 q^4\mid Z_n+1\Longleftrightarrow q^2\mid B_n.         \tag{0.2}
\]

In particular, the surviving simultaneous-zero gate is equivalent to a
**signed fourth-power trace packet**: every support prime of `A_ell` occurs
to fourth order in `Z_ell-1`, and every support prime of `B_ell` occurs to
fourth order in `Z_ell+1`.

There is also a canonical channel projector

\[
 E_n=\frac{Z_n+1}{2}=2B_n^2=A_n^2+1.                  \tag{0.3}
\]

Modulo `U_n^2`, it is the CRT idempotent which is one on the `A` channel and
zero on the `B` channel.  Its defect is not merely bounded:

\[
 E_n^2-E_n=2U_n^2.                                    \tag{0.4}
\]

Hence its raw precision `U_n^2` is sharp for `U_n>=3`.  This sharpness does not kill the
route: one Newton correction preserves the two channel residues modulo
`U_n^2` and becomes idempotent modulo `U_n^4`.

The exhaustive finite search accompanying this note detects exactly two
prime-rank depth-two collisions in its stated rectangle, one in each
channel.  Each has trace depth exactly four, so the proposed universal
promotion from coordinate depth two to trace depth five is false.  These
are local collision counterexamples.  At index seven the opposite coordinate
is the exponent-one prime `239`, so that row is not squarefull.  For the large
row only the displayed `A`-channel collision is certified; squarefullness of
the complete coordinate product remains unresolved.  Neither row is an abc
counterexample.

## 1. Addition and doubled trace

### Proposition 1.1 (quadratic-ring addition law)

For all nonnegative integers `m,n`,

\[
\begin{aligned}
 A_{m+n}&=A_mA_n+2B_mB_n,\\
 B_{m+n}&=A_mB_n+B_mA_n.
\end{aligned}                                         \tag{1.1}
\]

#### Proof

Multiply

\[
 (A_m+B_m\sqrt2)(A_n+B_n\sqrt2)
\]

and compare the rational and `sqrt(2)` coefficients with
`(1+sqrt(2))^(m+n)`.  Equivalently, induction on `n` applies the recurrence

\[
 (A,B)\longmapsto(A+2B,A+B).
\]

This proves (1.1).  □

Putting `m=n` gives

\[
 A_{2n}=A_n^2+2B_n^2,\qquad B_{2n}=2A_nB_n.           \tag{1.2}
\]

### Theorem 1.2 (signed trace-square identities)

If `n` is odd, then

\[
 A_{2n}=2A_n^2+1=4B_n^2-1,                            \tag{1.3}
\]

and therefore (0.1) holds.

#### Proof

The norm identity at an odd index is

\[
 A_n^2-2B_n^2=-1,
 \quad\text{or equivalently}\quad
 2B_n^2=A_n^2+1.                                      \tag{1.4}
\]

Substitute (1.4) into the first identity in (1.2):

\[
 A_{2n}=A_n^2+(A_n^2+1)=2A_n^2+1
          =2(2B_n^2-1)+1=4B_n^2-1.
\]

Subtracting or adding one proves (0.1).  □

## 2. Exact depth doubling

### Theorem 2.1 (support-square/fourth-trace dictionary)

Let `n` be odd.

1. If `q` is an odd prime dividing `A_n`, then

   \[
   q^4\mid Z_n-1\quad\Longleftrightarrow\quad q^2\mid A_n.
                                                               \tag{2.1}
   \]

2. If `r` is an odd prime dividing `B_n`, then

   \[
   r^4\mid Z_n+1\quad\Longleftrightarrow\quad r^2\mid B_n.
                                                               \tag{2.2}
   \]

#### Proof

By (0.1), the left sides are respectively divisibility of `2A_n^2` by
`q^4` and of `4B_n^2` by `r^4`.  The coefficients `2` and `4` are units at
the indicated odd primes.  After cancelling them,

\[
 q^4\mid A_n^2\Longleftrightarrow q^2\mid A_n,
 \qquad
 r^4\mid B_n^2\Longleftrightarrow r^2\mid B_n.
\]

These equivalences follow from unique factorization, by comparing the powers
of the indicated support prime on both sides.  □

### Corollary 2.2 (exact depth-two boundary)

Under the hypotheses of Theorem 2.1,

\[
 q^2\parallel A_n\Longrightarrow q^4\parallel Z_n-1,
 \qquad
 r^2\parallel B_n\Longrightarrow r^4\parallel Z_n+1.  \tag{2.3}
\]

#### Proof

The fourth-power divisibilities follow from Theorem 2.1.  If, for example,
`q^5` divided `2A_n^2`, cancellation of `2` would give
`5 <= 2v_q(A_n)`, hence `v_q(A_n)>=3`, contrary to
`q^2 || A_n`.  The other channel is identical after cancelling `4`.  □

This corollary explains why a trace fifth-power conclusion cannot follow
from first Hensel displacement alone.  The squaring map doubles depth; it
does not add a further digit.

## 3. Exact reformulation of simultaneous zero displacement

For odd positive integers `A,B` and an integer `Z` satisfying (0.1), define

\[
\begin{aligned}
 \operatorname{ST}_4(A,B,Z)\quad\Longleftrightarrow\quad&
 q^4\mid Z-1 &&\text{for every prime }q\mid A,\\
 &r^4\mid Z+1 &&\text{for every prime }r\mid B.
\end{aligned}                                          \tag{3.1}
\]

### Theorem 3.1 (signed fourth-trace packet equivalence)

For every odd prime `ell`,

\[
\begin{aligned}
 &\text{every fixed-}\!T=2\text{ support prime has zero first
 Hensel displacement}\\
 &\qquad\Longleftrightarrow
 A_\ell B_\ell\text{ is squarefull}\\
 &\qquad\Longleftrightarrow
 \operatorname{ST}_4(A_\ell,B_\ell,A_{2\ell}).         \tag{3.2}
\end{aligned}
\]

#### Proof

The first equivalence is the all-support transversality theorem and exact
gate from the preceding checkpoint.  Since `gcd(A_ell,B_ell)=1`, the product
is squarefull exactly when both coordinates are squarefull.  Theorem 2.1
turns the support-square condition in the first coordinate into the first
line of (3.1), and does the same for the second coordinate and second line.
Every support quantifier is retained.  □

This is an exact reformulation, not an exclusion theorem.  A proof that no
signed fourth-trace packet exists would close the fixed prime-index gate.  No
such proof is claimed here.

### Corollary 3.2 (radical fourth-power compression)

If both coordinates are squarefull, then

\[
 \operatorname{rad}(A_\ell)^4\mid A_{2\ell}-1,
 \qquad
 \operatorname{rad}(B_\ell)^4\mid A_{2\ell}+1,         \tag{3.3}
\]

and hence

\[
 \operatorname{rad}(A_\ell)^4
 \operatorname{rad}(B_\ell)^4
 \mid (A_{2\ell}-1)(A_{2\ell}+1).                     \tag{3.4}
\]

#### Proof

Squarefullness gives `rad(A_ell)^2 | A_ell` and
`rad(B_ell)^2 | B_ell`.  Squaring and applying (0.1) gives (3.3).
Multiplication gives (3.4).  □

Because the two coordinates are coprime, the left side of (3.4) is
`rad(A_ell B_ell)^4`.  The right side also has the exact value

\[
 A_{2\ell}^2-1=8(A_\ell B_\ell)^2.                    \tag{3.5}
\]

Thus (3.4) is compatible with squarefullness and is not by itself a
contradiction.  Its value is that the two channel conditions now live on
the adjacent factors of one trace coordinate.

## 4. The exact CRT projector

Put `A=A_n`, `B=B_n`, `U=AB`, `Z=A_(2n)` for an odd `n`, and define

\[
 E=\frac{Z+1}{2}=2B^2=A^2+1.                           \tag{4.1}
\]

### Theorem 4.1 (channel projector and exact defect)

The integer `E` satisfies

\[
 E\equiv1\pmod{A^2},\qquad E\equiv0\pmod{B^2},         \tag{4.2}
\]

and

\[
 \boxed{E^2-E=2U^2.}                                   \tag{4.3}
\]

Consequently `E` is an idempotent modulo `U^2`.  If `U>=3`, it is not an
idempotent modulo `U^3`.

#### Proof

The two congruences follow immediately from the two expressions in (4.1).
Moreover,

\[
 E^2-E=E(E-1)=2B^2A^2=2U^2,
\]

which proves (4.3).  If `U^3` divided this defect, cancellation of the
positive factor `U^2` would give `U|2`, impossible for `U>=3`.  □

The precision-two sharpness closes only a raw-projector strengthening.  It
does not refute the signed trace route.

### Theorem 4.2 (canonical Newton continuation)

For any integers `e,d` satisfying `e^2-e=d`, put

\[
 \mathcal N(e,d)=e-(2e-1)d.                             \tag{4.4}
\]

Then

\[
 \mathcal N(e,d)^2-\mathcal N(e,d)=d^2(4d-3).          \tag{4.5}
\]

For the Pell defect `d=2U^2`, the corrected projector is congruent to `E`
modulo `U^2` and is idempotent modulo `U^4`.

#### Proof

Set `z=2e-1`.  Since `z^2=4d+1`, direct expansion gives

\[
\begin{aligned}
 (e-zd)^2-(e-zd)
 &=d-z^2d+z^2d^2\\
 &=d^2(4d-3).
\end{aligned}
\]

The correction term is a multiple of `d=2U^2`, so it preserves `E` modulo
`U^2`.  The right side of (4.5) contains `d^2=4U^4`, proving the last
claim.  □

This is the useful route-retention point: raw precision three is false, but
there is a canonical higher lift.  Future work can compare its successive
Newton digits with the polynomial Hensel displacements and the earlier
factor-quotient ledger.

## 5. Complete-premise counterexamples and finite search

The computation directory

`research/computation/2026_09_03_pell_signed_trace_projector/`

contains a quadratic-ring producer and an independent matrix-powering
verifier.  The exhaustive rectangle is

\[
 \ell\le800000,\qquad q\le2000000,                     \tag{5.1}
\]

where both `ell` and `q` are prime and
`q = +/-1 mod 2ell`.  For every candidate the producer computes the two
coordinates modulo `q^2`.  A repeated hit is recomputed modulo `q^5`; the
polynomial derivative residue and the signed doubled-trace shift are then
checked.  The verifier independently powers

\[
 \begin{pmatrix}1&2\\1&1\end{pmatrix}^\ell
\]

and agrees exactly.

A separate complete-premise certifier checks both collision rows again.  It
proves primality by exhaustive trial division through the integer square
root, and makes quadratic-ring powering, matrix powering, and the defining
linear recurrence agree modulo q^5.  For the larger row, the respective
trial-division bounds are 879 and 1243, and all three algorithms agree
modulo

\[
 1546463^5=8844996565598309452666138088543.             \tag{5.1a}
\]

The replay status is `PASS`, with:

* 63,950 odd prime indices;
* 764,366 candidate-prime tests;
* 12,356 actual in-bound support hits;
* 11,098 indices with an in-bound exponent-one witness;
* 52,852 bounded unresolved indices;
* exactly two repeated hits, one in each channel;
* no coordinate depth-three hit; and
* no index having in-bound repeated hits in both channels.

The two complete repeated rows are

\[
 13=2\cdot7-1,\qquad 13^2\parallel B_7,                \tag{5.2}
\]

with

\[
 F_7'(2)\equiv12\pmod {13},\qquad
 13^4\parallel A_{14}+1,                               \tag{5.3}
\]

and

\[
 1546463=2\cdot773231+1,\qquad
 1546463^2\parallel A_{773231},                         \tag{5.4}
\]

where both `1546463` and `773231` are prime, with

\[
 L_{773231}'(2)\equiv326969\pmod {1546463},\qquad
 1546463^4\parallel A_{1546462}-1.                     \tag{5.5}

\]

The nonzero quotient residues in the frozen certificate prove the exact
depth statements rather than merely lower bounds.

These rows refute the following exact universal strengthenings:

1. no support prime repeats at an odd prime index;
2. repetition at prime index is globally confined to the `A` channel;
3. repetition at prime index is globally confined to the `B` channel;
4. attaining the minimal representative `q=2ell+/-1` forces simplicity;
5. coordinate depth two always promotes to signed-trace depth five.

The index-seven trace value is small enough to record transparently:

\[
 A_{14}=114243,\qquad A_{14}+1=4\cdot13^4,             \tag{5.6}
\]

so `13^5` does not divide `A_14+1`.  Lean proves this complete refutation of
the fifth strengthening.

No exact surviving gate is retired.  In particular, (5.1) does not decide
an unresolved row, a support prime above two million, a prime index above
800000, the existence of a depth-three collision, or the existence of a
simultaneous squarefull packet.

## 6. Formal boundary and next attack

The module

`Lean/IUTThreeClosures/PellSignedTraceProjector20260903.lean`

kernel-checks the addition and doubling laws, both signed trace identities,
the two fourth-power equivalences, exact depth-two-to-four transport, the
all-support signed-trace equivalence, radical fourth-power consequences, the
projector defect and precision sharpness, the Newton correction, and the
complete index-seven fifth-power refutation.  The companion axiom audit
covers every declaration.

The new exact attack surface is the pair of adjacent trace factors

\[
 A_{2\ell}-1,\qquad A_{2\ell}+1,                       \tag{6.1}
\]

equipped simultaneously with:

* disjoint fourth-power support packets if the Pell gate survives;
* the exact product `(A_(2ell)-1)(A_(2ell)+1)=8U_ell^2`;
* the raw projector defect `2U_ell^2`;
* one explicit Newton correction step; and
* the earlier rank, character, quotient-ledger, and all-order constraints.

A closing theorem must show that these structures cannot arise from an
actual odd prime-index orbit, or construct infinitely many such actual
orbits.  The two finite depth-two collisions show that neither channel nor
one extra trace digit can supply that theorem alone.  Since no
complete-premise counterexample to the signed fourth-trace packet exclusion
is known, this route remains active.
