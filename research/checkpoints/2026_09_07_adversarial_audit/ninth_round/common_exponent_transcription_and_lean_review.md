# CE transcription, finite replay, and arithmetic scope review

Date: 2026-09-07. Final TeX transcription: PASS. The two Lean sources
were independently read in full for mathematical and signature fidelity:
PASS. This review did not run a separate Lean compiler or replace the
author's and root's fresh compilation and axiom-audit manifests.

## TeX and finite supplement

Reviewed in full:
`2026_09_07_independent_route/ninth_round/paper/common_exponent_compatibility.tex`,
SHA256 `a6130f2e507c9c01d5ff50212e37667b9937deee30a671b19eb4832b488c74cc`.

Final scope-paragraph follow-up: the author replaced the former ten-
declaration description with fifteen declarations across the two modules.
The amended paragraph was actually reread and is accurate: the sum lower
bound and direct actual positive-exponent gap are now proved, while the
bad-part antecedent, prime orders, full valuation allocation, and real
logarithms retain their stated limits. Final TeX SHA256 after this
reviewed change is
`bfad54619e52e8ec56e423c29ade0bf64a914bb182ba5cd842d6f247e548428a`.

The statement and all proofs faithfully transcribe the independently
reviewed CE1--CE4 ordinary argument. Positivity, primitive actual norms,
odd prime p>=3, integer bases, complete p-exception depth, full valuation
products, strict signs and the fixed-versus-varying exponent scope are
preserved. The integral four-ninths certificate is exact. The final
passage to unequal pure exponents takes a common odd prime divisor and
does not assume the two exponents are equal. The real mass concerns full
valuations, not the radical. No existence claim is added.

The complete `replay_common_exponent.py` was independently read and
actually rerun using `python .../replay_common_exponent.py --check`.
The process returned exit code zero and an explicit PASS JSON:

* 116 exact cyclotomic factor/order/valuation examples;
* 3931 actual positive primitive seed identities, with coordinates 1..80;
* canonical result SHA256
  `7f5ca89ff61bd99393dca73932474f439bdd58c212adaf5323c91c00f7189cad`.

Trial division is complete on every finite factorization used; the
order check at a prime exponent combines t!=1 and t^p=1. The exponent
prime is checked both for occurrence and exact depth one. The computed
bad part of the product includes its full factor depths. Actual seed
identities use integer and Fraction arithmetic. The two kinds of finite
examples are explicitly separate: the run does not certify an actual
seed with both norms pure powers. JSON comparison uses canonical UTF-8
LF bytes and `--check` does not rewrite the certificate. The TeX's finite
counts and scope match this independently rerun result.

## CommonExponentArithmetic: ten theorem declarations

Source:
`2026_09_07_independent_route/ninth_round/Lean/CommonExponentArithmetic.lean`,
SHA256 `e85c75a29bce81fc95b56b80a71c20e7e4e9492d6f8e0382cf440df34a693bf0`.

The imported `norm` and `second` are the actual repository first and
second norms. The polynomial difference, integral four-ninths identity,
nonnegative-coordinate inequality, and strict positive-coordinate norm
comparisons are genuine unconditional arithmetic statements under the
visible sign assumptions.

The recursive homogeneous sum has the correct n terms. Its factorization
is proved by induction for every natural exponent, including zero. The
actual common-power factorization substitutes the explicit norm equations
and correctly identifies `(R^2)^p=(R^p)^2`; it does not assert such a
representation exists and does not require an artificial prime assumption.

The `root_gap_budget` is deliberately an arithmetic interface: `hS`
supplies the lower bound on the sum, `hM` supplies the factorization of
the squared actual norm, and positive `U` permits cancellation. The
nonnegative `D` premise supports multiplying the sum inequality. The
subsequent root lower bound uses `D>=1` and `p>=0`. The squared bad-part
budget retains the explicit `hbad : C^2 <= p*D`. These signatures do not
pretend that prime-order allocation or actual bad-part divisibility has
already been formalized.

## ActualCommonExponentGap: five further theorem declarations

Source:
`2026_09_07_independent_route/ninth_round/Lean/ActualCommonExponentGap.lean`,
SHA256 `243774d87010250bf55b1076808270b646f8497adf3f0bf4c1d91081b8329032`.

This additional module proves the geometric-sum lower bound and connects
it to actual power representations. Its scope is consequently stronger
than merely repeating `hS` as an assumption.

The nonnegative power monotonicity and homogeneous-sum lower bound use
induction, with the visible sign hypotheses needed for multiplication.
The strict actual root gap follows from the actual second norm being
greater than the square of the first norm. It handles every natural
exponent under the explicit equations; a contradictory zero-exponent
case is harmless and creates no existential assertion.

For the positive exponent `n+1`, the actual budget theorem chooses
`U=(R^2)^n`, proves it positive from `R>0`, proves the squared norm
identity from `hM`, and supplies the already proved homogeneous-sum
lower bound. It thus concludes

    9*(n+1)*(Q-R^2)<=4*R^2

directly from positive actual coordinates and the two common-power norm
equations. The next theorem uses the integral strict root gap to obtain
`9*(n+1)<=4*R^2`. These are precisely the integer core of root PP5 for
all positive common exponents. They do not require primality, coprimality,
rank laws, or valuation assumptions beyond the displayed equations.

## Formal boundary

The source review covers ten plus five theorem declarations, not a new
claim of independently compiled success. There is no added `sorry` or
user axiom in these sources; every theorem has a proof and an explicit
axiom-print command. The final authoritative compilation and imported
axiom scope must be read from the fresh verification manifest. Prime
orders, the exponent-prime valuation law, the full support allocation,
the real logarithmic estimates, and ABC itself are not formalized by
these arithmetic modules. No actual pure-power family is asserted.
