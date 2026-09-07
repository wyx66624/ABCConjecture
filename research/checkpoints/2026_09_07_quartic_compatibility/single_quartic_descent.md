# Actual conjugate-compatible quartic descent

Independently reviewed ordinary proof, sixth continuation. Standard ABC
is open. No assertion here is yet claimed as Lean formalized. The argument
refines QC1--QC5 in the independently reviewed fifth continuation using the
single actual root field instead of four independently allocated splitting-
field factors. All heights are absolute logarithmic Weil heights.

Put F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4. Let alpha be a root of
f(X)=F(X,1), L=Q(alpha), and K the degree-eight splitting field from QC1.
Throughout a,b are positive coprime integers and

    F(a,b)=V Q^g,   g>=3,   V,Q positive integers,   V g-free.

Neither gcd(V,Q)=1 nor disjoint prime support is assumed.

## SC1. The quartic root field has class number one

The quadratic factorization over Q(zeta), zeta^2-zeta+1=0, is

    f(X)=(X^2+(2-zeta)X+1)(X^2+(1+zeta)X+1).

Choose alpha in the first factor. Then zeta=alpha+alpha^(-1)+2 lies
in L, and L=Q(zeta,sqrt(-1-3zeta)). The discriminant -1-3zeta is
not a square in Q(zeta), since its norm is 13, not a rational square.
Consequently [L:Q]=4 and its signature is (0,2). The integral unit alpha
generates an order of discriminant 117, by the exact polynomial resultant
calculation already given in QC1 and its reproducible arithmetic certificate.
Thus |Disc(L)|<=117 and the index [O_L:Z[alpha]] has prime divisors only 3.

Minkowski's ideal-class bound (Milne, Algebraic Number Theory, version 3.08,
Theorem 4.3) represents every ideal class by an integral ideal of norm at most

    (4/pi)^2 (4!/4^4) sqrt(|Disc(L)|)
      <= (3/(2 pi^2)) sqrt(117) < 11/6 < 2.

The norm is a positive integer, so this ideal has norm one and is O_L.
Hence every ideal class is trivial. Dirichlet's unit theorem gives unit rank
one. Write O_L^*=mu_L times <epsilon>, and w_L=|mu_L|; these objects are fixed
independently of a,b,V,Q,g. These are explicitly named external number-field
inputs, not a class-number computation inferred from a finite search.

## SC2. One actual factor determines its complete ideal extraction

Set ell=a-alpha b. Its field norm is F(a,b). If p does not divide 117 and
p divides F(a,b), then b is nonzero modulo p: otherwise primitivity would
make F(a,b)=a^4 nonzero modulo p. Any prime ideal P above p dividing ell
has alpha congruent to a/b in its residue field. Because the order index
is prime to p and f has distinct roots modulo p, the factorization theorem
for unramified primes gives exactly one such prime ideal, of residue degree
one. Thus v_P(ell)=v_p(F(a,b)); all other primes above p have valuation zero.
There are at most four choices for this prime as the actual seed varies.

The primitive congruences proved in QC2 (and now in scoped Lean) say that
3 does not divide F and, if 13 divides F, then v_13(F)=1. In the latter
case the ideal norm formula sum_{P|13} f_P v_P(ell)=1 forces a unique
prime ideal of residue degree one and depth one. Again there are at most
four choices. In particular 13 does not divide Q. No assertion about
unramifiedness at 13 is used. These arguments cover all rational primes.

Write v_p(F)=r_p+g q_p, where r_p=v_p(V) lies in [0,g-1] and
q_p=v_p(Q). At the unique prime of ell above p put the exponents r_p and
q_p into ideals A and B respectively. Then

    (ell)=A B^g,        Norm(A)=V,        Norm(B)=Q.

For fixed V, there are at most 4^{omega(V)} possibilities for A; the looser
bound 4*4^{omega(V)} will be used uniformly below. The choices for B need
not be finite and are not counted as coefficient choices. Class number one
gives integral generators delta,beta with A=(delta), B=(beta), and

    a-alpha b=delta u beta^g,             u in O_L^*.

Replacing beta by a unit multiple reduces u modulo (O_L^*)^g. There are
at most w_L*g such unit classes, represented by zeta_0 epsilon^k with
zeta_0 in mu_L and 0<=k<g. This argument permits shared support of V,Q.

## SC3. A smaller family of actual conjugate-compatible covers

Choose one delta for each A and the above unit representatives. For each
kappa=delta u, apply all four embeddings sigma_i:L->K, with roots alpha_i.
The four actual equations are conjugates of the SAME equation:

    a-alpha_i b=sigma_i(kappa) sigma_i(beta)^g.

Consequently the ratios define a cover over K

    y_i^g=(x-alpha_i)/(xi_i(x-alpha_4)),  i=1,2,3,
    xi_i=sigma_i(kappa)/sigma_4(kappa),   x=a/b.

Every actual seed lifts to one of at most

    4 w_L 4^{omega(V)} g

such covers. The four embeddings and the three ratios do not create three
independent unit choices: all are determined by the single actual u in L.
Over an algebraic closure, the divisors at the four distinct roots prove
independence of the three Kummer classes modulo g, including composite g.
The connected cover has degree g^3 and four branch points, each with inertia
g. Riemann--Hurwitz gives genus 1+g^2(g-2), as in QC3.

For lambda=max(1,log V)/g, 4^{omega(V)}<=V^2 gives

    log(max(1,number of covers))/g
      <= 2 lambda + (log g+log(4w_L))/g.

Allowing all integral V<=exp(L_0 g) gives at most

    4 w_L g exp(3 L_0 g)

covers. For L_0 tending to zero, their logarithmic count divided by g tends
to zero. This is an upper bound with repetitions permitted. It neither
constructs points on those covers nor bounds their heights.

## SC4. Coefficient height with the single unit lattice

For each principal ideal A of norm V, multiply its generator by a unit to
balance the two complex logarithmic absolute values in a fixed fundamental
interval of the rank-one unit lattice. Their common mean is (log V)/4.
Thus every archimedean conjugate of delta has logarithmic absolute value
within a fixed constant of (log V)/4. Delta is integral, so

    h(delta) <= (log V)/4 + C_L.

The chosen u has h(u)<=g h(epsilon), and height is invariant under field
embeddings. Therefore

    h(xi_i) <= 2 h(delta u) <= (log V)/2 + C'_L g.

The constants depend only on L and the chosen fundamental unit. This
conservative estimate suffices; no sublinear unit-representative bound is
asserted. QC6's generic splitting-field unit-class obstruction remains
valid, but it does not justify ignoring actual conjugate compatibility.
The individual actual point bound remains in the other direction:
h(a/b)>=(g log Q+log V)/4-log 2. A small number of coefficient classes
does not contradict the existence of individual points of large height.

## SC5. Rational complete-intersection normal form

For a fixed kappa from SC3 write beta=X_0+X_1 alpha+X_2 alpha^2+X_3 alpha^3.
Expand kappa beta^g in the fixed Q-basis 1,alpha,alpha^2,alpha^3. Setting
its last two coefficients equal to zero gives two homogeneous degree-g
forms over Q in P^3. Every actual seed above yields a rational point of
this projective intersection; the first two coefficients recover a,-b up
to the appropriate common g-th-power scale. The reverse implication is
not asserted without integral and primitive conditions.

Over an algebraic closure the four embedding coordinates Z_i=sigma_i(beta)
are an invertible linear change of variables. The intersection says that
(sigma_i(kappa) Z_i^g)_i lies on the projective line

    (a-alpha_i b)_{i=1}^4.

That line meets each coordinate hyperplane once, at four distinct points,
and no point of the line has two zero coordinates. Thus every point of the
intersection has at most one zero Z_i. The annihilator of the line has
dimension two. The intersection is nonempty over the algebraic closure,
by choosing any point of the line and taking its four g-th roots. If the
two defining gradients were dependent, a nonzero
annihilator vector would be supported only on a zero coordinate. Such a
vector cannot annihilate the line, since none of its coordinate functions
vanishes identically. This proves smoothness and pure dimension one in
characteristic zero. The same Kummer independence as in SC3 proves geometric
connectedness of the chart where Z_4 is nonzero. Its complement is finite,
so it hides no additional one-dimensional component; smoothness prevents
embedded ones.
Hence this is a smooth geometrically connected complete intersection of
degrees (g,g) in P^3_Q, of genus 1+g^2(g-2).

In this fixed basis, denominators of powers of alpha are absent because
its polynomial is monic. Fixed field multiplication bounds the sizes of
all structure constants for kappa beta^g exponentially in g. The
multinomial coefficients have total sum 4^g. The coordinates of kappa have
logarithmic projective height O(log V+g), by the fixed linear embedding
map and SC4. After clearing the common coefficient denominator, the two
forms consequently have logarithmic projective coefficient heights
O(log V+g), with constants depending only on L and the basis. This gives
an explicit object over Q. No point-height bound or ABC conclusion follows
from smoothness, genus, or the coefficient bound alone.

## Dependencies and open targets

External: Minkowski ideal bound, Dirichlet units, prime factorization away
from the order index, elementary Kummer theory and Riemann--Hurwitz.
Internal: exact quartic factorization/discriminant and primitive bad-prime
depth from QC1--QC2. Both critical_bottleneck and adversarial_audit read and
independently approved the complete SC1--SC5 ordinary proof, including its
nonempty, smooth and connected geometric model and the coefficient-height
bound. Root also opened Milne's actual primary Theorem 4.3. Integration and
scoped formalization follow separately. The still-open targets are uniform
control of points or
actual compatible unit classes, and their relation to simultaneous norm
compression. Neither a hard generic unit class nor a rational cover is an
actual high-quality ABC family.
