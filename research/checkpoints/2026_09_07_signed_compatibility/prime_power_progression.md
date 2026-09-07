# PP1--PP5. Lifting actual common-exponent support to prime-power moduli

Status: complete ordinary proof submitted for independent review.
This strengthens the ninth-round CE/AC compatibility restriction when
the two pure exponents have a common prime-power divisor. It does not
assert that simultaneous pure-power seeds exist.

Let a,b be positive coprime integers, c=a+b, and write

    M=a^2+ab+b^2,    F=a^4+3a^3b+5a^2b^2+3ab^3+b^4.

Suppose p>=5 is prime, k>=1, n=p^k, m=p^(k-1), and

    M=R^n,    F=Q^n,    R,Q positive integers.              (PP1)

Then n=pm. For a positive integer z define its full part outside the
progression 1 modulo s by

    z_bad(s)=prod_{q prime, q not congruent to 1 mod s} q^v_q(z),
    z_good(s)=z/z_bad(s).

The modulus in the new conclusion is the full n, not merely p. No
prime-density assertion or modular representation input is needed.

## PP1. The top prime-power cyclotomic factor

Put

    D=Q^m-R^(2m),
    S=sum_{j=0}^{p-1}(Q^m)^(p-1-j)(R^(2m))^j.

Then D>0, gcd(Q,R)=1, and

    DS=Q^n-R^(2n)=F-M^2=ab*c^2.                         (PP2)

The polynomial S is Phi_n(Q,R^2). Every prime q dividing S other
than p satisfies

    ord_{F_q^*}(Q/R^2)=n,    q congruent to 1 mod n.     (PP3)

At the exponent prime, p divides S exactly when p divides D, and
then v_p(S)=1. Thus the full part of S outside 1 modulo n is 1 or p.

Proof. As in CE, actual primitivity implies gcd(M,abc)=gcd(M,F)=1.
It follows that gcd(Q,R)=1. The strict inequality F>M^2 gives Q>R^2,
so D>0, and the geometric-sum identity gives (PP2).

If a prime q divides Q or R then an extreme term of S is the sole
nonzero term modulo q, so q cannot divide S. For q different from p,
set t=Q/R^2 in F_q^*. The geometric sum in t^m vanishes. Therefore
t^n=1, whereas t^m is not 1 (otherwise the sum would equal p).
Since every proper divisor of the prime power n divides m, the order
of t is exactly n. This proves (PP3).

For the p-exception, write X=Q^m and Y=R^(2m). In characteristic p,
S=(X-Y)^(p-1), so p divides S if and only if p divides D=X-Y.
In that case X,Y are p-units. Expanding in D gives

    S=pY^(p-1)+binom(p,2)Y^(p-2)D+...+D^(p-1).

All terms after the first have valuation at least two; the first has
valuation one. This proof includes k=1 and does not discard p.

## PP2. A full valuation bound independent of k in its retained fraction

Let U=(ab*c^2)_bad(n). Then

    U divides pD,
    1<=D<=4R^(2m)/(9p),    U<=4R^(2m)/9,              (PP4)
    c_bad(n)<=2R^m/3 < (2/3)c^(2/p).                  (PP5)

Proof. For every bad prime other than p, (PP3) forces v_q(S)=0.
At p, v_p(S)<=1. Apply (PP2) prime by prime to obtain U|pD.
Each term of S is at least R^(2m(p-1)), hence
S>=pR^(2m(p-1)). The actual integer identity

    4M^2-9ab*c^2=(a-b)^2(4a^2+7ab+4b^2)>=0

gives ab*c^2<=4R^(2n)/9. Division by S yields the D bound in
(PP4); U|pD gives the U bound. Since c_bad(n)^2 divides U, (PP5)
follows. Finally M<c^2 implies R<c^(2/n), and m/n=1/p.

In particular the bad-part bound is as strong in its exponent 2/p
as the CE bound at modulus p, but now refers to the finer modulus p^k.

## PP3. The actual first root removes inert primes at the finer modulus

There is a primitive unramified Eisenstein integer w=x+y*zeta with
norm R and w^n=a+b*zeta. Define

    ell=x+y if n=1 mod6,    ell=x if n=5 mod6,
    J=prod_{q|c, q=1 modn, q not=1 mod6n} q^v_q(c).

Then

    J divides |ell|,    3J^2<=4R.                     (PP6)

Proof of the actual root is the AC factorization with n in place of p.
The primitive first norm has at most one factor of 3, so M=R^n excludes
that factor. Each remaining oriented split exponent is divisible by n.
Unique factorization gives a+b*zeta=u*w_0^n. Since gcd(n,6)=1, the
n-th power map of the six units is bijective, and the unit is absorbed
in w. Its norm is R; the primitive unramified nonunit root has R>=7
and no zero boundary arm.

Use the actual normalized arm quotients of SA1 at exponent n. If
n=1 mod6, the sum coordinate is c and its input arm is x+y. If
n=5 mod6, the normalized output is bar(w)^n=bar(a+b*zeta), whose
first coordinate is c and whose corresponding input arm is x.
In either case c=ell*D_j for one of those integer quotient arms.

Take q in J. It is an odd prime greater than n, different from p
and 3, and gcd(M,c)=1 gives q not dividing R. If q split, then
q=1 mod3 and q=1 modn would imply q=1 mod6n. Thus q is inert.
Its actual homogeneous boundary rank

    d=ord((w/bar(w))^3 mod q)

divides n, since q divides the boundary at exponent n. The inert
norm-one group gives d|(q+1)/3. But q=1 modn implies q+1=2 modp,
so gcd(n,q+1)=1 and d=1. The exact valuation law then gives
v_q(T_n)=v_q(T_1)+v_q(n)=v_q(T_1). Consequently every actual
quotient arm has zero q-valuation and v_q(c)=v_q(ell).
This proves J|ell with all its depths. The standard norm-height
identity for one Eisenstein arm gives 3ell^2<=4R, proving (PP6).

## PP4. Quantitative support at modulus 6p^k

The prime supports of c_bad(n) and J are disjoint and their product
is c_bad(6n). Combining (PP5) and (PP6) gives the exact integer bound

    27 c_bad(6n)^2 <= 16 R^(2m+1).                    (PP7)

Therefore

    c_bad(6n) <= [4/(3 sqrt3)]R^(m+1/2)
                < [4/(3 sqrt3)]c^(2/p+1/n),
    c_good(6n) > [3 sqrt3/4]c^(1-2/p-1/n).            (PP8)

Equivalently, the actual full valuation mass satisfies

    sum_{q|c, q=1 mod6p^k} v_q(c)log q
       > (1-2/p-1/p^k)log c+log(3 sqrt3/4).           (PP9)

The lower bound exceeds zero because p>=5 and n>=p. In particular
c has an actual prime divisor congruent to 1 modulo 6p^k, and it is
at least 6p^k+1. At k=1 this recovers AC. At fixed p and growing k,
the modulus grows while the guaranteed fraction tends to 1-2/p;
it is not claimed to tend to one unless p also tends to infinity.

Every common prime-power divisor p^k of two unequal pure exponents
h,g gives the same conclusion, by replacing bases with their h/n
and g/n powers. No premise that h=g or h=g=n is inserted.

## PP5. The full common exponent forces the first root to grow

There is a stronger height consequence using the entire common exponent,
not only its prime base. For any positive integer n, suppose actual
positive primitive a,b and positive integer R,Q satisfy M=R^n,F=Q^n.
Then

    9n(Q-R^2)<=4R^2,    R^2>=9n/4,
    log c > (n/4)log(9n/4).                            (PP10)

The same conclusions therefore hold for n=p^k in (PP1).

Proof. Let D_0=Q-R^2, which is a positive integer because F>M^2.
The complete geometric sum

    S_n=sum_{j=0}^{n-1} Q^(n-1-j)R^(2j)

has n terms, each at least R^(2n-2). Thus S_n>=nR^(2n-2), and
D_0 S_n=ab*c^2<=4R^(2n)/9. Cancel the positive factor
R^(2n-2) to get 9nD_0<=4R^2. Since D_0>=1, the root bound follows.
Finally R^n=M<c^2 gives log c>(n/2)log R and hence (PP10).
This argument is also valid at n=1 and uses no prime-order claim.

PP10 bounds the actual extraction root in terms of the full common
exponent. It still supplies a lower bound on the seed height, not an
upper bound or a contradiction. It complements the support statement
rather than converting a prime-progression mass into a radical bound.

## Remaining gap

This is a necessary condition on actual simultaneous pure powers, with
no assumption of independence between prime supports. All valuations,
including those at primes already in the actual small input arm, have
been accounted for. The prime-power lifting does not bound the radical
of the surviving part, its high multiplicities, or individual point
heights from above. A common pure exponent factor is still essential.
The ramified first norm, moving nonunit residuals and relatively prime
exponents remain separate live routes. No ABC conclusion follows.
