# SM1--SM3. A five-primary sieve at thirteen and the fixed rational locus

Next-only complete ordinary candidate, pending final combined review.
The conclusion is a classification for this one explicitly stated genus-two
curve. It is not an ABC proof, a statement for varying curves or residuals,
or a completed Lean formalization of the height argument.

Let C be the smooth projective completion of

    W^2=z^6-27z^4+99z^2-9.

Its two rational infinity points are distinguished by W/z^3=+1 and -1.
The claim is

    C(Q)={(1,8),(1,-8),(-1,8),(-1,-8),infinity+,infinity-}.   (SM1)

The argument uses the reviewed fixed-model ordinary results QL, HT, LH,
ZS, DS, UD, SU, ZD and IF. Its new global step is an exact finite sieve
which uses the proved five-saturation and does not assume a global basis.

## SM1. Transport through the rational group, not between local fields

Use the actual curves and points

    E1: y^2=x^3-9x-9,       P1=(-2,1),
    E2: y^2=x^3-189x+999,   P2=(6,9).

QL2 proves that both rational groups are torsion-free of rank one and
that d_i=[E_i(Q):Z P_i] is finite and prime to five. QL1 also proves
that log_(E_i)(P_i) is nonzero and has valuation one.

For any Q in E_i(Q) define the actual five-adic coefficient

    m_i(Q)=log_(E_i)(Q)/log_(E_i)(P_i).

Then m_i(Q) belongs to Z5. If E_i has good reduction at thirteen and
its reduced group has order fifteen, one has

    [3]red_13(Q)=[m_i(Q) mod5] [3]red_13(P_i).          (SM2)

The bracket on the right means multiplication by any integer representative
of the displayed F5 residue. The point [3]red_13(P_i) is killed by five,
so the choice of representative does not affect it.

Proof. The finite quotient of order d_i is killed by d_i. Hence there is
an integer a with [d_i]Q=[a]P_i. Apply the additive logarithm to get
m_i(Q)=a/d_i. Since five does not divide d_i, this rational number is
five-adically integral. Good reduction is a group homomorphism. Multiplying
the reduced relation by three gives

    [d_i][3]red_13(Q)=[a][3]red_13(P_i).

Both points are killed by five, because the reduced group has order fifteen.
Multiplication by d_i is invertible on such a group. Taking its inverse
modulo five gives SM2, and a/d_i mod5 is exactly m_i(Q) mod5.
No value in Q5 is reduced modulo thirteen in this argument: the connection
is the single integer relation in the global rational group. No saturation
at thirteen and no assertion d_i=1 are used. QED.

## SM2. The complete obstruction over F13

The quotient maps are the actual projective morphisms

    R1=((z^2-9)/4,W/8),
    R2=((33-9/z^2)/4,-9W/(8z^3)).

Their reductions modulo thirteen satisfy

    no X in C(F13) has [3]R1(X)=O and
             [3]R2(X) in {(11,2),(11,11)}.           (SM3)

Both reduced elliptic groups have order fifteen, and

    [3]red_13(P2)=(11,2),       -[3]red_13(P2)=(11,11).

Here is a complete finite proof, with O denoting the elliptic origin.
The discriminants of the two short models are respectively 3 and 9
modulo thirteen, so both are nonsingular. Their finite abscissas and
ordinates, in addition to O, are

    E1: (0,+/-2),(1,+/-3),(3,+/-2),(6,+/-6),
        (10,+/-2),(11,+/-1),(12,+/-5);
    E2: (3,+/-2),(5,+/-6),(6,+/-4),(8,+/-5),
        (9,+/-1),(11,+/-2),(12,+/-2).

These lists result from testing every abscissa 0 through 12 and every
ordinate in F13. Thus each group has exactly fifteen points.

The reduced sextic is F=z^6+12z^4+8z^2+4. The exact polynomial identity

    (10+8z^2)F+(6z+3z^3)F'=1 in F13[z]

proves squarefreeness over the algebraic closure, not merely the absence
of repeated F13 roots. Its monic even-degree projective model is smooth
also at its two infinities. The complete projective quotient-projection
table is as follows; every coordinate is a residue modulo thirteen.

| X on C | [3]R1(X) | [3]R2(X) |
|---|---|---|
| (0,2) | (3,11) | O |
| (0,11) | (3,2) | O |
| (1,5) | (3,11) | (11,2) |
| (1,8) | (3,2) | (11,11) |
| (3,3) | (11,1) | (11,11) |
| (3,10) | (11,12) | (11,2) |
| (6,3) | O | O |
| (6,10) | O | O |
| (7,3) | O | O |
| (7,10) | O | O |
| (10,3) | (11,1) | (11,2) |
| (10,10) | (11,12) | (11,11) |
| (12,5) | (3,11) | (11,11) |
| (12,8) | (3,2) | (11,2) |
| infinity+ | O | (8,8) |
| infinity- | O | (8,5) |

The fourteen affine points exhaust the same thirteen-by-thirteen direct
enumeration. At z=0, R2=O and R1=(-9/4,W/8). At infinity with sign e,
R1=O and R2=(33/4,-9e/8). Thus all displayed exceptional values are
actual values of the projective morphisms. The usual finite-field chord
and tangent formulas give the table and the value of [3]P2. Inspection
of the six rows with [3]R1=O proves SM3.

Every rational point of C reduces to one of these sixteen points, and
its quotient images reduce to the displayed images. This can be checked
without an affine-denominator assumption. If z is thirteen-adically
integral, W is integral. When z reduces to zero, the second quotient
has negative x-valuation and reduces to O; its first quotient is regular.
If z has negative valuation, q=1/z has positive valuation and
v=Wq^3 reduces to +1 or -1; the quotient limits are precisely the two
infinity values just given. In every remaining case the displayed
denominators are units. Hence the table applies to all rational points.

The complete exact certificate is
`next_verification/thirteen_sieve.json`, produced and independently checked
by `next_replay_thirteen_sieve.py`. It includes the smoothness Bezout
identity, both entire elliptic point lists, all sixteen curve points, both
quotient images, their projections and both forbidden signs. Its SHA256 is
`46adefa954c349500510973f452e551ab82125bfc3d5ade6a6ab0efba65515da`.
No probable-prime test, missing cofactor or numerical logarithm is used.

## SM3. Eliminate the four remaining local points

The preceding ordinary analytic certificates prove that f=F0-Omega has
exactly ten distinct Q5 zeros on the complete curve:

* UD: eight simple zeros on the four disks over z=+/-1 modulo five,
  including the four rational points (+/-1,+/-8);
* SU: no zeros on the four disks over z=+/-2 modulo five;
* ZD: no zeros on the two disks over z=0 modulo five;
* IF: exactly the two rational infinity points, each a double zero.

DS proves that these four orbits exhaust all twelve residue disks. These
are full restricted-series tail and root arguments; finite sampling alone
is not the input to the present sieve.

Every rational point on the finite nonzero chart must be among these
zeros, by LH and the rank-one height identity QL7. The z=0 fiber has no
rational point, since W^2=-9. The rational infinity points are already
included and were treated directly in IF2.

It remains to exclude the four extra zeros from UD. Take its representative
on z=1+5s, W(1)=8, with s=4 modulo five. The complete UD congruences are

    ell_1/5=4+4s mod5,       ell_2/5=3+s mod5,
    log_(E1)(P1)/5=4 mod5,  log_(E2)(P2)/5=2 mod5.

At this zero they give

    m_1(R1)=0 mod5,       m_2(R2)=1 mod5.              (SM4)

Under the two DS involutions, either both quotient points change sign or
only the second does. Thus all four extra zeros have coefficient pairs
(0,1) or (0,-1) modulo five.

Suppose one of these extra local zeros were rational over Q. Apply SM2
to its two actual rational quotient points. Their reductions would satisfy
[3]R1=O and [3]R2=+/-[3]P2, contradicting the complete table SM3. Thus none
of the four extra zeros is rational. This excludes all remaining candidates.

Conversely the four displayed finite points satisfy the sextic equation
because its value at z=+/-1 is 64. Both infinity points are rational
because the leading coefficient is one. Therefore all six points in SM1
exist, and no others do. This proves the claimed fixed rational locus. QED.

The complete inverse to the original same-source problem, its second square
and positive real conditions are separate subsequent checks. The ordinary
classification above also depends on the explicitly identified height,
rank, saturation and analytic arguments, which have not been formalized
as a complete Lean chain. It does not settle any varying-exponent or
varying-residual uniform bound required for ABC.
