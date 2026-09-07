# Independent review of the actual quartic Q-curve and local branches

Date: 2026-09-07. This records independently checked ordinary arguments
communicated by the independent-route agent and the subsequent complete
written FM1--FM4 in `sixth_round/frey_modular_entry.md`.
Final ordinary result for FM1--FM4: PASS. No Lean claim is made.

## Arithmetic and the inverse gate

For positive primitive integers a,b set x=a^2+b^2, y=a+b and
F=a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4. Then

    x^2+3*y^4=4F,   2x-y^2=(a-b)^2,   gcd(x,y)|2.

The second square and positivity conditions must remain part of the
actual inverse problem. When a,b are both odd, X=x/2,Y=y/2,D=(a-b)/2
give X^2+12Y^4=F and X-Y^2=D^2, with |D|<Y. In the opposite-parity
case x,y and a-b are odd and the original coefficient-four equation
must be retained. Neither generalized Fermat equation alone encodes
all the seed constraints.

## The curve and its invariants

Let r=sqrt(-3), alpha_+=3y^2+xr, alpha_-=3y^2-xr, and

    E: Y^2=X^3+A X^2+B X,  A=12y, B=6 alpha_+.

Direct expansion verifies

    alpha_+ alpha_-=12F,
    c4=2^5*3^2*(5y^2-xr),
    c6=2^8*3^3*y*(3xr-7y^2),
    Delta=2^11*3^4*F*alpha_+.

Indeed A^2-4B=24 alpha_- and Delta=16B^2(A^2-4B).
The standard rational-two-torsion isogeny has target coefficients
(-2A,A^2-4B), exactly the (-2)-quadratic twist of the conjugate
curve. The isogeny identity is algebraic; the subsequent modularity,
twisting-character and level-lowering requirements are separate.

At any prime ideal over a rational q>3, simultaneous divisibility of
alpha_+ and alpha_- would force q|x,y, contradicting gcd(x,y)|2.
If the prime divides F, exactly one alpha vanishes; c4 reduces to
a nonzero constant times y^2, and hence is a unit. Thus the local
reduction is multiplicative and its discriminant valuation is either
v(F) or 2v(F). Away F and 6 the model has good reduction.

## The ramified prime over three

Normalize v_r(r)=1, so v_r(3)=2. For primitive a,b, x=a^2+b^2
is always a unit modulo three. Hence v_r(alpha_+)=1,
v_r(B)=3, v_r(A)>=2, and v_r(Delta)=9. The coefficients a1,a3,a6
are zero. The additive normalization is already satisfied. The first
auxiliary cubic is T^3 and the later quadratic is T^2; both required
root translations can be zero. The next test sees v_r(a4)=3
exactly and yields type III*, minimal discriminant valuation nine,
and conductor exponent two.

## The inert prime over two

Use the integral basis 1,zeta, with zeta=(1+r)/2. For integer U,V,

    U+Vr in 2^j O  iff  2^j | (U-V) and 2^(j-1) | V,  j>=1.

This basis condition, rather than coordinatewise divisibility in
the nonintegral basis 1,r, is essential. Make the integral change
X=X'+R,Y=Y'+T. The new coefficients are

    a1'=0, a2'=A+3R, a3'=2T,
    a4'=B+2AR+3R^2,
    a6'=R^3+AR^2+BR-T^2.

If y is even, both a,b are odd and x=2 mod8. Choose R=2 and
T=2(r+s), with s=1 for y=0 mod4 and s=-1 for y=2 mod4.
Then

    a4'=6(H+xr), H=3y^2+8y+2,
    a6'=(16+48y+36y^2)+(12x-8s)r.

Both H/2 and x/2 are odd; the integral-basis test gives
v_2(H+xr)=2 and v_2(a4')=3. The r coefficient in a6' is divisible
by 16, and its constant coefficient minus that coefficient is
divisible by 32. To see the latter explicitly, the constant is
16 modulo32 when y=0 mod4 and zero when y=2 mod4; the r coefficient
has exactly the same corresponding residue, since x=2 mod8.
Also v_2(a2')=1 and v_2(a3')=3.

If y is odd, the seed has opposite parity and x=1 mod4. Choose
R=1+r. Use T=4 if the even seed coordinate is zero modulo four,
and T=2(r+1) if it is two modulo four. In these branches x is
respectively 1 or 5 modulo eight. Now

    a4'=6(H+Jr), H=3y^2+4y-1, J=x+4y+1.

Both H/2 and J/2 are odd, proving v_2(a4')=3. For T=4, the
r coefficient of a6' is V=24y+18y^2+6x and its constant minus
V is -24(1+2y+x). For T=2(r+1), the r coefficient is V-8 and
the difference is 8(1-6y-3x). The respective x residues modulo
eight give 16|V or 16|(V-8); odd y and x=1 mod4 give divisibility
by 32 of the stated differences. Also v_2(a2')=1 and v_2(a3')=3.

Thus in all four branches the uniform conditions are

    v_2(a2')=1, v_2(a3')>=3, v_2(a4')=3, v_2(a6')>=5.

The first auxiliary cubic is Z^2(Z+b) with b a unit, so its double
root is already zero. In the I_m* subalgorithm the first quadratic
is Z^2 modulo two, with zero root; retain the zero translation and
pass to its next quadratic. That quadratic has linear coefficient
a4'/8, a unit. It has distinct roots over the algebraic closure of
the residue field, so the algorithm terminates at m=2. Since
v_2(Delta)=12, this proves type I_2*, minimality, and conductor
exponent 12-2-4=6.

## Primary-source and scope check

Independently opened Cremona's author-hosted
[Chapter III of Algorithms for Modular Elliptic Curves](https://johncremona.github.io/book/fulltext/chapter3.pdf),
printed pages 67--68. Its double-root loop and final triple-root
tests agree with the structural branches used above. The residue
field at two is F_4: the book's coordinate-selection shortcuts for
prime fields should not be copied there. Here the relevant repeated
roots are explicitly zero, so the zero transformations justify the
same structural algorithm over the local ring. The ordinary proof
does not infer an infinite local classification from the finite
PARI sample. That sample is diagnostic only.

Result: the algebraic identities and both local conductor branches
PASS this independent review. No irreducibility theorem, global
modularity theorem, twisting-character construction, or complete
newform exclusion is established by these calculations.

The complete FM1--FM4 transcription additionally verifies that every
rational q>3 dividing F splits in K: the actual equation makes -3 a
nonzero square modulo q. Thus both primes have multiplicative reduction,
with discriminant valuations v_q(F) and 2v_q(F). Since F>=13 is prime
to six, at least one such prime exists. Its negative j-valuation excludes
CM by integrality of CM j-invariants. The full K-conductor formula in
FM13 follows. The cited actual thirteen-adic theorem was independently
re-read in fifth-round QC2: its quadratic factor modulo thirteen has
nonsquare discriminant, forcing a=b modulo thirteen; the expansion
F(b+13t,b)=13b^4 modulo169 proves exact depth one in the primitive scope.

One minor domain clarification was requested: the basis criterion FM9
is stated for integer depth n>=1. This has no effect on its applications
at n=3 and n=5. FM5 remains under the critical agent's separate source
and representation review; the local calculation alone is insufficient
to assert its proposed rational newform levels.

Final FM1--FM4 TeX transcription was read through the full proof of
`fm-quadratic-conductor`. It agrees with the ordinary proof. A missing
backslash in the integral-basis display (`quad` instead of `\quad`)
was reported and the author confirmed the exact correction. The
positive-integer depth domain is now explicit. Result: transcription
PASS after that correction. The new minimum-isogeny-degree argument
is also valid: in the non-CM rank-one Hom group all degrees are the
minimum degree times a square, so an existing degree-two isogeny has
minimum degree two.
