# Correlated all-order companion staircases and opposite-channel incidence in the balancing-Pell packet

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional polynomial identities, necessary conditions for the
remaining squarefull packet, and a certified finite exclusion through prime
index (271); no proof or disproof of the standard abc conjecture.

## 0. Claim and route boundary

Write

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2,
\]

and use the norm-one Lucas pair

\[
 u_n=A_nB_n=\frac{B_{2n}}2,
 \qquad v_n=2A_{2n},
 \qquad v_n^2-32u_n^2=4.
\]

The preceding all-order report proved a support-unit staircase for
(u_{\ell^2}/u_\ell) and reconstructed the two Pell channels from the first
companion correction.  This note proves that the companion quotient has its
own all-order support-unit staircase and that the two staircases are
coefficientwise correlated at every order.  The first-order splitter is
therefore one member of an entire coherent family.

The note also refines the aggregate kernel-character triangle to a
vertex-by-vertex parity law.  For (\ell\equiv3,5\pmod8), it forces an
opposite-channel depth-three pair (q,r) with

\[
 2\ell\mid q+r,\qquad \left(\frac qr\right)=-1,
\]

and the same all-order splitter simultaneously has signs (+1\pmod{q^6})
and (-1\pmod{r^6}).  This is a necessary condition, not a contradiction.

The route policy is literal: difficulty and finite no-hit results do not
retire the route.  Only a counterexample satisfying every premise may retire
the exact statement it contradicts.  No squarefull Pell packet was found.

## 1. The omitted companion polynomial in closed form

Let (k=2\theta+1) be a positive odd integer.  Define

\[
 d_j(k)=\binom{\theta+j}{2j}\qquad(0\le j\le\theta)
\]

and

\[
 \Psi_k(W)=\sum_{j=0}^{\theta}d_j(k)W^j.               \tag{1.1}
\]

Here a norm-one Lucas pair means the standard pair attached to roots
(\alpha,\beta) with (\alpha\beta=1):
(v_n=\alpha^n+\beta^n),
(\alpha^n-\beta^n=(\alpha-\beta)u_n), and
(\delta=(\alpha-\beta)^2).  This fixes all normalization conventions in
the general statement below.

### Proposition 1.1 (exact companion multiplication polynomial)

For every norm-one Lucas pair with discriminant (\delta), every (n\ge1),
and every positive odd (k=2\theta+1),

\[
 \frac{v_{nk}}{v_n}=\Psi_k(\delta u_n^2)
 =\sum_{j=0}^{\theta}\binom{\theta+j}{2j}
       \delta^j u_n^{2j}.                              \tag{1.2}
\]

Here the quotient notation means the exact identity
(v_{nk}=v_n\Psi_k(\delta u_n^2)), so no division in a residue ring is
being assumed.

#### Proof

Work first in the Laurent polynomial ring in an indeterminate (x), and put

\[
 W=(x-x^{-1})^2.
\]

For (m\ge0), write

\[
 S_m=x^{2m+1}+x^{-(2m+1)}.
\]

There is an exact factorization
(S_m=(x+x^{-1})R_m), where the quotient polynomial is determined without
inverting (x+x^{-1}) by

\[
 R_{m+1}=(W+2)R_m-R_{m-1},\qquad
 R_0=1,\quad R_1=1+W.                                  \tag{1.3}
\]

Indeed, the factorization is immediate for (m=0,1), and the Laurent
recurrence

\[
 S_{m+1}=(x^2+x^{-2})S_m-S_{m-1}=(W+2)S_m-S_{m-1}
\]

proves it inductively.  Thus this argument never cancels a possibly
nonunit value of (x+x^{-1}).

The polynomials

\[
 P_m(W)=\sum_{j=0}^m\binom{m+j}{2j}W^j
\]

obey the same recurrence and initial values.  Indeed, the coefficient of
(W^j) in ((W+2)P_m-P_{m-1}) reduces to
(\binom{m+1+j}{2j}) by two applications of Pascal's identity.  Thus
(R_m=P_m(W)).  Specializing (x=\alpha^n), and hence
(x^{-1}=\beta^n), gives
(W=(\alpha^n-\beta^n)^2=\delta u_n^2).  Taking
(m=\theta) now proves the exact identity (1.2).  □

This supplies explicitly the all-order companion polynomial whose existence
is stated, with only its first nonconstant coefficient written out, in the
audited Lucas source.

## 2. Coefficientwise correlation and a differential identity

The all-order multiplication polynomial for the first Lucas sequence is

\[
 \frac{u_{nk}}{u_n}=\Phi_k(\delta u_n^2),\qquad
 \Phi_k(W)=\sum_{j=0}^{\theta}c_j(k)W^j,               \tag{2.1}
\]

where

\[
 c_j(k)=
 \frac{k\prod_{m=1}^{j}(k^2-(2m-1)^2)}
      {4^j(2j+1)!}.                                    \tag{2.2}
\]

### Theorem 2.1 (coefficientwise companion correlation)

For every (0\le j\le\theta),

\[
 \boxed{(2j+1)c_j(k)=k d_j(k).}                        \tag{2.3}
\]

Consequently the multiplication polynomials satisfy the exact identity

\[
 \boxed{\Phi_k(W)+2W\Phi_k'(W)=k\Psi_k(W).}            \tag{2.4}
\]

#### Proof

Because (k=2\theta+1), each factor in (2.2) is

\[
 k^2-(2m-1)^2=4(\theta-m+1)(\theta+m).
\]

Therefore

\[
 \frac1{4^j}\prod_{m=1}^j(k^2-(2m-1)^2)
 =\frac{(\theta+j)!}{(\theta-j)!}.
\]

Substitution in (2.2) yields

\[
 c_j(k)=\frac{k}{2j+1}
         \frac{(\theta+j)!}{(2j)!(\theta-j)!}
       =\frac{k}{2j+1}\binom{\theta+j}{2j},
\]

which is (2.3).  Comparing coefficients gives (2.4).  □

There is also a direct analytic check: if (W=4\sinh^2t), then
(\Phi_k(W)=\sinh(kt)/\sinh t).  The operator (1+2W\,d/dW)
turns this ratio into (k\cosh(kt)/\cosh t=k\Psi_k(W)).  This check is
not needed for the algebraic proof.

## 3. Two simultaneous support-unit staircases

Fix an odd prime (\ell=2\theta+1), and put

\[
 A=A_\ell,qquad B=B_\ell,qquad U=AB=u_\ell.
\]

Define integral coefficients

\[
 a_j=32^j c_j(\ell),\qquad
 b_j=32^j d_j(\ell).                                   \tag{3.1}
\]

Then

\[
 Q_u:=\frac{u_{\ell^2}}{u_\ell}
      =\sum_{j=0}^{\theta}a_jU^{2j},qquad
 Q_v:=\frac{v_{\ell^2}}{v_\ell}
      =\sum_{j=0}^{\theta}b_jU^{2j}.                   \tag{3.2}
\]

For (0\le r\le\theta), define normalized tails

\[
 E_r=\sum_{j=r}^{\theta}a_jU^{2(j-r)},\qquad
 F_r=\sum_{j=r}^{\theta}b_jU^{2(j-r)}.                 \tag{3.3}
\]

To state the differential identity literally, also put

\[
 \mathcal E_r(X)=\sum_{j=r}^{\theta}a_jX^{j-r},\qquad
 \mathcal F_r(X)=\sum_{j=r}^{\theta}b_jX^{j-r},
 \quad E_r=\mathcal E_r(U^2),\quad F_r=\mathcal F_r(U^2).
\]

### Theorem 3.1 (paired all-order support-unit staircase)

For every (0\le r\le\theta),

\[
 Q_u-\sum_{j<r}a_jU^{2j}=U^{2r}E_r,qquad
 Q_v-\sum_{j<r}b_jU^{2j}=U^{2r}F_r.                   \tag{3.4}
\]

Moreover,

\[
 \gcd(E_r,U)=\gcd(F_r,U)=1,                            \tag{3.5}
\]

and the tail polynomials obey the exact differential relation

\[
 \boxed{(2r+1)\mathcal E_r(X)+2X\mathcal E_r'(X)
       =\ell\mathcal F_r(X).}                          \tag{3.6}
\]

In particular,

\[
 \boxed{(2r+1)E_r\equiv\ell F_r\pmod{U^2}.}           \tag{3.7}
\]

If (p\mid U) and (e_p=v_p(U)), the two unnormalized tails in
(3.4) both have exact valuation (2re_p) at (p).

#### Proof

The two factorizations in (3.4) follow by removing their prefixes and
factoring (U^{2r}).  Every support prime (p\mid U) satisfies
(p\ge2\ell-1>\ell).  Since
(\theta+j\le\ell-1<p), all factorials in
(d_j=\binom{\theta+j}{2j}) are units modulo (p); hence (p\nmid d_j).
The preceding all-order coefficient argument gives (p\nmid c_j(\ell)),
and (p\nmid32).  Therefore (a_r,b_r) are both units at every support
prime.  Since (E_r\equiv a_r\pmod{U^2}) and
(F_r\equiv b_r\pmod{U^2}), (3.5) follows.

Apply (2.3) term by term.  The coefficient of (X^{j-r}) in the left
side of (3.6) is

\[
 (2r+1+2(j-r))a_j=(2j+1)a_j=\ell b_j.
\]

This proves (3.6).  Evaluate it at (X=U^2); every nonconstant term then
vanishes modulo (U^2), giving (3.7).  Finally, the normalized tails are
(p)-adic units, so (3.4) gives the exact valuation (2re_p).  □

For an odd-kernel prime of a hypothetical squarefull packet,
(e_p\ge3); hence both staircases have exact depth at least (6r),
simultaneously at both opposite-channel primes.

## 4. Every-order channel reconstruction and cross-order coherence

Put

\[
 T_r=v_\ell F_r,qquad Z_0=\frac{v_\ell}{2}=A_{2\ell}.
\]

### Theorem 4.1 (every-order channel splitter)

For every (0\le r\le\theta), the congruence

\[
 2(2r+1)E_r Z_r\equiv\ell T_r\pmod{U^2}               \tag{4.1}
\]

has a unique solution modulo (U^2), and it is

\[
 \boxed{Z_r\equiv Z_0=A_{2\ell}\pmod{U^2}.}            \tag{4.2}
\]

Thus

\[
 Z_r\equiv1\pmod{A^2},\qquad
 Z_r\equiv-1\pmod{B^2},qquad
 Z_r^2\equiv1\pmod{U^2}.                              \tag{4.3}
\]

For any two levels (r,s), one also has the determinant-zero relation

\[
 \boxed{(2s+1)E_sT_r\equiv(2r+1)E_rT_s\pmod{U^2}.}     \tag{4.4}
\]

#### Proof

Multiplying (3.7) by (v_\ell) gives

\[
 \ell T_r\equiv(2r+1)v_\ell E_r
 =2(2r+1)E_rZ_0\pmod{U^2}.                             \tag{4.5}
\]

Every prime dividing (U) is odd, exceeds (\ell), and therefore divides
neither (2(2r+1)) nor (E_r).  The coefficient of (Z_r) in (4.1) is
thus invertible modulo (U^2).  Equation (4.5) proves existence and
uniqueness and identifies the solution as (Z_0).

The exact Pell identities

\[
 A_{2\ell}=2A^2+1=4B^2-1
\]

give the first two channel signs; coprimality of (A,B) combines them to
the last congruence in (4.3).  Finally, multiply (4.5) at level (r) by
((2s+1)E_s), multiply it at level (s) by ((2r+1)E_r), and cancel
(\ell), which is coprime to (U).  This proves (4.4).  □

### Corollary 4.2 (opposite depth-six signs at every order)

If (q^3\mid A) and (r^3\mid B), then every reconstructed (Z_j)
satisfies

\[
 Z_j\equiv1\pmod{q^6},\qquad
 Z_j\equiv-1\pmod{r^6}.                               \tag{4.6}
\]

#### Proof

The hypotheses give (q^6\mid A^2\) and (r^6\mid B^2).  Reduce (4.3)
through these divisibilities.  □

The higher splitters are coherent rather than independent: (4.4) says that
all pairs (((2r+1)E_r,T_r)) lie on one projective line modulo (U^2).
This significantly compresses the all-order data, but no uniform theorem
currently shows that the line cannot carry the two depth-six channel signs.

## 5. Vertexwise odd-kernel character incidence

For a hypothetical squarefull packet write

\[
 A=D_A^3X^2,qquad B=D_B^3Y^2,
\]

where (D_A,D_B) are the squarefree products of primes occurring to odd
exponent.  Let (O_A,O_B) denote their prime supports.  For
(q\in O_A,r\in O_B), put

\[
 \chi_{q,r}=\left(\frac qr\right).
\]

Every (B)-channel prime is (1\pmod4), so quadratic reciprocity permits
the two orientations of (\chi_{q,r}) to be interchanged without a sign.

### Theorem 5.1 (endpoint parity laws)

For every (r\in O_B),

\[
 \boxed{\prod_{q\in O_A}\chi_{q,r}
       =\left(\frac2r\right).}                         \tag{5.1}
\]

For every (q\in O_A),

\[
 \boxed{\prod_{r\in O_B}\chi_{q,r}
       =\left(\frac Bq\right).}                        \tag{5.2}
\]

The endpoint prescriptions have the exact compatibility condition

\[
 \prod_{r\in O_B}\left(\frac2r\right)
 =\prod_{q\in O_A}\left(\frac Bq\right)
 =\left(\frac2\ell\right).                            \tag{5.3}
\]

#### Proof

Fix (r\mid B).  From (A^2-2B^2=-1) one gets
(A^2\equiv-1\pmod r).  Since (r\equiv1\pmod4), Euler's criterion gives

\[
 \left(\frac Ar\right)=(-1)^{(r-1)/4}
 =\left(\frac2r\right).
\]

The square core disappears from a quadratic character and the cube has the
same character as its base, so
((A/r)=(D_A/r)=\prod_{q\in O_A}(q/r)).  This proves (5.1).

Similarly (B=D_B^3Y^2) gives

\[
 \left(\frac Bq\right)=\left(\frac{D_B}q\right)
 =\prod_{r\in O_B}\left(\frac rq\right)
 =\prod_{r\in O_B}\left(\frac qr\right),
\]

which proves (5.2).  Multiplying either all rows or all columns multiplies
the same edge matrix.  The inherited (B)-channel sign ledger evaluates
the row product as ((2/\ell)), proving (5.3).  □

Thus the aggregate triangle is a bipartite degree-parity condition.  A
(B)-kernel vertex (r\equiv5\pmod8) has odd negative degree, while a
vertex (r\equiv1\pmod8) has even negative degree.

### Proposition 5.2 (quartic-two column sign in the split class)

If (q\in O_A) and (q\equiv1\pmod8), then

\[
 \boxed{\left(\frac Bq\right)
   =2^{(q-1)/4}\pmod q\in\{1,-1\}.}                   \tag{5.4}
\]

Hence the negative degree parity at such a (q) is exactly the failure of
(2) to be a fourth power modulo (q).

#### Proof

Modulo (q\mid A), the Pell equation gives (2B^2\equiv1).  Put
(m=(q-1)/4).  Euler's criterion and (q\equiv1\pmod8) give

\[
 \left(\frac Bq\right)=B^{2m}=2^{-m}.
\]

Because ((2/q)=1), the sign (2^m) squares to one, so its inverse is
itself.  This proves (5.4).  □

For (q\equiv7\pmod8), the oriented sign ((B/q)) remains in (5.2); no
quartic character is asserted in that nonsplit exponent class.

### Corollary 5.3 (forced nonresidue opposite pair)

If (\ell\equiv3\) or (5\pmod8), a hypothetical squarefull packet has
primes (q\in O_A,r\in O_B) such that

\[
 v_q(A)\ge3,qquad v_r(B)\ge3,qquad
 \left(\frac qr\right)=-1,qquad 2\ell\mid q+r.        \tag{5.5}
\]

Both primes have norm-one rank (\ell), and every-order reconstruction
obeys (4.6) at this same pair.

#### Proof

In these two index classes, the inherited kernel table has
(D_B\equiv5\pmod8).  Every prime in (O_B) is (1) or (5\pmod8), so
an odd number of them are (5\pmod8).  Choose one such (r).  Equation
(5.1) says its row product is (-1), so some (q\in O_A) has
((q/r)=-1).  Squarefull odd exponents are at least three.  The channel
rank congruences are

\[
 q\equiv1\pmod{2\ell},\qquad
 r\equiv(2/r)=-1\pmod{2\ell},
\]

which proves (2\ell\mid q+r).  The rank and splitter conclusions are the
inherited rank theorem and Corollary 4.2.  □

At the actual index (11), the unique odd-kernel (B)-vertex (5741)
has two incident signs, ((23/5741)=-1) and
((353/5741)=+1).  Thus (5.1) is sharp: its negative product does not imply
that every edge is negative.  This is a full-premise counterexample only to
that stronger ordinary prime-index assertion, already retired in the
preceding report; it does not satisfy the squarefull-packet premises.

## 6. Relation to the third-order factorization ledger

The earlier third-order ledger uses the prime-factor quotients

\[
 q=1+2\ell k_q,qquad
 r=\left(\frac2r\right)+2\ell h_r
\]

and the elementary coefficients (K_A,C_A,H_A,K_B,C_B,H_B).  Nothing in
the proof of Sections 1--5 replaces that ledger.  A surviving packet must
satisfy simultaneously:

1. the third-order congruence modulo (8\ell^3);
2. both support-unit staircases and the exact tail differential law (3.6);
3. every cross-order determinant in (4.4);
4. the depth-six signs (4.6);
5. the vertexwise incidence laws (5.1)--(5.4), including the forced pair
   (5.5) in the two nonsquare classes of (2).

The new identities do not make the third-order coefficients functions of
the Lucas tail coefficients.  A missing uniform arithmetic theorem still
has to couple the prime-factor quotients to the all-order projective line.
That missing theorem is an open gate, not grounds for abandoning the route.

## 7. Independent finite proof and counterexample search

The replay bundle is

`research/computation/2026_09_01_pell_lucas_correlated_all_order/`.

It proves the following finite statement.

### Proposition 7.1 (exact exclusion through prime index 271)

For every odd prime (3\le\ell\le271), at least one of (A_\ell,B_\ell)
has a prime divisor of exponent exactly one.  Consequently

\[
 \boxed{A_\ell B_\ell\text{ is not squarefull for every odd prime }
        \ell\le271.}                                   \tag{7.1}
\]

#### Proof

There are (57) prime indices in the range.  For every row, the independent
verifier proves primality of the recorded divisor (q), recomputes the
chosen coordinate modulo (q^2), and checks that (q) divides that coordinate
while (q^2) does not.  Primes below (2^{64})
use deterministic Miller--Rabin bases; the large witness at (\ell=59)
uses a complete Pocklington certificate.  An exponent-one prime contradicts
squarefullness: the Pell identity gives (\gcd(A_\ell,B_\ell)=1), so the
recorded prime does not divide the other coordinate and has exponent exactly
one in (A_\ell B_\ell).  The verifier covers all 57 indices with no missing
row and returns `PASS`.  □

The bounded opposite-depth scan performs (527{,}352) prime-candidate
tests with (q\le2{,}000{,}000).  It finds only
(13^2\parallel B_7) and no depth-three hit.  This no-hit result is not an
unbounded theorem and retires no route.  The exact simple-divisor witnesses,
not the no-hit result, prove (7.1).

As formula audits, two independent implementations rebuild (c_j) from the
defining product/factorial formula and compare all (138{,}675) coefficient
pairs at prime (\ell\le2000) with the independently computed binomial
(d_j).  They check both multiplication polynomials in (228) recurrence
evaluations (57 indices times four moduli).  Complete factorizations at the
13 prime indices through 43 replay the row, column, quartic-two, and global
incidence laws.

No counterexample satisfying the full squarefull, rank, depth-three,
all-order, splitter, character, and third-order premises was found.  A
future full-premise example would refute the exact pointwise exclusion
target but would not by itself disprove standard abc; disproof of abc still
requires an unbounded family of sufficiently high-quality triples.

## 8. Lean boundary

The companion module is

`Lean/IUTThreeClosures/PellLucasCorrelatedAllOrderExclusion20260901.lean`.

It kernel-checks the passage from the original rational product coefficient
to the closed binomial form and its coefficient correlation, the exact
correlated-list weighted identity, normalized-tail congruence, every-order
paired correction, recovery of the common half-companion residue,
cross-order determinant, propagation of channel signs to sixth powers, and
the finite sign-row extraction used in Corollary 5.3.  The Lucas
multiplication theorem, rank theorem, perfect-power classification, and
nonexistence of the open packet are not declared as axioms.  Their arithmetic
specializations are proved above or supplied as explicit hypotheses at the
formal interface.

## References

* Geng-Rui Zhang, *13 unknowns over quadratic integer rings and Lucas
  congruences*, arXiv:2608.30389v1, 2026, Proposition 5.1 and Corollary 5.2.
* Christian J.-C. Ballot and Hugh C. Williams, *The Lucas Sequences: Theory
  and Applications*, Springer, 2023, classical Lucas multiplication
  polynomials.
* The inherited rank, kernel, character, and third-order results are proved
  and audited in
  `research/ABC_PELL_LUCAS_ALL_ORDER_STAIRCASE_2026_09_01.md` and
  `research/ABC_PELL_ODD_KERNEL_THIRD_ORDER_PACKET_2026_09_01.md`.
