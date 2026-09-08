# Actual three-phase arithmetic behind JP

Ordinary proof, prepared before formalization. This is an arithmetic refinement
and a precise formalization boundary for the reviewed JP result; it is not a
new cross-prime saving or a closure of the ABC tail.

For an Eisenstein pair z=(a,b), let N(z)=a^2+ab+b^2 and
R(z)=(-b,a+b). For two pairs z,w set

    x=det(z,w), y=det(z,R^2(w)), D=det(z,R(w)).

Direct substitution gives D=x+y and N(z)N(w)=x^2+xy+y^2.
In particular all three determinants are the actual three arms of one
additive relation. The discriminant identity is

    4(N(z)N(w))^3 - 27(x*y*D)^2
      = ((x-y)*(2*x+y)*(x+2*y))^2 >= 0.             (PB1)

This follows by expanding the displayed polynomial, with no asymptotics.
Consequently, if an integer m divides x*y*D and

    4(N(z)N(w))^3 < 27*m^2,                       (PB2)

then x*y*D=0: otherwise m^2 divides its positive square, whose size by
PB1 and PB2 is strictly below m^2, impossible. Thus one phase determinant
vanishes. This uses an exact joint bound, instead of separately bounding
the three absolute determinants; it changes constants, not the exponent
of the required combined precision.

For finitely many pairwise coprime integer moduli m_i, suppose each m_i
divides at least one of x,y,D. Then every m_i divides their product and
coprimality gives product_i m_i | x*y*D. This remains valid when phases
differ between primes. No common phase is assumed.

To obtain a finite capacity theorem, let A be any finite set of actual
products represented by pairs z_u, and let f_i:A->H_i be finite maps.
Assume collision at coordinate i forces m_i to divide one of the three
actual phase determinants for z_u,z_v. Assume also that a zero phase
determinant forces u=v and that PB2 holds for every pair u,v with
m=product_i m_i. Then the joint map u |-> (f_i(u)) is injective: equality
at all coordinates gives divisibility by the product modulus, PB1 forces
a zero determinant, and phase separation identifies u,v. Therefore

    |A| <= product_i |H_i| <= n^(number of i)

whenever every |H_i|<=n. In the ordinary JP proof these hypotheses are
supplied by actual products, quotient independence, the modular reduction
and the finite n-torsion bound. A formal theorem taking those hypotheses
as arguments does not itself formalize their arithmetic construction.

The finite-kernel independence step can also be stated without choosing
any prime: if the group homomorphism phi:G->H has kernel killed by three, a privately valued
independent signed-product family remains independent after phi. Indeed
equality of two images gives (A_x/A_y)^3=1. Applying any private valuation
to the torsion-free group Z gives 3*v_i(a_i)*(x_i-y_i)=0. Its nonzero
diagonal value forces x_i=y_i for every i.

No prime-label cardinality estimate, arbitrary-root coverage or ABC theorem
is inferred from these arithmetic statements. The determinant identity
also warns that applying an unproved radical bound to these three arms
would reintroduce an ABC-shaped problem.
