# Independent audit of the actual three-phase bridge

Status: full ordinary review PASS. Source is root's
`../../2026_09_07_joint_packets_and_jacobians/ordinary_phase_bridge.md`.
This record concerns the ordinary proof and its proposed formal interfaces,
not any subsequently generated Lean source.

The actual rotation R(a,b)=(-b,a+b) gives D=x+y, and direct substitution
gives N(z)N(w)=x^2+xy+y^2. The displayed discriminant identity has the
correct minus sign and constants 4 and 27. A nonzero product divisible
by an integer m has squared size at least m^2, contradicting the strict
height hypothesis and that identity. The case m=0 cannot satisfy the
strict hypothesis, since the norm product is nonnegative.

For finitely many pairwise coprime integer moduli, each modulus dividing
one of the three phases implies their product divides the product of all
three phases. The phase may differ at every modulus; the proof does not
assume a common choice. The injectivity conclusion then uses the explicit
zero-phase separation hypothesis. The target cardinality is the product
of the coordinate cardinalities, at most n^s, rather than at most n.

The final finite-kernel paragraph now explicitly says group homomorphism.
Equality of its two images makes the quotient a three-torsion element;
each private integer valuation annihilates that torsion and its nonzero
diagonal forces equality of the corresponding signed exponents. Negative
diagonal valuations are allowed.

The source accurately leaves actual modular reduction, the finite torsion
groups, private valuation witnesses, product-height estimates and
zero-phase separation as arithmetic constructions to be supplied in an
application. A finite theorem accepting these hypotheses does not prove
those constructions, nor a prime-label count or a global tail estimate.
The improved joint discriminant bound changes a constant, not the
required exponent of product precision or the n^s capacity.
