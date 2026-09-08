# Current distance to a complete ABC proof

This assessment answers the user's current status request. ABC is neither
proved nor disproved by this repository. No percentage or completion date is
justified by the number of pages, auxiliary theorems, or closed special cases.

## Evidence boundary

The checked main revision is a669f7d9844e04f1eb6e222aaa1c00c89ca971ff.
All five GitHub workflows for that exact revision completed successfully.
That published baseline PDF has 600 pages and SHA256
60732f02f13a00b3f8c057d5cdd9038f1ea39a7d3355cedaec5c223e11de9a72.
It contains the earlier fixed rational-locus closure and 24 new selector
arithmetic theorems. The new local release has completed full source and
transcription review, stable compilation and actual changed-page visual
inspection. Its designated PDF has 621 pages and SHA256
8a1f1576399c1eb76766a2f28a0bc8152c7c33656f3f3d1415e66696297866a2.
It adds ZD2/AC3, the ramified cubic obstruction, shifted-resultant/AP and
15 finite F13 theorems. Those additions are not part of the baseline
revision above. A later GitHub run must be checked at its actual commit.
Older route-ledger entries that still list the fixed rational locus or the
squared-unit cubic class as open are superseded only for those precise cases.

The fresh 15-theorem F13 manifest is
`verification/mathlib_validation.json`. Its scope is finite arithmetic,
polynomial identities and finite chart exclusions. It does not formalize
the entire Jacobian descent, local heights, rational-point classification,
or the ABC conjecture. Internal independent mathematical review is distinct
from external peer review and from a Lean kernel proof.

## Exact global target

For every epsilon > 0, prove one finite constant C_epsilon, independent of
all positive primitive triples a+b=c, such that

    log c - (1+epsilon) log rad(abc) <= C_epsilon.

A disproof needs a fixed epsilon > 0 and an actual unbounded sequence of
primitive triples for which the left side is unbounded above. Counterexamples
to auxiliary packet or certificate rules do not meet that requirement.

## Route assessment

| Route | Established scope | Remaining decisive work |
| --- | --- | --- |
| Original power blocks and signed prime depths | Actual radical identities, growing prime windows, per-prime depth estimates, shifted resultants, and AP control of all owners for a prescribed paired portion | Control the complete signed contribution of unmatched depths and singleton primes across different primes; handle exceptional and dependent roots; establish the necessary connection to arbitrary ABC triples |
| Fixed curves and double-norm geometry | Complete ordinary fixed cubic classifications; squared-unit rank-zero descent closes its positive locus and the primitive square/cube intersection; a cube second norm also forces the first norm to be prime to three | Treat the unramified nonsquare first norm, nonunit residuals and other exponents; prove a point-height estimate uniform as the curve varies; supply a valid all-triple reduction |
| Affine and nonlinear square/cube selectors | Exact arithmetic and positive-density results for fixed admissible finite input data | Prove thresholds and costs uniform for growing packets and exponents, and show the selected outputs actually cover the required original inputs |
| Shared CRT packets and incidence constructions | Once-only accounting and conditional implications from the precise SCRT/FCRT uniform gates to ABC; exact counterfamilies for narrower rules | Construct admissible arithmetic packets with a uniform small residual, or prove a complete-premise obstruction to the exact surviving gate |
| Frey--Szpiro, Arakelov--Vojta, effective integral points | Exact invariants and conditional height/conductor transfer interfaces | Obtain the required noncircular uniform inequality with the right coefficient and control dependence on changing prime support |
| IUT and pointed transport | Local constructions and explicit source-dependent interfaces | Realize compatible all-place objects, close Ind1--Ind3 and pointed transport, and derive the global height estimate without assuming the target |
| Pell/Lucas, Mersenne, smooth neighbours | Support identities, valuation reductions and finite certified data | Prove the stated uniform valuation or joint-distribution theorem; connect a successful result to the global target without losing quantifiers |
| Function-field specialization | Polynomial ABC with its necessary hypotheses | Control bad specialization primes, coefficient height and radical loss uniformly for integer triples |
| Canonical defect and other equivalent reformulations | Exact identities and some equivalences with ABC | Find a genuinely independent bound; proving an implication from an ABC-equivalent hypothesis does not close its premise |

## What is nearest to a useful breakthrough

The arithmetic line has the most explicit current target. On its original
blocks it must control a full signed expression of the form

    J(T) = sum_(q divides T) (v_q(T)-3) log q.

Depths one and two provide negative terms. Different primes can choose
different integer indices, and an index may have no partner at the required
depth. The new AP theorem controls all owners simultaneously for a fixed
shifted paired portion: on B=n^4 blocks its exceptional set has size
O_h(n^3/log n)=o(B) at tolerance 1/n. It proves no lower bound on how much
of the unpaired positive cost that portion captures. Neither a density-one
statement nor a per-prime estimate implies the required universal bound.

A coprime second-polynomial resultant certificate remains one possible
approach, provided its degree/height cost is small enough after retaining
all actual radical credits and the signed remainder. The reviewed SD
obstructions exclude the immediate derivative candidate, a specified norm
candidate that is a multiple of the first polynomial, and simultaneous
small-height/low-degree interpolation for one actual packet. They do not
exclude every certificate or establish a lower bound for the signed ledger.
These SD notes are later local research excluded from this release; they
are not a dependency of its seven sealed ordinary sources.

The geometry line has the strongest newly completed special-case theorem.
For positive coprime a,b, put

    M = a^2+ab+b^2,
    F = a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4.

The internally reviewed ordinary proof excludes M=U^2 and F=Q^3
simultaneously. It also excludes M=R^h with h even and F=Q^g with
g divisible by three. A separate reviewed ramified theorem now proves
F=Q^3 implies 3 does not divide M; consequently M=3R^h,F=Q^g is impossible
for every positive h and every g divisible by three. The unramified
nonsquare first norm, general F=V*Q^g, and arbitrary primitive ABC triples
remain outside these conclusions. There is no known coverage
fraction attached to this result. Uniformity and coverage are two separate
remaining obligations, even after all fixed cubic unit classes are closed.

## Next research tests

1. Separate the complete signed arithmetic ledger into the proved paired
   part and its exact remainder. Seek a cross-prime bound on that remainder,
   or a new admissible certificate that preserves every negative credit.
   Test every proposed saving on the recorded original-block counterfamilies.
2. Audit the global reduction in parallel: state what every hypothetical
   counterexample would have to map to, prove actual reconstruction and
   primitivity, and make all constants independent of the moving input.
3. Keep independent geometry active: investigate the remaining third-quotient
   positive rational loci when F is a cube and M is nonsquare, and bounds
   with explicit dependence on nonunit residuals. The ramified common-source
   twists have now been excluded. A fixed-curve classification is useful, but it must not
   be presented as the missing varying-family theorem.
4. Retain independent CRT/incidence and specialization research. Require a
   new arithmetic construction or quantitative inequality before enlarging
   an abstract framework, and retire only precisely refuted child claims.
5. Formalize complete reviewed subproofs with their actual dependencies.
   Successful local compilation is evidence for the encoded statements;
   it cannot supply a missing mathematical premise.

## Fermat reuse

The pinned official source has an actual `flt_mathlib : FermatLastTheorem`
in `FinalCheck.lean`, independently reopened for this assessment:
https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/FinalCheck.lean

The local reuse records certify selected unchanged subproofs; full FLT import
has not been locally verified. Reusing the library can reduce formalization
work. An application still needs an actual reduction to the theorem's
nonzero same-exponent equation. Such an import does not establish the
uniform radical bound for arbitrary ABC triples.

## Principal source pointers

- Published baseline: `../2026_09_08_fixed_curve_closure/current_gap_assessment.md`.
- Current paired theorem: `next_all_owner_paired_depth.md`.
- Later local certificate barriers, excluded from this release: `../2026_09_07_critical_bottleneck/eighteenth_round/next_simple_root_certificate_barrier.md`.
- Current geometric conclusion: `../2026_09_07_independent_route/nineteenth_round/next_actual_square_cube_exclusion.md`.
- Ramified conclusion: `../2026_09_07_independent_route/nineteenth_round/next_ramified_square_cube.md`.
- Its descent: `../2026_09_07_independent_route/nineteenth_round/next_zeta_squared_two_descent.md`.
- Varying-family height gap: `../2026_09_07_independent_route/tenth_round/double_oriented_covers.md`.
- Retained-route inventory: `../../ABC_ROUTE_BOTTLENECKS.md`.

This assessment is a research status record, not a proof of any newly
asserted universal estimate. No route is declared close to a complete ABC
proof merely because its last unproved premise can be written in one line.
