# Independent review of the actual prime-log bridge

Date: 2026-09-07. Ordinary note read in full: PASS.
Source `2026_09_07_depth_compensation/actual_prime_log_scope.md`,
SHA256 `acdac356f8c6074434bcd070319414e50b9e50f02b4d48c55f65f17df8e62da4`.

The variables are positive integers, and the cutoff is natural. All
sums use actual prime divisors, their full valuations and real logarithms.
The quantity W is explicitly the signed logarithmic cost rather than
its exponential. The support split gives S+L=log N with nonnegative
terms; N=1 has empty support and presents no exception.

For each positive cap, the primewise natural-depth inequality followed
by multiplication by nonnegative log p gives S<=hR+E. Additivity of
valuations gives S(UV)=S(U)+S(V). Support inclusion gives R(UV)>=R(V)
without any coprimality hypothesis. Under coprimality the supports are
disjoint and R, hence W, is additive. Combining these facts with
S(U)<=log U proves W(UV)<=W(V)+log U while preserving all overlap.

For three positive pairwise-coprime integers, applying the cap-two
bound to the first two arms and retaining the third radical term
gives exactly the displayed factor 3/2 and coefficient -3. The
visible interval bounds supply the two height substitutions. The
old-boundary factor is then adjoined by the overlap theorem, with
no new support assumption. The actual SA application uses absolute
values of nonzero quotient arms, so positivity is justified by its
ordinary input domain.

The intended bridge genuinely concerns factorization and real logs,
unlike the earlier finite integer-weight ledger. It nevertheless
leaves the actual height interval bounds, output primitivity,
analytic two-place theorem, arbitrary-root membership and ABC
outside its intended formal conclusion. None is promoted to an axiom.

## Final ordinary extension and two-module source audit

The completed ordinary note, including the positive-integer height
extension, was read in full: PASS. Its final reviewed SHA256 is
`c981a99f29a4b424e3eebca93c0e0fc765d3da15fc184b900f93f61efbf39712`.
The earlier SHA above identifies the previously reviewed finite note.

Both final Lean sources were read in full, including every theorem
signature and proof. Independent mathematical fidelity and scope review:
PASS. Final source hashes are:

- ActualPrimeLogCompensation.lean, seventeen declarations:
  `e032065e14cb3f917cccbe100d9e6e81c29b83827b53bbc6cb5310c33923307b`.
- ActualPrimeLogHeight.lean, seven declarations:
  `e91a8cb4fbb8d708c2bf8d9f8207179565479bc1382cda592edbd2034e7d6581`.

The definitions use actual Nat.factorization, Nat.primeFactors and
Real.log. Radical denotes the sum of logarithms of supported primes,
not the integer radical itself. The mass partition is meaningful for
positive integers; its Lean extension to zero is harmless because Lean's
factorization and real logarithm of zero both give the displayed zero
identity. Product valuation and overlap statements explicitly require
nonzero factors. Coprime support additivity does not silently replace
the unrestricted old-factor overlap inequality. The positive cap and
one-squarefree specializations retain the negative radical credits and
explicit actual valuation cap hypotheses.

The seven-declaration height module proves the finite logarithmic
antecedents from positive natural-number input/output data. It uses
logarithm monotonicity and additivity, with positivity derived from the
visible nonzero conditions. For positive inputs a,b,d and quotients
A,B,C, the bounds aA,bB,dC<=H imply the two lower output-log bounds.
The bounds a,b<=H1 then give the quotient mass lower bounds. The third
quotient mass upper bound follows from d>=1. Additivity and positivity
of the small-prime mass prove L(A)+L(B)<=L(T), even when the old factor
U=abd overlaps the quotients. The identity T=UABC is proved in Lean.

Thus finite_actual_arm_compensation states the complete finite real-log
SA inequality from natural-number data. Its pairwise-coprime quotient
and output-height hypotheses remain explicit. It does not assume a
desired signed-cost bound as an input. It also does not derive the
Eisenstein orbit, primitivity preservation, analytic two-place estimate,
arbitrary-root membership, or an ABC theorem.

## Compiler evidence and independent integrity checks

The root-produced manifest and complete log were read in full. This
review independently recomputed both source hashes and checked all
twenty-four declaration names against the source #print axioms inventory
and the manifest. All matched. Each corresponding log entry lists only
propext, Classical.choice, and Quot.sound.

- Manifest SHA256:
  `3dc74f34bdecdf6845b2abb3f0ec863bc1af3bea916395f3f7cd9e7655ab24d8`.
- Complete compiler/axiom log SHA256:
  `de150727937ca2b267f2470a4d59aa9602168b35a5a3cd051f502d73d58e5a20`.
- Reviewed verifier SHA256:
  `20c40da9725d238791c31c0d1bc72ae9fe8003778ffa4abf148ec2fbaa25a840`.

The recorded compiler is Lean 4.32.0, commit
8c9756b28d64dab099da31a4c09229a9e6a2ef35. Mathlib is pinned to
81a5d257c8e410db227a6665ed08f64fea08e997. The verifier was read in full:
it verifies the pin and tracked Mathlib source cleanliness, copies both
new sources to a fresh directory, prepends that directory to LEAN_PATH,
compiles the dependency module before the height module with warnings
as errors, and requires a complete allowed-axiom entry for every theorem.
It rechecks source bytes before reporting PASS. Pinned Mathlib cache
artifacts are reused; no whole-Mathlib or repository rebuild is claimed.

This is an independent source, proof, manifest and log audit. The fresh
compilation was run by the root researcher; this reviewer did not
independently repeat that compiler run or count it twice.
