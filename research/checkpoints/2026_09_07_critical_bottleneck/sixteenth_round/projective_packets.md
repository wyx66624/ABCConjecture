# A prime-independent quotient and a combined-precision packet bound

Sixteenth-round ordinary candidate, outside the current fifteenth-round paper
and formal scope. The purpose is to state the exact joint object that
survives prime-dependent arm phases. It does not control singleton
private labels or close the far signed tail.

Keep the reviewed US setup: n>324 prime, B=n^4, L=log(8B), actual
w_k=3k+zeta, alpha_k=w_k/bar(w_k), and a multiplicatively independent
subset I of the actual block. Put K=Q(zeta), zeta^2-zeta+1=0, and
let mu3={1,zeta^2,zeta^4} inside its norm-one multiplicative group G.

## JP1. A single actual quotient with different finite reductions

The classes a_k=[alpha_k] in G/mu3 are multiplicatively independent.
Indeed a relation product alpha_k^x_k in mu3 becomes trivial after
cubing, so independence of the alpha_k makes every integer x_k zero.
This is a prime-independent actual group and a prime-independent
collection of elements. It is not itself asserted to be finite.

For any fixed prime q>8B and precision e>=1, reduce norm-unit ratios
into the norm-one group G_(q,e) and then quotient by its embedded mu3.
The three global roots remain distinct because q>3. At precision one
the norm-one group is cyclic of order q-chi_q; its quotient by mu3
is cyclic of order (q-chi_q)/3. At higher precision the reduction
kernel is a finite abelian q-group, on which raising to the n-th
power is invertible. Thus n-torsion injects into the precision-one
quotient, and the n-torsion subgroup has at most n elements.

An actual hit q^e|T_k gives alpha_k^n in mu3 modulo q^e, so the
class a_k maps into that n-torsion subgroup. This removes the need
to select different lifts beta_(q,k) when constructing a joint map.
It does not remove the distinction between different finite reduction
targets. Reduction is only used on ratios whose numerator and
denominator are q-units, which includes every marked actual root.

## JP2. A uniform combined-precision rigidity criterion

Let S be a nonempty finite set of distinct primes q>8B, assign positive
integer precisions e_q, and put m=product_(q in S)q^e_q. Suppose every
root in J subset I satisfies q^e_q|T_k for every q in S. Fix a positive
integer radius nu. Then

    log m >= 6 nu L                                      (JP1)

implies that the signed integer l1 ball of radius nu on J injects
into the product of the finite n-torsion quotient groups of JP1.

Proof. For a signed exponent vector x, represent product alpha_k^x_k
as z_x/bar(z_x) with an actual product of w_k or bar(w_k), using the
empty product for zero. If its l1 norm is at most nu, then
|z_x|<=(6B)^nu. These products are units at every prime in S.

Suppose two vectors x,y have equal images in every finite quotient.
For each q there is a unique tau_q in mu3 such that the two actual
ratios differ by tau_q modulo q^e_q. For each of the three global
values tau choose a global Eisenstein unit v_tau with v_tau/bar(v_tau)
=tau, and form the integer coordinate determinant D_tau between
z_x and v_tau z_y. The conjugate-cross-product identity and q>3
give q^e_q|D_(tau_q). Thus, using distinct prime powers,

    m | D_1 D_(zeta^2) D_(zeta^4).                       (JP2)

For every tau, the actual Gram bound and unit norm preservation give

    |D_tau| <= (2/sqrt(3))(6B)^(2nu) < (8B)^(2nu).

Hence the absolute product on the right side of JP2 is strictly
less than (8B)^(6nu)<=m. Divisibility forces this integer product
to vanish, and some D_tau=0. Thus the exact ratios differ by a
global element of mu3. JP1's actual quotient independence gives x=y.
All signs, unequal lengths and the empty vector are included.

Equivalently, partitioning S according to its three tau_q values
shows that one phase has a product modulus at least m^(1/3).
The determinant argument above also covers the possibility that a
phase class is empty and avoids selecting an unproved common phase.

## JP3. The resulting exact count and its limitation

If s=|S| and M=|J|, the injection proves the ordinary finite bound

    C(M,nu)=sum_j 2^j choose(M,j)choose(nu,j) <= n^s.     (JP3)

This combines precision from several primes and uses n, rather
than 3n, in every target factor. The cost is the factor three in
JP1's logarithmic precision, paying for all possible global arm
phases. If a separate hypothesis proves the same phase tau at every
marked prime for every pair being compared, then only one determinant
is needed and 2nu L suffices; that extra hypothesis is not assumed.

The product target size n^s is essential to this argument. It cannot
be replaced by n merely because all targets have n-torsion exponent.
For singleton support packets M=1 the bound is only 2nu+1<=n^s.
Thus this theorem does not give a small number of prime labels per
actual root, bound their weighted depth cost, or show that the full
far positive or signed mean is sublinear. It supplies a coherent
joint object and a precise combined-precision implication, not the
missing cross-prime height saving.
