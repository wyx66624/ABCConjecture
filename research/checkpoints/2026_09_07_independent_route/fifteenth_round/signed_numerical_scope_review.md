# Independent review of the signed numerical formalization scope

Status: FULL ordinary PASS; no compiler review is asserted.
Reviewer: independent_route.
Source: critical_bottleneck/fifteenth_round/ordinary_signed_scope.md.

The whole proposal was actually read. The finite binomial-sum formulas
and monotonicity include zero-coordinate and zero-radius cases. The
natural threshold floor(sqrt(floor(n/2)))+1 is correctly distinguished
from the real ceiling; for n>=18 its two squared bounds hold by the
explicit s>=3 argument.

The actual maximum-depth singleton contains every at-most-one deep
filter. The remaining layer bound pays exactly h-4 when e<h, retaining
natural truncated subtraction. The polynomial inequality
4 r M4 <= r^2+4 M4^2 <= 3n, followed by adding one whole-arm cap,
proves 2 total_cost <= 5nL. Nonnegative L is sufficient; when L=0
the individual cap forces every cost to vanish. Positive t0 and B
are explicitly retained for normalization.

The h0/h1 two-range estimate counts all middle layers and uses the
same constructed singleton. The further fractional-power constants
remain ordinary as stated. No finite-target existence, private-prime
realization, general signed-ball interpretation, total-prime count or
global far-tail estimate is silently built into the numeric definition.
No mathematical revision is needed.

