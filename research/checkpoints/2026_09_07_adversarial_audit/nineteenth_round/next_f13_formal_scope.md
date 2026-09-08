# F13 arithmetic kernel: ordinary scope fixed before implementation

This is a future-batch module. It does not modify the sealed 24-declaration release or its evidence.

Let F=ZMod 13. Use the literal sextic polynomial S=X^6−27X^4+99X^2−9 in Polynomial F and its literal evaluation. The first theorem required for smoothness evidence is the actual polynomial equality

    (C 10+C 8*X^2)*S+(C 6*X+C 3*X^3)*S.derivative=1.

This must not be replaced by testing equality only at the thirteen elements of F. Coefficient expansion proves the ordinary identity: in normalized coefficients S=X^6+12X^4+8X^2+4 and S'=6X^5+9X^3+3X; the product sum has constant coefficient one and every other coefficient zero modulo thirteen.

The finite predicates and proposed conclusions are the following exact ones, already independently checked over integer residues:

* The affine equation W²=S(z) has precisely fourteen pairs: z=0 with W=2,11; z=1,12 with W=5,8; z=3,6,7,10 with W=3,10. The separate infinity model epsilon²=1 has the two signs. A disjoint-sum data model therefore has exactly sixteen valid elements. It is not declared to be a formally constructed smooth projective curve.
* Each elliptic affine equation y²=x³+a*x+b for (-9,-9) and (-189,999) has fourteen solutions. Good reduction, the elliptic group, and the geometric extra infinity point remain ordinary interfaces.
* For z nonzero, the actual projections are x1=(z²−9)/4, y1=W/8, x2=(33−9/z²)/4 and y2=−9W/(8z³). Under the sextic equation they satisfy the corresponding elliptic equations. At z=0 the first projection is (-9/4,W/8) and the second is O. At infinity the first is O and the second is (33/4,−9epsilon/8). All surviving affine coordinates satisfy the respective equations.
* Define psi(a,b,x)=3x^4+6ax²+12bx−a² and d4(a,b,x)=x^6+5ax^4+20bx³−5a²x²−4abx−8b²−a³. Define phi(a,b,x)=x psi²−8(x³+ax+b)d4. The substitution y²=x³+ax+b proves phi=x psi²−(4y d4)(2y). These are literal third-division x-coordinate polynomials.
* For every actual affine sextic pair with z nonzero, psi(-9,-9,x1)=0 implies phi(-189,999,x2)−11psi(-189,999,x2)² is nonzero. The four actual antecedent rows have value 12. At z=0 the first psi is 7. At infinity the second numerator is 9. These facts exclude both signs of the target x=11.
* A combined finite predicate uses first-psi-zero on the affine chart and True at infinity; its second-target predicate is False for z=0, the numerator equality for z nonzero, and the numerator equality at x=33/4 for infinity. No valid finite-model element satisfies both. This is an arithmetic predicate theorem, not a claim that abstract elliptic multiplication or geometric reduction has been formalized.

Use ordinary `decide`, finite case analysis and algebraic tactics to generate kernel-checked proof terms. No native_decide, sorry, new axiom or opaque oracle is permitted. Every theorem must have its own printed axiom query; only propext, Classical.choice and Quot.sound are allowed. Polynomial assertions must be polynomial identities, whereas the finite field predicates can be proved by exhaustive kernel evaluation.

The proof will use an independent fresh module and existing pinned Lean 4.32.0 / Mathlib 81a5d257c8e410db227a6665ed08f64fea08e997 cache, with no old project module import. Compiler and input bytes, every query and full log will be bound in a new per-run record. Failed runs must remain distinguishable from success.

Not formal claims: construction of a projective curve; equivalence to Mathlib's elliptic group [3]; a p-adic logarithm, height, zero certificate or reduction map; the global prime-to-five index; completeness of the rational locus; ABC. The ordinary division-polynomial and global 5/13 bridge connect these finite facts to the already separately proved rational-point theorem. They are not inserted as axioms or implicit hypotheses here.
