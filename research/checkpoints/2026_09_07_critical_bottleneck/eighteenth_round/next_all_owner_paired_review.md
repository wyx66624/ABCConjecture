# Full ordinary audit of AP1--AP2

Status: PASS after actual full reading of research/checkpoints/2026_09_08_descent_and_shift/next_all_owner_paired_depth.md.

Reviewed SHA-256: 8d8666464b7ebf75181dc6815beba551d7fd01ee74f9b2908352e77d025f9fc1.

For every q>B, the leading coefficient n*3^(3n-2) of F_n is nonzero modulo q. Its degree is therefore exactly d=3n-1. Reduction of the B consecutive integer owners modulo q is injective; at most d owners can be boundary hits. This proves the stronger first bound in AP1 with d times the complete sum of positive parts of maximum common depth minus three. The root-dependent count is paid explicitly; no prime is silently assigned only once.

The lcm exponent is precisely the maximum common full T-depth, so the second bound by d log C_T(h) is termwise legitimate. The corrected SR result handles three, although AP1 itself only sums q>B and therefore cannot accidentally include it.

The exceptional-set derivation uses actual t_k=n log|3k+zeta|>n log(3B), the strict threshold, and the positive bound even for an empty exceptional set. For fixed h and epsilon=1/n the bound is O_h(n^3/log n)=o(B). The set is defined from all actual common prime depths and is independent of arbitrary prime-owner assignments. This is a genuine quantifier improvement over the assigned-packet statement SO1.

The finite set of shifts is treated by maximum at each valid owner bounded by a sum, with d times the sum of the individual constants. Missing endpoints and existence of a sufficiently deep partner are not assumed away.

Only positive matched depths above B are bounded here. The statement does not discard or transfer negative credits in the original full signed identity. No lower bound on coverage of positive cost, no bound for unmatched depth, no full pointwise estimate, and no passage to arbitrary ABC triples is asserted. In the independent-domain singleton range the same matched quantity may already vanish; its extension to all original owners is correctly separated.

No new computation, formalization, compiler run or publication check was performed for this audit.

Final boundary clarification: the author now explicitly makes the finite-shift bound non-strict for an empty shift set, and strict only when the shift set is nonempty. I actually reread this revision and independently recomputed final SHA-256 66de6fec5ac15e28380c1e3f1fafdbcc08655369ea9065e66c6517a7333489fb. The empty set gives both zero cost and zero exceptions. Final ordinary PASS is bound to these corrected bytes; the earlier hash above records the original reviewed snapshot.
