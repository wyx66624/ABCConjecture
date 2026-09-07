# A non-CM boundary curve and its actual local shadows

Date: 2026-09-07. BS1--BS3 passed independent ordinary review by the
critical and independent-route agents, including separate exact replays.
The root-window TeX is frozen and unchanged. This note concerns one
specific modular elimination step, not the viability of the modular
route or the existence of a global pure-power seed family.

## BS1. An exact non-CM boundary object

Specialize the actual Frey curve at the excluded boundary seed (0,1):

    E0: Y^2=X^3+12X^2+6(3+r)X,  r^2=-3.

Here F(0,1)=1. Its discriminant is 2^11*3^4*(3+r), so it has good
reduction at every rational prime greater than three. Exact point counts
are

| Residue field | Image of r | #E0 | Frobenius trace | Discriminant |
|---|---:|---:|---:|---:|
| F25 | quadratic generator | 34 | -8 | -36 |
| F7 | 2 | 12 | -4 | -12 |
| F7 | 5 | 4 | 4 | -12 |

These are full finite-field enumerations, including the point at infinity,
in `replay_boundary_shadow.py`. In F25 the polynomial r^2+3 is
irreducible and all 25 field elements and all 625 affine pairs are
accounted for. The two prime-field enumerations contain all 49 pairs
each. They determine the exact characteristic polynomials of Frobenius.

**Theorem BS1.** E0 has no complex multiplication over the algebraic
closure of Q.

Proof. Fix the auxiliary Tate-module prime ell=17. Suppose that its
geometric endomorphism algebra is an imaginary quadratic field M.
Then M tensor Q17 embeds into End(V17(E0)). Its endomorphisms are
defined over some finite number-field extension. At a good place,
the resulting action therefore commutes with a positive power of the
original Frobenius matrix.

At the place of norm 25 the Frobenius eigenvalues are -4+3i and -4-3i.
Their ratio is (7-24i)/25. It is not a root of unity: it lies in Q(i),
whose only roots of unity are the fourth roots, and its real part is
7/25. At either place of norm seven the eigenvalues are plus or minus
2, together with plus or minus r; their ratio has real part 1/7. The
roots of unity in Q(r) are the sixth roots, with real parts in
{-1,-1/2,1/2,1}. Thus no positive Frobenius power has repeated
eigenvalues in either case.

Consequently each power has the same two-dimensional centralizer
as the original Frobenius matrix. The algebra M tensor Q17 must equal
that centralizer, by injectivity and equality of dimensions. At norm
25 the centralizer is Q17[T]/(T^2+8T+25), which is Q17 times Q17:
its discriminant is -36 and -1 is a square modulo17. At norm seven
it is Q17[T]/(T^2 plus or minus 4T+7), a quadratic field, since
its discriminant -12 has nonsquare unit part -3 modulo17. A product
algebra with nontrivial idempotents cannot be isomorphic to a field.
This contradiction proves the theorem.

The Tate-module injectivity and good-reduction Frobenius comparison
used here are standard structural results. They were independently
checked in Milne, *Elliptic Curves*, second edition, Proposition II.6.7
and Proposition V.8.3, in the author-hosted
[book](https://www.jmilne.org/math/Books/EC2.pdf). The proof above
does not require a database of CM curves or a probabilistic CM test.

## BS2. Unbounded positive seeds shadow every finite local test

**Theorem BS2.** Let L>=1 and H>=0 be integers. There exist positive
coprime integers a,b with a+b>H such that

    (a,b)=(0,1) mod L,
    (x,y,F)=(1,1,1) mod L,
    2x-y^2=(a-b)^2,

where x=a^2+b^2,y=a+b,F is the actual binary quartic. The same
seed passes every direct power-residue test F congruent to a g-th
power modulo every divisor of L, for every exponent g>=1.

Proof. Take any sufficiently large integer k>=1 and set
a=Lk,b=Lk+1. Their difference is one, so they are coprime and
positive, and their height is unbounded with k. Substituting their
residues proves all three congruences; the extra square is the exact
identity (a-b)^2=1. The residue F=1 is the g-th power of 1 for
every g. This proves all the quantified assertions simultaneously.

Since the Frey coefficients are integer polynomials in x and y, the
curve of this actual seed reduces to E0 at every prime ideal above
any q>3 dividing L. One can prescribe arbitrary finite precisions
by including powers q^e in L. Thus neither positivity, primitivity,
the inverse-square gate, nor arbitrary exponent power-residue tests
remove this local state. This does not assert F=Q^g over the integers.

## BS3. The exact limit on a particular Mazur product

Suppose a fixed descended eigenform f0 has been independently
identified with the E0 representation twisted by the fixed splitting
character. Consider a Mazur elimination product at an auxiliary
q>3 over all original seed residue states admitted by positivity,
primitivity, the inverse-square condition, and the direct F power
residue condition. If its local factors are the differences between
the compatible Frobenius traces of the candidate form and the
admitted curves, the residue state (0,1) contributes an exactly zero
factor. Consequently the product is zero at every such q. The
products at finitely many q cannot exclude f0, and BS2 supplies
simultaneous actual positive primitive shadows of those states.

This is a conditional statement about a specified, exactly identified
boundary form and a specified elimination procedure. It is not an
identification of E0 with a numerical candidate based on a few traces.
It does not obstruct auxiliary global covers, new local restrictions
proved from those covers, deformation arguments, or other modular
information. Nor does it give an actual small-residual pure-power
family. The need to distinguish local compatibility from a global
power equation remains the substantive boundary.

## BS4. A corrected character sign at thirteen

For the fixed d=3 character used in the Frey descent, the local unit
character theta on O/8 is specified by

    theta(zeta-1)=1, theta(r)=i,
    theta(3+2r)=1, theta(-1)=1.

This is precisely the d=3 case of the author-hosted
[Pacetti--Villagra Torcomian source](https://sweet.ua.pt/apacetti/papers/Q-curves.pdf),
Table3.3 and its following definition, which was independently opened.
The four generator orders are 3,4,2,2. Their 48 products are distinct:
reduce modulo two to remove the order-three factor; modulo four the
remaining r exponent must be even; its square is5 modulo eight, and
the zeta coefficient forces the (1+4zeta) exponent to vanish. The
remaining scalar factors 5 and -1 are independent. These products
therefore give all 48 units and the displayed assignment is a character.
It is trivial on the global units. Since r^2=5 modulo eight is1
modulo four but has theta=-1, its conductor is exactly eight.

The norm-thirteen generators pi=3+zeta and bar(pi)=4-zeta have

    pi=(zeta-1)(3+2r) mod8,
    bar(pi)=(zeta-1)^2*r^2*(3+2r) mod8.

Thus theta(pi)=1 and theta(bar(pi))=-1. At the corresponding primes,
r is respectively6 and7 modulo thirteen. Exact full point counts
are respectively18 and10, with traces -4 and4. Since the global
character is unramified away from two and is trivial on principal
ideles, chi((pi))=theta(pi)^(-1). Consequently both twisted traces
at thirteen are **-4**, not +4. Changing between theta and its inverse
does not change these two real signs.

The independently repeated PARI candidate list has two non-CM orbits,
at levels288 and576, with rational a_13 respectively4 and-4. Thus if
the E0 descent is proved to lie in that exact list, the character
calculation selects the level576 orbit. This is still a conditional
identification: a few matching coefficients alone prove no equality
of compatible Galois representations. In particular the positive-seed
large-image input cannot simply be applied to F(0,1)=1, which has
no multiplicative prime above three. A general modularity input for
this fixed non-CM Q-curve or a separate sufficiently-large-prime
argument is needed for an unconditional identification.

The source character and both signs were independently checked by
the independent-route agent. `replay_boundary_character.py` verifies
all48 units, all2304 multiplication pairs and both norm-thirteen
point counts. Its canonical JSON byte SHA256 is
`7eff33ce6623cca2544f5f4cd5c52a16d53a9cef8f0aa128903d800e7543c22a`.

## Exact finite evidence

`replay_boundary_shadow.py` gives the three full point counts and
sixteen illustrative actual simultaneous residue shadows. The latter
are checks of BS2's explicit formula, not substitutes for its proof.
Canonical results are UTF-8 LF in
`verification/boundary_shadow_results.json`, SHA256
`fecf29fe68b332d60cfdd3143f6a1639b335b5db94d3557b8ba41fa09862f5fa`.

Run `python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_boundary_shadow.py --check`
to recompute without rewriting the result. These are exact arithmetic
certificates of their finite scope; no Lean formalization is claimed.
