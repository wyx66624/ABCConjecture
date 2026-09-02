# Factor-quotient jets and the exact endpoint curvature of the correlated Pell--Lucas projective system

**Author:** ChatGPT  
**Date:** 2026-09-02  
**Status:** unconditional algebraic identities, an exact sharpness theorem for
the all-order projective modulus, a certified finite actual-Pell exclusion
through prime index \(271\), and full-premise counterexamples to three
precisely stated stronger auxiliary claims; no proof or disproof of the
standard abc conjecture.

## 0. Claim boundary and route policy

Write

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2,
 \qquad U=A_\ell B_\ell,
 \qquad v=2A_{2\ell}.
\]

The preceding reports produced two kinds of information about a hypothetical
squarefull packet at an odd prime index \(\ell\).

1. Prime-factor quotients of the two Pell channels give a third-order
   congruence modulo \(8\ell^3\).
2. The norm-one Lucas multiplication polynomials give a correlated family of
   projective points, pairwise collinear modulo \(U^2\), together with
   opposite depth-six signs and vertexwise quadratic-character incidence.

The missing interface was an exact formula relating the prime-factor quotient
data to the projective system.  This note supplies that interface.  Its most
rigid consequence is unexpectedly a sharpness theorem: for the highest two
adjacent orders, the cross-order determinant is *exactly* \(U^2\) times a
unit at every prime of \(U\).  Hence the previously proved modulus \(U^2\)
cannot be improved to \(U^3\), even for the genuine Pell sequence.  This
rules out one attempted strengthening, but it does not rule out the Pell
route.  The surviving route must use information beyond repeated copies of
the same projective congruence.

Throughout this report, a difficult or currently unproved step remains open.
Only a counterexample satisfying every premise of a precisely stated claim
retires that claim.  In particular, bounded absence of a squarefull packet is
never promoted to an unbounded theorem.

## 1. Inherited exact setup

Put \(x=2\ell\) and

\[
 a=\frac{A_\ell-1}{x},
 \qquad b=\frac{s_\ell B_\ell-1}{x},
 \qquad s_\ell=\left(\frac2\ell\right).
\]

For each prime factor \(q\mid A_\ell\), write

\[
 q=1+xk_q.
\]

For each prime factor \(r\mid B_\ell\), put
\(s_r=(2/r)\) and write

\[
 r=s_r+xh_r=s_r(1+x s_rh_r).
\]

Repeat \(k_q\) exactly \(v_q(A_\ell)\) times in a list \(T_A\), and
repeat \(s_rh_r\) exactly \(v_r(B_\ell)\) times in \(T_B\).  If
\(E_j(T)\) is the degree-\(j\) elementary symmetric function, define

\[
 (K_A,C_A,H_A)=(E_1(T_A),E_2(T_A),E_3(T_A))
\]

and similarly for \(B\).  The exact factorization and the third-order finite
product expansion give

\[
 a\equiv K_A+xC_A+x^2H_A\pmod{x^3},
 \qquad
 b\equiv K_B+xC_B+x^2H_B\pmod{x^3}.                 \tag{1.1}
\]

The negative Pell equation is equivalent to

\[
 a-2b+\ell(a^2-2b^2)=0.                              \tag{1.2}
\]

Substitution of (1.1) in (1.2) is exactly the previously proved
third-order ledger modulo \(8\ell^3=x^3\).

For \(\theta=(\ell-1)/2\), the correlated Lucas coefficients are

\[
 \alpha_j=32^j c_j(\ell),
 \qquad
 \beta_j=32^j\binom{\theta+j}{2j},
 \qquad
 (2j+1)\alpha_j=\ell\beta_j.                         \tag{1.3}
\]

Their normalized tail polynomials are

\[
 E_r(X)=\sum_{j=r}^{\theta}\alpha_jX^{j-r},
 \qquad
 F_r(X)=\sum_{j=r}^{\theta}\beta_jX^{j-r}.           \tag{1.4}
\]

They obey the exact differential identity

\[
 (2r+1)E_r(X)+2X E_r'(X)=\ell F_r(X).                \tag{1.5}
\]

At \(X=U^2\), put \(T_r=vF_r(U^2)\).  Reducing (1.5) modulo
\(U^2\) yields the inherited projective congruence

\[
 \ell T_r\equiv (2r+1)vE_r(U^2)\pmod{U^2}.           \tag{1.6}
\]

## 2. The cubic fingerprint of a depth-three carrier

### Proposition 2.1 (three repeated quotient copies)

Let \(t\) be an integer and let \(R\) be a finite integer list.  Write
\((K_0,C_0,H_0)=(E_1(R),E_2(R),E_3(R))\).  Then

\[
\begin{aligned}
 E_1(t,t,t,R)&=3t+K_0,\\
 E_2(t,t,t,R)&=3t^2+3tK_0+C_0,\\
 E_3(t,t,t,R)&=t^3+3t^2K_0+3tC_0+H_0.                \tag{2.1}
\end{aligned}
\]

#### Proof

Choose respectively one, two, or three entries from the three distinguished
copies and from \(R\).  For degree two, the three internal pairs contribute
\(3t^2\), the mixed choices group as \(3tK_0\), and the pairs
inside \(R\) contribute \(C_0\).  For degree three, the internal triple
contributes \(t^3\), choosing two distinguished copies and one residual
entry contributes \(3t^2K_0\), choosing one distinguished copy and a
residual pair contributes \(3tC_0\), and the residual triples contribute
\(H_0\).  This proves (2.1).  \(\square\)

If \(q^3\mid A_\ell\), its quotient \(k_q\) therefore enters the
third-order ledger with the unavoidable cubic fingerprint

\[
 (3k_q,3k_q^2,k_q^3)
\]

plus the exact residual terms in (2.1).  If an opposite-channel prime
\(r\equiv-1\pmod{x}\) has \(r=-1+xh_r\) and \(r^3\mid B_\ell\), its
normalized factor quotient is \(-h_r\), so its fingerprint is

\[
 (-3h_r,3h_r^2,-h_r^3).                              \tag{2.2}
\]

This makes the depth-three carriers visible in the third-order ledger
without assuming that their exponents are exactly three: additional copies
remain in the residual lists.

## 3. The companion jet read from the factor quotients

### Theorem 3.1 (two-channel companion jets)

Define

\[
\begin{aligned}
 V_A(K,C,H)={}&6+8xK+x^2(8C+4K^2)
                    +x^3(8H+8KC),\\
 V_B(K,C,H)={}&6+16xK+x^2(16C+8K^2)
                    +x^3(16H+16KC).                  \tag{3.1}
\end{aligned}
\]

Then the actual companion value satisfies

\[
 v\equiv V_A(K_A,C_A,H_A)\pmod{x^4},                 \tag{3.2}
\]

\[
 v\equiv V_B(K_B,C_B,H_B)\pmod{x^4}.                 \tag{3.3}
\]

Consequently the two displayed jets are congruent modulo \(x^4=16\ell^4\).

#### Proof

The exact companion identities are

\[
 v=4A_\ell^2+2=8B_\ell^2-2.                          \tag{3.4}
\]

Since \(A_\ell=1+xa\), the first identity gives

\[
 v=6+8xa+4x^2a^2.                                    \tag{3.5}
\]

Insert the first congruence in (1.1).  In the linear term one retains
\(K_A,xC_A,x^2H_A\); in the quadratic term, after multiplication by
\(x^2\), only \(K_A^2+2xK_AC_A\) survives modulo \(x^4\).  This is
(3.2).

Also \(B_\ell^2=(s_\ell B_\ell)^2=(1+xb)^2\), because
\(s_\ell^2=1\).  Thus

\[
 v=6+16xb+8x^2b^2,
\]

and the same substitution proves (3.3).  Both right sides are congruent to
the same integer \(v\), proving the last assertion.  \(\square\)

The equality between the two jets is a companion readout of the complete
third-order Pell ledger, but it is not equivalent to that ledger.  If \(L\)
denotes the integer on the left of the complete ledger formula, direct
subtraction gives

\[
 V_A-V_B=16\ell L-64\ell^4(C_A^2-2C_B^2).             \tag{3.6}
\]

Thus \(L\equiv0\pmod{8\ell^3}\) implies
\(V_A\equiv V_B\pmod{x^4}\).  Conversely, the jet congruence alone yields
only \(L\equiv0\pmod{\ell^3}\), so it loses the factor \(8\) in the
ledger modulus.  Its value here is conceptual and operational: the same
quotient data can now be read directly from a projective determinant
quotient while the stronger \(2\)-adic ledger information remains visible.

The loss of the factor \(8\) is genuine.  Consider the precise coefficient
claim:

> **R3.** At \(\ell=3\), equality of arbitrary two-channel companion jets
> modulo \(6^4\) implies the complete third-order ledger modulo \(216\).

Take

\[
 (K_A,C_A,H_A)=(27,0,0),\qquad
 (K_B,C_B,H_B)=(0,0,0).
\]

Then

\[
 V_A=106278,\qquad V_B=6,\qquad V_A-V_B=82\cdot6^4,
\]

whereas

\[
 L=2214=82\cdot3^3,\qquad L\bmod216=54.                \tag{3.7}
\]

Every premise of R3 holds and its conclusion fails.  Thus R3 is retired.
This tuple is coefficient data only: it does not satisfy a common companion
identity or the global negative-Pell equation, so it does not retire any
actual-Pell claim.

## 4. Exact endpoint curvature of the all-order system

At the final coefficient one has

\[
 \alpha_\theta=\beta_\theta=32^\theta.               \tag{4.1}
\]

The two top tail levels are therefore

\[
\begin{array}{ll}
E_{\theta-1}(X)=\alpha_{\theta-1}+\alpha_\theta X,
&F_{\theta-1}(X)=\beta_{\theta-1}+\alpha_\theta X,\\
E_\theta(X)=\alpha_\theta,
&F_\theta(X)=\alpha_\theta.
\end{array}                                            \tag{4.2}
\]

Define the oriented adjacent determinant

\[
 \Delta_{\rm top}
 =T_{\theta-1}\,\ell E_\theta(U^2)
  -T_\theta\,(\ell-2)E_{\theta-1}(U^2).              \tag{4.3}
\]

### Theorem 4.1 (exact endpoint projective curvature)

For every odd prime index \(\ell\),

\[
 \boxed{\Delta_{\rm top}=2v\,32^{\ell-1}U^2.}        \tag{4.4}
\]

#### Proof

Use \(T_j=vF_j(U^2)\) and expand (4.3).  The constant term is

\[
 v\alpha_\theta
 \bigl(\ell\beta_{\theta-1}
       -(\ell-2)\alpha_{\theta-1}\bigr)=0
\]

by (1.3) at \(j=\theta-1\).  The coefficient of \(U^2\) is

\[
 v\alpha_\theta^2\bigl(\ell-(\ell-2)\bigr)
 =2v\alpha_\theta^2.
\]

Finally \(\alpha_\theta^2=32^{2\theta}=32^{\ell-1}\).  This gives
(4.4).  \(\square\)

The same identity is the top-degree specialization of the exact Wronskian
formula

\[
\begin{aligned}
\ell\bigl(T_r(2s+1)E_s-T_s(2r+1)E_r\bigr)
=2vU^2\bigl((2s+1)E_sE_r'-(2r+1)E_rE_s'\bigr),       \tag{4.5}
\end{aligned}
\]

obtained by substituting (1.5) twice.  At
\((r,s)=(\theta-1,\theta)\), the Wronskian on the right is the nonzero
constant \(\ell\alpha_\theta^2\), so cancellation of \(\ell\) gives
(4.4).

### Corollary 4.2 (the modulus \(U^2\) is sharp)

For the actual Pell data,

\[
 \gcd(2v32^{\ell-1},U)=1.                             \tag{4.6}
\]

Hence

\[
 U^2\mid\Delta_{\rm top},
 \qquad U^3\nmid\Delta_{\rm top}.                   \tag{4.7}
\]

More locally, for every prime \(p\mid U\),

\[
 v_p(\Delta_{\rm top})=2v_p(U).                      \tag{4.8}
\]

#### Proof

The Pell coordinates at odd index are odd, so \(U\) is odd.  Since an odd
prime index has \(\ell\ge3\), the positive Pell coordinates also give
\(U=A_\ell B_\ell>1\).  The norm-one Lucas identity

\[
 v^2-32U^2=4                                           \tag{4.9}
\]

shows that any common odd prime divisor of \(v\) and \(U\) would divide
4, which is impossible.  Thus \(v\), \(2\), and every power of \(32\)
are units at every prime of \(U\), proving (4.6).  Equations (4.7)--(4.8)
now follow immediately from the exact factorization (4.4).  \(\square\)

This is a strict boundary result.  All cross-order points remain correlated,
but accumulating more levels cannot promote the top adjacent determinant
from modulus \(U^2\) to \(U^3\).  Any future proof must exploit the value of
the unit quotient, a relation with other arithmetic data, or a genuinely new
global constraint.

## 5. The factor-quotient/projective coupling

Define the endpoint curvature quotient

\[
 \kappa_\ell=\frac{\Delta_{\rm top}}{U^2}
             =2v32^{\ell-1}.                          \tag{5.1}
\]

Combining Theorems 3.1 and 4.1 gives the promised direct interface:

\[
\boxed{
 \kappa_\ell\equiv
 2\,32^{\ell-1}V_A(K_A,C_A,H_A)\pmod{16\ell^4},}      \tag{5.2}
\]

\[
\boxed{
 \kappa_\ell\equiv
 2\,32^{\ell-1}V_B(K_B,C_B,H_B)\pmod{16\ell^4}.}      \tag{5.3}
\]

Thus the third-order factor-quotient ledger determines the \(2\ell\)-adic
jet of the exact unit measuring the failure of integral projective
collinearity.  This is stronger than merely placing all projective points on
one line modulo \(U^2\).

For a hypothetical squarefull packet in the classes
\(\ell\equiv3,5\pmod8\), the inherited incidence theorem supplies primes
\(q\mid A_\ell\), \(r\mid B_\ell\) with

\[
 q^3\mid A_\ell,\quad r^3\mid B_\ell,\quad
 \left(\frac qr\right)=-1,\quad 2\ell\mid q+r.        \tag{5.4}
\]

At this same pair, every reconstructed splitter has the signs

\[
 Z_j\equiv1\pmod{q^6},
 \qquad Z_j\equiv-1\pmod{r^6}.                        \tag{5.5}
\]

Equations (2.1)--(2.2), (5.2)--(5.3), and (4.8) now hold simultaneously.
In particular, the selected depth-three primes divide
\(\Delta_{\rm top}\) to exactly twice their depth in \(U\), while neither
divides \(\kappa_\ell\).  Character incidence does not contradict this:
it prescribes a quadratic nonresidue edge between the carriers, whereas
\(\kappa_\ell\) is a separate multiplicative unit at both vertices.

There is also a precise reason no contradiction follows merely by combining
the two congruence moduli.  The rank theorem gives
\(\gcd(2\ell,U)=1\), so \(16\ell^4\) and \(U^2\) are coprime.  The Chinese
remainder theorem therefore combines the factor-quotient jet and the
projective congruence uniquely; coprimality alone can never make them
inconsistent.  A closing theorem must relate the *values* in (5.2)--(5.3)
to the vertex characters or to a global height/radical bound.

## 6. Full-premise counterexamples to exact stronger subclaims

### 6.1 The third-order local ledger is not by itself inconsistent

Consider the precise local-only claim:

> **L3.** There do not exist odd primes \(\ell,q,r\) with the forced
> quotient residues, the \(\ell\equiv3\pmod8\) kernel table, square cores
> \(1\pmod{2\ell}\), all three Jacobi signs negative, exactly three copies
> of each selected carrier quotient, and the complete third-order ledger
> modulo \(8\ell^3\).

This statement is false.  Take

\[
 \ell=3,\qquad q=7=1+6\cdot1,\qquad
 r=797=-1+6\cdot133.                                  \tag{6.1}
\]

All three numbers are prime.  The kernel quotients are both \(1\pmod4\),
and

\[
 q\equiv7\pmod8,\qquad r\equiv5\pmod8,\qquad
 \left(\frac qr\right)=\left(\frac3q\right)
 =\left(\frac3r\right)=-1.                            \tag{6.2}
\]

Take the two repeated quotient lists

\[
 T_A=[1,1,1],\qquad T_B=[-133,-133,-133].              \tag{6.3}
\]

Their coefficient triples are

\[
 (K_A,C_A,H_A)=(3,3,1),
\]

\[
 (K_B,C_B,H_B)=(-399,53067,-2352637).                 \tag{6.4}
\]

Direct substitution in the complete third-order ledger gives

\[
 L=-606586692816=-2808271726\cdot216,
 \qquad L\equiv0\pmod{8\cdot3^3}.                    \tag{6.5}
\]

The synthetic channel values \(q^3,r^3\) are squarefull with odd kernels
\(q,r\), depth exactly three, and square cores one.  Thus every premise of
L3 is met.  This retires L3 and only L3.

It is not a counterexample to the actual Pell packet.  Indeed

\[
 q^6-2r^6+1=-512601560592751008\ne0.                  \tag{6.6}
\]

So the global negative-Pell equation, and therefore the actual Lucas
projective realization, is absent.  The correct surviving statement is that
the local ledger plus the global Pell realization might be inconsistent;
that remains open.

### 6.2 Actual Pell data refute an \(U^3\) projective strengthening

Consider the precise stronger claim:

> **P3.** At every odd prime Pell index, the highest adjacent correlated
> determinant is divisible by \(U^3\).

The actual index \(\ell=7\) satisfies every premise of P3 and refutes it.
Here

\[
 A_7=239,\quad B_7=169=13^2,\quad U=40391,\quad
 v=228486,\quad \alpha_2=7168,\quad\alpha_3=32768.
\]

The top tails and determinant are

\[
 E_2=53458792651776,\qquad F_2=53458792649728,
\]

\[
 T_2=12214585697365751808,\qquad T_3=7487029248,
\]

\[
 \Delta_{\rm top}=800495088185894730989568.           \tag{6.7}
\]

Its exact quotient is

\[
 \kappa_7=490669948796928,\qquad \gcd(\kappa_7,U)=1,
\]

and

\[
 \Delta_{\rm top}\bmod U^3=24354030047568\ne0.       \tag{6.8}
\]

The factor-quotient lists are \(T_A=[17]\) and
\(T_B=[-1,-1]\), giving triples \((17,0,0)\) and \((-2,1,0)\).
Both formulas (5.2)--(5.3) give

\[
 v\equiv36406\pmod{14^4},\qquad
 \kappa_7\equiv26416\pmod{14^4}.                     \tag{6.9}
\]

Thus P3 is retired by a full actual-Pell example.  This example is not a
squarefull packet because \(239\parallel A_7\), and it does not refute the
valid \(U^2\) projective theorem.

## 7. Exact computation and counterexample search

The reproducibility bundle is

`research/computation/2026_09_02_pell_factor_quotient_coupling/`.

The producer and an independently written verifier perform the following
checks.

1. At every one of the 57 odd prime indices \(3\le\ell\le271\), they
   recompute the exact Pell coordinates, both top tails, the determinant,
   (4.4), coprimality (4.6), and the failure of \(U^3\)-divisibility.
2. They independently replay one prime divisor of exact exponent one at
   every such index, including a Pocklington certificate for the only
   witness above \(2^{64}\).  Hence no actual squarefull packet occurs in
   this finite range.
3. At the thirteen fully factored prime indices through 43, they rebuild
   every repeated factor-quotient list, its \((K,C,H)\) triple, the complete
   third-order ledger, both companion jets, the endpoint curvature jet, and
   every row and column character-incidence law.
4. Lean verifies the exact jet/ledger relation and the coefficient-level
   strictness witness (3.7).  The producer and verifier check every premise
   and every conclusion of the local counterexample (6.1)--(6.6), and every
   datum in the actual index-seven counterexample.

The actual search result is:

\[
 \boxed{A_\ell B_\ell\text{ is not squarefull for every odd prime }
 3\le\ell\le271.}                                     \tag{7.1}
\]

This is an exact finite theorem because each row has a proved prime divisor
of exponent one.  No candidate satisfying squarefullness, an opposite
depth-three pair, all-order staircase, cross-order determinants, character
incidence, and the third-order ledger was found.  The bounded conclusion
(7.1) neither proves an unbounded exclusion nor supplies evidence sufficient
to abandon the route.

## 8. Lean formalization boundary

The module

`Lean/IUTThreeClosures/PellLucasFactorQuotientProjectiveCoupling20260902.lean`

kernel-checks, after the mathematical proofs above:

* the three-copy depth-carrier fingerprint (2.1);
* the \(A\)- and \(B\)-channel companion jets (3.2)--(3.3);
* the two-channel equality of jets and their endpoint-curvature readout;
* the exact endpoint determinant identity (4.4);
* coprimality of the companion from the norm identity;
* sharpness of the modulus \(U^2\);
* the complete numerical and modular certificates for (3.7) and
  (6.1)--(6.9).

The separate axiom-audit module prints every public theorem used in this
checkpoint.  No Lucas multiplication theorem, rank theorem, character
incidence theorem, perfect-power classification, squarefull packet, or abc
statement is introduced as an axiom.  When such arithmetic data are needed
by a generic theorem, they occur as explicit hypotheses.

## 9. Remaining gate

The endpoint determinant is now fully understood.  It cannot itself close
the Pell route because its exact quotient is a support unit and its
\(2\ell\)-adic residue is compatible with the third-order ledger.  The
smallest surviving target is a theorem using the *global negative-Pell
realization* to rule out, or construct, an unbounded family simultaneously
satisfying:

1. squarefullness in both channels and nontrivial odd kernels;
2. an opposite-channel depth-three nonresidue pair;
3. the carrier fingerprints (2.1)--(2.2);
4. the full third-order ledger;
5. all correlated Lucas tails and their exact endpoint curvature;
6. the vertexwise character-incidence laws.

The local counterexample in Section 6 proves that conditions 2, 3, 4, and
the kernel character table do not suffice without the global Pell equation.
The exact-curvature theorem proves that higher divisibility of the same top
determinant is unavailable.  A viable continuation must therefore connect
the factor quotients or curvature unit to the global Pell realization by a
new reciprocity, height, or distribution theorem.  This route remains
active because no counterexample to that complete statement is known.

## References

* Geng-Rui Zhang, *13 unknowns over quadratic integer rings and Lucas
  congruences*, arXiv:2608.30389v1, 2026, Proposition 5.1 and
  Corollaries 5.2--5.4.  The source PDF, source archive, extracted TeX, and
  hash ledger are frozen in
  `research/sources/pell_fourth_order_lucas_2026_09_01/`.
* Christian J.-C. Ballot and Hugh C. Williams, *The Lucas Sequences: Theory
  and Applications*, Springer, 2023.
* Carlo Sanna, *The p-adic valuation of Lucas sequences*, Fibonacci
  Quarterly 54 (2016), 118--124.  A frozen source copy is in the inherited
  Pell source bundle.
* The prime-rank, perfect-power, third-order, and incidence inputs are proved
  or source-audited in
  `research/ABC_PELL_ODD_KERNEL_THIRD_ORDER_PACKET_2026_09_01.md` and
  `research/ABC_PELL_LUCAS_CORRELATED_ALL_ORDER_EXCLUSION_2026_09_01.md`.
