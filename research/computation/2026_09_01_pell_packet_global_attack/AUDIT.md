# Adversarial audit

**Date:** 2026-09-01  
**Object:** `REPORT.md` and its finite certificates  
**Outcome:** PASS at the stated boundary; the four-prime/two-depth-three
packet remains open

## Quantifier checks

1. Fellini--Murty Theorem 2.3 is quoted only in its printed form: finite
   base-gamma super-Wieferich **prime ideals** imply infinitely many
   base-gamma non-Wieferich prime ideals.
2. The prime-order conclusion is labelled as an extraction from Section 8,
   not as the printed theorem.  In that proof every divisor of the selected
   prime-index ideal `C_ell` has `f_gamma(mathfrak q)=ell`; therefore replacing
   the temporary finiteness assumption by finiteness of prime-order
   delta-one ideals leaves the Siegel contradiction unchanged.
3. In `Q(sqrt(2))`, at most two prime ideals lie over one rational prime.
   Hence infinitely many prime ideals imply infinitely many rational primes.
   For fixed `ell`, the nonzero ideal `(Phi_ell(gamma))` has finitely many
   prime divisors, so infinitely many produced ideals also imply infinitely
   many distinct prime indices.
4. The branch with infinitely many super-Wieferich ideals is descended only
   to infinitely many rational `q` with `e(q)>=3`.  No prime-rank, channel,
   or same-rank multiplicity is inferred in that branch.

## Algebra checks

* `u_n=alpha^(1-n)(gamma^n-1)/(gamma-1)` follows from
  `gamma=alpha^2` and `gamma-1=alpha(alpha-alpha^-1)`.
* `Norm(gamma-1)=-32`; every odd prime is unramified in the discriminant-eight
  field.  Hence `f_gamma(mathfrak q)=z(q)` and
  `delta_gamma(mathfrak q)=e(q)` without a hidden ramification factor.
* The local order formula uses the odd-prime LTE identity in an unramified
  DVR.  The multiplier `(N(mathfrak q)-1)/f_gamma(mathfrak q)` is prime to
  the rational residue characteristic, so Fellini--Murty depth and first-hit
  depth agree.
* Substitution of
  `A=1+2ell*a`, `B=s_ell(1+2ell*b)` into `A^2-2B^2=-1` gives exactly
  `a-2b+ell(a^2-2b^2)=0`; the coupled congruence is its reduction modulo
  `ell`.

## Counterexample-scope checks

The report closes only these fully stated implications:

1. a simple Lucas-polynomial derivative at the fixed parameter forces an
   exponent-one integer value;
2. a primitive divisor is necessarily simple;
3. attaining `q=2ell-1` or `q=2ell+1` in the relevant channel forces
   simplicity.

The report explicitly does not infer that every inequality `q>C ell` is
false, and it does not close derivative, primitive-divisor, Galois, or
Chebotarev strategies after additional hypotheses are added.

## Computation checks

* C++ enumerates every odd prime through `100,000,000`; the count
  `5,761,454` equals `pi(10^8)-1`.
* The exhaustive predicate is first evaluated modulo `q^2`; modulo `q^3` is
  evaluated for every and only `q^2` hit.
* For the first stage, `q^2<=10^16` fits `uint64`, and products fit unsigned
  128-bit arithmetic.  The rare second stage uses overflow-free
  double-and-add multiplication.
* The independent Python verifier regenerates the sieve, uses arbitrary
  precision, reproduces the complete CSV byte-for-byte by field, and returns
  PASS.
* The exact counterexample script uses exhaustive trial division below
  1.6 million for every claimed prime and directly checks the recurrence,
  channel, valuation, and derivative residues.

The absence of depth-three hits below `10^8` is recorded only as a finite
certificate.  It is not used to abandon the packet route or to assert global
nonexistence.

