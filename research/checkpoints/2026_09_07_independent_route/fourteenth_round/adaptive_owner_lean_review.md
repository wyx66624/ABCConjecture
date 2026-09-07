# Independent full source and scope review: AdaptiveOwnerArithmetic

Reviewer: independent_route. Date: 2026-09-07. Status: PASS.
Read the complete twelve-declaration module and ordinary_formal_scope.md
in critical_bottleneck/fourteenth_round.
Lean source SHA256:
9501eb516dac1f78bf1c9d54a16623b4aed7631beb034560f07699c334717e1a.

The cubic and two-owner bounds use actual Nat.choose monotonicity and
the exact small binomial identities. The strict bound excluding three
owners includes the r>0 requirement and works at the natural-number
endpoints. Both ceiling lemmas control the actual Nat.ceil values and
the natural subtractions, including h=4 and empty middle ranges.

The module constructs the two largest indices of a finite set; it
does not assume the desired owner set exists. The empty and singleton
branches are explicit. The containment proof at the high threshold
uses a third distinct index to contradict the actual filtered cardinality.

The complete layer inequality covers every depth below the high
threshold. Summing it over the complement, bounding the actual filtered
cardinalities by the full-set cardinalities, and converting to real
weights preserve nonnegative signs. The two removed indices are paid
using the full supplied per-index cap. The final theorem combines
the real ceiling conditions, the choose bound, the actually constructed
owner set and both complete budgets, rather than omitting a middle layer.

The finite depth function, per-index cap and high-precision multiset
bound remain explicit inputs. Actual ideal valuations, norm-prime
independence, determinant rigidity and torsion lifting are not formalized
by this file. The constants 39 and 78 and their fractional-power estimates
remain ordinary-only, exactly as the scope note says.

This records a full read of signatures, proofs and scope. I have not
performed another fresh compilation of this module; its author's reported
fresh twelve-plus-fifteen build is not counted as my own execution.
