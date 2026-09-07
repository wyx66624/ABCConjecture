# Independent second-round review

Reviewer: adversarial-audit agent. Date: 2026-09-07.

This is in-session independent agent review, not external peer review and not
a claim that all reviewed ordinary mathematics has been encoded in Lean.

## Shared shifted ranks, towers and finite averages

Reviewed `2026_09_07_critical_bottleneck/next_shifted_tail.md` through its full
tower classification and fixed-finite-prime Cesaro theorem. Accepted:

- the good-prime residue order and its exact depth-dependent period;
- empty-or-one-class arithmetic, coherence, spacing and finite discrepancy;
- the norm-one principal kernel has p elements at each step: trace is onto
  because Tr(1)=2, and an arbitrary lift's norm can be corrected;
- a depth-s_p hit therefore lifts to every depth, giving precisely the empty,
  finite-stopping-before-s_p, and full-tower alternatives;
- the three signed local mean formulas and their step-orbit upper bound;
- the fixed-v,w, finite-prime Cesaro limit, using the established logarithmic
  cap to obtain H_N=O(log N), with no claim about a moving infinite prime set.

The actual finite-stopping, empty and full-tower examples have the stated
arithmetic hypotheses. The stopping example is also checked for every index
in the new Lean module.

## Moving windows and the stronger height-cap argument

Reviewed both the original local-logarithmic cap proof and the stronger
height-only replacement in discussion with the critical agent and root.
For N<=n<2N, let q=log Q and v=log V. The exact norm cap gives

    log A_n <= Lmax = 3v/2 + 3Nq.

For each p>3 use H_p=floor(Lmax/log p), including H_p=0. It covers every
actual valuation; H_p log p<=Lmax. The progression-density bound gives

    sum_n v_p(A_n) log p <= 2Nq + Lmax = 5Nq+3v/2.

Using the full lower denominator log c_n >= (v+Nq)/2, the normalized block
mean up to Z is therefore at most

    [(10Nq+3v)/(Nq+v)] pi(Z)/N <= 10 pi(Z)/N.

This stronger inequality is uniform in V and Q and needs no small-rho
condition. The prime range is strictly p>3. Primes dividing VQ never divide
the boundary, by primitivity and the norm-boundary gcd. No contribution at
two or three is silently included in this estimate.

Also reviewed the finite box union step. There are at most
(4sqrt(B)+1)^2<=25B integer pairs of norm at most B, for B>=1. Each compatible
residual has at most 10 pi(Z)/eta bad indices. Thus a common good-index set
for all residuals with norm<=B loses at most the proportion

    250 B pi(Z)/(N eta).

Including all compatible roots with norm<=C multiplies the count by at most
25C, giving 6250 BC pi(Z)/(N eta). The stated choices of polynomial boxes
require nonnegative beta,gamma with beta+gamma<1 and Z>=5. Subject to these
bounds, choices may be made adaptively at each common good index. This does
not cover arbitrary residual heights, all exponents, or primes beyond Z.
The elementary prime-count estimate used to turn pi(Z) into a logarithmic
rate must retain its stated range; the pi(Z)-form above requires no such input.

## Two-step norm compatibility

Reviewed `2026_09_07_independent_route/next_two_step_compatibility.md`, TC1--TC5,
and checked the valuation, unit and positive-sector passages in its
`paper/two_step_transport.tex` transcription. Accepted:

- the exact second quartic norm and the bound M1=1 modulo three;
- the fixed quartic extension, actual unit kappa and unit-coefficient identity;
- the twist kappa*u^(-2)*zeta^(-e0), nonvanishing from kappa outside K, and
  the degree-four p-adic estimate;
- all coefficient factors stay local units at every p|M1, INCLUDING thirteen;
  the rational norm sum uses the weights e_P*f_P with total four;
- the fixed-root pure second-content bound h/log(3+h)<=constant_w is correctly
  deduced from the inherited boundary p-valuation and norm-height comparison;
- the exact thirteen-adic obstruction and valuation one; the infinite
  content-one successor family uses positive RAW pairs, so a unit rotation
  cannot alter its quartic congruence;
- the 67-adic binomial precision, unit derivative 22 and unique digit lift;
- the second 67 branch and 967 branch have unit derivatives seven and 39,
  and their periods always have gcd six, with compatible residues three
  modulo six; CRT and irrational rotation therefore produce the claimed
  infinite simultaneous LOCAL contact families.

These ordinary checks were independently replayed in integer arithmetic in
`verify.py`. In particular all relevant pairs modulo 169 were checked, as
were eight levels of the initial 67 branch, six levels of each simultaneous
branch, and all 36 period-compatibility pairs. The g=199 second norm has 337
decimal digits and exact 67-depth two; no full factorization is claimed.

The reviewed results do not settle NT4. A fixed finite set of deeply supported
primes does not control the whole second radical or its residual norm. Fixed
roots with growing second remainders and roots of unbounded norm remain active.
The subsequent `lambda_refinement_review.md` records a stronger distinction:
for fixed first root and bounded first lambda, the second lambda now has a
positive effective floor. Its convergence to zero is therefore excluded in
that class. The finite two-step threshold and moving-root branches remain
unresolved; the earlier rho-only asymptotic window is not retained as open.

## Corrected one-sided signed-tail statement

During transcription of the homogeneous packet theorem, this reviewer found
one precision error in the preceding next-round note: a one-sided upper bound
log W/log c<=positive o(1) does not prove the signed ratio tends to zero.
It proves (log W)_+/log c->0, or equivalently the relevant nonpositive limsup
upper bound. The second-round note and TeX now use the positive part; the
sufficient ABC absorption proof is unchanged. No published first-round file
was altered for this correction.

## Formal scope independently reviewed by the other agent

The critical-bottleneck agent separately reviewed all eight declarations of
`Lean/ShiftedResidueCounts.lean` and `ordinary_proofs.md`. They confirmed the
actual residue parameterization, uniqueness, both modulus-one/empty-interval
boundaries, exact all-index stopping family and stated non-formalized scope.
Actual Lean 4.32.0 warning-as-error compilation passed with standard axioms only.
