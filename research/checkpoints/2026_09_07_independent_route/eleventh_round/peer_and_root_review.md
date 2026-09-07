# Additional eleventh-round independent reviews

Reviewer: independent_route.

## SQ1--SQ3 ordinary proof: PASS

Actually read the complete
`research/checkpoints/2026_09_07_critical_bottleneck/eleventh_round/squarefree_outer_window.md`,
and reread its full-mass estimate FM1 and elementary block inputs EA1--EA3
in that peer's tenth-round notes.

The rank-one exclusion compares q^2 with each individual old factor
a,a+1, not their product. The exact-rank simple-lifting interval count
and the two-progression estimate give precisely the stated constants
3n/B and 6U/(B log(U/(3n))). The growing endpoint yields the joint
exceptional proportion; no independence premise is used. At prime index
the three FM terms and EA's pointwise 2,3 cost imply the stated Markov
bound. Eventually U>6B+1 eliminates every old rank in the remaining
packet. The window has proved depth-one credit but no lower mass bound;
its credit is itself sublinear on the typical set. The positive linear
far-tail cost and excluded roots have not been paid for.

This review reused the previously source-reviewed Brun--Titchmarsh
input; it does not claim a new independent download of that source or
a new analytic Lean build.

## Parent actual-content TeX and 22 new declarations: PASS

Actually read the complete parent file
`research/checkpoints/2026_09_07_integral_lifting/paper/actual_content_and_residual_bill.tex`
and all signatures and proofs in:

* `Lean/ActualProjectiveContent.lean`: nine proved declarations;
* `Lean/ResidualReflectionArithmetic.lean`: seven proved declarations;
* `Lean/ActualResidualLogThreshold.lean`: six proved declarations.

The actual Int.gcd, its own Bezout coefficients, total zero convention,
nonzero primitivity, norm positivity, and exact reduction identities are
used honestly. The support bill uses actual Nat.factorization and the
product of distinct prime factors, with positivity and strict Real.log
comparison proved. The oriented local reflection law remains an explicit
hdepth premise and is not silently inferred from the coordinate gcd core.
The actual prime-log sum is connected to the integer radical without
adding an analytic premise.

The joint total of 31 new declarations includes nine statements in a
separate global-signed module; this review's new full-source reading
covers the 22 above. The parent's joint fresh run reports 31+53 declarations
and standard axiom queries. This reviewer did not rerun that build.

## Parent research-status section: PASS

Actually read the full initial and updated
`paper/eleventh_research_status.tex`. The final reviewed SHA-256 is
`8843fb16aefda1d4c880298ab655b2b892a213d7b1769a2c0644261118d1e734`.
The update adds the precise finite GE/BK replay scope. The positive
rational-locus restriction, even-component defect, remaining odd and
moving-residual routes, ordinary versus formal boundaries, and absence
of a complete ABC proof are all retained.
