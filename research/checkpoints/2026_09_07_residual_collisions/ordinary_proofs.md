# Actual residual cancellation and congruence determinants

Date: 2026-09-07. These ordinary arguments precede the scoped Lean proofs.
The common notation and general collision results are proved in
`../2026_09_07_critical_bottleneck/next_global_tail.md` and independently
reviewed in `../2026_09_07_adversarial_audit/third_round/collision_review.md`.
This note records precisely the additional integer statements formalized here.

Write z=(a,b), N(z)=a^2+ab+b^2, P(z)=ab(a+b), with multiplication in
Z[zeta], zeta^2-zeta+1=0, and conjugation (a,b) -> (a+b,-b).
The Lean code imports the repository's original Eisenstein definitions.

1. Rational scalar multiplication gives P(mz)=m^3 P(z) by homogeneity.
   The exact product identity
   (v2 conjugate(v1))(v1 H)=N(v1)(v2 H)
   follows by associativity and v1 conjugate(v1)=N(v1).
2. If v1 H is primitive, N(v1) divides N(v1 H) and the latter is
   coprime to P(v1 H). Thus N(v1) is coprime to that boundary as well.
3. Apply the already proved exact boundary gcd identity to x=v1 H and
   multiplier y=v2 conjugate(v1). Using steps 1 and 2 cancels N(v1)^3
   and proves
   gcd(P(v1 H),P(v2 H))=gcd(P(v1 H),P(v2 conjugate(v1))).
   The formal statement needs only the first product primitive. It includes
   all integer signs, all primes, and zero second boundary.
4. For v=(a,b), w=(c,d), put det(v,w)=ad-bc and
   <v,w>=2ac+ad+bc+2bd. Direct expansion gives
   4N(v)N(w)-<v,w>^2=3det(v,w)^2.
   Multiplication by H has determinant N(H), so
   det(vH,wH)=N(H)det(v,w).
5. The three identities
   4N(a,b)-3a^2=(a+2b)^2,
   4N(a,b)-3b^2=(2a+b)^2, and
   4N(a,b)-3(a+b)^2=(a-b)^2
   bound every squared boundary arm by 4N/3. Similarly step 4 bounds
   3det(v,w)^2 by 4N(v)N(w).
6. If a nonzero integer d is divisible by an integer q, write d=qk.
   Then k is a nonzero integer, k^2>=1, and q^2<=d^2. Consequently
   q|det(v,w) and det(v,w)!=0 imply 3q^2<=4N(v)N(w).
7. Fix one of the three actual arms a, b, or a+b. If q divides that
   arm for both v and w, it divides det(v,w). For the sum arm this is
   the identity det(v,w)=(a+b)d-b(c+d); the coordinate arms are immediate.
8. If the same arm of both vH and wH is divisible by q, step 7 and
   step 4 show q|N(H)det(v,w). If gcd(q,N(H))=1, cancel N(H).
   Apply step 6 to obtain the actual annotated-arm norm inequality.
   This argument works for every integer modulus, not just prime powers.

The resulting Lean file has 15 declarations including its algebraic helpers.
It does not formalize the full CRT index, the nonassociate classification,
the lcm envelope GC9, any probability theorem, or a bound on private depth.
The determinant nonvanishing premise is retained; an index calculation
alone does not lower-bound the first short vector of a congruence lattice.

The kernel audit is scoped to these statements and their unchanged source
dependencies. It is not a full-repository or complete ABC verification.

## Local arithmetic in the independent elliptic descent

The separate module `QuarticTwistArithmetic.lean` follows the independently
reviewed ordinary descent in
`../2026_09_07_independent_route/third_round/quartic_square_geometry.md`.
It adds twelve declarations, including supporting congruence tables.

For coprime integers u,v, their residues are not both zero at either two or
three, because such a prime would divide gcd(u,v)=1. The integer squares
modulo 16 are 0,1,4,9. The three primitive quartics

- 2u^4-4u^2v^2+8v^4,
- 2u^4-12u^2v^2+72v^4,
- 6u^4-12u^2v^2+24v^4

have residues in {2,6,8,14} modulo 16. The proof checks every pair of residue
classes modulo 16 with a kernel-reduced finite proposition, proves the general
polynomial congruence identity, and transfers that proposition to arbitrary
integers. None of these quartics can be an integer square.

If w^2=3u^4-12u^2v^2+48v^4, reduction modulo three forces 3|w.
Writing w=3k gives 3k^2=u^4-4u^2v^2+16v^4. The right side is one modulo
three whenever u,v are not both divisible by three, a contradiction.
The formal code performs the exact division and finite-to-integer transfer.

Finally, writing R=2a^2+3ab+2b^2 and the actual successive norm forms
M0=a^2+ab+b^2 and M1=a^4+3a^3b+5a^2b^2+3ab^3+b^4, direct expansion gives

    R^4+2R^2(ab)^2-3(ab)^4 = 16 M0 M1 (a+b)^2.

The module proves this polynomial identity and the concrete exact equality
M1(101,355)=192529^2. These arithmetic proofs support the ordinary geometric
argument; they do not constitute a Lean construction of the elliptic group,
the isogenies, rank zero, the torsion classification, or the global combined
norm nonsquare theorem.
