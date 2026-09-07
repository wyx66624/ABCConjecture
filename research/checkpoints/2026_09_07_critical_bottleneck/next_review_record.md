# Second-round independent mathematical review

Date: 2026-09-07. Reviewer: the `critical_bottleneck` research agent.

These are research-agent reviews of ordinary proofs and formal statement scope.
They are not journal peer review, and they do not certify an ABC proof.
The first-round `paper/shared_generators.tex` and its verification record are
frozen; this note records only subsequent work.

## Shifted towers and moving windows

The `adversarial_audit` agent independently reviewed the shifted-rank level
classification, principal norm-one kernel argument, finite-stop examples,
finite signed discrepancy, and fixed-finite-prime Cesaro limit in
`next_shifted_tail.md`. It found the proofs correct. In particular, a hit at
depth `s_p` forces a full tower, while a finite stopping tower stops strictly
before `s_p`; this does not presume that all shifted towers are nonempty.

Both the parent and `adversarial_audit` independently checked the first moving
window estimate in `next_moving_prime_window.md`. The parent then sharpened the
elementary height-cap proof by retaining the residual norm in the denominator.
I independently checked the resulting per-prime bound

\[
 \sum_{N\le n<2N}v_p(A_n)\log p
 \le 5N\log Q+\tfrac32\log V,
\]

and the normalized aggregate bound

\[
 \frac1N\sum_{N\le n<2N}\frac{F_Z(n)}{\log c_n}
 \le\frac{10\pi(Z)}N.
\]

The denominator is `log c_n >= (log V + N log Q)/2`; replacing it by only
`N log Q/2` would lose the stated uniformity in arbitrary residual norm.
The result concerns good primes `3 < p <= Z`. Primes dividing the norm have
zero boundary valuation, but two and three are outside this moving theorem.
The residual and root stay fixed within an application to one block.

The proof and the bounded-family union corollaries are transcribed into
`paper/shifted_rank_windows.tex`. The `adversarial_audit` agent subsequently
read that complete transcription and independently approved the norm
denominator, zero height-cap case, norm-prime exclusion, union constants
`250` and `6250`, and the elementary prime-count constant eight. The tower
and Cesaro transcription matches the reviewed ordinary proofs. Its only
wording suggestion was to state the remaining signed-tail sufficient condition
as an upper bound on the positive part; that clarification was applied.

## Actual residue-count Lean statements

I independently read
`../2026_09_07_adversarial_audit/second_round/Lean/ShiftedResidueCounts.lean`
and `../2026_09_07_adversarial_audit/second_round/ordinary_proofs.md`.
The eight stated theorems agree with their ordinary proofs:

- The piecewise count includes the empty interval case.
- The actual congruence condition on `n < N` is equivalent to membership in
  a uniquely indexed arithmetic progression.
- The denominator-cleared counting discrepancy includes `N = 0` and `d = 1`.
- The recursive Eisenstein orbit is an actual multiplication recurrence,
  not an assumed residue sequence; its boundary is five modulo twenty-five
  at every index, giving exact valuation one.
- The step boundary has exact valuation two at five.

This formal scope does not include the norm-one group classification, the
weighted moving average, analytic input, or ABC. The author reported a fresh
Lean 4.32.0 check with warnings as errors and only standard axioms. This review
checked statements and proofs rather than repeating that compiler run.

## Independent review of the lambda refinement

The primary source was opened directly again on 2026-09-07:
Y. Bugeaud, *B prime*, arXiv:2209.00275v1,
<https://arxiv.org/html/2209.00275v1>. The relevant statements are Theorem 1.1,
equation (1.3), and Theorem 1.4. Their precise coefficient and independence
conditions were checked, rather than relying on the alternative in the second
part of Theorem 1.3.

For a compatible primitive profile

\[
 z=u(1+\zeta)^e v w^g,
 \quad e\in\{0,1\},\quad Q=N(w)\ge7,\quad V=N(v),
 \quad h=\max(1,\log V),\quad 0<\lambda=h/g\le1,
\]

the denominator ideals of `w/bar w` and `v/bar v` are respectively the
conjugate principal ideals, because oriented split factors have no conjugate
partner. Both archimedean absolute values are one. Thus

\[
 h((w/\bar w)^3)=\tfrac32\log Q,
 \qquad h((v/\bar v)^3)=\tfrac32\log V.
\]

This remains valid when `v` is a unit, with ordinary Weil height zero.
The ramified factor is kept outside `v,w`; its contribution to the cubed ratio
is the sign `(-1)^e`.

Set `eta=(w/bar w)^3`, `xi=(-1)^e(v/bar v)^3`. With principal logarithms,
choose an integer `k` so that

\[
 \Lambda=g\log\eta-2k\log(-1)+\log\xi\in i[-\pi,\pi].
\]

Then `|2k| <= g+2`, and `Lambda` is nonzero because the actual boundary is
nonzero. The residual logarithm is last, with coefficient one. For this
three-logarithm form, the source parameter satisfies

\[
 B'\le\max\{3,1+(g+2)/h\}\le4/\lambda.
\]

The number of logarithms and degree are fixed at three and at most two.
Equation (1.3) therefore yields an absolute-constant bound

\[
 3\log c-\log(abc)
 \le C\lambda\log(4/\lambda)\log c.
\]

Here the chord bound `|exp(Lambda)-1| >= 2|Lambda|/pi`, the exact cubic
boundary identity, and `3c^2/4 <= N(z) <= c^2` account for the passage from
the linear form to the boundary. Fixed additive constants are absorbed using
`h log Q >= log 7`. No multiplicative independence is required in this
archimedean argument.

For the nonarchimedean form use `alpha=eta` and
`beta=(-1)^e(v/bar v)^(-3)`, with positive exponents `g,1`.
If these numbers are multiplicatively independent, Theorem 1.4 applies.
At every boundary prime both are units, and its `B'` is at most `4/lambda`.
If the numbers are dependent, their nonnegative oriented exponent vectors
are proportional. There is a primitive integral direction and actual
Eisenstein integer `x` such that

\[
 w=\text{unit}\cdot x^s,
 \qquad v=\text{unit}\cdot x^\ell,
 \qquad z=\text{unit}\cdot(1+\zeta)^e x^H,
 \quad H=sg+\ell\ge g,
\]

where `s >= 1` and `ell >= 0`. The unit-residual case is included.
The established one-block estimate gives normalized cost bounded by
`C p^2 log(3+H)/H`. Since `log(3+x)/x` decreases on positive `x`, while
`h log(4g/h)` increases for `1 <= h <= g`, this is bounded by
`C p^2 lambda log(4/lambda)`. Together the two cases give

\[
 v_p(abc)\le Cp^2\lambda\log^2(4/\lambda)\log c.
\]

There is no omitted three-adic case: if three divides the boundary then
`e = 0`, and the valuation of the cubed-ratio difference is
`v_3(abc)+3/2`; bounding that difference bounds `v_3(abc)`.

These derivations were sent in full to the `independent_route` agent, which
then wrote the unified ordinary proof in
`../2026_09_07_independent_route/lambda_refinement.md`. I read its complete
LR1--LR5 proof, including all constants, and found no substantive gap.
In particular the fixed-root successor floor permits any fixed finite upper
bound on the first `lambda`, rather than requiring its `rho` to vanish.
The floor has not been compared with the finite two-step radical threshold.
The paper's choice `Y=lambda^(-1/6)` is valid: the normalized full small-prime
mass is bounded by an absolute constant times
`sqrt(lambda) log^2(4/lambda) log(1/lambda)`, which tends to zero.
This is an ordinary-proof review, not a Lean certificate. I also
checked its stronger separation family: with `r` primes in `[X,2X]`,
`L=log X`, `g=r^2 ceil(L) ceil(sqrt(log r))`, and exponents `g+i`,
one has `lambda` comparable to `1/sqrt(log r)` uniformly in `L >= log 7`,
but `rho=lambda log(4+g)` tends to infinity. All previous disjoint-partition
penalties remain bounded below by a fixed positive multiple of `log c`.
The small-block proof is unchanged; for more than `r/2` blocks the denominator
is bounded by `16 r^3 L^2 sqrt(log r)`, which is dominated uniformly by the
exponential block factor. This family is a strict improvement of the proved
compression criterion, not a disproof of ABC or of any unexcluded route.

## Scope corrections retained

A one-sided signed-tail bound implies a vanishing positive part, or a
nonpositive upper limit after normalization. It need not imply that the signed
quantity itself tends to zero. The reference to the homogeneous packet result
in `next_shifted_tail.md` was corrected accordingly. The moving full
multiplicity mass is nonnegative, so its average statements are unaffected.

The unresolved ABC dependency is still the complete large-prime signed tail,
including exceptional indices. None of the reviewed average estimates permits
replacing a fixed finite prime set by all primes without an additional
uniform estimate.
