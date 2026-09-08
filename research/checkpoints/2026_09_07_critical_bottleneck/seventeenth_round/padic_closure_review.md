# Full independent ordinary review of QL1--QL4

Ordinary/source review PASS, 2026-09-07. Entire peer manuscript read:
`research/checkpoints/2026_09_07_independent_route/seventeenth_round/padic_closure_entry.md`,
SHA-256 `e54c52e6a8554d01de7f33668e750fa59a87585ba688c149262610b7fdbd992d`.

Actually reopened Milne EC2 (formal-group/reduction discussion),
https://www.jmilne.org/math/Books/EC2.pdf , and Balakrishnan--Dogra I,
https://arxiv.org/pdf/1601.00388 , especially the extra closure hypothesis
in Theorem 1.2 and the monic even-sextic scope in Corollary 8.1. The earlier
QH general finite-container review remains separate.

The formal-log proof is valid on 5 Z5: all degree n>=2 terms differ from
their linear approximation by at least one extra valuation, and the
complete-ball contraction gives an actual bijective isometry. Invariant
differentials supply the homomorphism identity. Thus a parameter with
valuation one gives a dense cyclic subgroup of the reduction kernel.
Combining this with actual order nine modulo five proves the whole local
elliptic closures; no global generator assertion is used.

Read the complete exact replay source and independently ran its read-only
`--check`. PASS, canonical SHA-256
`2bc0673769cc10abba959725e1683676d162918afa7fbf89a463f664c9b24696`.
This independently verifies both finite elliptic tables and ninefold
coordinates, the valuation/unit tests, full F25 H count, and finite matrix
arithmetic. It does not verify formal groups, closure or rank by software.

Reopened the original EQ formulas. At A=(0,1) and both infinities their
six exact values agree with QL4. The displayed determinant-four matrix is
correct. Since the local Jacobian has odd-order reduction and a pro-5
formal kernel, doubling is invertible; Phi and Psi therefore give a local
topological isomorphism. The argument uses the two separate coordinate
generators, not an invalid scalar change mixing different elliptic groups.

Torsion-freeness, finite index, and five-saturation follow with the stated
rank/GD inputs. A five-divisibility of the cyclic index would contradict
the local formal parameter test. The image columns recover n and m+n
modulo five and give the claimed saturation of the two divisor classes.
The divided logarithm determinant is 2 modulo five, as stated.

QL4 correctly supplies the extra finite-index closure hypothesis for this
fixed genus-two quotient. It does not compute heights, correspondence
data, analytic zeros, or the rational points. The nonmonic even chart is
explicitly not substituted unchecked into a monic formula. Full global
bases, other-prime saturation, the second square condition on D, varying
exponents and the ABC coverage gap remain open. No new Lean execution or
statement is claimed by this review.
