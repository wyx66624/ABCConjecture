# Three simultaneous private top-rank depths in actual roots

Date: 2026-09-07. Status: complete ordinary proof independently reviewed
by the root researcher and both research peers: PASS. This note is
separate from the frozen eighth- and ninth-round TeX.

This construction disproves automatic membership in SA's two-cubefree-
arm subclass. It does not disprove the signed compensation criterion,
the full signed-tail estimate, or ABC. In particular it supplies actual
roots, not a uniform residue model or an unverified norm representation.

## TD1. Statement with full depths and all three actual arms

Let n>=5 be any integer with gcd(n,6)=1, and let s1,s2,s3>=4 be
integers. There are distinct primes q1,q2,q3, each 1 modulo 6n,
and infinitely many positive integers a divisible by three, such that
the actual primitive unramified root

    w=a+zeta,    Q=N(w)=a^2+a+1

has the following properties. Form SA's normalized power z_n=A+B*zeta,
equal to w^n for n=1 modulo six and bar(w)^n for n=5 modulo six,
and its actual integer quotients

    D1=A/a,    D2=B,    D3=(A+B)/(a+1).

Then for each i,

    v_(q_i)(D_i)=s_i,
    v_(q_i)(D_j)=0 for j!=i,
    q_i does not divide a(a+1)Q,
    ord(((w/bar(w))^3) mod q_i)=n.                 (TD1)

In particular q_i is a genuine top-rank prime of the actual power,
and v_(q_i)(T_n)=s_i with T_n=|P(w^n)|. The depths are private
to their respective arms and have not been moved into the old factor.

For any sequence of such n tending to infinity the representation has
unit residual and lambda=1/n (and rho=log(4+n)/n). All q_i>n^(1/6).
Every pair of quotient arms therefore fails the condition that all
prime depths above the moving cutoff be at most two. No conclusion
about the sign of E_i+E_j-2R_k follows from this failure.

## TD2. Elementary supply of distinct primes and exact orders

For any integer N>=3 and any finite previously chosen prime set S,
put X=N*product(S). The integer Phi_N(X) is greater than one:
pair conjugate primitive roots, and each squared distance from X
is at least (X-1)^2>1. Its constant term is one, so any prime
q dividing Phi_N(X) is coprime to X, hence to N and every old prime.

Since q does not divide N, the polynomial Z^N-1 over F_q has
no repeated root. Its factorization into the reductions of Phi_d,
d dividing N, therefore has pairwise coprime factors. A root of
Phi_N cannot also be a root of Z^d-1 for a proper divisor d of N.
Thus X modulo q has order exactly N, and q=1 modulo N.

Applying this three times at N=6n gives distinct q_i and elements
t_i of exact order 6n. This supplies existence without a prime-density
theorem. In a finite replay, other explicitly certified primes and
elements of this same order can of course be used.

## TD3. A simple root for each specified arm

Fix one such q and t. Set z=t^n in F_q, a primitive sixth root.
Then z^2-z+1=0, bar(z)=1-z=z^(-1), and z!=bar(z), since q>3.
The reduction of the actual Eisenstein ring is evaluated at this root.
For a variable X with X+bar(z)!=0, define

    alpha(X)=(X+z)/(X+bar(z)).

For any alpha0!=1 its inverse coordinate is

    X0=(alpha0*bar(z)-z)/(1-alpha0).                (TD2)

The three choices alpha0=t^2,t^6,t^4 have respective n-th powers
z^2,1,z^4. Their orders exceed three, and the cube of each has
order exactly n: these assertions use that n is coprime to six.
Thus X0 is neither zero nor minus one. Also X0+z and X0+bar(z)
are both nonzero, so the norm and all three input arms are units.

Write the raw power (X+zeta)^n=A_n(X)+B_n(X)*zeta. Its quotient
by its conjugate is alpha(X)^n. Direct substitution shows:

* alpha(X)^n=z^2 if and only if A_n(X)=0;
* alpha(X)^n=1 if and only if B_n(X)=0;
* alpha(X)^n=z^4 if and only if A_n(X)+B_n(X)=0.

These equivalences are on the norm-unit locus. Each numerator is
a nonzero constant times the indicated linear arm, divided by the
unit (X+bar(z))^n. Two arms cannot vanish together there.

The derivative

    alpha'(X)=(bar(z)-z)/(X+bar(z))^2

is nonzero. Because q>n, the derivative of alpha(X)^n at X0 is
also nonzero. Consequently the indicated raw arm has a simple zero.
Its actual quotient polynomial divides by X, 1, or X+1, each a
unit at X0, so the zero of the specified quotient is simple as well.

The target selection must take the normalized power into account.
For n=1 modulo six use t^2,t^6,t^4 for D1,D2,D3 respectively.
For n=5 modulo six, conjugation sends the raw coordinates to
(A_n+B_n,-B_n), so use t^4,t^6,t^2 respectively. This swap is
essential; it identifies the actual labeled quotient in TD1.

## TD4. Exact lifting and actual simultaneous realization

The quotient polynomials have integer coefficients by SA1. At a
simple root modulo q, the elementary expansion

    D_i(r+jq^e)=D_i(r)+j*q^e*D_i'(r) modulo q^(e+1)

gives one and only one lift to a zero at the next depth. Starting
at the root above, lift uniquely to a zero modulo q^s, then choose
any of the q-1 lifts which is not zero modulo q^(s+1). This gives
a residue r_i modulo q_i^(s_i+1) whose exact D_i depth is s_i.
The other quotient arms remain nonzero modulo q_i, as do the norm
and the input arms. The residue ratio still has cube order n.

The Chinese remainder theorem combines the three residues with
a=0 modulo three. Put

    M0=3*product_i q_i^(s_i+1).

Let r be the representative in [0,M0). Every integer a=r+j*M0,
j>=1, is positive, divisible by three, and preserves all assertions.
The root has coordinate gcd one, and Q=a^2+a+1=1 modulo three.
It is therefore an actual primitive unramified nonunit root.
The established primitive power theorem gives nonzero pairwise
coprime output arms, so the actual triple and all SA quantities
are defined. The power representation uses residual a unit and
exponent n; no simultaneous second-norm pure power is asserted.

The exact valuations at the selected primes follow from the chosen
residues. As q_i does not divide T1=a(a+1), the identity
T_n=T1*|D1D2D3| gives the same full depth in T_n. The cube order
computed above proves that these primes first hit at rank n.

## TD5. Why this boundary does not refute signed compensation

The construction can be chosen to pay a visible height cost. Every
chosen a above is at least M0. Let c=max(|A|,|B|,|A+B|) and
t_height=log c. Since Q^n<=c^2 and Q>a^2,

    t_height>n*log a >= n*log M0.

The contribution of the selected primes alone to the total three-arm
excess above depth two is

    E_selected=sum_i (s_i-2)log q_i
               < log M0 <= log a < t_height/n.     (TD3)

The selected positive signed depths (s_i-3) satisfy an even smaller
bound. These inequalities hold uniformly if the prescribed depths
also vary with n. For fixed n, letting a grow in its congruence class
makes these fixed selected costs negligible compared with height.

Thus all three arms can contain arbitrarily deep, distinct, genuinely
new primes in an actual small-lambda family. This is a counterexample
to automatic membership in the particular two-cubefree-arm subclass.
It is not a counterexample to quantitative signed compensation: the
other prime divisors and their negative credits are not determined,
and even the selected positive excess has the explicit O(1/n) cost.
General control of E_i+E_j-2R_k and the full signed tail remains open.

## Finite supplement and independent review

The separate exact replay checks n=5,7,11,25,35, each with prescribed
depths (4,5,6), and two actual CRT roots per exponent. This gives ten
actual roots and thirty selected full-depth checks. Primality is checked
by complete trial division; required orders are checked against every
proper divisor; each selected lifting level is exhaustively checked.
The whole quotient arms are not factored. Canonical result SHA256 is
`71c8e1d1aa54ecef4048ca2ba05ded94e8efdce60a00b25e7fe707283e1ec0fe`.

All three other researchers read the complete ordinary proof and
returned PASS. The critical-bottleneck reviewer additionally read the
replay source and independently reran `--check`, returning the same
canonical result. The independent-route review covered the ordinary
proof only; it is not counted as another software run. No Lean proof
of this construction is claimed.
