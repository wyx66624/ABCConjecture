# Identifying the boundary descent through a fixed Tate-module prime

Status: ordinary proof passed both other research agents' full
independent reviews of BM1--BM4 and the primary-source chain,
2026-09-07. The sixth-round BS manuscript remains frozen. This note
addresses its explicit boundary-form membership premise. It does not
prove a Frey--Mazur assertion or a global pure-power seed family.

Put K=Q(r), r^2=-3, and

    E0: Y^2=X^3+12X^2+6(3+r)X.

The sixth-round two-Frobenius argument proves that E0 is geometrically
non-CM. The same explicit two-isogeny as for the actual family makes
it a Q-curve: its two-isogenous curve is the (-2)-twist of its conjugate.
Fix the finite order-four Hecke character chi used in FM5 and BS4.
Its square is the restriction of psi_3=(12/.) to G_K, and its
conjugation relation cancels the character of the two-isogeny.

## BM1. A finite-character comparison lemma

Let H be a finite-index normal subgroup of a group G. Let rho1,rho2
be two-dimensional representations over an algebraically closed field
of characteristic zero whose restrictions to H are isomorphic and
absolutely irreducible. Then

    rho2 = rho1 tensor nu

up to isomorphism, where nu is a character of G/H.

Proof. Identify their restrictions to H. For g in G, the matrix
rho2(g) rho1(g)^(-1) commutes with rho1(H), because H is normal.
It is scalar by Schur's lemma. Denote that scalar nu(g). The
representation laws imply nu(gg')=nu(g)nu(g'), and nu is1 on H.
Since G/H is finite, its values are roots of unity. For continuous
Galois representations this is a finite continuous character. Over
G_Q it is therefore the character of a Dirichlet character.

## BM2. The specified descent is modular in weight two

Fix ell=17. The conjugation relation of chi and the isogeny give an
extension rho_tilde of V17(E0) tensor chi from G_K to G_Q, by the
Schur-normalization argument in the proof of Pacetti--Villagra
Torcomian Theorem4.2. There are two extensions, differing by psi_-3.
Both are odd and have determinant psi_3 times the17-adic cyclotomic
character. Only the representation argument is used: the source's
different Diophantine equation and its displayed conductor are not
substituted for the actual E0 conductor.

**Claim BM2.** Either such extension is the17-adic representation
of a characteristic-zero weight-two newform of nebentypus psi_3.

Proof. Ribet's Theorem6.1 constructs a primitive abelian variety A
of GL2-type over Q and a finite Galois extension L/Q such that
A_L is isogenous to a power of E0. Enlarge L to contain K and to
kill chi. Khare--Wintenberger Corollary10.2(i), the completed
modularity theorem for GL2-type varieties, makes A modular. Choose
one of its two-dimensional coefficient-field components at17,
denoted rho_A. It comes from a weight-two newform f_A.

Over G_L, rho_A is isomorphic to V17(E0) after extending scalars.
Indeed, V17(A)|G_L is a direct sum of copies of V17(E0), and the
chosen coefficient component has dimension two. Faltings'
semisimplicity and endomorphism theorem, together with
End_L(E0) tensor Q=Q, imply that V17(E0)|G_L is absolutely
irreducible. The same description holds for rho_tilde|G_L because
chi is killed there. BM1 therefore gives

    rho_tilde = rho_A tensor nu

for a finite Dirichlet character nu. Twisting a weight-two newform
by a finite Dirichlet character gives a weight-two eigenform; take
its primitive newform constituent f. Its representation is exactly
rho_tilde, so its determinant identifies its nebentypus as psi_3.
There is no nonzero Tate twist and no weight change. This proves BM2.

This argument fixes one Tate-module prime. It does not choose
unrelated extensions at different primes and then assume they form
a compatible system. Nor does it invoke the positive-seed large-image
theorem: E0 has no multiplicative prime greater than three.

For later use, the resulting modular form automatically supplies
compatibility. At every good prime of K outside a finite set its
restricted Frobenius polynomial equals that of E0 tensor chi, by
the17-adic isomorphism. These are equalities of algebraic numbers,
since the chosen embedding into Qbar17 is injective. The usual
compatibility for the elliptic curve, finite character and newform
then gives the same polynomials at any other auxiliary prime.
Chebotarev and semisimplicity consequently yield

    rho_f,ell | G_K = Vell(E0) tensor chi_ell

for every ell, up to scalar extension. Thus local statements at the
rational prime17 may be checked with ell=19. No crystallinity
descent theorem is needed to remove17 from the newform level.

## BM3. Recomputing the actual characteristic-zero conductor

The local Tate proofs FM1--FM4 apply at the boundary coordinates
a=0,b=1: all their needed polynomial identities and parity statements
hold, while non-CM has already been independently proved by BS1.
For clarity, the relevant local branches are exhibited here.

At the inert prime over2, translate X by R=1+r and Y by T=4.
With A=12, B=6(3+r), the transformed coefficients are

    a1'=0, a2'=15+3r, a3'=8,
    a4'=36+36r, a6'=-48+48r.

The integral basis1,zeta with zeta=(1+r)/2 gives valuations
v2(a2')=1, v2(a3')=3, v2(a4')=3, v2(a6')=5.
For example, a6'=96(zeta-1), whose last factor is a unit at2.
The discriminant has valuation12. The reviewed Tate branch has
first cubic Z^2(Z+b), b a unit, first starred quadratic with double
root zero, and next quadratic with unit linear coefficient a4'/8.
It is type I2*, minimal, of conductor exponent6.

At the prime r over3, v_r(3)=2. The original coefficients have
v_r(a2)=2, v_r(a4)=3, a1=a3=a6=0 and v_r(Delta)=9.
The reviewed Tate branch has successive zero multiple roots and
a4/r^3 a unit, giving type III*, minimal, conductor exponent2.
Good reduction holds at all primes above rational q>3.

The character chi is unramified at3 and has conductor exponent3 at2.
For the elliptic representation at2, potentially good reduction makes
inertia finite; its determinant is unramified. Hence the fixed-space
dimension of any inertia subgroup is either zero or two: a finite
determinant-one matrix fixing a nonzero vector is the identity.
The untwisted conductor6 therefore consists of tame codimension2
and Swan conductor4, with its only final upper break at2. The
character has upper break2 as well. Their tensor product is trivial
on upper groups with index>2, so its conductor is at most6.
The unramified extension K_2/Q_2 preserves that exponent. The
determinant psi_3 has conductor exponent2 at2, giving the lower
bound2. Write the resulting exponent as e, with2<=e<=6.

At3, the restricted elliptic representation has tame inertia and
no inertia invariants, because its conductor is2 and its reduction
is potentially good and additive. The extension K_3/Q_3 is tame;
the two wild inertia groups agree, so the descended representation
is tame as well. Its inertia invariants are contained in the zero
invariants of the restriction. Thus its conductor exponent is
exactly2. This holds for either of the two descents.

For any q>3, take an auxiliary ell different from q and use BM2's
compatible restriction. Both E0 and chi are unramified at q, and
K/Q is unramified there, so the descended representation is
unramified. Characteristic-zero newform conductor compatibility
now gives the exact level

    N=2^e*9,  2<=e<=6.                                    (BM3)

This is an assertion about the characteristic-zero conductor, not
an inference from a congruence or a bound for a residual level.

## BM4. Exact identification of the orbit and its limited consequence

The modular form in BM2 cannot have CM. A CM newform representation
becomes a sum of characters over a finite extension. Its restriction
there cannot be the absolutely irreducible Tate representation of
the non-CM curve E0; this contradicts BM2's restriction after enlarging
the finite field. Hence only non-CM orbits in (BM3) are eligible.

The independent exact PARI newspaces in the frozen sixth-round
certificate have just two such orbits, at288 and576. Their rational
a_13 values are4 and-4 respectively. BS4's exact fixed-character
calculation gives a_13=-4 for either descent:13 splits in K, so
the ambiguity psi_-3 does not change this value. Therefore the
descent belongs to the unique non-CM level576 Galois orbit.

The ordinary modularity/conductor proof and the complete finite
newspace enumeration are distinct dependencies. Identification now
uses membership proved in BM2--BM3; it is not inferred from a few
matching coefficients alone. The enumeration remains exact
software-assisted evidence, not a Lean formalization of modular forms.

The independently reviewed BM1--BM4 discharge the membership premise
of BS3 for this specific576 orbit. The particular
finite-state Mazur products described there have a zero factor at
every auxiliary prime. This still does not forbid additional global
cover constraints or prove that any positive seed has a global power
norm. The separately proved fixed-affine-slice finiteness provides
precisely a global restriction on the consecutive shadow family.

## Primary-source ledger and review status

Actually opened and inspected:

* Ribet, *Abelian varieties over Q and modular forms*, Theorem6.1
  and its construction on printed12--15, plus Proposition3.3:
  https://math.berkeley.edu/~ribet/Articles/korea.pdf .
* Khare--Wintenberger, *Serre's modularity conjecture I*, Theorem10.1
  and Corollary10.2(i), printed20--21. The latter explicitly gives
  modularity of primitive GL2-type abelian varieties:
  https://www.math.ucla.edu/~shekhar/papers/results.pdf .
* Pacetti--Villagra Torcomian, *Q-curves, Hecke characters and some
  Diophantine equations*, proof of Theorem4.2 for Schur-normalized
  extensions, oddness and determinant; not its equation-specific level:
  https://sweet.ua.pt/apacetti/papers/Q-curves.pdf .

Additional established inputs: Faltings semisimplicity and the Tate
endomorphism theorem; Dirichlet twisting of newforms; Chebotarev and
Brauer--Nesbitt; and characteristic-zero equality of newform conductor
with the conductor of its ell-adic representation away from ell.
The last equality is used with ell different from each tested prime.
All local Tate calculations and the finite exact enumeration already
have independent sixth-round records. Both other research agents
independently opened Ribet Theorem6.1 and its geometric-power
construction and Khare--Wintenberger Corollary10.2(i), and each passed
the full BM1--BM4 comparison, local conductor calculation and assembly.
No new Lean theorem is claimed.
