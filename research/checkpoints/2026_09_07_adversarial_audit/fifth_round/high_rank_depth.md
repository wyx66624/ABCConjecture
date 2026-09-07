# Moving high-rank depth in actual homogeneous profiles

Date: 2026-09-07. Fifth-round ordinary proof, independently reviewed in
full by both peer mathematical agents. Earlier rounds are frozen.

Write O=Z[zeta], zeta^2-zeta+1=0, P(A+B zeta)=AB(A+B), and
N(A+B zeta)=A^2+AB+B^2. For primitive w with Q=N(w)>1, prime to
three, and p>3 not dividing Q, let

    d_p=ord((w/bar w)^3 mod p),  s_p=v_p(P(w^{d_p})).

The order is in the norm-one group of O/pO. In the split case it is
the order under either embedding into F_p; the two images are inverse
and have equal order.

The new cyclotomic packet method distinguishes

    E_net(g,Y)={d|g: sum_{p>Y, d_p=d}(s_p-3)log p > 0}

from the larger set

    E_hit(g,Y)={d|g: some p>Y has d_p=d and s_p>=4}.

Every positive net packet has such a prime, but one such prime does not
make the whole signed packet positive. This note constructs an actual
counterfamily to automatic totient sparsity of E_hit. It does not refute
automatic sparsity of E_net, any conditional packet theorem, or the
signed-tail gate.

In these sums and sets, rank notation ranges only over primes p>3 with
p not dividing Q, as in its definition above. This convention also applies
when a finite initial cutoff Y is below three; asymptotically Y tends to
infinity.

## HR1. A split prime supporting any prescribed large prime rank

For each prime ell>=5 there is a prime p=1 modulo 6ell.
This special existence can be shown elementarily, without a uniform
least-prime bound or Dirichlet's theorem.

Proof: put n=6ell and choose any prime divisor p of Phi_n(n). The
cyclotomic integer Phi_n(n) exceeds one: its complex product has factors
of absolute value at least n-1 and positive real product. Its constant
term is one, so each rational prime dividing n does not divide Phi_n(n).
In particular p does not divide n. Reducing X^n-1=product_{d|n}Phi_d(X)
modulo p gives a squarefree polynomial, because p does not divide n.
The residue n is a root of Phi_n and therefore of no Phi_d with proper
d|n. Its multiplicative order modulo p is n. Thus n divides p-1.

## HR2. Exact depth at the prescribed maximal rank

Fix a prime ell>=5, a prime p=1 modulo 6ell, and an integer s>=4.
There is a positive integer a, divisible by three, such that w=a+zeta
satisfies

    Q=N(w)>1, gcd(Q,3p)=1,
    d_p=ell, s_p=s,
    p^s<=a<3p^{s+1}.

Proof: in F_p choose z of order six, so z^2-z+1=0, and put zbar=1-z.
Choose R of order ell. Set

    a0=(R*zbar-z)/(1-R).

Then a0+zbar=(zbar-z)/(1-R) is nonzero, and a0+z=R(a0+zbar)
is nonzero. Their ratio is R, so the cube of their ratio has exact
order ell. In particular the norm is nonzero modulo p.

Consider the integer polynomial G_ell(T)=P((T+zeta)^ell). The exact
cubic identity reduces modulo p to

    3(z-zbar)G_ell(T)=(T+z)^{3ell}-(T+zbar)^{3ell}.

At T=a0 the right side vanishes. Differentiating its expression
(T+zbar)^{3ell}(R(T)^{3ell}-1), where
R(T)=(T+z)/(T+zbar), shows a nonzero derivative there: p does not
divide 3ell, R(a0) is nonzero, and
R'(a0)=(zbar-z)/(a0+zbar)^2 is nonzero. The factor 3(z-zbar) is
also nonzero. Thus a0 is a simple root of G_ell modulo p.

Lift it uniquely to a root b modulo p^s, with 0<=b<p^s. Among the
p residues b+j p^s modulo p^(s+1), exactly one gives depth at least
s+1. Choose j from {1,2} which does not give that lift. Then
A=b+j p^s satisfies p^s<=A<3p^s and v_p(G_ell(A))=s.
CRT now selects a=A+k p^(s+1), with k in {0,1,2}, so that a=0
modulo three. This is possible because p is prime to three. The
result satisfies the indicated size bound and preserves all p-adic
conclusions. Since a is divisible by three, Q=a^2+a+1=1 modulo three.
The formula for a0 already proves p does not divide Q.

## HR3. Failure of automatic coarse rank sparsity at a moving tail cutoff

For each prime ell>=5 choose p and w as in HR1--HR2, with s=4, and
put g=ell. All powers w^g are actual primitive Eisenstein integers.
After a unit rotation they give primitive positive abc triples with
an actual pure extraction of exponent g and unit residual. Hence

    lambda=1/g -> 0,       Y=lambda^(-1/6)=g^(1/6).

The selected prime p exceeds Y, has actual rank g and actual first
depth four. Consequently

    (1/g) sum_{d in E_hit(g,Y)} phi(d) >= (g-1)/g -> 1.

Thus a universal assertion that the totient mass of ranks merely
containing a depth-at-least-four prime is o(g) is false, even on actual
homogeneous profiles with unit residual and lambda tending to zero.

Proof: w is primitive because its second coordinate is one. Its norm
is prime to three. No inert prime can occur in its norm, and it cannot
contain both orientations of a split prime, since that would divide
both its integer coordinates. Raising these oriented factors to any
power therefore remains primitive. If w/bar w were a root of unity,
the ideals (w) and (bar w) would coincide; the oriented factorization
and absence of ramification would then force w to be a unit. Since
Q>1, the boundary of w^g is nonzero. One of the six unit rotations
places it in the positive sector, preserving norm and absolute boundary.
This supplies an actual primitive triple and the unit-residual profile.

By construction p>=6g+1>Y, d_p=g, and s_p=4. Thus g belongs to
E_hit, while phi(g)=g-1. There are arbitrarily large primes g,
completing the full-premise infinite family.

## The precise signed boundary retained

The selected prime contributes only (s-3)log p to the positive signed
cost. If t=log c for the positive rotation, then

    t>=g log Q/2>=gs log p,
    (s-3)log p/t <= (s-3)/(gs) <= 1/g.

Here Q=a^2+a+1>=p^(2s), using HR2's explicit choice a>=p^s.
Thus even an arbitrarily large prescribed first depth s can occupy
the maximal totient rank while its own cost is sublinear in height.
This pinpoints the loss in marking an entire large rank just because
one high-depth prime occurs there.

Other primes of that rank may carry negative signed credit. No sign
or size of their full net packet has been proved here. In particular
E_net need not equal E_hit; this construction does not refute a
totient-sparsity condition on E_net, a weighted saving condition, or
the global signed-tail conjecture. The chosen prime moves beyond the
actual cutoff, unlike the earlier fixed-five shifted example, but
that distinction does not remove the requirement to retain all the
other prime contributions.

Only elementary cyclotomic algebra, finite-field cyclicity, simple-root
lifting, CRT, and the established actual Eisenstein primitive-factor
description enter the construction. No unproved prime distribution
estimate or finite search is used as an existence theorem.
