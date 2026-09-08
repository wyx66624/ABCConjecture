# ZD1--ZD3 independent complete review

Status: **full ordinary proof PASS**. The full finite verifier was actually
read and independently executed with `--check`, exit 0; the reviewed source
and canonical certificate were not rewritten.

Candidate `next_zero_fiber_certificate.md` in the independent eighteenth
round has SHA256
`4d1a2d0ae7269448c8fe75e82f9f1c0fe4304afc1bf5274e1d60edf40af26c65`.
Verifier `next_replay_zero_fiber.py` SHA256
`166e966051523d0c76d8f5ef3b23241cdc8004e3ef1597c26fac2bd535da9aa1`.
Canonical `next_zero_fiber_exact.json` SHA256
`077103d25ebfcb6102d2e30bf62b4f3d8d087dc3b1b72fa6725a4488273148fd`.

The formal-group calculation correctly uses two independent integral
units with constant nine: `[9]t/t` and `t^80 psi9`. Their quotient is
`delta/t^81` with constant one, and the oddness of delta makes it even.
The standard division degree/leading coefficient was checked against the
primary Sutherland source during UD/IF review. The integral formal group
is used on a good integral short model at five, where these operations
are valid. No integrality assertion about sigma is substituted for this
rational-function pole cancellation.

The actual quotient parameter is exactly
`tau=2z(11z^2-3)/(3W)`, so `tau/z` is an odd-parameter quotient with
constant `-2/W0`, an integral even unit. Consequently the cancelled Xi
is `(z/tau)^81 delta1/d2(tau)` and has the stated finite center value
`delta1(-9/4,W0/8)*(-W0/2)^81`. The exponent and its sign are correct.
The first quotient's unit phi/omega and divisible psi follow from the
actual center calculation and integral formal inverses, not merely
pointwise nonvanishing. Both ninth-multiple parameters lie in 5A over
the entire disk, with the second quotient equal to O at its center.

The evenness of Xi gives a relative unit in `1+25s^2 A` after z=5s.
Its logarithm's full tail has the required Gauss lower bound. The full
ZS/SU composition estimates put R0 and L-T in valuation at least four,
so they cannot affect f mod125 in the central computation. Knowing
5alpha mod25 also suffices, since the resulting alpha error is multiplied
by an elliptic-log square of valuation at least two.

The Hensel residues W0=21 mod25 and W0=46 mod125 are on the specified
branch and give Xi0=16/66, log Xi0=15 at both precisions, and T1=20/95.
Thus ell1/5 is 1 mod5 and 16 mod25. Direct substitution, including the
`+4/3 log(3)` sign, gives zero mod5 and **20 mod25** for the normalized
center value. This computation does not assume that this non-Q center
satisfies a global rational-point identity.

The invariant-differential pullbacks show that ell1 has no linear
variation while ell2/5 is 3s mod5. The complete integrated tails have
valuation at least two. Together with `5alpha2=3`, they give the full
reduction `g(s)=2s^2 mod5A`. Exact evenness of g, not just evenness
modulo five, then gives `g(5t)=g(0)=20 mod25 Z5<t>`. All nonconstant
even terms acquire at least two factors of five, and completeness
justifies this for the entire restricted series. The only candidate
residue is therefore excluded. DS excludes the companion disk.

The executed program checks the finite Hensel lifts, the actual first
quotient's division recurrences, cancelled Xi value, unit logarithms and
the previously audited exact rational alpha inputs. It reuses the UD/SU/ZS
helpers. Independent execution of that program is not represented as a
second implementation or as a machine proof of its analytic tails.

Combining the separately reviewed UD, SU, IF and ZD ordinary conclusions
with the previously checked twelve-disk coverage gives ten distinct zeros
of this fixed local QC function: eight simple zeros on the four first-unit
disks and two double zeros at infinity. Six are the known rational points;
the four extra first-unit zeros have not been proved rational or nonrational.
This count is for the fixed local function only, and supplies no uniform
varying-family ABC estimate or intrinsic genus-six QC conclusion.
