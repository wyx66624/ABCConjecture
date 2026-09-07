# UM1--UM4. Uniform tuple rigidity and a window near n times the root length

Status: complete ordinary proof, fully reviewed by root,
adversarial_audit and independent_route with PASS.
This is thirteenth-round work; the twelfth-round publication is frozen. It strengthens PN on the same actual proved
positive-density class, but does not control the unbounded farther
signed tail.

Retain the actual root block a_k=3k, B<=k<2B,
w_k=a_k+zeta, Q_k=a_k^2+a_k+1, alpha_k=w_k/bar(w_k).
Let S_B consist of the indices whose Q_k has a prime factor >12B.
The proved PN1 theorem gives

    |S_B| >= B/2-O(B log log B/log B)

and proves multiplicative independence of all alpha_k with k in S_B.
This is an ordinary theorem about actual roots, not a new hypothesis.
For boundary statements take n>324 prime, B=n^4,
T_n(k)=|P(w_k^n)| and t_k=log c_n(k).

## UM1. A determinant comparison uniform in the tuple length

Let B>=5 be an integer and q>8B a prime. For every integer nu>=1,
two ordered nu-tuples of block roots whose algebraic ratio products
are congruent modulo q^(2nu), with all denominators units, have
exactly equal algebraic ratio products over Q(zeta).

Proof. For z=prod_j(a_j+zeta)=R+S*zeta, the PN telescoping proof,
which is valid for every finite nu, gives

    |R|<=2(7B)^nu,       |S|<=2nu(7B)^(nu-1).

For a second tuple z'=R'+S'zeta the integer determinant D=RS'-R'S
therefore satisfies

    |D|<=8nu*7^(2nu-1)*B^(2nu-1).

Equality of ratio products modulo q^(2nu) implies q^(2nu)|D,
by the conjugate cross difference; q>3 makes its fixed scalar a unit.
Put x=49/64. Since q>8B, the ratio of the displayed height bound
to q^(2nu) is strictly less than

    (8/(7B))*nu*x^nu.

For every nu>=1, the finite geometric sum gives

    nu*x^nu < sum_(j=0)^(nu-1) x^j < 1/(1-x)=64/15.

Consequently the ratio is strictly less than

    512/(105B) < 5/B <=1.

It follows that D=0. Thus z*bar(z')=z'*bar(z) over the number field,
and their ratios are exactly equal. Neither a bound on nu nor a
positive sign of R or S is required. The elements z,z' are nonzero.
This proves the uniform assertion. QED.

The extra condition q>8B is essential to this proof; we do not
silently extend its all-nu conclusion down to q>B or 6n^3.
No growing constant C_nu has been absorbed into a uniform big-O.

## UM2. A multiset bound and three roots at square-root depth

For n>324 prime, q>8B and each integer nu>=1, put

    M_nu(q)=#{k in S_B:q^(2nu)|T_n(k)}.

Then

    binom(M_nu(q)+nu-1,nu)<=3n                    (UM1)

if M_nu(q)>0; when it is zero the number of multisets is zero.
In particular

    M_2(q)<=sqrt(6n).                            (UM2)

Let r=ceil(sqrt n). Then

    M_r(q)<=3.                                  (UM3)

Proof. All ratios of the set counted by M_nu lie in the norm-one
3n-torsion group modulo q^(2nu). It has at most 3n elements, by the
same split/inert simple-lifting proof as MC1; q>8B>n.
Multiplication is commutative. Each multiset of nu roots gives an
image in that group. By UM1, equal images give equal actual products;
by PN1 independence, their index multiplicities agree. Thus this is
an injective map on multisets. The elementary stars-and-bars count
is binom(M+nu-1,nu), proving (UM1).

For nu=2, M(M+1)/2<=3n implies (UM2).
If M_r>=4, just the multisets on four of those roots would give

    3n >= binom(r+3,3)
        = (r+1)(r+2)(r+3)/6
        > r^3/6 >= n^(3/2)/6 >3n.

The last inequality uses sqrt n>18. This is a contradiction.
Hence (UM3). Here r grows with n, but UM1 has already supplied a
height bound valid for all finite tuple lengths. QED.

## UM3. An absolute per-prime layer budget and an explicit mean

For every n>324 prime and every real 8B<Z<=B^2, define

    F_(8B,Z)(k)=sum_(8B<q<=Z) (v_q(T_n(k))-3)_+ log q.

Then

    (1/B) sum_(k in S_B) F_(8B,Z)(k)/t_k
       <= 80 Z/[B n log(Z/(3n))].                (UM4)

Proof. Use the exact identity

    (e-3)_+=sum_(j>=4) 1_(e>=j).

Put r=ceil(sqrt n). For a fixed prime q>8B, the layers
4<=j<2r each have at most sqrt(6n) roots in S_B, by (UM2).
There are at most 2r of them, and r<=sqrt n+1<=2sqrt n.
Thus their total weighted contribution is at most

    4sqrt(6)*n log q <10 n log q.

Every layer j>=2r has at most three roots, by (UM3).
The elementary boundary height bound is

    log T_n(k)<=3n L,       L=log(6B+1).

Consequently its depth cap is at most 3nL/log q, and all these
higher layers together cost at most 9nL. Combining both ranges,

    sum_(k in S_B)(v_q(T_n(k))-3)_+ log q
          <=10n log q+9nL.                      (UM5)

This upper bound remains valid if one range of layers is empty.
It pays every positive depth, not only a high-depth truncation.
For q<=Z<=B^2 and B>=7, one has

    log q<=2log B,     L=log(6B+1)<=2log B,
    t_k>=n log(3B)>=n log B.

Therefore the normalized contribution at one prime is at most 38/B.

A prime with positive excess has exact homogeneous rank n.
Indeed rank one would imply v_q(T_n)=v_q(T_1), since q>n,
and q^2 would divide one of the coprime factors a_k,a_k+1.
Both are below 6B+1<q^2. Hence rank one is impossible.
Exact rank n implies q=+1 or -1 modulo 3n.
The established two-progression Brun--Titchmarsh estimate bounds
the number of eligible primes up to Z by

    2Z/[(n-1)log(Z/(3n))].

Multiplying by 38/B gives
76Z/[B(n-1)log(Z/(3n))]. Since n>324 implies 76n/(n-1)<80,
this proves (UM4). All constants are absolute in the stated domain.
The normalization is by the entire block B. QED.

The narrower discarded interval (B,8B] is not assigned a cap.
It will be paid as part of the already controlled small-prime full
mass at cutoff 8B. This avoids claiming uniform high moments at
primes below the explicit 8B threshold.

## UM4. A positive-density window at Bn times a logarithmic factor

Fix any real delta>0. For sufficiently large prime n put

    Z_n=floor(B n (log n)^(1-delta)).

Then 8B<Z_n<=B^2, and (UM4) implies

    (1/B) sum_(k in S_B) F_(8B,Z_n)(k)/t_k
        =O_delta((log n)^(-delta)).              (UM6)

Indeed n(log n)^(1-delta) tends to infinity and is o(n^4),
which proves the domain for this fixed delta. Also

    log(Z_n/(3n))
      =4log n+(1-delta)log log n-log3+o(1)
      ~4log n.

This accounts for the floor and gives (UM6).
Markov at (log n)^(-delta/2) removes at most
O_delta((log n)^(-delta/2)) of the full block.
The established prime-index FM estimate, with the elementary EA
inputs, at cutoff 8B gives mean L_(8B)(T_n)/t=O(1/log n).
Markov at (log n)^(-1/2) removes O((log n)^(-1/2)).
Intersect with PN1. Thus there is an actual set P_(n,delta) of
relative size at least

    1/2
      -O_delta(log log n/log n
                 +(log n)^(-delta/2)+(log n)^(-1/2))

on which simultaneously

    F_(8B,Z_n)(k)/t_k <=(log n)^(-delta/2),
    L_(8B)(T_n(k))/t_k <=(log n)^(-1/2).

Let W_(Z_n)(k) be the signed cost of supported primes above Z_n.
The exact disjoint prime decomposition then gives

    J(T_n(k))/t_k
      <=W_(Z_n)(k)/t_k
          +(log n)^(-delta/2)+(log n)^(-1/2).     (UM7)

Using the elementary angular lower bound log T_n/t_k>=3-4/n,

    log rad(T_n(k))/t_k
      >=1-4/(3n)
          -[(log n)^(-delta/2)+(log n)^(-1/2)]/3
          -(W_(Z_n)(k))_+/(3t_k).                (UM8)

Thus delta=1 gives an interval ending at Bn=n^5, and any fixed
0<delta<1 gives a logarithmic expansion beyond n^5. These are
actual complete positive-excess estimates on a proved positive-
density class. They do not assert that the intermediate full mass
is small, nor prove that its negative signed credit has any
particular size.

The farther signed cost, the complementary norm-smooth roots, and
the residual exceptional subsets are still not controlled.
No inference from a small number of deep roots at each prime to
a pointwise bound at all unbounded primes is made. This note
proves no global ABC estimate and contains no new Lean claim.

## Dependency chain and review targets

1. PN1 proves a private prime ideal for each root of S_B and its
   asymptotic size, using the fixed-progression prime theorem.
2. The finite telescoping estimate is uniformized at q>8B, with
   the explicit finite geometric inequality 512/(105B)<1.
3. MC's actual unramified torsion group plus independence gives
   injective multisets at every finite precision.
4. The growing choice r=ceil(sqrt n) bounds high layers by three;
   the two-tuple bound separately pays every lower positive layer.
5. Actual height, rank progressions and Brun--Titchmarsh give UM4.
6. FM/EA at 8B and ordinary Markov give UM7--UM8.

The new uniformization is precisely where the former fixed-nu
qualification is replaced. All other larger-tail hypotheses stay
explicit. This candidate is kept outside the frozen current paper
until separate full ordinary reviews are recorded.
