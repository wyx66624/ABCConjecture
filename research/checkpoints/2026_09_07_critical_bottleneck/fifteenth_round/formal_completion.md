# Completed finite signed-moment arithmetic

The ordinary proof and the separate proposed scope were fully reviewed
before implementation. The final source has 22 theorems and the finite
natural definition `ballCount`.

Source: `Lean/SignedMomentArithmetic.lean`.
SHA-256: `01d03813915c7fcffcf2994cfde948a0d961ac5b6dcc69af77fb05beb5c65327`.

The author ran `verify_signed.py --project /root/abc-lean-build` under
WSL. It freshly compiled this source and the unchanged 15-declaration
UniformMomentArithmetic and 12-declaration AdaptiveOwnerArithmetic
dependencies. All 49 axiom queries passed, using only propext,
Classical.choice and Quot.sound. Lean was 4.32.0, with Mathlib pinned to
81a5d257c8e410db227a6665ed08f64fea08e997. The Mathlib compiled cache was
reused; this is not a whole-Mathlib or whole-repository rebuild.

Both independent_route and adversarial_audit subsequently read the
complete final source and its signatures: PASS. Adversarial additionally
recomputed all three source hashes and matched every log query to the
manifest. These peer audits do not claim a second compiler execution.

## Exact declaration inventory

1. ballCount_radius_two
2. ballCount_radius_three
3. ballCount_two_coordinates
4. ballCount_mono
5. signed_low_count
6. signed_cubic_count
7. signed_count_le_one
8. count_le_one_of_actual_diamond
9. half_root_threshold
10. half_root_threshold_upper
11. signed_low_layer_coefficient
12. exists_one_maximal
13. one_maximal_contains_deep
14. complete_one_range_budget
15. removed_one_cost
16. finite_global_from_one_cost
17. actual_single_owner_budget
18. single_owner_budget_from_signed_counts
19. actual_one_owner_two_range
20. single_prime_budget_at_natural_threshold
21. normalized_actual_prime_budget
22. signed_progression_normalization

## Scope and exact inputs

The finite binomial sum is genuinely defined and its special formulas
and monotonicity proved. Its interpretation as the image of an actual
arithmetic signed ball is not supplied by its name. A separate theorem
also accepts the explicit two-coordinate diamond consequence rather
than a full-dimensional binomial-count premise.

The actual finite depth filters, the actual selected maximum, the
empty-set case, natural truncated subtraction before real casts and
all positive layers are present in the source. The per-index entire
depth cap is explicit. The numerical core proves the complete 5/2
budget; normalized_actual_prime_budget uses each actual height t_i,
not a stipulated averaged normalization. The two-range remainder is
proved with its exact cardinal coefficients.

The natural threshold sqrt(n/2)+1 uses natural division and natural
square root; it need not equal the real ceiling for every even input.
Its lower square bound holds for all n, and its upper square bound is
proved for n>=18. The final n-dependent theorem retains this exact
threshold in its filter.

The estimate 7 n^(5/6), the actual number-field units and valuations,
the residue torsion construction, prime counting, density and the
full signed far tail are not claimed as formal results of this module.
The 11 coefficient theorem is a numerical denominator comparison,
with the preceding progression estimate left as an explicit premise.
