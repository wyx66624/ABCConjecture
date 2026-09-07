# CI1--CI2. An integral converse for all positive points of the pure-coefficient curves

Status: complete ordinary proof; root, critical_bottleneck, and
adversarial_audit independently reviewed CI1--CI2 and passed. Both peers
also passed the final self-contained TeX transcription. The pure
coefficient converse was proposed independently by critical_bottleneck
and checked algebraically by this author before writing the full proof.
The tenth-round DC/RD sources are not modified.

Let zeta^2-zeta+1=0 and gamma=1+zeta, so gamma^2=3*zeta. Let h,g>=2
be integers. Fix units u0,u1 and e0 in {0,1}, and use the RD maps with

    tau0=u0*gamma^e0, tau1=u1.

Let D be the full rational fiber product

    L_tau1,g(t1)=r(L_tau0,h(t0)),
    r(x)=x/(x^2+x+1).                                (CI1)

## CI1. Every positive rational point gives actual pure norm profiles

For every Q-rational point (t0,t1) of D with x=L_tau0,h(t0) positive
and finite, write x=a/b in lowest positive terms. Then there exist
an exponent e in {0,1} and integers R,Q>=7 such that

    a^2+ab+b^2=3^e R^h,
    F(a,b)=Q^g.                                      (CI2)

Both are actual oriented Eisenstein profiles with unit residuals.
No unramifiedness or nonunit assumption on the projective input
coordinates t_i is imposed. The first ramified exponent e need not
equal e0 when h is odd. When h is even one has e=e0.

Proof. Represent any rational projective point t_i by a primitive
integer pair (r_i,s_i), and write w_i=r_i+s_i*zeta. This includes
s_i=0 and the point at infinity. Each w_i is nonzero. Its gamma-depth
epsilon_i is either zero or one: depth at least two would imply
divisibility of both coordinates by the rational prime three because
gamma^2=3*zeta. Write

    w_i=gamma^epsilon_i*v_i,
    epsilon_i in {0,1}, v_i primitive unramified.

Dividing a primitive element by gamma cannot introduce a common
rational factor into its coordinates, so the displayed v_i is indeed
primitive. The previously reviewed oriented UFD factorization shows
that all powers v_i^n remain primitive and unramified.

For either output, write E=e_initial+epsilon_i*n, where the initial
ramified exponent is e0 on the first side and zero on the second.
The exact identity gamma^2=3*zeta gives

    u*gamma^E*v_i^n
      =3^floor(E/2) * u*zeta^floor(E/2)
           *gamma^(E mod 2)*v_i^n.                  (CI3)

The final element in CI3 is primitive: its split factors have only
one orientation at each prime, and its gamma-depth is at most one.
Its content is therefore one. Thus the full projective content of
the output is exactly 3^floor(E/2), and its reduced norm is

    3^(E mod 2)*N(v_i)^n.                            (CI4)

Let M=a^2+ab+b^2. The primitive first output, after changing its
common sign if necessary, is exactly (a,b), so CI4 gives

    M=3^e R^h, R=N(v0),
    e=(e0+epsilon0*h) mod 2.

The primitive second output has ratio ab/M by CI1. Since gcd(ab,M)=1,
its positive primitive coordinates are exactly (ab,M). Consequently

    F(a,b)=3^(epsilon1*g mod 2)*Q^g, Q=N(v1).

The actual quartic is prime to three, so epsilon1*g is even and
F=Q^g. Also F(a,b)>=13 for a,b>=1, hence Q>1. Being a primitive
unramified norm, Q is an integer at least seven.

If R were one, the first norm would be 3^e<=3. For positive a,b,
M>=3, with equality only when a=b=1. That would give F=13=Q^g,
impossible for an integer g>=2 and Q>1 because thirteen is prime.
Thus R>1 and R>=7.

The primitive factorizations left in CI3, after the common sign
changes, are precisely actual oriented pure profiles. The signs
only alter their units. This proves the full integral conclusion,
including all projective input cases. Finally e=e0 when h is even,
whereas the possible first ramified parity change for odd h is
explicitly retained.

Conversely, every positive primitive seed with actual pure profiles
M=3^e R^h, F=Q^g gives, by DC/RD, a rational point of one of these
curves with tau0=u0*gamma^e and tau1=u1. Thus after allowing the
finite unit choices and both initial ramified parities, their positive
rational points correspond exactly to the actual pure-profile seeds.
No uniqueness of the point or of its factorization choices is asserted.

## CI2. A complete even/even positive-point obstruction

If both h and g are even, none of the curves CI1 has a rational point
whose x-coordinate is positive and finite.

Proof. CI1 would give M=3^e R^h and F=Q^g with e in {0,1}.
Thus MF/3^e would be a rational square. The already proved QG3 exact
combined-norm obstruction says that for every positive primitive
seed neither MF nor MF/3 is a rational square. This is a contradiction.

The conclusion concerns the positive rational base locus. Points over
other fields, negative base coordinates, and the boundary base values
are not excluded by this argument. It also leaves every exponent pair
outside the even/even subbranch open unless another proved obstruction
applies.

This pure-coefficient converse is consistent with the PC cancellation
counterexample, which has a nonunit multiplier of norm seven. Here the
only cancellation is the explicitly accounted-for ramified power of
three, and the actual second norm removes its residual parity. No
point-height upper bound or proof of the general compatibility problem
is obtained from this converse.
