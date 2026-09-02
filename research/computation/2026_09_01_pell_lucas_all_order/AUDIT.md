# Independent audit of the Pell--Lucas all-order checkpoint

**Auditor:** ChatGPT

**Audit date:** 2026-09-01

**Verdict:** **PASS.**  The two minor editorial corrections identified below
were applied during integration.  The Zhang
quantifiers, the specialization (a=6,delta=32), the support-coprimality
argument, every normalized tail valuation, the companion splitter, and the
full-premise (k=2451) counterexample are mathematically valid.  No
counterexample satisfying the complete premises of the all-order or paired
companion theorems was found.  The finite no-hit search is not treated as a
proof of a uniform statement.

The audit found one genuine quantifier overstatement in `SOURCE_NOTES.md` and
one missing exact-divisibility assertion in the independent verifier.  Both
were corrected during the audit.  Two presentation points in the mathematical
report remain listed below because the audit instructions prohibited editing
that report.

## 1. Audited artifacts and frozen boundary

The audit read but did not modify:

* `research/ABC_PELL_LUCAS_ALL_ORDER_STAIRCASE_2026_09_01.md`;
* `Lean/IUTThreeClosures/PellLucasAllOrderStaircase20260901.lean`;
* Zhang's archived PDF, submitted TeX, and source archive in
  `research/sources/pell_fourth_order_lucas_2026_09_01/`.

The only existing files modified by the audit were explanatory or
verification files:

* `SOURCE_NOTES.md`, to state the companion identity with its exact
  quantifier boundary;
* `verify_lucas_all_order_packet.py`, to check exact divisibility before a
  second modular division.

No aggregate report, principal paper, status file, or Lean theorem was
changed.

## 2. Primary-source quantifier audit

The authoritative local source is
`source_tex/13quad_arXiv1.tex`; the PDF page numbers below refer to
`arXiv:2608.30389v1`.

| Source result | Exact hypotheses and conclusion | Checkpoint use | Result |
|---|---|---|---|
| Proposition 5.1, PDF p. 20, TeX lines 1018--1056 | Fix (a\in\mathbb Z).  Let (k\ge1) be odd, (	heta=(k-1)/2), and let (n>0) satisfy (u_n\ne0).  Every displayed (c_r(k)), (0\le r\le\theta), is a positive integer and (u_{nk}/u_n=\sum_{r=0}^{\theta}c_r(k)\delta^r u_n^{2r}).  The source also gives every finite truncation modulo (u_n^{2h}), (h>0). | Set (a=6,delta=32,n=k=\ell), with (ell) an odd prime.  This gives exactly equation (3.1), including all coefficients through (r=(\ell-1)/2). | **PASS** |
| Corollary 5.2, PDF p. 21, TeX lines 1059--1075 | Under the same (n,k) hypotheses, (u_{nk}/u_n\equiv k+\delta k(k^2-1)u_n^2/24\pmod{u_n^4}).  Separately, (v_{nk}=v_n\Psi_k(\delta u_n^2)), where (Psi_k(W)=1+(k^2-1)W/8+W^2\Psi_k^*(W)) and both polynomials have integral coefficients. | For (a=6), the report proves (v_n=2A_{2n}>0), so division by (v_n) is valid.  With (n=k=\ell), the result is (v_{\ell^2}/v_\ell\equiv1+4(\ell^2-1)U^2\pmod{U^4}), exactly (4.4). | **PASS** for the report; source-note wording corrected |
| Corollary 5.3, PDF p. 21, TeX lines 1078--1100 | Let (p\ge3) be prime, (p\nmid\delta), (p\mid u_n), and (r=v_p(u_n)\ge1).  Put (h_p=1) for (p=3), otherwise (0).  Part (1) requires (	au=v_p(k(k^2-1))<2r+h_p); part (2) requires (	au'=v_p(k^2-1)<2r). | A support prime in the report satisfies (p\ge2\ell-1>\ell+1).  Hence (p\ge5) and (p\nmid32\ell(\ell^2-1)); for (n=k=\ell), (h_p=\tau=\tau'=0).  The resulting first-tail and companion valuations agree with the staircase.  The report does not use this corollary to claim higher-order valuations. | **PASS** |
| Theorem 5.6, PDF pp. 23--24, TeX lines 1172--1225 | Fix (n>0) with (u_n\ne0), a nonzero integer (s\mid u_n), and an odd integer (t).  Every class (c\pmod s) is realized by infinitely many positive odd (k\equiv t\pmod{u_n^2}) in the normalized second-order correction. | (a=6,n=3,u_3=35,s=5,t=1) satisfies every hypothesis.  The theorem is single-channel and gives no independent simultaneous control of the companion correction; the report preserves this boundary. | **PASS** |

### Corrected source-note quantifier

The previous note called the companion formula a quotient under only
(u_n\ne0).  That is too strong in the general (a\in\mathbb Z) family:
for example (a=0,n=1) gives (u_1=1\ne0) but (v_1=0).  The note now
states Zhang's factor identity first and permits quotient language only when
(v_n\ne0).  This does not affect the report because (a=6) gives
(v_n=2A_{2n}>0).

## 3. Mathematical audit of the specialization

### 3.1 Channel splice

For (alpha=3+2\sqrt2=(1+\sqrt2)^2) and
(eta=3-2\sqrt2=(1-\sqrt2)^2), direct addition and subtraction of the
Binet expressions give

\[
u_n=B_{2n}/2=A_nB_n,\qquad v_n=2A_{2n},\qquad
v_n^2-32u_n^2=4.
\]

These identities and the recurrence initial values agree.  At odd (n),
(A_n^2-2B_n^2=-1), so any common divisor of (A_n) and (B_n) divides
one.  Thus the product (U=A_\ell B_\ell) is genuinely a product of
coprime channels.

### 3.2 Support-coprimality of every coefficient

For a prime (p\mid U), the inherited rank congruence gives
(p\equiv(2/p)\pmod{2\ell}), hence (p\ge2\ell-1>\ell+1).  For
(1\le j\le r\le(\ell-1)/2), all three positive numerator factors

\[
\ell,\qquad \ell-(2j-1),\qquad \ell+(2j-1)
\]

are strictly below (p).  Therefore (p) does not divide the numerator of
(c_r(\ell)).  Since the numerator equals
(4^r(2r+1)!c_r(\ell)), divisibility of the integer (c_r(\ell)) by (p)
would force divisibility of that numerator, a contradiction.  Also (p) is
odd, so (p\nmid32).  This proves
(gcd(32^r c_r(\ell),U)=1) for every displayed (r).

At (	heta=(\ell-1)/2), factor pairing gives

\[
\prod_{j=1}^{\theta}
\bigl(\ell^2-(2j-1)^2\bigr)=4^\theta(2\theta)!,
\]

and hence (c_\theta(\ell)=1).  No denominator-cancellation assumption is
needed in the support argument.

### 3.3 Every normalized tail and valuation

Proposition 5.1 gives the exact finite polynomial.  Factoring (U^{2r})
from its (r)-th tail gives

\[
D_r=U^{2r}E_r,\qquad
E_r=32^r c_r(\ell)+U^2(\text{integer}).
\]

The preceding coefficient result implies (gcd(E_r,U)=1).  Thus for every
prime (p\mid U), with (e_p=v_p(U)),

\[
v_p(D_r)=2r e_p
\]

with equality at every order.  At the last order the one-term tail is
(32^\theta U^{\ell-1}).  No cancellation or sign case is missing.

### 3.4 Companion splitter

Corollary 5.2 gives the two leading normalized corrections

\[
W\equiv\frac{4\ell(\ell^2-1)}3\pmod{U^2},\qquad
S\equiv4v_\ell(\ell^2-1)\pmod{U^2}.
\]

Multiplying them by (3v_\ell) and (ell), respectively, proves
(ell S\equiv3v_\ell W\pmod{U^2}).  The negative Pell identity gives

\[
v_\ell=4A_\ell^2+2=8B_\ell^2-2,
\]

so the reductions modulo (A_\ell^2) and (B_\ell^2) have signs (+6W)
and (-6W).  The support bound makes (6W) a unit modulo (U^2).  Its
inverse therefore recovers (A_{2\ell}) modulo (U^2).  Finally
(gcd(A_\ell,B_\ell)=1) combines the two squared channel congruences to
(Z^2\equiv1\pmod{U^2}).  The splitter is valid.

## 4. Exact audit of the (k=2451) counterexample

The displayed arithmetic premises all hold:

\[
u_3=35,\qquad k=2451=1+2\cdot35^2>0,\qquad k\text{ odd}.
\]

Both bundled recurrence implementations and the Lean kernel certificate
give

\[
u_{7353}\equiv85785=35\cdot2451
\pmod{214375},\qquad 214375=35(5\cdot35^2).
\]

The modular divisions are legitimate.  In general, if (d\mid x,y) and
(x\equiv y\pmod{dM}), then (x/d\equiv y/d\pmod M).  First take
(d=35,M=5\cdot35^2).  Lucas divisibility supplies (35\mid u_{7353}),
so

\[
u_{7353}/35\equiv2451\pmod{5\cdot35^2}.
\]

Both sides are one modulo (35^2); applying the same elementary division
to their differences gives

\[
\frac{u_{7353}/35-1}{35^2}\equiv
\frac{2451-1}{35^2}=2\pmod5.
\]

An additional exact computation formed
(u_{7353}=A_{7353}B_{7353}), a 5629-digit integer, before either division
and obtained the same residue.  Thus this is a full-premise counterexample
to R0, not an artifact of floor division or a chosen modular representative.

The independent verifier now explicitly checks
`(q - 1) % 35**2 == 0` before executing Python integer division.  This
strengthens the verifier; it does not change the frozen packet values.

## 5. Reproduction and expanded counterexample search

The following commands were run from the repository root with the bundled
Python runtime:

```powershell
python research/computation/2026_09_01_pell_lucas_all_order/produce_lucas_all_order_packet.py
python research/computation/2026_09_01_pell_lucas_all_order/verify_lucas_all_order_packet.py
```

The producer reported:

```text
fixed-zero counterexample: PASS
all five local residues: PASS
all-order and splitter samples: PASS
```

The verifier reported `verification: PASS`, with five local residue rows and
sample indices (3,5,7,11).  The regenerated artifact hashes are:

```text
6fbfc7b2fe6627feac7b4d00211891cecfc24a017973a7148bcf1e641d8f1411  lucas_all_order_packet.json
9abb1c35d3668ff5d8b7529faf33d846a6871b90c2969a41616a22bfa6e9c00d  lucas_all_order_verification.json
```

A third, temporary implementation used binary powering of
(1+\sqrt2), rather than either bundled recurrence method.  It tested every
odd prime (ell\le101): 25 prime indices and 592 complete coefficient/tail
levels.  Every coefficient was coprime to (U), every normalized tail was a
support unit, every exact all-order polynomial matched
(u_{\ell^2}/u_\ell), and every companion splitter reconstructed the two
channel signs.  Complete factorizations of (U) for
(ell=3,5,7,11,13,17,19) also satisfied the rank congruence and
(p\ge2\ell-1).  No full-premise counterexample was found.

This finite search is pressure testing only.  It neither proves the
remaining squarefull-Pell exclusion nor permits retiring the all-order or
paired-companion routes.

The archived primary-source hashes in `SHA256SUMS.txt` were independently
recomputed and all passed.

## 6. Lean audit

The command

```powershell
lake env lean -DwarningAsError=true IUTThreeClosures/PellLucasAllOrderStaircase20260901.lean
```

completed successfully.  All 20 printed declarations have at most the
standard dependencies `propext`, `Classical.choice`, and `Quot.sound`;
`no_fixed_zero_of_full_local_surjectivity` uses no axioms.  The concrete
`u7353_mod_214375_certificate` is kernel-reduced with `decide`, not
`native_decide`.

The module does not assert Zhang's multiplication theorem, the Pell rank
theorem, local surjectivity, or a squarefull-packet exclusion as an axiom.
It formalizes only downstream algebra with explicit hypotheses and the
finite recurrence certificate.  This boundary is accurate.

## 7. Required and recommended corrections

### Corrected during this audit

1. **General companion quotient wording:** `SOURCE_NOTES.md` now states the
   factor identity and adds the necessary (v_n\ne0) condition for quotient
   language.
2. **Verifier modular division:** the independent verifier now checks exact
   divisibility by (35^2) before calculating the normalized correction.

### Applied during integration after the read-only audit

1. **Typesetting:** the literal `,qquad` in equation (3.4) was corrected to
   `,\qquad` before publication.  This was not a mathematical failure.
2. **One-line proof clarification:** the last step of Theorem 4.1 now says
   explicitly that
   (gcd(A_\ell,B_\ell)=1), by
   (A_\ell^2-2B_\ell^2=-1), before combining the two channel-square
   congruences into a congruence modulo (U^2=A_\ell^2B_\ell^2).  The fact
   was already asserted in the report and is an explicit hypothesis in the
   Lean theorem.  The added sentence makes the paper proof complete at
   journal level.

No other mandatory correction was found.  In particular, the actual
(a=6) companion quotient, all-order tail valuations, and the (k=2451)
counterexample do not need to be weakened.
