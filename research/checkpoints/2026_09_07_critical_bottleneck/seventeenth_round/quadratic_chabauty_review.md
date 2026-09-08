# Independent ordinary review of QH1--QH3

Full ordinary review PASS, 2026-09-07. Reviewed the complete peer file
`research/checkpoints/2026_09_07_independent_route/sixteenth_round/quadratic_chabauty_entry.md`,
SHA-256 `410e910aaad3d4a8d0e6fbd609d4ab1d8776c2092e6c6c156f2ab3b8d73b3559`.
This review is separate from the frozen fifteenth publication and from the
previous QS review. No new computation, formalization or rational-point
classification is claimed.

## Source and hypotheses actually checked

Opened Balakrishnan--Dogra, *Quadratic Chabauty and rational points I*,
arXiv:1601.00388v2, https://arxiv.org/pdf/1601.00388 . Read the general
setup on printed pages 3 and 6, Lemmas 3.1--3.2 on printed page 12, and
the additional hypotheses in Theorem 1.2 on printed page 4. The lemma
uses the ground-field Neron--Severi rank and applies to the general
smooth projective curve in that setup. No algorithmic finite-index
closure assumption is imported into its abstract finiteness conclusion.

The existing HG/GD/QS ordinary inputs are retained with their audited
scope: the actual degree-two map D to H1, the rational Jacobian isogeny
J_H1 ~ E^2, and rank E(Q)=1. They are not Lean Chabauty inputs.

## Full mathematical checks

The three rational classes on E^2 have the displayed nonsingular
intersection matrix. Isogeny pullback preserves their rational linear
independence in NS tensor Q by the line-bundle norm identity. Adding
the two independently restricted ample classes gives the lower bound
five on the full Jacobian. Neither argument asserts geometric Picard
rank, an exact Picard rank, or an absence of CM.

The simple, pairwise disjoint branch divisors modulo five give good
reduction of H1 and of the normalized biquadratic curve D. At the common
pole divisor use 1/v and w/v, so only one simple quadratic branch remains;
the unit extension is etale since 2 is invertible. Infinity is unbranched.
The displayed rational basepoints and genera satisfy the source setup.

For H1 the strict rank inequality is 2 < 2+rho_Q(J_H1)-1, since rho>=3.
Thus its second Chabauty set is finite. The inverse image C5 under the
finite degree-two map is finite, each geometric fibre having at most two
points, and D(Q) is contained in it. Projective and ramified fibres are
included. No coordinates, cardinality or rationality test for C5 have
been computed.

The argument as written proves finiteness of this inverse-image container;
it does not identify that container with the intrinsic D(Q5)_2. No
unstated functoriality or equality of Selmer constructions is used.
The separate direct application to D is correctly conditional on
rank J2(Q)+rank J3(Q)<=6, giving total rank<=8<10. The known even lower
bounds for these ranks do not prove this upper bound.

All QH conclusions and stated limitations pass. Effective evaluation of
heights, local values, precision and a final rational-point sieve remain
separate tasks; no claim about all ABC triples or varying exponents follows.
