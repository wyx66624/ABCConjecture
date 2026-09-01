# Signed endpoint arithmetic: actual prime support and a dyadic obstruction

Author: ChatGPT  
Date: 2026-08-30  
Status: mathematical proofs written before the new Lean formalization.

This note continues v16/v17. It does not prove or disprove abc. In particular,
a necessary condition on one endpoint cannot be promoted to an equivalent
uniform target on that endpoint.

## 1. Instantiating the exponent identity at actual integers

For a positive integer n, let e_p = v_p(n), and put

\[
 E_1(n)=\sum_{p\mid n,\ e_p=1}\log p,\qquad
 E_3(n)=\sum_{p\mid n}(e_p-2)_+\log p.
\]

Here the positive part is taken in the integers: `(e_p-2)_+ = max(e_p-2,0)`.
Unique prime factorization and the definition of the radical give

\[
 \log n=\sum_{p\mid n}e_p\log p,\qquad
 \log\operatorname{rad}(n)=\sum_{p\mid n}\log p.
\]

For each e_p>=1 one has

\[
 e_p-2=(e_p-2)_+-\mathbf 1_{e_p=1}.
\]

Multiplying by log p and summing proves the exact identity

\[
 \delta_2(n):=\log n-2\log\operatorname{rad}(n)=E_3(n)-E_1(n).
\]

Thus the finite-profile identity of v17 applies to the integer's actual prime
factorization, with no distribution or approximation hypothesis.

For a positive primitive triple a+b=c write m=min(a,b), M=max(a,b),
R=log rad(abc), and h=log c. Pairwise coprimality gives

\[
 \Delta=\log(Mc)-2R
 =E_3(M)+E_3(c)-E_1(M)-E_1(c)-2\log\operatorname{rad}(m).
\]

Since c/2<=M<=c, the already proved corridor is

\[
 2h-2R-\log2\leq\Delta\leq2h-2R.
\]

It follows that the following full signed prime-support statement is exactly
equivalent to abc:

\[
 \forall\varepsilon>0\ \exists K_\varepsilon\ \forall(a,b,c):\quad
 E_3(M)+E_3(c)\leq E_1(M)+E_1(c)
   +2\log\operatorname{rad}(m)+2\varepsilon R+K_\varepsilon.
\]

This is a reformulation, not an independent estimate. The two endpoints must
remain in the same inequality.

## 2. An unconditional counterexample to separate endpoint control

**Proposition.** For every real rho with 0<=rho<1 and every K, there is a
positive primitive abc triple with m=1 such that

\[
 \delta_2(M)>\log\operatorname{rad}(m)+\rho R+K.
\]

**Proof.** Take

\[
 (a,b,c)=(1,2^N,2^N+1),\qquad N\geq1.
\]

It is primitive, m=1 and M=2^N. Since rad(2^N)=2,

\[
 \delta_2(M)=(N-2)\log2.
\]

Submultiplicativity of the radical and rad(n)<=n give

\[
 \operatorname{rad}(abc)
 \leq2(2^N+1)\leq2^{N+2},\qquad
 R\leq(N+2)\log2.
\]

Consequently

\[
 \delta_2(M)-\rho R
 \geq\big((1-\rho)N-2-2\rho\big)\log2.
\]

The coefficient of N is strictly positive. Choosing an integer

\[
 N>\frac{K/\log2+2+2\rho}{1-\rho},\qquad N\geq1,
\]

proves the proposition. No information about the factorization of 2^N+1
was used. In particular this argument is unconditional and does not rely on
an unproved squarefree-value assertion. QED.

The same witnesses refute a universal bound on the maximum of the two
one-integer defects with slope rho<1. They do **not** contradict the uniform
bound on their sum after the small-endpoint radical charge. They also do not
assert that the odd neighbour always supplies enough cancellation: a lower
bound of the needed strength for every such neighbour would itself require
substantial arithmetic input. The safe statement is that discarding possible
cancellation imposes a false stronger target.

## 3. Consequence for the retained route

The implication proved in v17 remains valid: a violation forces one large
endpoint's defect to exceed the displayed threshold. The stronger program
of excluding every such one-endpoint event is impossible: the proposed
uniform separate-endpoint bounds fail on arbitrarily large dyadic endpoints.
This paragraph does not assert a converse to the violation implication.

Only that proposed separate-endpoint estimate is retired. The coupled signed
estimate, powerful-gap methods, Frey/Szpiro, and source-derived IUT comparisons
remain open routes. A method must control the coupled inequality, or show how
the opposite endpoint contributes a compensating negative term, without
assuming precisely the abc-equivalent estimate it is intended to prove.

## 4. Formalization boundary

`SignedPrimeSupport.lean` instantiates the actual prime sums, and
`SignedEndpointDyadicObstruction.lean` proves the displayed unbounded dyadic
counterexample in Lean. The targeted Lake build passed under Lean 4.32.0;
the eight displayed core dependency reports contain only `propext`,
`Classical.choice`, and `Quot.sound`. Consolidated build results and the
remaining paper-only boundaries are recorded in the session validation note.
