# Prime-unit, two-arm, and order-layer continuation of the abc program

**Author:** ChatGPT  
**Date and literature cut-off:** 1 September 2026  
**Status:** rigorous new implications and full-premise local counterexamples;
no unconditional proof or disproof of the standard abc conjecture.

## 1. Research rule and common target

For a primitive positive triple `a+b=c`, write

\[
                 r=\operatorname{rad}(abc).
\]

The standard conjecture asserts that for every `epsilon>0` there is a constant
`C_epsilon` such that

\[
                        c\le C_\epsilon r^{1+\epsilon}.       \tag{1.1}
\]

This continuation advances positive proofs and counterexample searches in
parallel.  A route is not closed because it is difficult or because a finite
search has no hit.  It is closed only to the extent that a counterexample
satisfies every hypothesis of a precisely stated claim.  In particular, none
of the counterexamples below is a counterexample to (1.1), to IUT, or to an
entire affine or recurrence route.

The four independently developed routes are:

| Route | New positive theorem | Exact rejected mechanism | Minimal open bridge |
|---|---|---|---|
| prime-power radical neighbours | radical exponent `sigma<2/5-1/k` is enough to disprove abc | Carella v2's printed global high-`omega` hypothesis | produce an unbounded low-radical neighbour subsequence |
| IUT same-pilot vector | faithful labelled prime/unit signatures reconstruct points and regions | exponent-only, one-residue, and unordered aggregate interfaces | prove preservation or image containment on the actual IUT carrier |
| minimal affine shear | coprime joint excess and a unique two-arm CRT class | the two marginal long-arm gates are sufficient | force the full three-arm excess inequality at matching density |
| Mersenne order blocks | corrected lifting ledger, cyclotomic excess identity, and near-quadratic small-support control | omission of the LTE lifting factor; two universal support strengthenings; `E_d=1` for every block | control deep lifts, the same-order transition cluster, and the exceptional small-order tail |

## 2. Literal global-omega counterfamily and the retained positive target

Carella's current preprint,
[*Note on the Exceptional Set in the ABC Conjecture*,
arXiv:2608.16764v2](https://arxiv.org/abs/2608.16764v2), prints in Theorem
5.1(iii)

\[
 \#\{n\le x:\omega(n)>w\}=o(x^{3/5}),
 \qquad w\le2\log\log x.                              \tag{2.1}
\]

Let `r=floor(w)+1` and let `Q_r` be the product of the first `r` primes.
Every positive multiple `m Q_r<=x` has at least `r>w` distinct prime factors,
so

\[
 \#\{n\le x:\omega(n)>w\}\ge\left\lfloor\frac{x}{Q_r}\right\rfloor.
                                                               \tag{2.2}
\]

Bertrand's postulate gives `p_j<=2^j`.  Hence, under the threshold in (2.1),

\[
 \log Q_r\le\frac{r(r+1)}2\log2
            =O((\log\log x)^2)=o(\log x).             \tag{2.3}
\]

Thus the lower bound in (2.2) is `x^(1-o(1))`, not `o(x^(3/5))`.  This is an
asymptotic counterfamily satisfying all displayed hypotheses, so it rejects
the printed global formula and its unconditional invocation.  The prose in
the preprint instead discusses smooth integers in a short interval; that is a
different set.  The counterfamily does not reject a sparse low-radical
neighbour.

The valid final radical calculation has a wider form.  Let `X=p^k` and suppose
infinitely many unbounded pairs satisfy

\[
 X<c\le X+X^{3/5},\qquad p\nmid c,\qquad
 \operatorname{rad}(c)\le X^{\sigma+o(1)}.             \tag{2.4}
\]

Putting `a=c-p^k`, `b=p^k` gives a primitive abc triple and

\[
 \operatorname{rad}(abc)
       \le X^{3/5+1/k+\sigma+o(1)}.                   \tag{2.5}
\]

Consequently

\[
                         \sigma<\frac25-\frac1k        \tag{2.6}
\]

is sufficient to disprove abc.  Conventional smoothness and a small value of
`omega` are unnecessary.  If `k>=3` and candidates occur at a fixed positive
proportion of prime centres, disjointness of the intervals and the Rankin
radical count force `sigma>=1/k`.  The density-compatible window is nonempty
exactly when `k>5`; for every `k>=6`, `sigma=1/5` is feasible.  For `k=1,2`
the target itself is empty; for `3<=k<=5` only the positive-density version is
excluded.  Sparse subsequences remain active.

Full proof and formal core:

- `research/ABC_CARELLA_GLOBAL_OMEGA_HYPOTHESIS_2026_09_01.md`;
- `Lean/IUTThreeClosures/CarellaGlobalOmegaHypothesis20260901.lean`.

## 3. Faithful prime-unit-label reconstruction before volume

For a rational prime `p` and `x` in `Q^*`, define

\[
 e_p(x)=v_p(x),\qquad u_p(x)=x/p^{e_p(x)}.             \tag{3.1}
\]

Then `v_p(u_p(x))=0` and `p^(e_p(x))u_p(x)=x`; hence the complete coordinate
`(e_p(x),u_p(x))` is injective.  The same proof is carried out on Mathlib's
actual complete field `Q_p`.  For an arbitrary field and a nonzero scale
`pi`, the valuation-free complement `x/pi^(e(x))` gives an analogous
reconstruction template; it is called a genuine unit only after appropriate
valued-field hypotheses are supplied.

If a packet `P:L->X` retains every fixed label and every coordinate of a
faithful fingerprint `Sigma`, then `Sigma(P)` determines `P`.  More strongly,
for packet regions `A,B`,

\[
                         \Sigma(A)\subseteq\Sigma(B)
                    \quad\Longrightarrow\quad A\subseteq B.    \tag{3.2}
\]

Any monotone finite region functional therefore transfers an output bound to
the input after (3.2) has been proved independently.  This avoids defining
same-pilot equivalence by equality of the scalar volume one wants to bound.

A labelled transport has exponent shifts `delta_i` and unit twists `tau_i`.
They compose label by label.  If the transport returns to the same labelled
point, exact reconstruction forces

\[
                              \delta_i=0,\qquad\tau_i=1             \tag{3.3}
\]

for every label.

Three full counterexamples delimit weaker interfaces:

1. at `p=5`, the one-label packets `1` and `2` have the same exponent but are
   unequal;
2. the packets `1` and `6` have the same exponent and the same unit residue
   modulo `5`, but are unequal;
3. `(1,2)` and `(2,1)` have the same unordered complete coordinates and unit
   twists `(2,1/2)` with aggregate product one, but differ at fixed labels.

These examples reject only exponent-only reconstruction, a first-residue
truncation, and unordered aggregate holonomy.  They do not refute an explicit
returned permutation or the actual IUT construction.  The live theorem is a
source-level all-place/all-label preservation or signature-image containment
through the theta link, log-Kummer correction, determinant normalization, and
the required Ind1--Ind3 branches.

Full proof, formal core, and pinned IUT/LANA sources:

- `research/ABC_IUT_PRIME_UNIT_LABEL_VECTOR_BRIDGE_2026_09_01.md`;
- `Lean/IUTThreeClosures/IUTPrimeUnitLabelVectorBridge20260901.lean`;
- `research/sources/iut_prime_unit_label_vector_bridge_2026_09_01/`.

## 4. A two-arm affine CRT packet and an exact insufficiency witness

For the minimal-step affine shear with `R=rad(abc)`,

\[
 U=1+Rh,\qquad V=1+R(h+ck),\qquad W=1+R(h+bk),         \tag{4.1}
\]

write `E(n)=n/rad(n)`.  Every desired three-quarter exception in the canonical
upper-half box must satisfy

\[
                         Rc<8192E(V),\qquad Rc<8192E(W). \tag{4.2}
\]

Since the arms are coprime, the two gates combine into a genuine joint
carrier:

\[
 (Rc)^2<8192^2E(V)E(W),\qquad
 (E(V),E(W))=1,\qquad E(V)E(W)\mid VW.               \tag{4.3}
\]

On the diagonal `h=k`, admissibility is automatic and

\[
 V=1+R(c+1)k,\qquad W=1+R(b+1)k.                    \tag{4.4}
\]

For coprime squarefree carriers `D,F`, with the two coefficients invertible
modulo the corresponding carrier, CRT gives a unique class modulo `D^2F^2`
on which `D^2|V` and `F^2|W`.  Hence `D|E(V)` and `F|E(W)`.

For the seed `(1,242,243)`, `R=66`, choosing `D=5`, `F=7` gives

\[
                          h=k=356+1225t.               \tag{4.5}
\]

Exactly `318322715` distinct values lie in the canonical upper-half interval,
and every one satisfies both gates in (4.2).  At the first value,

\[
 h=k=389945326231,\qquad (E(U),E(V),E(W))=(1,5,7),    \tag{4.6}
\]

the resulting primitive point is

\[
 (A,B,C)=(25736391531247,
 1519682447137014050,1519708183528545297).             \tag{4.7}
\]

The squarefree number

\[
 d=139267\cdot2119433\cdot17431=5145057294975341
\]

divides `ABC`, and `d^4>C^3`; hence `rad(ABC)^4>C^3`.  This point satisfies
the seed, box, admissibility, cap, primitive-output, and both marginal-gate
hypotheses, yet is not a three-quarter exception.  It is a complete
counterexample only to the assertion that the two marginal gates are
sufficient.

The affine route remains open at the full coupled inequality

\[
 E(U)E(V)E(W)>
 \frac{RUVW}{(cW)^{3/4}}
 =\frac Rc\,UV(cW)^{1/4}.                             \tag{4.8}
\]

A matching-density proof must produce at least
`kappa R^(-2/3)c^(4+eta)` canonical parameters satisfying (4.8) uniformly on
each fixed subcritical seed range.  Growing CRT carriers and correlated
powerful values in all three arms remain active routes.

Full proof, Lean certificate, computation replay, and source ledger:

- `research/ABC_AFFINE_TWO_ARM_CRT_PACKET_2026_09_01.md`;
- `Lean/IUTThreeClosures/AffineTwoArmCRTPacket20260901.lean`;
- `research/computation/2026_09_01_affine_two_arm_crt_packet/`;
- `research/sources/affine_two_arm_crt_2026_09_01/`.

## 5. Prime-index Mersenne layers and the corrected LTE ledger

Let `M_m=2^m-1` and `W_m=M_m/rad(M_m)`.  For each odd prime `q`, put

\[
 d_q=\operatorname{ord}_q(2),\qquad
 w_q=v_q(2^{d_q}-1),\qquad
 E_d=\prod_{d_q=d}q^{w_q-1}.                         \tag{5.1}
\]

The total loss is not merely the product of the base order blocks.  LTE gives

\[
 W_m=L_m\prod_{d\mid m}E_d,\qquad
 L_m=\prod_{q\mid M_m}q^{v_q(m/d_q)}.                \tag{5.2}
\]

Because `d_q|q-1`, the prime `q` does not divide `d_q`; thus
`v_q(m/d_q)=v_q(m)` and

\[
                                L_m\mid m.             \tag{5.3}
\]

The omitted factor has a complete witness at `m=6`:

\[
 M_6=63=3^2\cdot7,\qquad W_6=3,\qquad
 \prod_{d\mid6}E_d=1,\qquad L_6=3.                   \tag{5.4}
\]

Thus (5.4) rejects exactly the uncorrected product, not the corrected route.

If `ell` is an odd prime and `M_ell` is composite, it is not a nontrivial
prime power, so it has two distinct prime factors.  Every factor `q` has
exact order `ell` and satisfies `q=1 mod 2ell`.  Therefore

\[
 (2\ell+1)^2\le\operatorname{rad}(M_\ell),\qquad
 (2\ell+1)^2E_\ell\le\Phi_\ell(2).                  \tag{5.5}
\]

Combining a largest factor of size at least `H` with the second factor gives
the asymmetric product bound `H*(2ell+1)`.  Erdős and Shorey's original theorem supplies
`P(2^ell-1) >> ell log ell` at prime indices; hence

\[
 \frac{E_\ell}{\Phi_\ell(2)}
          \ll\frac1{\ell^2\log\ell}.                 \tag{5.6}
\]

This is polynomial and does not reach `log E_ell=o(ell)`.  The corrected
global sufficient target is

\[
                              \log E_d=o(\varphi(d)).   \tag{5.7}
\]

Indeed, the identity `sum_(d|m) phi(d)=m` bounds the base-block log mass by
`C_D+epsilon m`, and (5.3) adds only `log m=o(m)`.

The positive implication is now kernel-checked at the actual arithmetic
objects.  Lean defines canonical, index-independent blocks, proves that the
relative block at every divisor `d|m` equals the canonical `E_d`, proves the
exact logarithmic divisor-sum decomposition, and derives
`log W_m=o(m)` from the explicit open premise `log E_d=o(phi(d))`.  The premise
itself remains the live number-theoretic problem.

Two further complete examples close only universal strengthenings:

- `2^37-1=223*616318177` has exactly two prime factors, so “at least three
  factors for every composite prime layer from 37” is false;
- `2^11-1=23*89` has radical `2047<23^3`, so a cubic replacement of (5.5)
  at every composite odd-prime layer is false.

The finite scan through prime index `61` found no repeated factor.  It is a
bounded no-hit and closes no eventual statement.

At the composite order `d=364`, however, the exact data
`1093^2 | 2^364-1`, `1093^3 ∤ 2^364-1`, together with the three proper-order
checks at exponents `182`, `52`, and `28`, prove
`ord_1093(2)=364` and hence `1093 | E_364`.  This full-premise witness closes
only the stronger assertion that every canonical block is one; it does not
close the asymptotic target (5.7).

The latest original-source audit gives the exact cyclotomic reformulation

\[
 E_d=\frac{\Phi_d(2)}{\operatorname{rad}(\Phi_d(2))},\qquad
 \log\Phi_d(2)=\varphi(d)\log2+O(1).                \tag{5.8}
\]

Write `E_d=T_d D_d`, where `T_d` contains one copy of every same-order
Wieferich prime and `D_d` contains the remaining super-Wieferich depth.
Brun--Titchmarsh proves unconditionally that the part of `T_d` with

\[
 q\le Y_d:=\frac{\varphi(d)^2}{\log\log(3d)}
\]

has logarithm `o(phi(d))`.  Consequently, if (5.7) fails, an infinite
subsequence must carry a positive proportion of `phi(d)` in at least one of
three precise arms: super-Wieferich depth, at least `Omega(phi(d)/log d)`
same-order Wieferich primes between `Y_d` and `d^(2+delta)`, or a weighted
tail of primes `q>d^(2+delta)` having the exceptional small order
`ord_q(2)<q^(1/(2+delta))`.  Erdős--Murty put the last primes in a
zero-density exceptional set, but this does not bound their weighted mass.
No full-premise counterexample to (5.7) is known, so all three arms remain
active.

Full proof, current Lean core, exact computation, and primary sources:

- `research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`;
- `Lean/IUTThreeClosures/MersennePrimeLayerRadical20260901.lean`;
- `Lean/IUTThreeClosures/MersenneOrderBlockDecomposition20260901.lean`;
- `Lean/IUTThreeClosures/MersenneOrderBlockAsymptotic20260901.lean`;
- `Lean/IUTThreeClosures/MersenneCanonicalBlockWitness20260901.lean`;
- `Lean/IUTThreeClosures/MersenneWieferichTailReduction20260901.lean`;
- `research/computation/2026_09_01_mersenne_prime_layer_radical/`;
- `research/sources/mersenne_prime_layer_radical_2026_09_01/`.

## 6. Cross-route implications

The four routes expose the same logical hazard in different forms: a scalar
or marginal necessary condition is easily mistaken for an object-level or
coupled sufficient theorem.

- Counting many smooth integers does not select one with the required
  radical.
- Equality of one volume does not reconstruct a labelled IUT packet.
- Two large marginal affine excesses do not imply the full three-arm excess.
- A polynomial Mersenne radical carrier does not imply a near-full radical,
  and a base-block product does not include index lifting automatically.

The corrected positive interfaces are correspondingly explicit:

1. produce a sparse unbounded radical-neighbour family below (2.6);
2. prove complete labelled coordinate preservation on the actual IUT common
   carrier;
3. prove (4.8) for a matching number of canonical affine parameters;
4. prove the base-block estimate (5.7), or another estimate strong enough for
   the same divisor sum.

None is assumed as a field of a structure or introduced as a Lean axiom.

## 7. Formal and computational boundary

The paper proofs precede their Lean modules.  The eight modules check the
finite arithmetic and algebraic kernels, actual rational and `p`-adic
reconstruction, exact counterexamples, CRT uniqueness, finite set cardinality,
prime-index Mersenne bounds, exact-order LTE, the corrected finite order-block
product, the conditional asymptotic passage, the finite
deep/transition/extreme mass reduction, and the exact ambient square-budget
ratio used in the transition arm.  They do not turn Bertrand's
postulate, the Rankin count, the prime number theorem, IUT's global
multiradial transport, Erdős--Shorey's theorem, or the open canonical-block
estimate into new axioms.  The cyclotomic classification,
Brun--Titchmarsh/totient small-arm estimate, and Erdős--Murty order theorem
also remain explicit published paper inputs.

The affine and Mersenne computation directories contain deterministic replay
scripts and frozen outputs.  A finite no-hit is labelled as such.  The IUT and
all literature-dependent routes include source ledgers with byte hashes and
version metadata.

At this checkpoint there is still no Lean term of unconditional
`ABCConjecture` and no Lean term of its rigorous negation.  Every broad route
whose defining claim has not met a full-premise counterexample remains active.
