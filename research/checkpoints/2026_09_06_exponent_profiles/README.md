# Exponent profiles and compensated large-prime multiplicity

Author: ChatGPT. Research continuation, September 2026.
Baseline: `e27d295939e2130e2565b4686549e6c4a3b6ac8a` (347-page manuscript).

**This checkpoint does not prove or disprove standard ABC.** It contains ordinary
proofs with stated external inputs, restricted-class conclusions, a full-premise
infinite obstruction, a deterministic finite replay and narrower Lean theorems.
No priority, independent peer review or autonomous-subagent execution is claimed.

## Main mathematical results

1. Regroup the actual oriented Eisenstein factors by gcds of exponent blocks.
   The number of logarithms is the number of blocks, not the raw prime count.
   The angular and p-adic constants are uniform in the block roots and their
   prime sizes; every dependence remains in an explicit block penalty.
2. A growing common exponent content gives sublinear angular and full
   small-prime costs with no restriction on individual norm primes or their
   number. A quantitative unbalanced-triple exclusion follows independently
   of any boundary-excess hypothesis.
3. With at most d blocks and a sufficiently large product of their contents,
   the same conclusion applies even when the global gcd is one. A stated
   *compensated* large-prime condition gives the standard 1+epsilon bound on
   that class. The high-prime condition is not proved for all members.
4. Linnik's established least-prime theorem produces an unbounded family
   (1, ell, ell+1) with a polynomial-height prime of exact exponent h>=4.
   Its raw large-prime excess has logarithm comparable to log c, yet R>c.
   Thus global raw-excess smallness is false; the older restricted theorems
   are not refuted. The low-depth credit and the shape of the triple matter.
5. On squarefree split-norm profiles the best partition penalty is computed
   exactly. It is linear, not sublinear, in log c. Regrouping alone does not
   close prime-norm terminal cases. Even the full low-depth credit leaves an
   unbounded remainder for this particular envelope on prime-norm endpoints.

## Dependency and route registry

| Route | Reliable result at this checkpoint | Remaining node | Status |
|---|---|---|---|
| Exponent blocks / logarithmic forms | Actual root reconstruction; uniform block penalty and small-prime control | Low-content and incompatible many-block profiles | ACTIVE |
| Compensated high-prime multiplicity | Exact credit and restricted-class implications | Independent control of signed high-prime cost on the required class | OPEN |
| Raw high-prime smallness for all triples | Infinite Linnik family with R>c | The exact unrestricted child is false, not ABC or its parent | REFUTED CHILD |
| Sublinear angular defect for all triples | Exact 1+b=c angular asymptotic | The exact independent child is false | REFUTED CHILD |
| Prime-norm terminals | Exact optimized partition cost | New arithmetic input beyond this regrouping | OPEN |
| FCRT / packets | Prior once-only accounting preserved | Original arithmetic residual uniformity | ACTIVE, no new closure |
| Pell / Mersenne | Prior rank and valuation ledgers preserved | Required first-depth weighted distribution | ACTIVE, no new closure |
| IUT / geometric route | Prior source-labelled interfaces preserved | Original all-place comparison / global estimate | ACTIVE, no new closure |

The unrestricted compensated shape identity is ABC-equivalent after the
appropriate bound. It is explicitly not counted as a proof or a weaker solved
bridge. A proof of a restricted class does not exhaust all triples.

## Formal scope

`Lean/ExponentProfiles.lean` proves 16 named declarations: integer-pair powers,
commutative regrouping, exact norm products, universal progression divisibility
and nondivisibility, and an exact shape identity. It imports the previously
checked `EisensteinDescent.lean` (29 declarations). Its objects are actual integer
pairs, not an assumed global arithmetic model. External logarithmic forms,
Linnik, splitting classification and real asymptotic estimates are not encoded
as extra axioms or described as kernel-checked.

The first source run failed (34015344307). The repaired source was actually
accepted in run 34015534201 at commit
`4a042e213871246815509950ee095202129a110f`. The final integration run is recorded
separately after execution. Only `propext`, `Classical.choice`, `Quot.sound` are
permitted; warnings remain errors. A scoped build is not a full-repository build.

## Reproduce from repository root in an existing Linux x86_64 / WSL environment

```sh
python3 research/checkpoints/2026_09_06_exponent_profiles/verify.py
bash research/checkpoints/2026_09_06_exponent_profiles/wsl/verify_lean.sh
python3 research/checkpoints/2026_09_06_exponent_profiles/integrate.py
cd paper
latexmk -pdf -interaction=nonstopmode -halt-on-error ChatGPT_ABC_Uniformity_2026.tex
```

The isolated installer does not change the existing elan default, established
Lean toolchain or verified imports. Hosted execution is not access to the user's
personal WSL. The integration script rejects an unknown master source and
preserves the complete baseline exactly after removal of its two marked blocks.
