# QH1--QH3. A precise quadratic-Chabauty entry through the first quotient

Status: complete ordinary candidate and primary-source check, awaiting peer
review. No p-adic Chabauty set has been computed. This document is a bounded
resumption entry, separate from the frozen fifteenth publication and from
QS1--QS4's rank lower bounds.

Use the smooth projective genus-six D=D_(3,zeta), its three HG quotients
H_j, and the reviewed isogeny

    J_D ~ E^2 x J2 x J3,   J_H1 ~ E^2,
    E: Y^2=X^3-9X-9,      rank E(Q)=1.

The last equality is GD's complete ordinary descent, not a software rank
assumption. The map pi:D->H1 is the established degree-two quotient.
On its dense chart it is (s,v,w)->(s,y=Bv), B=f_1(s).

## QH1. Rational divisor classes and source hypotheses

The rational Neron--Severi ranks satisfy

    rho_Q(J_H1)>=3,       rho_Q(J_D)>=5.          (QH1)

Both H1 and D have good reduction at five and have rational basepoints.

Proof of the divisor bound. On E^2 the three rational divisors E x {O},
{O} x E and the diagonal have intersection matrix

    [0 1 1; 1 0 1; 1 1 0],

whose determinant is two. They are linearly independent modulo algebraic
equivalence, since an algebraically trivial divisor is numerically trivial.
Thus rho_Q(E^2)>=3, without any assertion that E has no CM or that these
are all divisor classes. Pullback under an isogeny is injective on NS tensor
Q: the norm of a pulled-back line bundle is its degree-th tensor power,
and the norm preserves algebraic equivalence to zero. An isogeny exists
in each direction, so rational NS ranks agree on isogenous varieties.
This proves the first inequality in (QH1).

On E^2 x J2 x J3, take the preceding three classes and a rational ample
class on each J_j. Restriction to E^2, J2 and J3 separately shows these
five pulled-back classes are independent. A rational ample class exists
because these are projective abelian varieties over Q. The same isogeny
argument proves the second inequality. No equality for either Picard
number is required.

For H1 good reduction at five follows from the same explicit smoothness
proof as QS2: f_0 and f_1 have nonzero discriminants mod five, their
difference is 3s(s+1), neither vanishes at 0 or -1, and the two infinity
points with leading ordinate +/-1 are smooth. An infinity point is a
rational basepoint of H1.

For D, the three branch divisors on P1 are the zeros of f_0,f_1,f_4.
Each is finite etale over Z_5 and they are disjoint. The cover is the
normalization in the biquadratic extension v^2=f_0/f_1,
w^2=f_4/f_1. Away from these divisors the cover is etale. At a zero
of f_0 or f_4 only one square root ramifies. In an etale-local base
coordinate t its normalized equation is z^2=t times a unit, smooth
over Z_5 because the coefficient of t is a unit; the other square
root is an etale unit extension. At a zero of f_1 use z=1/v and
w/v: z gives the same simple quadratic ramification and (w/v)^2
is a unit, again an etale extension. Thus the normalization is smooth
etale-locally at every branch. It is proper and finite over P1_Z5,
with the stated smooth genus-six generic fibre, so D has good reduction.
There is no branch at infinity. The point (s,v,w)=(0,1,1) is a rational
nonbranch point of D and supplies a rational basepoint. QED.

## QH2. An unconditional finite p-adic container through H1

Let H1(Q5)_2 be the quadratic Chabauty set defined by Balakrishnan--Dogra.
Then

    H1(Q5)_2 is finite,
    C5={P in D(Q5): pi(P) in H1(Q5)_2} is finite,
    D(Q) is contained in C5.                     (QH2)

Proof. The first quotient has genus two and rank J_H1(Q)=2. By QH1,

    2 < 2 + rho_Q(J_H1) - 1,

since the right hand side is at least four. All hypotheses of
Balakrishnan--Dogra, Quadratic Chabauty and rational points I, Lemma 3.2,
are now verified: the base field is Q; H1 is a smooth geometrically
integral projective curve of genus greater than one; it has a rational
basepoint; five is a good reduction prime (and splits completely in Q).
The Picard number is over Q, precisely the number bounded in QH1.
Their lemma proves finiteness of H1(Q5)_2, and the defining Selmer
condition includes H1(Q) in this set.

The full smooth-projective HG map pi is finite of degree two. Each fibre
over a Q5-point has at most two geometric points, including ramified
fibres and all chart exceptions. Its inverse image of a finite set is
therefore finite. Every rational point of D maps to a rational point of
H1, proving the last assertion of (QH2). QED.

This is a finite-container existence theorem and has not computed C5,
its cardinality, its coordinates, or which of its points are rational.
It makes no automatic assertion about the particular set D(Q5)_2 itself.
The reduction via pi avoids needing an upper bound for the ranks of J2
and J3 for this container. It does not classify the positive source locus.

A possible calculation may exploit the two elliptic maps of H1 and their
proved rank-one targets. It still requires rigorously evaluating p-adic
heights and integrals, the finite local-height values, sufficient precision
and a rational-point or Mordell--Weil sieve. None is silently supplied
by Lemma 3.2 or by a finite search for multiples of one displayed point.
In particular no basis theorem for E(Q) is available in GD.

## QH3. A second, conditional direct entry on the full curve

If the additional, currently unproved rank bound

    rank J2(Q)+rank J3(Q)<=6                      (QH3)

holds, then D(Q5)_2 itself is finite by the same lemma.

Proof. GD and HG give rank J_D(Q)=2+rank J2(Q)+rank J3(Q)<=8.
QH1 gives genus(D)+rho_Q(J_D)-1 >=6+5-1=10. Thus the strict inequality
needed by the lemma holds. Its other assumptions were checked in QH1.
This proves the conditional assertion. QED.

QS4 already gives rank J2,rank J3 >=2 and both even. Thus (QH3) allows
only the total full-curve ranks six or eight; it is weaker than asking
for both remaining ranks to be exactly two. Those upper bounds remain
unproved. If the eventual full-curve rank is ten or more, this particular
rho>=5 estimate simply does not establish the criterion; larger Picard
number or other constructions are not ruled out.

## Primary source and exact scope

Actually opened and read: Balakrishnan and Dogra, Quadratic Chabauty and
rational points I: p-adic heights, arXiv:1601.00388, especially the setup
on printed page 3, Section 2, Lemma 3.1 and Lemma 3.2 on printed page 12.
https://arxiv.org/pdf/1601.00388
The setup explicitly uses the Picard number over the ground field.
Lemma 3.2 is for a general smooth projective curve in that setup; it
is not restricted to hyperelliptic curves. Its explicit height formula
Theorem 1.2 has further assumptions, including r=g and finite-index
p-adic closure. Those additional algorithmic assumptions have not been
verified here and are not needed for the stated abstract finiteness.

The elementary divisor intersections and pullback argument above give
the Picard lower bounds directly. The group/Jacobian norm facts use the
same established Milne and HG inputs as QS. No Chabauty computation or
Chabauty/NS/rank statement is claimed as a Lean theorem.
