# CU1--CU4. Actual pure-cube selectors using a proved low-degree squarefree theorem

Next-only complete ordinary candidate, 2026-09-07. This is separate from
the sealed LM publication and from NP's elementary exponent-two proof.
Here an unconditional published squarefree-value theorem is an explicit
input. Its hypotheses are checked on the actual polynomial after all
marked exceptions have been removed. Its constants are not uniform in
moving packets. No ABC conjecture is used as an input.

## CU1. The actual primitive cube and all irreducible factors

Let k>=1 be an integer, put a=3k, and write

    (a+zeta)^3=A+C zeta,
    A=a^3-3a-1,       C=3a(a+1),
    c=A+C=a^3+3a^2-1.

These are positive primitive coordinates. Their entire boundary is

    T_3(k)=3a(a+1) f(a) g(a),
    f(a)=a^3-3a-1,    g(a)=a^3+3a^2-1.                (CU1)

The two displayed cubics are distinct irreducible polynomials over Q,
each of discriminant 81. The complete product a(a+1)f(a)g(a) is
squarefree over Q. Modulo every prime p>3 it has eight or fewer
distinct simple roots and no repeated roots over an algebraic closure.

Proof. Multiplication using zeta^2=zeta-1 gives the formulas. For
a>=3 all three arms are positive. A is coprime to a and a+1,
since its residues are -1 and 1 respectively. It is also -1 modulo
three because a=3k. Thus gcd(A,C)=1, and all three arms are pairwise
coprime. The root norm a^2+a+1 is one modulo three. As in NP1,
N(a+zeta)^3=A^2+AC+C^2 proves that every prime dividing T_3(k)
is a unit for the actual root norm.

The rational-root test at +/-1 proves irreducibility of each monic
cubic. Their discriminants from the cubic formula are both 81.
The difference g-f=3a(a+1), and the values of f at zero and minus
one are -1 and 1. Thus they cannot have a common root modulo p>3;
neither shares a root with a or a+1 there. The discriminants ensure
that each cubic is separable modulo such a prime. This proves the
full squarefreeness and root claims, not just those of one factor.
Substitution a=3k preserves them outside three. QED.

## CU2. Freeze arbitrary finite exact different-owner packets

Fix a finite nonempty set S of primes q>7. For each q choose an
actual positive owner index k(q) with e_q=v_q(T_3(k(q)))>=1.
The root norm is automatically a q-unit by CU1. Choose a positive
integer k0 by CRT such that

    k0=k(q) mod q^(e_q+1)  for all q in S.

Let E=S union {2,3,5,7}. Put

    F_p=v_p(T_3(k0)) for p in E,
    K=product_(p in E) p^F_p,
    H=product_(p in E) p^(F_p+1),
    k_j=k0+Hj for j>=1.

All primitive outputs (3k_j+zeta)^3 are exact pure cubes. Their
depths at every p in E are exactly F_p, including e_q at the
marked primes. In particular the full marked signed contribution
is sum_(q in S)(e_q-3)log q, including the negative terms.

The actual quotient polynomial

    G(J)=T_3(k0+HJ)/K                                 (CU2)

belongs to Z[J], is nonconstant and squarefree over Q, and has no
fixed prime divisor. Each of its irreducible factors has degree at
most three.

Proof. The extra digit of each congruence preserves the exact actual
valuation. It gives F_q=e_q, so H is a multiple of the marked CRT
modulus. The same argument at every p in E proves all the frozen
depths along the progression.

For integrality of CU2, the constant coefficient T_3(k0) is divisible
by K, and every nonconstant coefficient of T_3(k0+HJ) is divisible
by H, hence by K. This follows by expanding each integer monomial;
no integer-valued-polynomial inference is needed. For p in E,
H/K has positive p-valuation and T_3(k0)/K is a p-unit. Consequently
G(J) is a fixed nonzero constant modulo p.

For p outside E, K, H and 3 are units. The affine substitution is
invertible, and CU1 shows that G modulo p is a nonzero squarefree
polynomial of degree eight, with at most eight roots. Since p>=11,
it cannot vanish on all residue classes. Thus no prime is a fixed
divisor. The nonzero affine substitution and scalar division preserve
the squarefreeness and factor degrees over Q. QED.

## CU3. Positive density and a complete signed identity on actual pure cubes

For the fixed data in CU2, there is a set G_good of positive integers
of natural density

    d=product_p(1-rho_G(p^2)/p^2) >= 1/5,              (CU3)

such that for EVERY j in this set,

    T_3(k_j)=K R_j,  R_j squarefree, gcd(K,R_j)=1.

All prime divisors of R_j lie outside E. The full signed identity is

    J((3k_j+zeta)^3)
       =-2log T_3(k_j)+3log(K/rad(K)).                 (CU4)

As j in G_good tends to infinity,

    J/log c -> -16/3,          log rad(T_3)/log c -> 8/3.
                                                               (CU5)

In particular every good output satisfies the explicit bound

    c <= 2 (K/rad(K))^(3/8) rad(T_3)^(3/8).            (CU6)

Proof and precise external input. Apply Booker--Browning,
"Square-free Values of Reducible Polynomials", arXiv:1511.00601v3,
Theorem 1.2, printed page 4 (equation (2) defines rho). For a
nonconstant squarefree polynomial G in Z[J] with no fixed prime
divisor and each irreducible factor of degree at most three, it states

    sum_(1<=j<=X) mu^2(G(j))
       = X product_p(1-rho_G(p^2)/p^2)+O_G(X/log X).

The authors assume no fixed prime divisor from the opening setup;
CU2 checked that assumption explicitly, in addition to every other
polynomial hypothesis. The result is unconditional. Its proof uses
proved low-degree large-square estimates (Section 4), not an ABC
assumption. We do not replace that theorem's large-prime tail by an
unjustified elementary degree-eight union bound.

At p in E, rho_G(p^2)=0 because G is always a p-unit. Outside E,
the at most eight simple roots from CU1 lift uniquely, so
rho_G(p^2)<=8. Hence

    sum_(p not in E) rho_G(p^2)/p^2
       <=8 sum_(m>=11)1/m^2
        <8 integral_10^infinity x^-2 dx=4/5.

The elementary product lower bound gives CU3. Take G_good to be
the indices with G(j) squarefree. Positivity of the original factors
ensures G(j)>0 for j>=1. Its primes avoid E by the exact freezing,
so R_j=G(j) has all the asserted properties. The radical identity
rad(T_3)=T_3/(K/rad(K)) proves CU4, retaining every finite-depth
exception and every unmarked negative contribution.

Now log T_3=8log j+O(1) and log c=3log j+O(1), proving CU5.
For a>=3, f(a)>=a^3/2, g(a)>=a^3 and 3a(a+1)>=3a^2, so
T_3>=a^8. The first bound follows from a^3-6a-2>=0 on a>=3.
Also c=a^3+3a^2-1<=2a^3. Eliminating a and using the radical
identity proves CU6 for every good index. QED.

The constant in the asymptotic theorem depends on the fixed polynomial
G. Here its coefficients depend on the entire marked packet and its
CRT representative. The positive density is in the fixed parameter
progression (and has density d/H among all positive root indices),
not a uniform density in a moving prime-index block.

## CU4. Actual inputs and positive-depth examples without a prime-value conjecture

At k=1 and k=2 the primitive triples are respectively

    (A,C,c)=(17,36,53),       (197,126,323).

The primes 53 and 197 are prime by trial division up to their square
roots, and give different owners: the first root has no hit at 197,
and the second has no hit at 53. These are actual nonempty packets
for CU2, and hence already produce infinitely many selected pure
cubes under CU3.

Arbitrarily large FIXED positive depths at these two primes are also
available. At k=1 the c factor has derivative 135, a unit modulo 53,
and the other two arms are units there. At k=2 the A factor has
derivative 315, a unit modulo 197, and the other arms are units.
For either simple root, the expansion

    F(r+q^j u)=F(r)+q^j u F'(r) mod q^(j+1)

gives exactly one lifting digit which retains the root, and q-1
digits which give exact depth j. Lift to depth e and choose a
nonroot next digit to obtain any specified exact e>=1. Afterward
CRT may additionally require the 53-owner to be 1 modulo 197 and
the 197-owner to be 2 modulo 53. These extra coprime congruences
ensure that each marked prime still has only its stated owner.
Choose positive representatives. Thus, for example, depths four
and five give the positive marked cost log 53+2log 197, and CU3
supplies actual pure cubes with that fixed cost and complete new
negative support. No infinite prime-value conjecture is required.

The preserved residual coefficient is one and the exponent is three;
the previously used unit-residual parameter lambda=1/n is therefore
fixed at 1/3. It does not approach zero. This is a fixed low-degree
nonlinear construction, and does not prove a uniform tail budget for
the original n>324 prime, B=n^4 family. The squarefree theorem cannot
be invoked on an arbitrary changing exponent without verifying all
irreducible factor degrees and the dependence of its constants.
Other roots, the exceptional and independent-domain complements,
general residuals, and complete ABC coverage remain open.

## Primary source actually opened

Booker--Browning, Discrete Analysis 2016:8, arXiv:1511.00601v3:
https://arxiv.org/pdf/1511.00601 . The opening setup on printed page 1,
Theorem 1.2 on printed page 4, the fixed discriminant/resultant
dependence immediately after it, and the large-square decomposition
in Section 4 were read directly. This note invokes the stated
unconditional theorem; it does not claim a new proof of its deep
cubic squarefree input, a new finite experiment or a Lean result.
