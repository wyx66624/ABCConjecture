# Odd-kernel and third-order localization in the balancing-Pell packet

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional necessary conditions and certified finite exclusions;
no proof or disproof of the standard abc conjecture.

## 1. Claim boundary

Write

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2.
\]

At an odd prime index \(\ell\), the inherited packet theorems give

\[
 A_\ell^2-2B_\ell^2=-1,\qquad \gcd(A_\ell,B_\ell)=1,       \tag{1.1}
\]

and, for every prime divisor in the indicated channel,

\[
 q=1+2\ell k_q\quad(q\mid A_\ell),                       \tag{1.2}
\]

\[
 r=s_r+2\ell h_r\quad(r\mid B_\ell),\qquad
 s_r=\left(\frac2r\right)\in\{1,-1\}.                  \tag{1.3}
\]

Put \(s_\ell=(2/\ell)\).  The preceding reports also prove the sign
and reciprocity ledgers

\[
 \prod_{r\mid B_\ell}s_r^{v_r(B_\ell)}=s_\ell             \tag{1.4}
\]

and

\[
 \prod_{q\in O_A}\prod_{r\in O_B}\left(\frac qr\right)
 =s_\ell,                                                  \tag{1.5}
\]

where \(O_A,O_B\) are the primes of odd exponent in their respective
channels, under the squarefull hypothesis.

This note makes three further advances.

1. It compresses every hypothetical squarefull packet into two squarefree
   **odd-exponent kernels** and two square cores.  The kernels inherit the
   complete mod-eight orbit, the signed rank congruences modulo \(2\ell\),
   and a three-edge Jacobi-character triangle with the index.
2. It retains one more quotient digit than the previous second-order
   ledger, giving a third-order coupling modulo \(8\ell^3\).
3. It searches every actual odd prime index through \(5000\) for a bounded
   simple-divisor witness, and gives independently replayed exact witnesses
   at every odd prime index through \(191\).

None of these statements contradicts the remaining packet.  In particular,
the 187 unresolved rows of the bounded search are retained as open rows;
they are not interpreted as squarefull examples or as evidence against the
route.

## 2. Cubic-square normal form of a squarefull factorization

### Proposition 2.1 (canonical odd-kernel decomposition)

Let

\[
 N=\prod_{i=1}^t p_i^{e_i}
\]

be a positive odd squarefull integer with distinct prime bases.  Put

\[
 O=\{i:e_i\text{ is odd}\},\qquad D=\prod_{i\in O}p_i.
\]

Then there is a positive integer \(C\) such that

\[
                       N=D^3C^2.                         \tag{2.1}
\]

The integer \(D\) is squarefree.  Every prime in \(D\) occurs in \(N\) to
odd exponent at least three.  If the exponent vector has gcd one, then
\(D>1\).

#### Proof

If \(e_i\) is even, squarefullness writes it uniquely as
\(e_i=2+2c_i\).  If it is odd, squarefullness writes it uniquely as
\(e_i=3+2c_i\).  Hence

\[
 C=\prod_{e_i\text{ even}}p_i^{1+c_i}
   \prod_{e_i\text{ odd}}p_i^{c_i}
\]

satisfies (2.1).  Distinctness of the bases makes \(D\) squarefree, and the
description of the odd exponents is immediate.  If \(D=1\), all exponents
are even, so their gcd is at least two, contrary to the last hypothesis.
\(\square\)

Apply Proposition 2.1 to a hypothetical squarefull pair
\(A_\ell,B_\ell\).  Write

\[
 A_\ell=D_A^3X^2,\qquad B_\ell=D_B^3Y^2.                 \tag{2.2}
\]

The inherited perfect-power classifications make both exponent-vector gcds
one (the exceptional \(B_7=13^2\) cannot occur in a squarefull packet because
\(A_7=239\)).  Thus \(D_A,D_B>1\), and every prime in either kernel is a
depth-three prime of rank \(\ell\) in its specified channel.  Equation
(1.1) becomes the compressed generalized-Fermat equation

\[
 D_A^6X^4-2D_B^6Y^4=-1.                                  \tag{2.3}
\]

This equation records all odd valuation data without discarding the even
tails.

## 3. Kernel residues and the square-core lift

### Theorem 3.1 (signed kernel and square-core localization)

For a hypothetical squarefull packet at an odd prime index \(\ell\),

\[
 D_A\equiv1\pmod{2\ell},\qquad
 D_B\equiv s_\ell\pmod{2\ell},                           \tag{3.1}
\]

and

\[
 X^2\equiv Y^2\equiv1\pmod{2\ell}.                      \tag{3.2}
\]

Consequently there are signs \(\tau_A,\tau_B\in\{1,-1\}\) such that

\[
 X\equiv\tau_A\pmod{2\ell},\qquad
 Y\equiv\tau_B\pmod{2\ell}.                             \tag{3.3}
\]

The kernel residues modulo eight are exactly

\[
\begin{array}{c|rrrr}
\ell\bmod8&1&3&5&7\\ \hline
D_A\bmod8&1&7&1&7\\
D_B\bmod8&1&5&5&1.
\end{array}                                               \tag{3.4}
\]

#### Proof

Every prime in \(D_A\) is an odd-exponent \(A\)-channel prime, so (1.2)
gives \(D_A\equiv1\pmod{2\ell}\).  Every prime in \(D_B\) satisfies
(1.3), and reducing (1.4) modulo exponent parity gives

\[
 \prod_{r\in O_B}s_r=s_\ell.
\]

Therefore \(D_B\equiv s_\ell\pmod{2\ell}\), proving (3.1).

The inherited coordinate congruences are
\(A_\ell\equiv1\pmod{2\ell}\) and
\(B_\ell\equiv s_\ell\pmod{2\ell}\).  Insert (2.2) and (3.1).
Since \(s_\ell^2=1\), cancellation gives (3.2).  The solutions of
\(Z^2\equiv1\pmod\ell\) are \(Z\equiv\pm1\pmod\ell\), because \(\ell\)
is prime.  Both cores are odd, so the Chinese remainder theorem upgrades
this to (3.3) modulo \(2\ell\).

Finally, for an odd integer \(C\), \(C^2\equiv1\pmod8\), and for odd
\(D\), \(D^3\equiv D\pmod8\).  Equation (2.2) therefore gives
\(D_A\equiv A_\ell\) and \(D_B\equiv B_\ell\pmod8\).  The exact orbit
table from the preceding report proves (3.4). \(\square\)

There is also an exact quotient refinement.  Define

\[
 d_A=\frac{D_A-1}{2\ell},\qquad
 d_B=\frac{D_B-s_\ell}{2\ell}.                           \tag{3.5}
\]

Equations (3.1) and (3.4) give

\[
\begin{array}{c|rrrr}
\ell\bmod8&1&3&5&7\\ \hline
d_A\bmod4&0&1&0&1\\
d_B\bmod4&0&1&3&0.
\end{array}                                               \tag{3.6}
\]

For example, in the \(3\pmod8\) class both kernel quotients are
\(1\pmod4\).  This is stronger bookkeeping than the earlier assertion that
some individual prime lies in the forced residue class.

## 4. The index--kernel Jacobi triangle

### Theorem 4.1 (three coupled quadratic characters)

Under the same hypotheses, all displayed Jacobi symbols are nonzero and

\[
 \left(\frac{D_A}{D_B}\right)=s_\ell,\qquad
 \left(\frac{D_A}{\ell}\right)=1,
 \qquad
 \left(\frac{D_B}{\ell}\right)=
          \left(\frac{s_\ell}{\ell}\right).             \tag{4.1}
\]

After quadratic reciprocity,

\[
 \left(\frac{\ell}{D_A}\right)=
          \left(\frac{-1}{\ell}\right),
 \qquad
 \left(\frac{\ell}{D_B}\right)=
          \left(\frac{s_\ell}{\ell}\right).            \tag{4.2}
\]

Equivalently, the complete sign table is

\[
\begin{array}{c|rrrr}
\ell\bmod8&1&3&5&7\\ \hline
(D_A/D_B)&+1&-1&-1&+1\\
(\ell/D_A)&+1&-1&+1&-1\\
(\ell/D_B)&+1&-1&+1&+1.
\end{array}                                               \tag{4.3}
\]

#### Proof

Because the kernels are squarefree products of precisely the odd-exponent
primes, multiplicativity turns (1.5) into the first identity in (4.1).
Equation (3.1) gives \(D_A\equiv1\pmod\ell\) and
\(D_B\equiv s_\ell\pmod\ell\), proving the other two identities.

The table (3.4) says \(D_B\equiv1\pmod4\), so reciprocity introduces no
sign when exchanging \(\ell,D_B\).  It also says that \(D_A\equiv3\pmod4\)
exactly when \(\ell\equiv3\pmod4\).  Reciprocity therefore introduces a
minus sign exactly in that case, while \((D_A/\ell)=1\).  This proves (4.2).
Evaluating \(s_\ell=(2/\ell)\) and \((-1/\ell)\) in the four odd residue
classes gives (4.3). \(\square\)

At \(\ell\equiv3\pmod8\), all three edges of the aggregate character
triangle are negative.  This is a strict strengthening of the earlier
existence of one negative cross pair.  It remains an aggregate constraint:
it does not say that every individual cross pair is negative, an assertion
already refuted at the actual index eleven.

## 5. One more quotient digit

For a finite integer list \(T=(t_1,\ldots,t_m)\), put

\[
 E_1(T)=\sum_i t_i,\qquad
 E_2(T)=\sum_{i<j}t_it_j,\qquad
 E_3(T)=\sum_{i<j<k}t_it_jt_k.                           \tag{5.1}
\]

### Lemma 5.1 (third-order finite-product expansion)

For all integers \(x\),

\[
 \prod_i(1+xt_i)\equiv
 1+xE_1(T)+x^2E_2(T)+x^3E_3(T)\pmod{x^4}.                \tag{5.2}
\]

#### Proof

Induct on the list.  Multiplying the expansion for the tail by
\(1+xt_1\) adds \(t_1E_1\) to the quadratic coefficient and
\(t_1E_2\) to the cubic coefficient.  The only omitted new term is
\(x^4t_1E_3\), which vanishes modulo \(x^4\). \(\square\)

Repeat each \(A\)-channel quotient \(k_q\) exactly \(a_q=v_q(A_\ell)\)
times to obtain a list \(T_A\).  Repeat each signed \(B\)-channel quotient
\(s_rh_r\) exactly \(b_r=v_r(B_\ell)\) times to obtain \(T_B\).  Write

\[
 K_A=E_1(T_A),\ C_A=E_2(T_A),\ H_A=E_3(T_A),
\]

and similarly with subscript \(B\).  With

\[
 a=\frac{A_\ell-1}{2\ell},\qquad
 b=\frac{s_\ell B_\ell-1}{2\ell},                      \tag{5.3}
\]

Lemma 5.1, with \(x=2\ell\), gives

\[
 a\equiv K_A+2\ell C_A+4\ell^2H_A\pmod{8\ell^3},
\]

\[
 b\equiv K_B+2\ell C_B+4\ell^2H_B\pmod{8\ell^3}.       \tag{5.4}
\]

### Theorem 5.2 (third-order two-channel coupling)

The six product coefficients obey

\[
\boxed{\begin{aligned}
0\equiv{}&K_A-2K_B+\ell(K_A^2-2K_B^2)+2\ell(C_A-2C_B)\\
 &+4\ell^2\bigl(H_A-2H_B+K_AC_A-2K_BC_B\bigr)\\
 &+4\ell^3(C_A^2-2C_B^2)
 \pmod{8\ell^3}.
\end{aligned}}                                           \tag{5.5}
\]

#### Proof

The negative Pell equation gives the exact quotient identity

\[
                 a-2b+\ell(a^2-2b^2)=0.                 \tag{5.6}
\]

Substitute (5.4).  The linear terms give the first, fourth and
sixth-degree-in-\(\ell\) displayed contributions.  In the quadratic part,
the surviving terms modulo \(8\ell^3\) are

\[
 \ell(K_A^2-2K_B^2)
 +4\ell^2(K_AC_A-2K_BC_B)
 +4\ell^3(C_A^2-2C_B^2).
\]

Terms containing \(K_AH_A,K_BH_B\) have a factor \(8\ell^3\), and all
later terms have at least that divisibility.  Collecting the terms proves
(5.5). \(\square\)

Reducing (5.5) modulo \(4\ell^2\) recovers the previous second-order
ledger.  Thus (5.5) retains a genuinely new quotient digit.  It is a
necessary condition, not a contradiction; the cubic coefficients remain
free enough that no universal exclusion is claimed.

## 6. Actual prime-index search in both directions

The directory

`research/computation/2026_09_01_pell_odd_kernel_packet/`

contains a producer and an independent verifier.

The bounded producer examines every one of the 668 odd prime indices
\(3\le\ell\le5000\).  It searches every prime
\(q\le2{,}000{,}000\) in the necessary classes
\(q\equiv\pm1\pmod{2\ell}\), computes \(A_\ell,B_\ell\pmod{q^2}\), and
records the first exact exponent-one divisor it finds.  The replay gives

\[
 481\text{ certified simple-divisor hits},\qquad
 187\text{ unresolved indices}.                          \tag{6.1}
\]

In a second pass the verifier does not stop at the first simple divisor.  It
exhausts all 648,189 prime candidates in those index-dependent congruence
classes, computes both channels modulo \(q^3\), and records every repeated
factor.  The complete hit list is

\[
                    13^2\parallel B_7,                   \tag{6.2}
\]

with no depth-three hit.  This recovers the known exceptional square
\(B_7=13^2\); its opposite coordinate \(A_7=239\) has a simple divisor, so
it is not a full squarefull packet.  The result says nothing about candidate
primes above two million.

Every hit proves that the actual \(A_\ell B_\ell\) is not squarefull.  An
unresolved row says only that this bounded search found no small simple
divisor; the row remains fully active in both the proof and counterexample
directions.

For every odd prime index \(3\le\ell\le191\), the producer additionally
factors the exact coordinates and selects a simple divisor.  The independent
verifier does not trust those factorizations: it recomputes the coordinate
modulo \(q^2\), proves \(q\mid A_\ell\) or \(q\mid B_\ell\) and
\(q^2\nmid A_\ell,B_\ell\), and checks primality.  Forty-one factor primes
are below \(10^{12}\) and are checked by exhaustive trial division through
their square roots.  At \(\ell=59\), it checks the larger witness

\[
 13558774610046711780701\parallel B_{59}                 \tag{6.3}
\]

with a complete Pocklington certificate for the factorization of \(q-1\).
The replay status is `PASS`.  Therefore

\[
 \boxed{A_\ell B_\ell\text{ is not squarefull for every odd prime }
        \ell\le191.}                                     \tag{6.4}
\]

This is an exact finite theorem.  It neither proves eventual simplicity nor
rules out a squarefull packet at a larger prime index.

## 7. Formalization and remaining gate

The companion module

`Lean/IUTThreeClosures/PellOddKernelThirdOrderPacket20260901.lean`

kernel-checks the cubic-square factor-list identity, the odd-kernel residue
transport, the Jacobi reciprocity steps used in the index--kernel triangle,
the arbitrary-list third-order product expansion, quotient cancellation, and
the transfer from the two channel congruences to (5.5).  It contains no
proof placeholders, custom axioms, native evaluation shortcut, or imported
conjectural statement.

The module does not formalize the inherited perfect-power classification,
the deduction that the actual kernels are nontrivial, the actual Pell
mod-eight orbit, the arithmetic hypotheses that make the displayed Jacobi
symbols applicable, or the finite computation in Section 6.  Those inputs
are stated and proved or independently certified in ordinary mathematics;
the Lean boundary is the integer-algebraic core just listed.

The smallest remaining pointwise gate is still the actual opposite-channel
depth-three exclusion.  A hypothetical packet must now simultaneously have:

* nontrivial squarefree kernels \(D_A,D_B\), all of whose primes have rank
  \(\ell\) and depth at least three in their assigned channels;
* the mod-eight and mod-\(2\ell\) kernel table (3.1)--(3.6);
* square cores localized to \(\pm1\pmod{2\ell}\);
* the Jacobi triangle (4.3);
* the earlier second-order ledger and the sharper third-order ledger (5.5);
* no prime-index example at or below 191.

No full-premise counterexample to this packet was found, so the route is not
discarded.  Conversely, a single finite squarefull packet would refute the
pointwise exclusion but would not disprove standard abc; that still requires
an unbounded family of high-quality triples.

## References

The inherited rank, valuation, primitive-divisor, perfect-power, second-order
and reciprocity statements, with source copies and quantifier audits, are in:

* `research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md`;
* `research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md`;
* `research/ABC_PELL_RESIDUE_PARITY_LOCALIZATION_2026_09_01.md`.

The new arguments in Sections 2--5 are elementary consequences of the
displayed inherited identities.
