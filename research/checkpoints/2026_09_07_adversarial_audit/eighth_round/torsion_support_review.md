# Final independent review of TS1--TS3

Date: 2026-09-07. Status: complete ordinary proof and primary-source
review PASS. No mathematical correction was required.

Reviewed in full:
`2026_09_07_independent_route/eighth_round/torsion_support_refinement.md`,
SHA256 at review
`af939cab1971ba85f5ba3667b762bf5620919ec0efcde99ac44314df6635b0b3`.
The dependency on BT is needed only for the unconditional application
to the pure-power branch, not for the local conditional theorem.

## Source check and coefficient extension

The reviewer actually reopened both author-hosted primary texts:

* [Darmon--Diamond--Taylor, Fermat's Last Theorem](https://www.math.mcgill.ca/darmon/pub/Articles/Expository/05.DDT/paper.pdf),
  Propositions 2.11(c) and 2.12(b), PDF page 57. The good supersingular
  mod-p module is irreducible over F_p; the multiplicative module is
  a Tate extension of the cyclotomic character by the trivial one,
  with the unramified quadratic splitting twist.
* [Boeckle's lecture notes](https://math.uni.lu/wiese/galois/Boeckle-Luxemburg-Notes.pdf),
  Section 1.3.1 and Exercise 1.30, PDF page 13. The connected--etale
  sequence supplies the ordinary unramified quotient, and its
  Frobenius eigenvalue is the unit root alpha. Modulo p the standard
  characteristic polynomial alpha^2-t_p alpha+p=0 gives alpha=t_p,
  since alpha is a unit.

The completion is Q_p because a prime dividing the actual norm splits
in K. Thus the local hypotheses, particularly absolute ramification
index one, are satisfied. No assertion of absolute irreducibility of
the supersingular residual module is needed. The Tate subcharacter,
after cancelling the allowed quadratic nu, has values in F_p. For
that fixed character theta, Hom(theta,E0[p]) is a kernel of linear
equations over F_p. Finite image reduces the equations to a finite
system, so field extension preserves the kernel and its dimension.
A nonzero intertwiner after extending to Fbar_p descends to F_p,
contradicting the stated F_p irreducibility in the supersingular case.

## TS1: the exponent prime and the strengthened cutoff

At a split good prime, reduction preserves the nonzero rational
two-torsion point because the residue characteristic is odd. Therefore
the finite group order is even and the integer trace is even.

If p divided F, the full actual module would be multiplicative over
Q_p. The preceding argument forces the good boundary curve to be
ordinary. Its two Jordan--Holder characters, after twisting, are
lambda nu and omega lambda^{-1} nu. Exactly one is trivial on inertia,
because omega is nontrivial and lambda, nu are unramified. Comparing
with eta and omega eta from the actual Tate module forces
lambda nu=eta, including when either extension splits. Evaluating
this one-dimensional unramified character at Frobenius gives
t_p congruent to 1 or -1 modulo p.

For p>7, Hasse gives |t_p|<=2sqrt(p)<p-1. The only integers in this
open interval congruent to either sign of 1 are the odd integers
1 and -1. The even trace cannot equal them. Hence p does not divide
the norm. This argument does not assign an unramified Frobenius
trace to the full two-dimensional module at its residue prime.

For every remaining norm prime q, BC supplies a congruence between
t_q and one sign of q+1. The resulting difference is nonzero, is
even, and is divisible by the odd prime p. Its absolute value is
at least 2p and at most q+1+2sqrt(q). Therefore
q>=(sqrt(2p)-1)^2. For p>7, p^2-6p+1>0 makes this lower bound
strictly greater than p. The trace-square condition now has no
q=p exception.

## TS2--TS3 and the remaining scope

The reviewed BT theorem supplies the full module isomorphism, with
one of four quadratic twists unramified outside six, for every actual
positive primitive F=Q^p, p>7. Consequently the local theorem applies
unconditionally to that pure branch under the stated ordinary and
exact-software dependencies. The existing exclusions at 7 and 13
persist. Removing the exponent prime and a finite initial interval
does not change the already reviewed fixed-p support density.

Since Q has a prime divisor, Q>=(sqrt(2p)-1)^2>p. The exact bounds
F<=c^4 and F<=13H^4 give both displayed logarithmic lower bounds and
p^p<F<=13H^4. These are lower bounds on actual seed height. They
do not exclude moving large prime support, prove an upper bound on
rational-point height, or close the signed-tail or ABC gates.

The complete local representation inputs are ordinary mathematical
dependencies. Neither this review nor the finite modular-form replay
claims their Lean formalization.
