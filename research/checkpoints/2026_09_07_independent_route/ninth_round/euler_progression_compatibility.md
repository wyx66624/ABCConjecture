# EP1--EP4. A totient budget for general common pure exponents

Status: complete ordinary proof; both independent research peers have
completed full review with PASS.
This extends the prime-power-modulus companion by using the top
cyclotomic factor at a general exponent. It does not modify frozen CE
sources. All statements concern actual simultaneous pure powers and
do not assert their existence or nonexistence.

Let a,b be positive coprime integers, c=a+b,
M=a^2+ab+b^2 and F=M^2+ab c^2. Assume

    M=R^n, F=Q^n, R,Q positive integers,
    n>1, gcd(n,6)=1.                                  (EP1)

Write phi=phi(n), P for the largest prime divisor of n, and

    L=Phi_n(1),  kappa=P/L.

Here Phi_n(X,Y) is the homogeneous cyclotomic polynomial and Phi_n(1)
means its usual one-variable value, equivalently Phi_n(1,1).
We prove below that L=P for a prime power n and L=1 otherwise.
In particular kappa is a positive integer with kappa<=n.

## EP1. Complete bad-prime allocation at the top factor

For any coprime positive integers X,Y with X>Y and any odd n>1,
every prime q dividing Phi_n(X,Y) and not congruent to 1 modulo n
is the largest prime divisor P of n, and its valuation is one.
Thus the full part of Phi_n(X,Y) outside 1 modulo n divides P.

Proof. The homogeneous cyclotomic polynomial is monic in X with
constant term Y^phi(n), so a prime dividing XY cannot divide it.
First suppose q is odd and a unit in both X,Y. Put
d=ord_{F_q^*}(X/Y), so d divides q-1 and q does not divide d.
Let u=v_q(X^d-Y^d). The elementary valuation law is

    v_q(X^m-Y^m)=0                         if d does not divide m,
    v_q(X^m-Y^m)=u+v_q(m/d)                if d divides m. (EP2)

For completeness, after dividing by q-unit powers of Y, this law
reduces to v_q(B^h-1)=v_q(B-1)+v_q(h), where B is a rational
q-unit with B=1 modulo q. Multiplication of h by q adds one to the
valuation by the binomial expansion: its leading term q(B-1)
has valuation u+1, and every other term has valuation at least u+2.
Taking a power prime to q preserves the valuation, since the
corresponding geometric sum is that exponent modulo q. Factoring
h into its q-part and its prime-to-q part proves the formula.

The factorization X^m-Y^m=product_{e|m}Phi_e(X,Y) uniquely determines
the cyclotomic valuations by induction on m. The following values
have exactly the divisor sums (EP2):

    v_q(Phi_d(X,Y))=u,
    v_q(Phi_(d*q^j)(X,Y))=1                for j>=1,
    all other cyclotomic valuations are zero.           (EP3)

Indeed, when d divides m the sum is u plus the number of j>=1
for which d*q^j divides m, namely u+v_q(m/d); when d does not
divide m the sum is zero. This also includes d=1 and Phi_1=X-Y.

If n=d, then n divides q-1, so q is a good prime. Otherwise a
supported bad prime requires n=d*q^j with j>=1. Because d divides
q-1, every prime divisor of d is smaller than q. Hence q is the
largest prime divisor P of n, with valuation exactly one by (EP3).

At q=2, if X and Y have different parity then X^n-Y^n is odd.
If both are odd, for every odd m the geometric sum gives
v_2(X^m-Y^m)=v_2(X-Y). Divisor induction then gives valuation
zero at every odd cyclotomic index n>1. This proves EP1 including
the entire exceptional-prime contribution.

## EP2. A direct archimedean lower bound

For positive real X>Y and n>2,

    Phi_n(X,Y) >= L Y^phi(n), L=Phi_n(1).              (EP4)

Proof. Pair each primitive n-th root zeta with its complex conjugate.
The roots in each pair are distinct because n>2. For a pair,

    |X-Y*zeta|^2 - Y^2|1-zeta|^2
      =(X-Y)^2+2Y(X-Y)(1-Re(zeta)) >=0.

Multiplying the pair inequalities gives (EP4), because the product
of the factors |1-zeta|^2 is Phi_n(1)>0.

The value L is elementary as well. Evaluating
(T^n-1)/(T-1)=product_{d|n,d>1}Phi_d(T) at T=1 gives
product_{d|n,d>1}Phi_d(1)=n. Induction on n shows that each prime
power p^j contributes p, while each non-prime-power index contributes
1: the proper prime-power divisors already contribute all prime-power
parts of a non-prime-power n, and for n=p^j they contribute p^(j-1).
Thus L=P if n is a prime power, and L=1 otherwise.

## EP3. The actual mass budget at modulus n and modulus 6n

For a positive integer z define z_bad(s) to be its full prime-power
part outside 1 modulo s, and z_good(s)=z/z_bad(s). Under (EP1),

    9 c_bad(n)^2 <= 4 kappa R^(2(n-phi)),
    27 c_bad(6n)^2 <= 16 kappa R^(2(n-phi)+1).          (EP5)

Consequently

    c_good(6n) > [3sqrt(3)/(4sqrt(kappa))]
                     c^(2phi/n-1-1/n),

    sum_{q|c,q=1 mod6n} v_q(c)log q
      > (2phi/n-1-1/n)log c
         +log(3sqrt(3)/4)-(1/2)log kappa.              (EP6)

Every q in the sum is prime. The estimate concerns full valuations
and is not a lower bound of the same size for the radical.

Proof. Actual primitivity gives gcd(Q,R)=1, as in CE. Also Q>R^2.
Set T=Phi_n(Q,R^2) and C=(Q^n-R^(2n))/T. Both T and C are positive
integers and TC=ab c^2. By EP1, the full bad part U=(ab c^2)_bad(n)
divides P*C. Using EP2 and the actual integer four-ninths certificate,

    C <= [4 R^(2n)/9]/[L R^(2phi)],
    U <= (4 kappa/9)R^(2(n-phi)).                     (EP7)

Since c_bad(n)^2 divides U, the first inequality of (EP5) follows.

For the second inequality, use the actual Eisenstein power root
w=x+y*zeta of norm R with w^n=a+b*zeta. Its existence follows from
oriented factorization, the first norm's ramified valuation at most
one, and the invertibility of the n-th power map on the six units
when gcd(n,6)=1. The normalized arm construction SA1 gives
c=ell*D_j with ell=x+y if n=1 modulo 6 and ell=x if n=5 modulo 6.
In both cases ell is nonzero and 3ell^2<=4R.

Let J be the full c-part at primes q=1 modulo n but not 1 modulo 6n.
Every such q is inert, exceeds n, and does not divide R. Its boundary
rank d divides n and also divides (q+1)/3. Since q+1=2 modulo n
and n is odd, gcd(n,q+1)=1, so d=1. The exact homogeneous valuation
law then gives v_q(T_n)=v_q(T_1)+v_q(n)=v_q(T_1).
The entire actual arm-quotient product therefore has q-valuation
zero, and c=ell*D_j gives v_q(c)=v_q(ell). Hence J divides |ell|
with all depths, and 3J^2<=4R.

The disjoint support identity c_bad(6n)=c_bad(n)*J, combined with
the first inequality of (EP5), proves the second. Now divide c^2
by this bound, take square roots, and use the strict inequality
R<c^(2/n), which follows from M<c^2. This proves (EP6), even if
its displayed exponent happens to be nonpositive.

## EP4. A concrete totient condition forces a large progression prime

If in addition

    2 phi(n)>n+1,                                    (EP8)

then c has an actual prime divisor q=1 modulo 6n, necessarily
q>=6n+1. This includes every prime-power n=p^k with p>=5.

Proof. Put rho=2phi(n)-n-1. Since n is odd, rho is an even integer;
(EP8) gives rho>=2. The actual general common-exponent root budget,
proved in PP5 and in the arithmetic Lean companion, gives
R^2>=9n/4. Meanwhile c^2>R^n and (EP5) give

    c_good(6n)^2
      > [27/(16kappa)] R^rho
      >= [27/(16kappa)] R^2
      >= 243n/(64kappa) >= 243/64 >1.                (EP9)

Thus the good part has a prime divisor, with the required congruence.
For n=p^k, 2phi(n)-n-1=n(1-2/p)-1>=2, proving the inclusion.

The argument also applies to any divisor n of two unequal pure
exponents, provided the selected n satisfies gcd(n,6)=1 and (EP8).
No premise that the two exponents are equal is imposed in that
application. If (EP8) fails, (EP5)--(EP6) remain valid, but this
particular existence argument is not claimed to succeed.

## Boundary of the result

The classical cyclotomic valuation and root-of-unity estimates above
are proved here to make their actual use checkable. The result is a
necessary condition on the actual norm pair. The factor kappa retains
the exceptional prime instead of deleting it. No arbitrary-model
coefficient bound is used as a rational-point height bound.

The surviving primes can grow, and their high valuations remain
uncontrolled. The root's size estimate is a lower bound. Nonunit
residuals, the ramified first norm, and pairs of exponents without a
suitable common divisor remain separate live routes. None is excluded
by failure to satisfy the hypotheses of this note, and no ABC proof
or disproof follows.

## Exact finite supplement

The standard-library replay_euler_progression.py checks 14 completely
factored homogeneous cyclotomic values, the exact order of every
nonexceptional supported prime, the value at one and the integer
archimedean lower bound. Four additional exact valuation tests include
v_11(Phi_55(3,1))=v_11(Phi_605(3,1))=1 but
v_11(Phi_275(3,1))=0. Thus extending an index by arbitrary factors
does not preserve its exceptional-prime occurrence; the pattern
d*q^j matters. These are generic homogeneous examples, not actual
simultaneous pure-power seeds.

All assertions passed. Canonical UTF-8/LF JSON SHA256:
cfa7705fbd29e52a6288ffddc8abd4ea2bd112580457a06aeda6ed6b43287271.
The --check mode recomputes and compares canonical bytes.
