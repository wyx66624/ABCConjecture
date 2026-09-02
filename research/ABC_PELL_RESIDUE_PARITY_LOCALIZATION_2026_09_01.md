# Residue-parity localization in the balancing-Pell packet

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional pointwise sharpening and an exact counterexample to
an overstrong reciprocity shortcut; no proof or disproof of the standard abc
conjecture.

## 1. Scope and route policy

Put

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2 .
\]

For odd \(n\),

\[
 A_n^2-2B_n^2=-1,
 \qquad \gcd(A_n,B_n)=1.                         \tag{1.1}
\]

The preceding Pell packet analysis shows that, at an odd prime index
\(\ell\), every odd prime divisor of \(A_\ell B_\ell\) has rank \(\ell\).
It also proves the cross-channel character identity

\[
 \prod_{q\in O_A}\prod_{r\in O_B}
       \left(\frac qr\right)=\left(\frac2\ell\right),   \tag{1.2}
\]

where \(O_A\) and \(O_B\) are the prime divisors occurring to odd exponent
in the two channels.  If \(A_\ell B_\ell\) is squarefull, every member of
these sets has exponent at least three.

This note extracts two additional pieces of information from (1.1)--(1.2):

1. in three of the four odd residue classes of \(\ell\pmod 8\), at least one
   depth-three prime is forced into a specified residue class modulo eight;
2. when \((2/\ell)=-1\), at least one pair of odd-exponent primes in opposite
   channels has cross Legendre symbol \(-1\).

The second assertion is existential.  Section 6 gives a full actual
prime-index counterexample to the stronger assertion that every cross pair
must have symbol \(-1\).  That exact strengthening is discarded.  The
squarefull Pell route is not discarded: the counterexample has exponent-one
factors and hence does not satisfy its squarefull premise.

## 2. The exact mod-eight orbit

Multiplication by \(1+\sqrt2\) gives

\[
 A_{n+1}=A_n+2B_n,
 \qquad B_{n+1}=A_n+B_n.                         \tag{2.1}
\]

Moreover

\[
 (1+\sqrt2)^8=577+408\sqrt2
              \equiv 1\pmod8
              \quad\text{in }(\mathbb Z/8\mathbb Z)[\sqrt2].       \tag{2.2}
\]

Consequently \((A_{n+8},B_{n+8})\equiv(A_n,B_n)\pmod 8\).  Evaluating the
four odd starting classes gives

\[
\begin{array}{c|cccc}
n\pmod8&1&3&5&7\\ \hline
A_n\pmod8&1&7&1&7\\
B_n\pmod8&1&5&5&1.
\end{array}                                                \tag{2.3}
\]

### Proposition 2.1 (odd-orbit residues)

For every odd prime \(\ell\),

\[
 A_\ell\equiv
 \begin{cases}
 1\pmod8,&\ell\equiv1,5\pmod8,\\
 7\pmod8,&\ell\equiv3,7\pmod8,
 \end{cases}                                               \tag{2.4}
\]

and

\[
 B_\ell\equiv
 \begin{cases}
 1\pmod8,&\ell\equiv1,7\pmod8,\\
 5\pmod8,&\ell\equiv3,5\pmod8.
 \end{cases}                                               \tag{2.5}
\]

#### Proof

Equation (2.2) makes the pair periodic modulo eight with period dividing
eight.  The four direct evaluations in (2.3) prove (2.4)--(2.5).  No
primality property beyond the fact that \(\ell\) belongs to one of the four
odd residue classes is used.  \(\square\)

## 3. Residue classes of the channel primes

### Proposition 3.1 (local channel residues)

Let \(\ell\) be odd.

1. If an odd prime \(q\mid A_\ell\), then
   \(q\equiv1\) or \(7\pmod 8\).
2. If an odd prime \(r\mid B_\ell\), then
   \(r\equiv1\) or \(5\pmod 8\).

#### Proof

If \(q\mid A_\ell\), equation (1.1) gives

\[
                    2B_\ell^2\equiv1\pmod q.             \tag{3.1}
\]

Thus \(2\) is a nonzero quadratic residue modulo \(q\).  The supplementary
law for \(2\) gives \(q\equiv1,7\pmod 8\).

If \(r\mid B_\ell\), equation (1.1) gives

\[
                    A_\ell^2\equiv-1\pmod r.             \tag{3.2}
\]

Hence \(-1\) is a quadratic residue modulo \(r\), so
\(r\equiv1\pmod4\), equivalently \(r\equiv1,5\pmod8\).
The coprimality in (1.1) ensures that the displayed residues are nonzero.
\(\square\)

## 4. An involutive residue extraction lemma

The following elementary lemma is useful beyond the Pell specialization.

### Lemma 4.1 (odd exponent in the nontrivial involution class)

Let \(G\) be a commutative multiplicative monoid.  Let
\(\rho\in G\) satisfy \(\rho^2=1\) and \(\rho\ne1\).  Suppose

\[
                   \prod_{i=1}^t x_i^{e_i}=\rho,          \tag{4.1}
\]

and every \(x_i\) is either \(1\) or \(\rho\).  Then some \(i\) satisfies

\[
                         x_i=\rho,qquad e_i\text{ odd}.  \tag{4.2}
\]

If additionally every \(e_i\ge2\), this exponent is at least three.

#### Proof

Assume that no index satisfies (4.2).  If \(x_i=1\), then
\(x_i^{e_i}=1\).  If \(x_i=\rho\), its exponent must be even, and
\(\rho^{e_i}=(\rho^2)^{e_i/2}=1\).  Every factor in (4.1) is therefore one,
contradicting \(\rho\ne1\).  An odd integer at least two is at least three.
\(\square\)

Apply the lemma in \((\mathbb Z/8\mathbb Z)^\times\).  Both \(7=-1\) and
\(5\) are nontrivial involutions.

### Theorem 4.2 (forced-residue depth-three localization)

Let \(\ell\) be an odd prime, and suppose \(A_\ell B_\ell\) is squarefull.

1. If \(\ell\equiv3\) or \(7\pmod8\), there is a prime
   \(q_A\mid A_\ell\) such that
   
   \[
                q_A\equiv7\pmod8,qquad v_{q_A}(A_\ell)\ge3,        \tag{4.3}
   \]
   and the exponent is odd.
2. If \(\ell\equiv3\) or \(5\pmod8\), there is a prime
   \(q_B\mid B_\ell\) such that
   
   \[
                q_B\equiv5\pmod8,qquad v_{q_B}(B_\ell)\ge3,        \tag{4.4}
   \]
   and the exponent is odd.

#### Proof

Factor \(A_\ell\) and \(B_\ell\) into prime powers.  Proposition 2.1 shows
that both coordinates are odd, so every factor prime is odd.  Proposition
3.1 says that the \(A\)-channel residue factors are \(1\) or \(7\), and the
\(B\)-channel residue factors are \(1\) or \(5\).  In the first pair of
index classes, Proposition 2.1 says that the total \(A\)-product is \(7\);
Lemma 4.1 with \(\rho=7\) gives an odd exponent in that class.  In the
second pair, the total \(B\)-product is \(5\), and the same lemma with
\(\rho=5\) applies.  Since \(\gcd(A_\ell,B_\ell)=1\), squarefullness of
\(A_\ell B_\ell\) makes every positive exponent in either channel at least
two.  Hence the selected odd exponents are at least three.  \(\square\)

For \(\ell\equiv3\pmod8\), both conclusions hold simultaneously.  Thus a
hypothetical squarefull packet in that index class contains a \(7\pmod8\)
depth-three prime in the \(A\) channel and a \(5\pmod8\) depth-three prime
in the \(B\) channel.  This is strictly more localized than the earlier
existence of an unspecified odd exponent in each channel.

For the formal interface, use finite factor lists

\[
 \mathcal A=[(q_i,a_i)]_i,
 \qquad \mathcal B=[(r_j,b_j)]_j,
\]

which are the complete prime factorizations in the actual Pell
specialization.  Every listed base is prime, every \(a_i,b_j\ge2\), the \(A\)-residues
belong to \(\{1,7\}\), and the \(B\)-residues belong to \(\{1,5\}\).  Put

\[
 R_A=\prod_i(q_i\bmod8)^{a_i},
 \qquad R_B=\prod_j(r_j\bmod8)^{b_j}.
\]

Then \(R_A=7\) forces a listed \(q_i\equiv7\pmod8\) with odd
\(a_i\ge3\), and \(R_B=5\) forces a listed
\(r_j\equiv5\pmod8\) with odd \(b_j\ge3\).  This is precisely Lemma 4.1
applied to each list; the proof introduces no condition beyond the displayed
factor-list hypotheses.  For the actual Pell packet, Proposition 3.1 supplies
the allowed classes, Proposition 2.1 supplies \(R_A=7\) or \(R_B=5\), and
coprimality plus squarefullness supplies the lower bounds on the exponents.

## 5. A forced cross-channel nonresidue

### Theorem 5.1 (existence of a nonresidue depth pair)

Let \(\ell\) be an odd prime with
\(\ell\equiv3\) or \(5\pmod8\).  If \(A_\ell B_\ell\) is squarefull, then
there are primes \(q\mid A_\ell\) and \(r\mid B_\ell\), each occurring to
odd exponent at least three, such that

\[
                              \left(\frac qr\right)=-1.   \tag{5.1}
\]

#### Proof

For these two residue classes, the supplementary law gives
\((2/\ell)=-1\).  Hence the finite product in (1.2) is \(-1\).  Every factor
of that product is \(1\) or \(-1\), since the two channels are coprime and
the Legendre symbols cannot vanish.  If all were \(1\), their product would
be \(1\).  At least one pair therefore has symbol \(-1\).  Its two primes
belong to \(O_A\) and \(O_B\), so their exponents are odd.  Squarefullness
makes those exponents at least three.  \(\square\)

This theorem adds a cross-prime condition that is invisible to separate
order towers.  It does not determine which pair is the nonresidue, and it
does not by itself contradict the packet.

The corresponding factor-list formulation flattens
\(O_A\times O_B\) into a finite list of records
\((q,r,a_q,b_r,\left(\frac qr\right))\).  If each recorded sign is \(1\) or \(-1\), both
recorded exponents are odd and at least two, and the product of all recorded
signs is \(-1\), then some record has sign \(-1\) and both of its exponents
are odd and at least three.  The proof first applies the finite sign-product
lemma and then uses oddness together with the lower bound two.  Coprimality
of the two channels supplies the sign range; Equation (1.2) and
squarefullness supply the remaining hypotheses for the actual packet when
\(\ell\equiv3,5\pmod8\).

## 6. Exact counterexample to the all-pairs shortcut

The existential conclusion in Theorem 5.1 cannot be replaced, under the
ordinary actual prime-index hypotheses, by the assertion that every cross
pair is a nonresidue.

### Proposition 6.1 (the actual index-eleven counterexample)

At the prime index \(\ell=11\),

\[
 A_{11}=8119=23\cdot353,qquad B_{11}=5741,               \tag{6.1}
\]

and \(23,353,5741\) are prime.  The two cross symbols are

\[
                  \left(\frac{23}{5741}\right)=-1,
          \qquad  \left(\frac{353}{5741}\right)=1.       \tag{6.2}
\]

Their product is \(-1=(2/11)\), exactly as required by (1.2), but one
individual pair is a residue.

#### Proof

Eleven steps of (2.1) give the coordinates in (6.1), and trial division up
to the relevant square roots proves the three primality claims.  For the
positive symbol,

\[
                        252^2\equiv353\pmod {5741}.        \tag{6.3}
\]

For the negative symbol, \(5741\equiv1\pmod4\), so quadratic reciprocity
gives

\[
 \left(\frac{23}{5741}\right)
 =\left(\frac{5741}{23}\right)
 =\left(\frac{14}{23}\right)=-1,                         \tag{6.4}
\]

where the last equality follows from \(14^{11}\equiv-1\pmod {23}\).
Also \(11\equiv3\pmod8\), so the supplementary law gives
\((2/11)=-1\).  This proves (6.2) and verifies the global-character premise.
\(\square\)

This is a full-premise counterexample to the statement

> at every odd prime index with \((2/\ell)=-1\), every pair in
> \(O_A\times O_B\) has Legendre symbol \(-1\).

It is not a counterexample to Theorem 5.1.  It is also not a counterexample
to any assertion whose premise requires \(A_\ell B_\ell\) to be squarefull:
all three exponents in (6.1) are one.

## 7. Formalization boundary and next gate

The companion Lean module

`Lean/IUTThreeClosures/PellResidueParityLocalization20260901.lean`

kernel-checks:

1. the integral recurrence and negative Pell norm;
2. the exact eight-step formula and all four odd residue classes modulo
   eight;
3. the general involutive-residue extraction lemma, its depth-three
   corollary, and the explicit two-channel factor-list packet theorem
   corresponding to Theorem 4.2;
4. the sign-product existence lemma and the flattened cross-factor-list
   packet theorem corresponding to Theorem 5.1;
5. one combined index-eleven certificate containing prime-index status,
   the global character, the Pell coordinates, factorization, exponent-one
   witnesses and both cross Legendre symbols.

The elementary number-theoretic specialization from the abstract residue
lemma to arbitrary prime factorizations is stated and proved above before
the Lean implementation.  No classification theorem, finite scan, IUT
statement, or abc proposition is inserted as an axiom.

The remaining Pell gate is still the actual opposite-channel depth-three
exclusion.  Theorem 4.2 narrows the allowed residue classes and Theorem 5.1
forces at least one cross nonresidue when \(\ell\equiv3,5\pmod8\); neither
condition is yet contradictory.  Searches for a full squarefull packet and
positive attempts to exclude it both remain active.

## References

The inherited source ledger, exact channel theorem, valuation dictionary,
second-order congruence and reciprocity identity are in:

* `research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md`;
* `research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md`;
* `research/computation/2026_09_01_pell_four_prime_coupling/SOURCE_NOTES.md`.

All new arguments in Sections 2, 4, 5 and 6 are elementary consequences of
the displayed identities.
