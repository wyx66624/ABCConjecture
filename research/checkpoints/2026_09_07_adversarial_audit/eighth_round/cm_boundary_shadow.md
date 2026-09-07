# An actual positive local shadow of the CM boundary

Date: 2026-09-07. Status: CB1--CB5 passed complete independent ordinary
reviews by independent_route, critical_bottleneck, and the root agent.
All independently reopened the original projective-image source and
the published N_3=7 input. This new note does not change the frozen
seventh round. It addresses a different boundary from the non-CM seed
(0,1).

Write K=Q(r), r²=−3 and retain the actual quartic F(a,b), first norm
N(a,b)=a²+ab+b², and the Frey curve

    E_ab: Y²=X³+12(a+b)X²+6[3(a+b)²+(a²+b²)r]X.

## CB1. An explicit CM boundary curve

At the non-positive boundary seed (a,b)=(−1,1), both N and F equal
one, and the curve is

    E_*: Y²=X³+12r X.

Its discriminant is −64(12r)³, which is nonzero and has support only
at primes above 2 and 3. It has j-invariant 1728. Over K(i), the map
(X,Y) -> (−X,iY) extends over the point at infinity, preserves the
curve equation and the origin, and squares to the elliptic negation
map. Thus the endomorphism ring contains Z[i]; this is the precise
CM property needed here. No modular-form membership follows merely
from this calculation.

If q≡7 mod12 is prime, then q splits in K and q≡3 mod4. At either
place above q, choose the corresponding root r_q²=−3 in F_q. For
f(X)=X³+12r_q X one has f(−X)=−f(X). The quadratic character of −1
is −1, so the terms of the sum of quadratic characters of f(X)
cancel in the pairs {X,−X}; the X=0 term is zero. Consequently

    #E_*(F_q)=q+1,   t_q(E_*)=0

at both split places, for every such q. This is an exact point-count
argument valid for all these primes, not an extrapolation from small
prime computations.

## CB2. Simultaneous positive primitive shadows

For every positive integer L and every height target T there are
positive coprime integers a,b with a+b>T satisfying

    (a,b)≡(−1,1) mod L,
    N(a,b)≡F(a,b)≡1 mod L.

Indeed take b=1 and a=Lk−1, where k is any sufficiently large positive
integer. Then a+b=Lk is arbitrarily large and gcd(a,b)=1. The two
polynomial congruences follow by evaluating at (−1,1). They also hold
modulo every divisor of L, so both norms pass every direct power-residue
test with any positive exponent at all these moduli, using root 1.

The Frey coefficients agree with E_* modulo L in Z[r]. In particular,
for any specified finite collection of rational primes q>3 and any
specified finite precision at each, choosing L divisible by those
prime powers makes the corresponding coefficient data agree. At all
included split primes the reductions are good and have exactly the
same Frobenius traces as E_*. At the included primes q≡7 mod12 the
traces are therefore zero by CB1.

These are actual positive primitive integer seeds. The usual first
mixed seed (ab,N,(a+b)²) is also primitive: any prime dividing both
ab and N would divide both a and b. Its two defining square conditions
remain exact, as they do for every actual seed. Nothing in this
construction says that the integer F is a global perfect power.

## CB3. The exact limitation and its global complement

Thus the specific finite test consisting of direct norm power residues
and the trace-zero conditions at finitely many CM-inert split primes
cannot exclude all actual positive primitive seeds: CB2 gives an
unbounded family passing all of them. Even arbitrarily deep but finitely
specified polynomial coefficient congruences to this boundary have such
positive primitive lifts. This statement does not address tests on an
auxiliary descent cover, uniform global height arguments, all primes
simultaneously, or the full modular method.

It does not identify the specified fixed-character descent of E_* with
any of the remaining CM newform orbits; that would require a separate
modularity/character/conductor proof. Nor does it supply a residual
Galois-module isomorphism with E_* at any prime exponent.

The already proved actual SG1 theorem excludes a global square norm
for every seed of CB2, since b=1. Hence every even pure exponent is
impossible for this entire positive shadow family. The separately
reviewed effective affine-slice theorem bounds all global pure powers
F(a,1)=Q^g with Q>1, g≥2 to an effectively finite list, across all
exponents. That finiteness does not classify its odd-exponent members.
The local construction and these global obstructions coexist without
contradiction. CB1--CB3 alone do not decide any CM-orbit congruence
branch. The following separate global representation argument does.

## CB4. Actual global congruences to CM forms are impossible for p>7

**Theorem.** Let a,b be positive coprime integers and p>7 a prime.
Take the specified residual descent of E_ab[p] times the fixed character
chi used in FM5--FM7. It is not isomorphic, even after extending residue
coefficient fields, to the semisimplified residual representation of
any characteristic-zero CM newform. This applies independently of a
power factorization of F and of the weight of the candidate newform.

**The exact large-image input.** The actual positive seed satisfies
F>=13 and gcd(F,6)=1, so F has a prime divisor q>3. The proved FM
calculation makes E_ab multiplicative at the places over q, and its
explicit cyclic isogeny to its conjugate has square-free degree two.
Thus the general Q-curve theorem, with the already source-reviewed
N_3=7 improvement in FM5, applies to this actual curve.

The projective target in this theorem is important. Ellenberg's
author-hosted original paper, Theorem 3.14 (PDF page 15), explicitly
uses the projective extension

    P rhobar_E,p : G_Q -> PGL_2(F_p),

and gives its surjectivity unless E has potentially good reduction at
every prime outside 6. The multiplicative place excludes that
alternative. Pacetti--Villagra Torcomian, Theorem 5.2 (PDF page 28),
states the general multiplicative-prime criterion with N_3=7. This is
the same published general input already used in FM5, not a theorem
about a substituted nonprimitive generalized Fermat triple. Its
small-prime numerical improvement remains a cited external input.

On restricting this surjective projective representation to G_K, its
image H is a normal subgroup of index at most two in PGL_2(F_p). It
contains PSL_2(F_p): any quotient of order at most two kills commutators,
while PSL_2(F_p) is perfect for p>3. To see the latter directly, SL_2
is generated by upper and lower elementary unipotents; choose t in
F_p^* with t²!=1, and write an arbitrary upper unipotent U(x) as

    [diag(t,t^(-1)), U(x/(t²−1))].

The analogous lower-unipotent formula proves perfectness of SL_2 and
then of its projective image. This projective subgroup is nontrivial
and therefore not solvable. Thus H is not solvable. In particular no
claim that the image over G_K itself must be the full PGL_2 is needed.

**The CM side.** A characteristic-zero CM newform has its two-dimensional
Galois representation induced from a one-dimensional character of the
absolute Galois group of its imaginary quadratic CM field M. This
standard CM representation description is also explicitly invoked in
Section 6 of the same primary Q-curve paper. An induced stable lattice
can be chosen in the two cosets of G_M. After reduction modulo a prime
above p, its restriction to G_M is diagonal, and the other coset acts
by an antidiagonal matrix. The resulting semisimplification is either
irreducible and of this same monomial form, or a direct sum of two
characters. Indeed if the two residual inducing characters coincide,
the induced module splits because the quotient has order two and p is
odd; otherwise it is irreducible. Consequently its projective image
is cyclic-by-a-group-of-order-at-most-two, or abelian, and is solvable.
The diagonal projective image is finite cyclic because it is a finite
subgroup of the multiplicative group of the algebraic closure of F_p.
This reasoning is unchanged by coefficient embeddings or scalar twists.

If a candidate residual isomorphism existed, restrict it to G_K. The
scalar chi disappears after projectivization, leaving the nonsolvable
image H on the actual side, but a subgroup of a solvable projective
image on the CM side. This contradiction proves the theorem. The
actual irreducibility supplied by the large-image input also shows
that there is no distinction here between the actual module and its
semisimplification.

This proof uses the uniform large projective-image theorem. The bare
fact that an individual elliptic curve has no geometric CM would not
by itself justify the residual exclusion for every p>7.

## CB5. What remains in the pure modular branch

If an actual seed satisfies F=Q^p with p>7, the proved FM5 modular
reduction supplies a weight-two newform with character psi_3 at one
of the levels 36,72,144,288,576. The independently repeated complete
exact PARI newspace enumeration in the sixth round lists only two
non-CM Galois orbits: one at 288 and one at 576. CB4 therefore leaves
precisely these two possible orbits, without selecting between them.
Their complete coefficient-embedding ambiguity remains part of the
candidate set. The boundary identification and BC4 already treat
the 576 orbit while retaining chi versus chi^{-1} correctly.

CB4 also excludes CM forms from the varying-level and non-flat-weight
FM6/FM7 reductions. It does not turn those varying spaces into the
same two-element list; that last list requires the pure branch and
its five fixed levels. Neither non-CM orbit in the pure branch is
excluded here, and no uniform height bound or ABC statement follows.

The finite shadows in CB2 remain valid. They show that the specified
finite local tests miss a global projective-image obstruction, which
now rigorously excludes the CM residual candidate route. They do not
undermine the obstruction, nor do they rule out different global
modular approaches to the surviving non-CM branches.

## Primary sources reopened for CB4

* Jordan Ellenberg, [Galois representations attached to Q-curves and the
  generalized Fermat equation A^4+B^2=C^p](https://people.math.wisc.edu/~ellenberg/A4B2Cp.pdf),
  Theorem 3.14 and the earlier definition of its G_Q projective
  representation. The theorem's displayed target PGL_2(F_p) was
  independently checked in the original author-hosted PDF.
* Ariel Pacetti and Lucas Villagra Torcomian,
  [Q-curves, Hecke characters and some Diophantine equations](https://sweet.ua.pt/apacetti/papers/Q-curves.pdf),
  Theorem 5.2, and Section 6's distinction between CM-induced projective
  images and the surjective image. The N_3=7 source chain is the same
  one independently checked in the sixth-round FM proof.

## Exact finite supplement

`replay_cm_shadow.py` was actually run to write its canonical JSON and
then independently rerun with `--check`. Both executions returned PASS.
The script enumerates every affine point at both K-places over
q=7,19,31,43,67,79,103,127: sixteen field rows and 81,376 tested
affine states. It also checks thirty-two actual positive primitive
shadows, their integer polynomial congruences, both inverse square
identities and mixed primitivity. These finite rows supplement CB1--CB3;
they do not prove CM newform membership, a residual congruence, or CB4's
global-image obstruction.

`cm_shadow_results.json` uses canonical UTF-8 LF bytes, SHA256
`a244f2e71b150a6e8076f86e22abea176f82e1348527e760fb4d79c23e2f09bd`.
