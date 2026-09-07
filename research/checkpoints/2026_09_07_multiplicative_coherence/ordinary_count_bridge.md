# Ordinary proof of the finite actual-root counting bridge

This proof precedes its Lean implementation. It connects the reviewed
actual phase/divisor theorem to the square of the cardinality of a root
set. The finite-ring map and its cardinality remain explicit premises;
neither the torsion/Hensel theorem nor an asymptotic divisor estimate is
replaced by an axiom.

For a natural N define the actual finite divisor envelope

    D(N)=max {card(k.divisors): 0<=k<=N}.

The library convention at k=0 is harmless. Every positive k<=N has
card(k.divisors)<=D(N) by membership in this finite maximum.

Let B be a positive integer and S a finite set of integers a with
3B<=a<6B. Let H be any finite type with a multiplication, let phi:S->H
(or a function on all integers restricted to S), and let m>864B^3.
Suppose that whenever a,b,c,d belong to S and

    phi(a)phi(b)=phi(c)phi(d),

the actual integer m divides

    (ab-1)(c+d+1)-(cd-1)(a+b+1).

Then

    |S|^2 <= |H| D(2500 B^4).

In particular |H|<=3n gives |S|^2<=3n D(2500 B^4).
Associativity, inverses and commutativity of H are not needed for this
finite implication. In the ordinary MC application H is the actual
finite norm-one torsion group, so its multiplication is already available.

Proof. Partition all ordered pairs S x S by their product image in H.
An empty fiber contributes zero. In a nonempty fiber choose one actual
representative (a,b), and set u=ab-1, v=a+b+1. The proved block bounds
give 0<u<=36B^2 and 0<v<=12B. For any (c,d) in the same fiber, the
assumed divisibility and the proved determinant bound force that integer
determinant to be zero. Thus

    v(cd-1)=u(c+d+1).

The already proved actual phase-fiber injection maps (c,d) to the
positive divisor vc-u of K=u^2+uv+v^2. The injection includes ordered
and diagonal pairs. The positive constant satisfies K<=2500B^4, so
the fiber has cardinality at most card(K.divisors)<=D(2500B^4).
Summing this same upper bound over the actual finite type H proves
the asserted inequality. Finally use |H|<=3n.

The representative coefficients u,v need not be reduced or coprime.
This is deliberate: positivity, the factor identity, injectivity and
the 2500B^4 bound all hold for the actual unreduced pair coordinates.
Thus the formal counting bridge does not assume extraction of a reduced
fraction for each group-image fiber.

For positive natural n, B=n^4 and q>6n^3, one has

    q^4 > (6n^3)^4=1296n^12>864(n^4)^3.

Consequently the same theorem applies with the actual modulus q^4,
provided its explicit phase-divisibility premise and |H|<=3n hold. Its
integer conclusion is |S|^2<=3n D(2500n^16). Since both sides are
nonnegative, strict monotonicity of squaring on nonnegative reals (or
the square-root order equivalence) gives

    |S| <= sqrt(3n) sqrt(D(2500n^16)).

The elementary ordinary divisor estimate in MC bounds D(N) by
C_epsilon N^epsilon. That asymptotic estimate, the actual finite-ring
construction, primality/rank arguments and the sieve are outside this
finite bridge. The theorem assumes exactly its same-image divisibility
and finite target-size premises, not the desired root-cardinality bound.
It supplies no pointwise bound for the farther signed prime packet.
