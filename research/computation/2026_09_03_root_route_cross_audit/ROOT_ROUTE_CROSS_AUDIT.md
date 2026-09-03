# Independent cross-audit of two 2026-09-03 routes

**Auditor:** ChatGPT
**Date:** 2026-09-03
**Verdict:** no critical mathematical or Lean defect found in the two new
bridges.  Four precision findings raised during the audit were corrected in
the current files; two cautions concern the Sankaran source rather than the
new bridge.  Neither route proves or disproves the standard abc conjecture.

## 1. Audited objects

The audit covers:

* `research/ABC_MERSENNE_FAREY_QUANTITATIVE_SWARM_2026_09_03.md`;
* `Lean/IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903.lean` and
  its AxiomAudit;
* `research/ABC_ALTERNATIVE_QUALITY_PACKING_AUDIT_2026_09_03.md`;
* `Lean/IUTThreeClosures/AlternativeQualityPackingBridge20260903.lean` and
  its AxiomAudit; and
* the archived Sankaran arXiv source capsule, including a visual review of
  PDF pages 16--18.

The official arXiv abstract page was checked on 2026-09-03.  Its submission
history still contains only v1.  A fresh download of the versioned PDF had
SHA-256
`94eb7424ac297b62e6b2c526b3ddcf571860d7da112f97ce1bb7490f374cdd0a`,
identical byte-for-byte to the archived capsule.

## 2. Mersenne--Farey route

### 2.1 Premise and quantifier matrix

| Written result | Lean result | Audit conclusion |
|---|---|---|
| Harmonic identification for every `T`, and `H_T <= 1+log T` for `T>=1` | `harmonicPrefix_eq_harmonic`, `harmonicPrefix_le_one_add_log` | Lean is at least as strong: the upper inequality is proved for every natural `T`. |
| Prefix bound under `rows q subset {1,...,H-1}` for `1<=q<=T` | `prefixFareyEnergy_le_square_mul_one_add_log` | Exact fibre and cutoff quantifiers agree. |
| Chebyshev bracket for `log(lcm(1,...,n))` | `log_lcmUpto_lower`, `log_lcmUpto_upper` | Exact for every natural `n`; no PNT premise is hidden. |
| Cleared and divided swarm inequalities from the displayed finite inputs | `quantitativeSwarm_cleared`, `quantitativeSwarm_count_lower` | Exact.  The divided form needs only `H>0` in addition to the cleared hypotheses.  No sign assumptions on `A,epsilon,kappa` are needed for either implication. |
| Finite exact-order rows inject into bounded depth-three primes | `endpointRows_card_le_superWieferichPrimesUpTo` | Exact only at one fixed common index `m`, as the report explicitly states.  Primality, depth and size remain premises for every row. |
| Failure of little-oh gives one fixed positive epsilon on a frequent set | `not_isLittleO_iff_exists_frequently_gt` | Exact for pointwise nonnegative real sequences. |
| Frequent energy lower bound plus eventual structural data gives a frequent swarm | `frequent_quantitativeSwarm_cleared` and `notLittleO_forces_frequentSwarm_of_negligiblePrefix` | Exact.  The intersection used is one frequent set with one eventual set, not an invalid intersection of two frequent sets. |
| No uniform prefix coefficient `c<1` | `not_uniformStrictPrefixImprovement` | Full-premise witness `T=1,H=2,R_1={1}` is exact.  It refutes only the universal strict coefficient improvement. |

The displayed divided inequality (3.2) in the research report follows
immediately from the cleared conclusion when `H>0`.  During this audit it
was also given the separate declaration `quantitativeSwarm_count_lower`
and added to the AxiomAudit.  The paper fragment states the cleared form.

The super-Wieferich counting limsup remains an explicit open premise.  The
finite row theorem neither creates arithmetic endpoint rows nor estimates
their target set.  The report and Lean comments preserve that boundary.

### 2.2 Counterexample boundary

For `T=1,H=2`, the full fibre has triangular capacity one, harmonic prefix
one, and prefix energy one.  Therefore every proposed universal estimate
`E_prefix <= c C_H H_T` with `c<1` gives `1<=c`.  All premises of that exact
auxiliary claim are met.  This witness says nothing about an arithmetic
improvement that also assumes primality, exact order, depth, or cross-fibre
correlation.

## 3. Alternative-quality route and the Sankaran source

### 3.1 Exact source range

The PDF says in Lemma 4.12:

* `N=P*N_0`;
* `P` tends to infinity; and
* `N_0` remains invariant.

Because `N_0` is the product of all complementary distinct prime factors,
this fixes the complementary prime set and hence fixes `omega`.  The rate
`eta=O((log P)^(1/omega-1))` is valid in this fixed-complement regime.

Theorem 4.13 first proves the algebraic identity

\[
 q_s=q_C(\alpha,1)\,\omega^{\alpha-1}\eta.
\]

At `alpha=1` this is exactly `q_s=eta*q_DGM`.  That identity has no
fixed-complement restriction.  The root report uses it correctly.

The unsupported step occurs only in the unnumbered extension at the end of
the proof of Theorem 4.13.  There `omega_n` grows like a positive power of
`log c_n`, while `N_n/P_n` is not fixed.  The text nevertheless imports the
fixed-complement rate from Lemma 4.12.  The additional condition
`log P_n=O(log c_n)` controls one coordinate and cannot restore the missing
hypothesis.  The source also calls this condition equivalent to
`P_n~c_n^kappa`; that equivalence is false.

Thus the root report's scope judgment is correct: the factorization
identity, Theorem 4.15's pointwise reformulation, and the Chen-based DGM
divergence are unaffected; the decay conclusion in the extension is not
proved by the displayed hypotheses.  The audit does not claim an actual
abc-triple counterexample to that extension.

There is a second, source-level caution outside the root bridge.  The
displayed proof of Theorem 4.10 obtains an upper bound from Lemma 4.11 but
then calls the boundary limsup constant exact.  The shown argument does not
supply a matching lower bound.  The main limsup upper inequality in Theorem
4.13 needs only the upper estimate, so the new packing bridge does not
inherit this exactness issue.

### 3.2 Clustered logarithms

For positive logarithmic coordinates in `[L,L+C]`, their geometric and
arithmetic means satisfy

\[
 L\le G\le A\le L+C,
 \qquad \eta=G/A\ge L/(L+C).
\]

The proof in the report and `clustered_efficiency_lower` are correct.  For
prime coordinates in `[X,e^C X]`, take `L=log X`; for every fixed `C>0`,
the lower bound tends to one.  The PNT supplies more than any prescribed
power of `log X` distinct primes in that interval.  Selecting
`omega_X=floor(delta*(log(e^C X))^gamma)` of them, with `0<gamma<1`, gives a
prime-coordinate model satisfying the critical prime-count scale and the
largest-coordinate bound while `eta` tends to one.  This proves that those
coordinate conditions alone cannot yield the asserted decay.

The qualification `C>0` is necessary for the PNT cluster sentence.  The
static inequality remains true for `C=0`, but `[X,X]` cannot contain
arbitrarily large sets of distinct primes.  The current report and paper
now include the required strict positivity qualification.

The cluster is deliberately only a prime-coordinate stress test.  It is not
claimed to be the radical of an additive abc triple; additive arithmetic
could impose a dispersion condition absent from the metric hypotheses.

### 3.3 Lean and abstract counterexample

`packing_bound_iff` is the exact positive-efficiency division equivalence.
`standard_nonneg_and_le_dgm` has precisely the one-sided AM--GM sign data.
The Lean clustered theorem omits the unused hypothesis `G<=A` and instead
takes `A>0` explicitly, so it is a harmless strengthening of the written
proposition.

The sequence

\[
 q_{D,n}=n+1,\qquad \eta_n=(n+1)^{-1},\qquad q_{s,n}=1
\]

satisfies every premise of the stated metric-only implication.  Lean proves
the identity, positivity, efficiency interval, unbounded DGM sequence, and
constant standard sequence.  Its types are real sequences, so it cannot be
misread as an integer-triple counterexample.

The current report states the next positive gate exactly as
`eta*q_DGM>1+delta` on the desired subsequence.  This replaces an earlier
Vinogradov-notation version whose unspecified constant would not by itself
have forced standard quality above one.

## 4. Formal verification

All four commands below exited zero with warnings treated as errors:

```text
cd Lean
lake env lean -DwarningAsError=true IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903.lean
lake env lean -DwarningAsError=true IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903AxiomAudit.lean
lake env lean -DwarningAsError=true IUTThreeClosures/AlternativeQualityPackingBridge20260903.lean
lake env lean -DwarningAsError=true IUTThreeClosures/AlternativeQualityPackingBridge20260903AxiomAudit.lean
```

The Mersenne AxiomAudit covers all 17 theorem declarations; the alternative
quality AxiomAudit covers all nine theorem declarations.  Their exact axiom
union is `propext`, `Classical.choice`, and `Quot.sound`.  Neither module
contains `sorry`, `admit`, `sorryAx`, or a project `axiom` declaration.

Run the independent offline audit with:

```text
python verify_cross_audit.py
```

It checks the source hashes and scope anchors, exact theorem-level audit
coverage, both finite countermodels, report claim boundaries, and finite
prime clusters in `[X,2X]` through `X=10^6`.  Those numerical rows illustrate
the proved static inequality only; the PNT argument above supplies the
asymptotic existence statement.

## 5. Final disposition

No exact surviving route is retired by this audit.  The Mersenne arithmetic
counting gate remains open.  The alternative-quality route remains active
only after adding an arithmetic control on packing efficiency or its
correlation with DGM quality on actual triples.  The only refuted statements
remain the explicitly stronger arbitrary-fibre coefficient improvement and
the abstract metric-only divergence transfer.

The current route files also record the source's false Big-O equivalence and
the missing lower estimate behind Theorem 4.10's word `exact`.  These are
source-level cautions and are not imported as assumptions into either Lean
bridge.
