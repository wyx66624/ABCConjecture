# Route and dependency registry

Author: ChatGPT. Baseline: d3f7b33b1115538920cb5fcd851a97f0c3a26a3d.

## Results proved in this supplement

| ID | Exact content | Dependencies | Status |
|---|---|---|---|
| PD1 | Relative radical balance for difference powers, with two-adic correction, and odd sum powers | binomial/LTE proof, prime orders, unique factorization | ordinary proof |
| PD2 | Same-constant cleared-defect descent and minimal-failure obstruction | PD1, positive integer algebra | ordinary arithmetic proof; abstract algebraic core Lean checked |
| PD3 | Complete-budget cocycle and first-depth reallocation under base powers | PD1, elementary order and valuation identities | ordinary proof; abstract cocycle core Lean checked |
| PD4 | Uniform abc inequality on T<=n^A and n>=2(1+eps)/eps | PD1, explicit exponential domination | ordinary proof of restricted stratum only |
| FO1 | r_(k+1)=r_k+32*(r_k^2+r_k+1), r_0=226; exact v_7=k+2 and no perfect powers, for every k | polynomial identity, induction, divisibility, residues | scoped universal Lean proofs |
| FO2 | Small representative x_k with x_k<28*7^(k+1), 7^(k+2) dividing x_k^2+x_k+1, and no perfect powers | FO1, polynomial congruence | scoped universal Lean proofs |
| FO3 | x_k tends to infinity and T_3(x_k,1)>x_k/28; no uniform T_3<=C*x^theta for theta<1 | FO2, elementary order-three interpretation, growth | ordinary proof; arithmetic certificates FO2 Lean checked |
| EP1 | Pair-energy integer-lifting envelope at most largest normalized exponent | coefficient gcd/Bezout, finite energy sublevels, legal pair moves | ordinary proof; exchange polynomial Lean checked |

## Refuted children, not discarded parents

1. `R_n*(L_n*T_n)=R_1*g_n` for every difference exponent without a two-adic factor is false: x=7,y=1,n=2 gives required B=8, not L*T=2.
2. First-appearance depth is invariant under a base-power change is false: the base 2^(7^j), outer exponent 3 has first seven-adic valuation j+1, while base 2 has first valuation one.
3. A normalized-base first-appearance product has a bound depending only on the outer exponent is false, already for n=3.
4. An independent uniform bound `T_3(x,1)<=C*x^theta` with theta<1 after removing perfect powers is false by FO3.

These do not refute standard abc, the coupled first-appearance/seed problem,
the whole derivative route, or the original FCRT route.

## Active routes and exact gaps

| Route | Strongest usable result | Missing statement | Classification |
|---|---|---|---|
| Power descent | PD2 same-constant transfer | Joint control of budget and seed defect; a descent/predecessor mechanism covering triples not sharing power exponents | ACTIVE; global coverage and bound unproved |
| First appearance / p-adic | FO3 exact normalized infinite obstruction | A coupled inequality retaining seed radical information, not the refuted independent T bound | ACTIVE; new mechanism needed |
| Arithmetic derivatives | EP1 improves local integer realization | Independent control of global transverse norm divided by J; previous SD condition is ABC-equivalent | BLOCKED at theorem-strength global gap; local result proved |
| FCRT / signed or multi-output transport | Prior exact accounting and feasible algorithms | Uniform endpoint bound for all triples, including no-face regions | ACTIVE; unchanged gap |
| IUT / anabelian | Prior repository definitions and scoped lemmas | Actual all-place comparison and compatibility chain producing the required scalar estimate | ACTIVE; not closed or newly reconstructed here |
| Geometry / Szpiro / Arakelov | Prior exact excess-contact module | Uniform height bound removing multiplicity; no conjectural height input allowed | ACTIVE; unchanged gap |
| Pell / Mersenne / S-unit and related routes | Prior fixed-parameter/repeated-lifting observations | Uniform first-appearance control with dependencies traced as support and parameters vary | ACTIVE; not newly solved here |

## Dependency discipline

The elementary chains PD1 -> PD2/PD3/PD4, FO1 -> FO2 -> FO3, and the local
chain gcd/Bezout -> energy minimization -> EP1 do not use ABC.
No chain from these results to unconditional ABC is complete. PD4 retains
its T and exponent restrictions. Parent routes are not marked REFUTED merely
because no new theorem was produced on them. No independent subagent or
external peer-review result is implied by this registry.

## Final target

For every epsilon>0 there must exist one constant depending only on epsilon
that works for every primitive positive triple. The full Lean theorem with
that content is absent. Finite tests, the infinite obstruction family, and
successful scoped kernel checks are not substitutes for this target.
