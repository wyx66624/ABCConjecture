# Route registry and dependency audit

This registry supplements rather than replaces the persistent project ledger.
Baseline: `9edd965d6df645dbebc0869530f3f5a40fb8cddc`.
The standard epsilon-dependent constant must be independent of every triple.

| Route / mechanism | Strongest result in this checkpoint | Exact remaining issue | Status |
|---|---|---|---|
| Eisenstein factor descent | Every primitive nonunit has a prime-norm predecessor with height contraction at most 2/3; ordinary proof | Control the new boundary primes and their multiplicities, not merely existence of the predecessor | COVERAGE PROVED; GLOBAL ESTIMATE BLOCKED |
| Exact boundary coupling | `gcd(F(w),F(beta*w))=gcd(F(w),F(beta))` for arbitrary multiplier and primitive input | An overlap formula does not bound the new radical magnitude | KERNEL-CHECKED |
| Fixed norm-seven orbit | Whole-boundary Lucas relation and strong divisibility for all indices | First-apparition valuation and exponential radical growth remain uncontrolled | KERNEL-CHECKED STRUCTURE; ESTIMATE OPEN |
| Signed homogeneous first apparition | Entire cubic quotient 7^n; normalized first excess of quadratic base-height size | Must estimate first excess jointly with `rad(x*y*(x-y))` | ORDINARY PROOF; MODULAR/NORM CORES CHECKED |
| Pointwise no-loss factor selection | All prime-norm parents at alpha^6 have smaller q_m than the child | Counterexample closes this exact policy; 1+48=49 also refutes same-constant transfer from both factors, not factor descent or amortized policies | REFUTED CHILD |
| Arithmetic-derivative lifting | Inherited integer-realization results retained | A smaller local overhead alone cannot close the ABC-equivalent real minimum | INHERITED; NO NEW GLOBAL BOUND |
| FCRT and endpoint residues | Newly merged PR419 obstruction included in baseline audit | Must not infer a positive proper subface from mere counting collisions | INHERITED; NO NEW TRANSPORT ESTIMATE |
| Pell/Lucas | The new nonreal Lucas sequence has parameters (20,343) | Do not identify it with the earlier real Pell sequence or transfer first-valuation bounds without proof | CONNECTED STRUCTURE, DISTINCT SEQUENCE |
| IUT and geometric uniformity | Existing source-dependent and conditional interfaces preserved | All-place/same-pilot and uniform height comparisons remain unresolved | RETAINED, NOT ADVANCED HERE |
| Standard ABC | No unconditional proof or disproof | All triples; every positive epsilon; uniform constant | OPEN IN THIS WORK |

## Proved dependency chains

- Explicit pair algebra -> coordinate rounding -> Euclidean Bezout gcd -> prime-norm predecessor -> height contraction -> finite algebraic coverage.
- Polynomial divisibility remainders + actual coprimality -> exact full gcd -> orbit addition -> Euclidean induction on indices -> strong divisibility.
- Norm-seven orbit + mod-7 and mod-4 invariants -> full single-prime cubic quotient + normalized bases -> quadratic first-excess obstruction.
- Exact norm-seven divisor enumeration + two complete small factorizations -> all-parent pointwise-loss counterexample.

The first chain is an ordinary proof, not a completed Lean construction.
The second chain, including the general gcd and all-index strong divisibility,
is fully covered by the supplied Lean source. The third chain has formal norm,
recurrence and residue cores, but not its complete asymptotic interpretation.
The fourth has formal cleared arithmetic inequalities, but its full parent
classification and prime/radical interpretation are ordinary proofs.

## Source versus new work

The project ledger supplied the first-valuation and uniformity bottlenecks,
not the new estimates or proofs. This checkpoint independently derives the
listed algebraic formulas. It neither re-audits every theorem in the large
repository nor presents any disputed global source program as established.
The no-loss counterexample and quadratic excess family are not counterexamples
to standard ABC. The restricted-family exponential bounds and a total path-loss
bound are labelled restatements, not independent sufficient lemmas already close
to being proved.

## Edge cases and auditing

- Units: norm one, boundary zero; any q_m=1 terminal convention is bookkeeping,
  not a change to the definition of the radical.
- Index zero: B_0=0 and strong divisibility includes it.
- Signs: F=x*y*(x+y) and G=x*y*(x-y) are different forms and are never substituted.
- Multiplicity: the boundary theorem is an equality of full gcds; proof includes
  cube cancellation and pairwise-coprime product decomposition.
- Normalization: abs(x_n)=2 modulo 4 on n=6*j+1 excludes nontrivial perfect powers.
- All parents: at alpha^6 all norm-prime factors have norm seven; the bounded
  coordinate enumeration is complete, not a heuristic search.
- Execution: independent program paths and kernel checking were used, not
  independent autonomous research agents or an external referee.
