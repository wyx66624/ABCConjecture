# Independent read-only review of the actual prime-log bridge

Date: 2026-09-07. Reviewer: critical_bottleneck.

I read the complete ordinary proof `actual_prime_log_scope.md`, both
complete Lean modules, `verify_prime_logs.py`, and the final manifest.
Ordinary proof, all 24 signatures and all proof bodies: PASS.
I did not repeat the author's fresh compilation in this review.

## Exact arithmetic and logarithmic semantics

ActualPrimeLogCompensation defines six observables using actual
Nat.factorization, Nat.primeFactors, and Real.log. The cutoff is the
natural integer Y, and weight is log p exactly when Y<p. The excess
uses truncated natural subtraction before casting to Real. The signed
observable is mass minus three radical mass, without taking a positive
part. Thus the negative credits retained in the ordinary proof are
present in the actual formal objects.

I checked all seventeen declarations: nonnegative prime weights and
both masses; the exact factorization logarithm partition; the actual
cap inequality including h=0; mass additivity; coprime radical and
signed additivity; the radical support inclusion for arbitrary products;
the old-factor overlap cost; three-factor additivity; both two-arm
budgets and old-factor extension; actual cap-to-zero-excess; and the
one-squarefree-arm inequality. All nonzero and coprimality premises
needed for product factorization or support disjointness are explicit.
No coprimality with the old factor U is added. The actual cap condition
only constrains prime divisors above Y.

The generic mass/log identities also accept N=0 according to Mathlib's
empty factorization and Real.log 0 conventions. This does not assert
an ordinary valuation of zero: every main arithmetic product theorem
and its intended boundary application retains nonzero inputs.

## Height premises are actually derived

I checked all seven declarations of ActualPrimeLogHeight. The natural
log product and monotonicity lemmas preserve positive domains. The
output-log lower bound follows from bounding the other two output
logs. The actual-arm mass bounds derive the logarithmic lower premise
by subtracting the input log and exact small-prime mass; the upper
premise follows from A<=a*A<=H. The small-mass product budget uses
additivity and nonnegativity, without assuming the old factor is
coprime to the quotient product.

The final finite_actual_arm_compensation theorem starts with positive
natural input arms a,b,d and quotients A,B,C, pairwise coprime quotient
factors, input bounds a,b<=H1 and the three actual output bounds
 a*A,b*B,d*C<=H. It proves the complete finite signed logarithmic
inequality after deriving both lower height premises and the final
small-mass budget. The output product identity T=(a*b*d)*(A*B*C) is
proved by ring arithmetic. Delta is the actual expression
3log H-log T, not an unspecified estimate supplied by an axiom.

This is a real advance beyond integer-weight lists. It is nevertheless
an arithmetic interface theorem: no imported Eisenstein orbit module
is silently supplying primitive-power preservation or cap membership.
No theorem here proves an analytic two-place estimate, an asymptotic
signed-tail saving, a general radical saving, or ABC.

## Source and build-evidence checks

I independently recomputed both on-disk source hashes and declaration
counts. They exactly match the final manifest and all query lists:

- ActualPrimeLogCompensation: 17 declarations,
  SHA256 e032065e14cb3f917cccbe100d9e6e81c29b83827b53bbc6cb5310c33923307b.
- ActualPrimeLogHeight: 7 declarations,
  SHA256 e91a8cb4fbb8d708c2bf8d9f8207179565479bc1382cda592edbd2034e7d6581.

The verification script copies both sources into a fresh directory,
compiles them sequentially so Height imports the new Compensation,
uses warnings as errors, rejects sorry/admit/custom axiom declarations,
checks every declaration has exactly one axiom query, and validates
all reported axiom sets against propext, Classical.choice, Quot.sound.
It checks Lean 4.32.0, pins Mathlib commit
81a5d257c8e410db227a6665ed08f64fea08e997, and explicitly reuses its
existing dependency cache. The reported success is fresh compilation
of the two new modules, not a fresh rebuild of Mathlib or the repository.
The script also rechecks both copied and original source bytes after
compilation. This review does not add another compiler execution to
that runtime evidence.
