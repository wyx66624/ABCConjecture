# Independent full ordinary review: ZD1--ZD3

2026-09-07. Next-only review; no frozen publication material was edited.

I read the complete peer note `next_zero_fiber_certificate.md`, SHA256
`4d1a2d0ae7269448c8fe75e82f9f1c0fe4304afc1bf5274e1d60edf40af26c65`.
**Full ordinary PASS.** This includes the removable formal-group factor,
integral even series, complete composition tails and two-disk exclusion.

The quotient delta/t^81 is the ratio of two integral formal series with
constant 9. The numerator uses the actual integral formal group and the
denominator uses the odd division polynomial of degree 40 with leading
coefficient 9 together with the actual x=t^-2 times an integral unit.
Both constants are units at 5. The ratio therefore lies in 1+t Z5[[t]],
and parity under negation makes it even. No unproved sigma integrality
assertion is used to justify this rational cancellation.

I checked the exact parameter formula
tau=2z(11z^2-3)/(3W), including its leading term -2z/W0 and the formal
branch at O. The cancellation in Xi leaves the integral even unit
(z/tau)^81 delta1/d2(tau), with the stated central factor (-W0/2)^81.
The first quotient's phi and omega constants are units, so both T_i lie
in 5A on the entire disk. The inherited ZS/SU all-tail estimates apply
without a punctured-disk exception. In particular the Xi logarithmic
variation lies in 25s^2A, not merely pointwise modulo 25.

The central residues W0=21 modulo 25 and W0=46 modulo 125 satisfy the
actual square-root equation. The cancelled rational functions have unit
denominators, and the unit-log formula has an entire omitted tail of
valuation at least 3. The table gives ell1/5=1 modulo 5 and 16 modulo
25; ell2 is exactly zero at the center. The pullback derivatives give
ell1/5 constant modulo 5A and ell2/5=3s, with full integral-primitive
tails accounted for. Therefore g=2s^2 modulo 5A. At the next precision,
the exact constants 5alpha=(16,3) give g(0)=20 modulo 25. There is no
appeal to a rational-point height equality at this nonrational center.

Evenness and integrality imply g(5t)=g(0) modulo 25 Z5<t>, excluding
the sole possible residue root. This is a whole-subdisk obstruction,
not an unsuccessful simple-root test or a finite center sampling. DS
then excludes the companion zero-fiber disk. No conclusion about the
infinity orbit or rationality of the additional unit-disk zeros follows
from ZD alone.

## Independent finite execution

I read the complete `next_replay_zero_fiber.py`, SHA256
`166e966051523d0c76d8f5ef3b23241cdc8004e3ef1597c26fac2bd535da9aa1`,
and independently ran `--check`. It passed with canonical JSON SHA256
`077103d25ebfcb6102d2e30bf62b4f3d8d087dc3b1b72fa6725a4488273148fd`.
The finite square-root lifts, division-polynomial data, exact logarithms
and normalized obstruction agree with the ordinary text. The infinite
formal cancellation and full-subdisk exclusion remain separately audited
ordinary mathematics, rather than claims attributed to this finite run.
