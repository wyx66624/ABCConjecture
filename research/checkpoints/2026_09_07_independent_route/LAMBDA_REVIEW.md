# Independent review of the remainder-proportion refinement

Date: 2026-09-07. Reviewed sources:

- `lambda_refinement.md`, LR1--LR6 and moving-support equations L18a--L18d.
- `paper/lambda_refinement.tex`, the corresponding complete ordinary proofs.

Status: independent ordinary mathematical review passed. This does not
claim that the transcendence estimates or the combined theorem are formally
verified in Lean, and it does not claim ABC or existence of a sequence meeting
the two-step counterexample gate.

## Reviews received

Critical_bottleneck independently checked the exact Weil heights, ramified
sign, normalized p=3 valuation, winding coefficient and last-logarithm
placement, independent and dependent p-adic branches, full small-prime mass,
fixed-root lambda floor, all-partition comparison, and its uniformity in both
the block count and the size of the selected primes. It then independently
checked the direct one-block source application, moving-support interval
condition, and the entirely explicit LR6 family. All were approved.

Adversarial_audit independently checked LR1--LR6, the moving-support formulas,
and the full TeX transcription. Its requested clarification was to state
0<lambda<=1 explicitly in the small-prime corollary, whose proof invokes LR2.
That domain restriction is now explicit in both the ordinary note and TeX;
the moving-support TeX inequality also explicitly retains lambda_1<=1.

Root independently checked LR1--LR5 and supplied the explicit LR6 construction,
which was then checked separately by both research agents.

## Scope and historical consistency

The strengthened p-adic theorem uses Bugeaud Theorem 1.4 only when the two
algebraic numbers are multiplicatively independent. The dependent branch
uses actual proportional oriented exponent vectors, retains the ramified
factor outside the split exponent, and invokes the unconditional first
inequality of Theorem 1.3. The Archimedean refinement uses Theorem 1.1 (1.3),
with the residual logarithm placed last and coefficient one. No branch of
a disjunctive theorem is silently selected.

The fixed-root asymptotic lambda window is now excluded for bounded first
lambda, whereas the earlier rho bound alone left it undecided. Forward
pointers were added, with root authorization, to the not-yet-published
second-round `next_two_step_compatibility.md` and
`paper/two_step_transport.tex`. First-round published files remain untouched.
The specific finite NT4 threshold and sufficiently large moving first-root
prime support are not excluded by the new theorem.

The LR5 family separates the new explicit estimates from all old disjoint
partition penalties. LR6 supplies a completely explicit integer family with
small lambda and divergent rho for its specified shared representation,
without requiring complete norm factorization or a prime availability input.
Neither asserts that every alternate shared representation has large rho,
or that these families have high ABC quality.

## Exact replay format

The unrelated second-round local compatibility replay now emits canonical
UTF-8 with LF via `write_bytes`, matching Windows and WSL output. Its current
JSON SHA256 is
`c39345159ae293f13fca50b4eca51d864c8bfa830acf24d47b0dfbdfb5cf0295`.
The replay checks 12 complete small factorizations, eight local Hensel levels,
and 36 simultaneous depth pairs. These finite checks are not substitutes for
the infinite ordinary proofs in either manuscript section.
