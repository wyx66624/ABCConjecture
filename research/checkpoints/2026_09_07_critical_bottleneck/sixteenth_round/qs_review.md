# Independent review of QS1--QS3

I read the complete independent_route sixteenth-round
`rational_simple_quotients.md`: ordinary full review PASS.
Reviewed source SHA-256:
`46b9b2db8da4badf77a4c4b741e564363e089a56f57484db40f444188663dbc5`.

The actual order-three fractional-linear map preserves all three
curves, including its ordinate sign. The invariant ordinate and the
degree-three parameter identify the fixed fields with the three stated
smooth conics. The zero quotient Jacobian therefore forces the
quadratic cyclotomic endomorphism relation, and its rational action
makes the Mordell--Weil rank even, including rank zero.

I independently opened the cited primary Milne sources:

- [Abelian Varieties](https://www.jmilne.org/math/CourseNotes/AVc.pdf),
  Proposition I.10.1 and Theorem IV.3.5: reduction to factors over the
  ground field and the good-reduction criterion on rational Tate modules.
- [Jacobian Varieties](https://www.jmilne.org/math/xnotes/JVs.pdf),
  Theorem 11.1, Corollary 11.4 and the proof of Corollary 12.3:
  curve point counts determine the Frobenius polynomial, and smooth
  proper curve reduction supplies good Jacobian reduction.

The good-five discriminant and coprimality checks cover the finite
charts and the two smooth infinity points. I separately implemented
direct enumeration of all actual y-square fibres in F5 and F25. This
does not use the author's norm-character computation. Its two full
25-entry tables agree, and it gives H2 counts 6/36 and H3 counts 6/12,
with Frobenius polynomials X^4+5X^2+25 and X^4-7X^2+25. The exact
independent script and result are `replay_peer_qs_five.py` and
`peer_qs_five_review.json` in this directory.

If either Jacobian split over Q, the good-five factors would have
integer elliptic traces a and -a. Their quadratic coefficient would
be 10-a^2, forcing a^2=5 or 17. This is impossible and proves the
stated Q-simplicity. Distinct good-prime polynomials prohibit a
Q-isogeny between the two Jacobians. The genus-one quotient implication
is valid; the rational infinity point also supplies an elliptic image
when needed. No absolute simplicity, rank upper bound or complete
rational-point claim is made. The remaining ranks and positive source
locus are still open.

The point enumeration is finite evidence supporting the ordinary
argument through its explicit standard inputs. It is not a Lean
formalization of the Jacobians, Frobenius or rational simplicity.

## Subsequent QS4 full review

The appended QS4 has also been fully read: ordinary PASS. This binds
the expanded source SHA-256
`ca3672e3c0533b2e3ef7c04e8308d1d8e4e744df3bb6a4abccffd42fda0aaea3`;
the previous QS1--QS3 review is retained as a separate historical stage.

I implemented and actually ran an independent complete F7/F49 direct
square-fibre enumeration. Both displayed 49-entry tables agree entry
by entry, giving point counts 11 and 61, characteristic polynomial
X^4+3X^3+10X^2+21X+49, and Jacobian order 84. This second script and
its result are `replay_peer_qs_seven.py` and `peer_qs_seven_review.json`.

The prime-to-p reduction injection is explicitly supported by the
proof of Milne AV IV.3.5, which I opened again at its reduction-map
statement. Combined with the orders 31/19 at five and 84 at seven,
it excludes every torsion prime: the five-primary and seven-primary
parts are treated using the other good prime. The nonzero class of
(0,1)-infinity_+ cannot be principal on a genus-two curve, since a
function with one simple pole would give degree one to P1. It is
therefore of infinite order. The preceding evenness of rank yields
rank at least two for both remaining Jacobians, and rank at least
six for the genus-six D Jacobian. These are lower bounds only; the
ordinary note correctly limits the classical rank-less-than-genus
method and does not exclude other point-finding methods.
