# AP1--AP2: all-owner paired-depth independent review

Reviewed root source: `research/checkpoints/2026_09_08_descent_and_shift/next_all_owner_paired_depth.md`.

Final SHA256: `66de6fec5ac15e28380c1e3f1fafdbcc08655369ea9065e66c6517a7333489fb`.

Verdict: full ordinary proof PASS after the author resolved the finite-empty-shift boundary identified in this review. No source was edited by the reviewer, and no new compiler or finite replay was required for this consequence of the already fully reviewed SR proof.

The actual leading coefficient of F_n is n times 3^(3n-2). For every prime q>B=n^4, it is nonzero modulo q, so the reduction has actual degree d=3n-1. The B consecutive original indices are distinct modulo q. Thus there are at most d hit owners in the entire original block, independent of any assignment. Requiring a valid shifted partner cannot increase this number. At a fixed prime, every nonzero positive common-depth summand is at most max(b_q(h)-3,0). The root-count bound therefore applies to the simultaneous sum over every owner, rather than only to one selected owner per prime.

The union of supports is finite because the block and all actual nonzero integer boundary evaluations are finite. The maximum valuation is exactly the corresponding exponent of the literal lcm C_T(h). The termwise positive-part bound by that exponent and the previously proved SR bound yield AP1 with its explicit extra factor d. This discards no term from a claimed signed equality: the text correctly calls AP1 a bound only for the positive portion of this specified paired ledger.

For AP2, t_k=n log|3k+zeta| is strictly greater than n log(3B). Every member of the finite exceptional set satisfies the strict defining inequality. Summing gives the strict displayed bound when the set is nonempty, and positivity of the right-hand side handles an empty exceptional set. With fixed h and epsilon=1/n, d C_n(h)=O_h(n^3), while the denominator is log(3B), giving O_h(n^3/log n)=o(B). This rate has the stated epsilon normalization; no factor of n was dropped.

The claim still concerns only the B-|h| valid base owners for a fixed nonzero shift, and the missing |h| endpoints are explicitly retained if extending to the whole block. For finitely many shifts, the maximum of the valid nonnegative ledgers is bounded by their sum. The resulting exceptional-set bound pays the sum of all shift costs; it does not construct a useful shift for a singleton or its excess valuation.

The first version referred to carrying over the strict exceptional-set inequality for any finite H. At H empty this would read 0<0. I reported this concrete boundary. The final source now states a non-strict bound for every finite H, strict only for nonempty H, and explicitly records zero maximum and zero exceptional set for empty H. I actually reread this final paragraph and recomputed the bound source hash above.

The q>B hypothesis is necessary for the stated distinct-residue owner count. No hidden estimate for repeated small-prime residues is included. No lower bound for the fraction of total positive depth captured by this common-depth ledger has been proved; unmatched excess, absence of partners, independent-domain restrictions, exceptional owners, and general ABC coverage remain separate. This is a valid simultaneous estimate on a precisely defined part of the original arithmetic block, not a full signed or pointwise ABC estimate.
