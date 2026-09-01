# Multi-route global-packet continuation toward the abc conjecture

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Literature cutoff:** 2026-09-01  
**Status:** five coordinated routes advanced; several exact subclaims closed;
the standard abc conjecture and its negation remain unproved.

## 1. Governing rule and exact endpoint

The target is the unchanged standard proposition `ABCConjecture` in the Lean
development.  This continuation produces neither a closed term of that type
nor a closed term of its negation.  It therefore is a research checkpoint,
not an abc solution.

Every route is governed by the same rule.

1. Difficulty, a missing theorem, or a finite no-hit computation does not
   close a route.
2. A counterexample closes only a statement whose complete hypotheses it
   satisfies.
3. A contradiction among the fields of a proposed interface closes that
   interface as a satisfiable specification; it does not refute the intended
   mathematics represented by a corrected interface.
4. Each formalized result first appears with a mathematical proof in one of
   the dated reports.  Lean then checks the stated algebraic, logical, or
   finite core without importing unformalized literature as an axiom.

The active positive targets after this round are:

* a genuinely uniform affine exceptional-count lower bound, or an independent
  direct boundedness theorem for the same subcritical seed locus;
* a contradiction to the forced four-prime Pell packet, beyond isolated local
  rank and valuation information;
* a Fibonacci-specific simple primitive divisor at every adaptively generated
  Danilov state, or another nondegenerate fresh packet;
* a corrected, inhabited log-volume interface followed by an object-level
  pointed same-pilot construction in the IUT/LANA route.

## 2. Exact result ledger

| Route | New unconditional result | Full-hypothesis counterexample or contradiction | Disposition |
|---|---|---|---|
| Affine radical shear | The seed product may be replaced by any positive modulus containing its prime support; all three endpoint projections remain injective.  Under the existing uniform upper estimate, the desired eventual matching lower is equivalent to boundedness of the subcritical locus. | The seed `(1,8,9)` has `447,120,793` admissible minimal-step points and no exponent-`3/4` exception.  Three exact all-square rows are also nonexceptional. | A lower bound applying to that seed without an eventual threshold and “squares imply exception” are closed.  No unspecified asymptotic raw-size threshold is refuted; the eventual matching lower remains active. |
| Balancing Pell packet | Exact prime-power rank tower and channel quotient coupling; a repaired prime-order/Siegel argument gives an unconditional infinitude alternative. | At index `7`, `13^2 || u_7` although the associated polynomial root is nonsingular modulo `13`.  A printed cyclotomic identity also fails at `x=2,p=3,f=2,i=1`. | Three overstrong local/source shortcuts are closed.  The four-prime packet route remains active. |
| Danilov recursive lift | A simple fresh primitive divisor at every adaptive state gives an infinite nested-prime contradiction for a fixed survivor. | A complete quadratic-unit example satisfies the abstract one-step packet hypotheses but has no fresh successor. | Automatic abstract continuation is closed.  Danilov-specific continuation remains active. |
| Danilov simple primitive divisor | At the current index, failure forces an entirely primitive, powerful Fibonacci cyclotomic value supported on Wall--Sun--Sun primes, including one prime at least `41 n_* + 1`. | The real Lucas sequence `U_{m+2}=2U_{m+1}+3U_m` has `U_10=2*11^2*61`, with `11` its only primitive prime. | Sequence-uniform real-Lucas simplicity is closed.  The Fibonacci/Danilov statement remains active. |
| IUT/LANA same-pilot | Equality at one canonical pilot point is sufficient; full eta-map equality is stronger than needed. | The literal pinned `RHSData` is uninhabited: its unrestricted real-valued scaling law at the empty set forces `log 2=0`. | The pinned low-resolution signature is ruled out as a satisfiable specification.  Corrected same-pilot, IUT, and abc remain active. |

## 3. Positive proof routes

### 3.1 Minimal-support affine shearing

Let `a+b=c`, let the seed be primitive, and put

\[
 P=abc,\qquad \mathcal R=\operatorname{rad}(P).
\]

Take any positive `Q` with `\mathcal R\mid Q` and define

\[
 U=1+Qh,\qquad
 V=1+Q(h+ck),\qquad
 W=1+Q(h+bk).
\]

Then

\[
                         aU+bV=cW.                    \tag{3.1}
\]

If `h,k` satisfy the explicit coprimality conditions of the affine report,
then `U,V,W` are pairwise coprime and avoid every prime of `abc`.  Hence

\[
 \operatorname{rad}(aUbVcW)
   =\mathcal R\operatorname{rad}(U)
                    \operatorname{rad}(V)
                    \operatorname{rad}(W).            \tag{3.2}
\]

All three pair projections are injective.  For example, `(U,V)` recovers

\[
        h=(U-1)/Q,\qquad k=(V-U)/(Qc),
\]

and the other two pairs have analogous inverses.  This proves the primitive
shear theorem with only prime-support divisibility, rather than the stronger
and unnecessary condition `abc\mid Q`.

The minimal choice `Q=\mathcal R` maximizes the canonical parameter box.
Every fibre for `Q=s\mathcal R` embeds into it by `(h,k)\mapsto(sh,sk)`, so
averaging over multiples of the same support modulus cannot create new
outputs.  Combined with the previously proved upper bound

\[
 |\mathcal E_{\mathcal R}(c^8)|
 \ll_{\eta}\mathcal R^{-2/3}c^{4+\eta/2},              \tag{3.3}
\]

an eventual lower bound of size
`A\mathcal R^{-2/3}c^{4+\eta}` forces `c^{\eta/2}` to be bounded.  Conversely,
if the subcritical seed locus is bounded, choosing the eventual threshold
above it makes that universal lower statement vacuous.  Thus the lower bound
is a valid proof route, but after (3.3) it is logically equivalent to the
boundedness it is meant to prove.  No finite seed can refute its eventual
quantifiers.

### 3.2 Balancing-Pell prime ranks

Let

\[
 \gamma=17+12\sqrt2,
 \qquad
 u_n=\alpha^{1-n}\frac{\gamma^n-1}{\gamma-1},
\]

with the normalization in the Pell report.  For an odd rational prime `q`,
let `z(q)` be its first rank and let `e(q)=v_q(u_{z(q)})`.  Since odd `q` is
unramified in `\mathbb Q(\sqrt2)` and does not divide
`N(\gamma-1)=-32`, local lifting of exponents gives

\[
             z(q^k)=z(q)q^{\max(0,k-e(q))}.             \tag{3.4}
\]

Indeed, if `y=\gamma^{z(q)}` in the local field and `v(y-1)=e`, the
odd-prime binomial expansion gives `v(y^m-1)=e+v_q(m)`.  The least multiplier
raising level one to level `k` is therefore `q^{\max(0,k-e)}`.  In particular,
depth two is one failure of order growth and depth three is two consecutive
failures.

At an odd prime index `\ell`, the two coprime Pell channels obey an exact
first-order ledger.  Writing

\[
 A_\ell=1+2\ell a,
 \qquad
 \left(\frac2\ell\right)B_\ell=1+2\ell b,
\]

the Pell norm gives

\[
                       a-2b+\ell(a^2-2b^2)=0.           \tag{3.5}
\]

This couples the quotient coordinates of the packet primes across the two
channels.  Free quotient variables still prevent a contradiction.

The cited Fellini--Murty Section 8 architecture required repair.  The report
does not quote the defective displayed second case of its Lemma 6.4.  At a
prime index `\ell`, a selected factor of `\Phi_\ell(x)` has order exactly
`\ell`: order one would force the excluded simultaneous congruences
`x\equiv1` and `\ell\equiv0`.  Its exponent is then its first-occurrence
valuation.  After separating the terminal binomial term and allowing a
localized square generator to be a unit, the finite square-class and Siegel
argument yields the paper-level alternative

\[
\begin{split}
&\text{infinitely many odd }q\text{ have }e(q)\ge3,\quad\text{or}\\
&\text{infinitely many odd prime }\ell\text{ admit }
  q\parallel u_\ell\text{ with }z(q)=\ell.
\end{split}                                      \tag{3.6}
\]

Neither branch contradicts the exact four-prime, two-channel packet forced by
a squarefull prime-index term.  The route therefore remains open.

### 3.3 Recursive Danilov packets

Maintain an adaptive state

\[
                       3T+1=hQ,\qquad h\in\{1,2\},       \tag{3.7}
\]

and the exact factorization

\[
                         L_T=5F_{10hQ}F_{10hQ-5}.        \tag{3.8}
\]

If a fresh primitive prime satisfies `p\parallel F_{10Q}` and the stated
nondegeneracy exclusions, squarefullness forces the unique residue

\[
                           h+3r\equiv0\pmod p.           \tag{3.9}
\]

For its representative `0\le\rho<p`, divisibility together with
`0<h+3\rho<3p` gives a unique `h'\in\{1,2\}` such that
`h+3\rho=h'p`.  The update

\[
                         T'=T+Q\rho,\qquad Q'=Qp          \tag{3.10}
\]

preserves (3.7).  If such a simple fresh primitive divisor exists at every
state, iteration produces arbitrarily many distinct primes dividing the one
fixed nonzero integer attached to any surviving index.  This is impossible,
so the conditional closure is rigorous.

The exact missing premise is multiplicity one.  At `n>5`, `5\mid n`, every
primitive `p\mid F_n` satisfies

\[
                      z(p)=n,qquad p\equiv1\pmod n.      \tag{3.11}
\]

Sanna's valuation formula then gives

\[
                        v_p(F_n)=v_p(F_{p-1}).            \tag{3.12}
\]

Thus repetition is precisely the Wall--Sun--Sun condition at these indices.
At the final certified squarefree modulus `Q_*`, put `n_*=10Q_*`.  Yabuta's
one-factor correction cannot occur, so failure of a simple primitive divisor
would make the entire Fibonacci cyclotomic value `C_{n_*}` powerful and
Wall--Sun--Sun supported.  Hong's explicit theorem with `\kappa=40`, combined
with (3.11), forces one such prime to satisfy

\[
                               p\ge41n_*+1.               \tag{3.13}
\]

This is a strong necessary condition, not a contradiction.  The positive
route is now the Fibonacci-specific assertion that not every primitive factor
at an adaptive index is Wall--Sun--Sun.

### 3.4 The corrected same-pilot target

At Project LANA commit
`ddaddc274281adb5674d647e24fa478745ac6d40`, a putative `RHSData D` supplies a
positive-length procession and weights summing to one on the rational-prime
two fibre.  The sum identity makes that fibre nonempty and hence supplies a
packet component.  Its scaling field is quantified over every set `U`:

\[
 \operatorname{vol}((x\mapsto2x)^{-1}U)
     =\operatorname{vol}(U)+\log2.                         \tag{3.14}
\]

Taking `U=\varnothing` gives `\log2=0`, contradicting `\log2>0`.  Therefore
the literal `RHSData D` and the assembled variant record are uninhabited.  A
universal target over the latter is vacuous.

This contradiction identifies a domain error in the low-resolution
real-valued volume interface.  A repair must restrict (3.14) to nonempty
finite positive-volume measurable regions, with closure under preimages, or
use a codomain that handles zero and infinite volume.

After repair, let `p_q` be the canonical pilot point, `\nu` the normalized
volume coordinate, and `q_*=-|\log q|`, `T=-|\log\Theta|`.  A globally
synchronized output `S` would suffice if it supplied

\[
 \nu(\eta^q(p_q))=q_*,\qquad
 \eta^q(p_q)=\eta^{\rm anab}_S(p_q),\qquad
 \nu(\eta^{\rm anab}_S(p_q))\le T.                         \tag{3.15}
\]

Applying `\nu` to the middle equality proves `q_*\le T`.  This one-point
certificate is weaker than equality of the entire eta maps.  Its hard content
is an object-level closed diagram through the theta link, all required
indeterminacies, log-Kummer correction, determinant normalization, and
compatible local/global metrics.  Defining the point equality only after
quotienting by the desired scalar value would be circular.

## 4. Counterexample and no-go audit

The following closures use full hypotheses of the named claim.

1. **Pell simplicity shortcut.**  At index seven,
   `B_7=13^2`, `13^2\parallel u_7`, and `z(13)=7`; hence a primitive divisor
   at the extremal channel bound need not be simple.
2. **Nonsingular-value shortcut.**  For
   `F_7(X)=X^6-5X^4+6X^2-1`, one has
   `F_7(6)=13^2*239` while `F'_7(6)\not\equiv0\pmod {13}`.  Nonsingularity of
   a polynomial root modulo a prime does not prevent the fixed integer value
   from having square divisibility.
3. **Printed cyclotomic quotient.**  At `x=2,p=3,f=2,i=1`, the printed
   expression identifies `\Phi_6(2)=3` with
   `(2^6-1)/(2^2-1)=21`; that displayed identity is false.  The repaired
   prime-index proof avoids it.
4. **Abstract recursive continuation.**  With
   `\eta=(9+4\sqrt5)^8`, `\alpha_0=19+\sqrt5`, and
   `L_r=2\operatorname{Re}(\alpha_0\eta^r)+11`, one has
   `L_r\equiv7r\pmod {49}`.  At `(T,Q,p)=(0,1,7)` the local slope is nonzero,
   the forced root is zero, and `L_0=49`, yet the updated state has no fresh
   prime.  This closes automatic continuation in the abstract packet model,
   not the Danilov norm specialization.
5. **Parity-free Lucas-quotient unit formula.**  At `n=15`, the prime `61`
   is primitive for `F_15`, but `L_15/2\equiv11\pmod {61}` and
   `11^2\equiv-1\pmod {61}`.  This refutes the auxiliary conclusion
   `s\in\{1,-1\}` without the missing assumption `2\mid n`.  The corrected
   formula uses `s^2=(-1)^n`; every Danilov index `10Q` is even.
6. **Uniform real-Lucas simplicity.**  The sequence with roots `3,-1` is
   real, nondegenerate, and has coprime parameters, but
   `U_{10}=2*11^2*61`; `11` is its only primitive divisor at index ten.  This
   is not a Fibonacci counterexample.
7. **Pinned LANA record.**  The empty-set contradiction uses every field
   needed to construct an actual component of the literal record.  It rules
   out that record as a satisfiable specification.  Because no instance exists,
   it is not a counterexample object to `lhs\le rhs` and says nothing by
   itself about a corrected interface.

The bounded computations have equally strict scope.  No depth-three Pell
prime below `10^8`, no next Danilov packet below `10^8`, and no simple
primitive certificate for 45 small test indices below `5\cdot10^7` are
finite no-hit statements.  None refutes the corresponding infinite
existence statement.

## 5. Reproducible computation

Four permanent bundles contain source, certificates, replay programs, logs,
metadata, and cryptographic manifests.

* `research/computation/2026_09_01_affine_matching_lower_gate/` replays the
  minimal-support affine scan and exact square rows.
* `research/computation/2026_09_01_pell_packet_global_attack/` independently
  exhausts all `5,761,454` odd primes through `10^8`.  Exactly
  `13,31,1546463` repeat, each to depth two, and no depth-three prime occurs.
* `research/computation/2026_09_01_danilov_recursive_lift/` replays 626 fresh
  packets in thirteen nonempty batches, the state invariant, and the final
  no-next-packet search through `10^8`.  The final `Q_*` has 4398 digits and
  exactly 638 distinct prime factors.
* `research/computation/2026_09_01_danilov_simple_primitive_divisor/` checks
  the Lucas counterexample, the final-state consequences, Hong's threshold,
  and the 252-index bounded Fibonacci search: 207 certificates and 45
  unresolved cases.

Each bundle's manifest verifier is part of the global continuation replay.
The source-audit snapshots for the Pell and IUT/LANA arguments are archived
under `research/sources/`.

## 6. Lean scope

The five companion modules are:

* `PellPrimeRankCounterexamples20260901.lean`;
* `AffineRadicalStep20260901.lean`;
* `DanilovRecursiveLift20260901.lean`;
* `DanilovSimplePrimitiveNoGo20260901.lean`;
* `IUTLanaSpecificationNoGo20260901.lean`.

Together their source contains 122 theorem or lemma declarations and 42
definitions, structures, or abbreviations.  Direct compilation of each module
and the 9194-job aggregate build succeeds.  The source scan finds no `sorry`,
`admit`, `native_decide`, declaration-style `axiom`, `opaque`, or `unsafe`
construct.  Embedded `#print axioms` checks report only `propext`,
`Classical.choice`, and `Quot.sound` where dependencies occur.

The permanent replay package is
`Lean/verification/2026_09_01_global_packet_continuation/`.  Its explicit
inventory is 122 theorem/lemma declarations, 37 definitions or
abbreviations, five structures/classes/inductives, and 83 declaration-level
`#print axioms` commands.  Five direct compilations have zero warnings, the
aggregate `IUTThreeClosures` target completes 9194 jobs, and all four
computation manifests plus the pinned IUT snapshot and dedicated replay pass.
The SHA256 of its `SHA256SUMS` is
`da4e28c8e80c0439bb8a9954bbe76cbc853bbeda1a04c735721890b766f17e8f`.

Lean checks the exact finite counterexamples, divisibility calculations,
affine identities and coprimality consequences, abstract recursion, logical
quantifier equivalence, elementary powerful-part consequences, and the exact
pinned `RHSData` contradiction.  It does not formalize the repaired
Fellini--Murty/Siegel proof, the external Fibonacci primitive-divisor and
valuation theorems, Hong's theorem, the large finite searches, or a corrected
IUT same-pilot diagram.  Those boundaries remain explicit.

The ChatGPT-authored journal manuscript is frozen as the 119-page
`output/pdf/ChatGPT_ABC_Global_Packet_Continuation_2026_09_01.pdf` (SHA256
`6d3e1faed22053e973f8d87fd669423d7c02a8bed6cc557435a9458b3d8b237e`).
All pages were rendered and inspected; the mechanical and visual record is
`output/pdf/ChatGPT_ABC_Global_Packet_Continuation_2026_09_01_QA/QA.md`.

## 7. Next concentrated proof program

The routes should be pursued in parallel because their unresolved statements
have different logical shapes.

1. **Fibonacci packet:** attack the powerful cyclotomic alternative directly.
   Any counterexample must make every factor of `C_{10Q}` a split
   Wall--Sun--Sun prime, including one beyond `41(10Q)+1`.  Seek a congruence,
   height, or Galois obstruction coupling all such factors; one isolated
   Wall--Sun--Sun prime would not refute the route.
2. **Pell packet:** combine the rank tower (3.4), channel ledger (3.5), and
   global alternative (3.6).  The remaining target is simultaneous depth
   three in both channels at one prime index, rather than an independent
   single-prime estimate.
3. **Affine route:** seek an argument that controls the large-modulus boundary
   or a correlated union of templates.  Fixed-template density and averaging
   over multiples of the same support modulus are now known to be
   insufficient mechanisms, but the eventual matching statement is not
   refuted.
4. **IUT/LANA route:** first construct an inhabited corrected volume model.
   Then type the q-pilot region, output family, determinant normalization, and
   pointed closed diagram.  Only a counterexample satisfying that complete
   repaired certificate could close the same-pilot route.
5. **Counterexample search:** continue exact searches on the same state spaces
   while treating all finite absence results as bounds only.  A true abc
   disproof requires a rigorously unbounded family with a fixed positive
   radical-exponent gap, or an explicit failure of one fixed abc constant;
   isolated high-quality triples are insufficient.

## 8. Detailed reports

Full hypotheses, proofs, source ledgers, counterexamples, and reproduction
commands are in:

* `research/ABC_AFFINE_MATCHING_LOWER_GATE_2026_09_01.md`;
* `research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md`;
* `research/ABC_DANILOV_RECURSIVE_LIFT_2026_09_01.md`;
* `research/ABC_DANILOV_SIMPLE_PRIMITIVE_DIVISOR_2026_09_01.md`;
* `research/ABC_IUT_LANA_SAME_PILOT_AUDIT_2026_09_01.md`.

The English journal manuscript is
`paper/ChatGPT_ABC_Uniformity_2026.tex`; its dated compiled PDF is generated
only after the final Lean, manifest, bibliography, and visual-layout checks.
