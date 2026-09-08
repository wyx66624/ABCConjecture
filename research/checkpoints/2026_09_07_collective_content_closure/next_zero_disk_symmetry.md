# DS1--DS3. Four disk orbits and forced even orders

Next-only ordinary candidate. This is not part of the sealed publication at
main 455c68d, a zero certificate, or a Lean theorem. It uses the fixed curve,
maps and locally analytic function proved in ZS1--ZS4. No statement about
moving curves or ABC follows.

Let

    C: W^2=z^6-27z^4+99z^2-9,
    R1=((z^2-9)/4,W/8),
    R2=((33-9/z^2)/4,-9W/(8z^3)).

The two quotient curves are short Weierstrass models. Let F0 be ZS9, with
its established extensions over z=0 and infinity, and set

    f=F0+(4/3)log_5(3).

Thus the required local-height condition is f=0.

## DS1. Exact invariance of the function

The commuting involutions

    iota(z,W)=(z,-W),       s(z,W)=(-z,W)

extend to the smooth projective curve, generate a group of order four, and
leave f invariant on all C(Q5).

Proof. Off the exceptional fibers their effects on the actual maps are

    R1 o iota=-R1,    R2 o iota=-R2,
    R1 o s=R1,        R2 o s=-R2.

For an odd index, the division polynomial psi_9 is a polynomial in x.
The parameter t=-x/y changes sign under negation, and negation commutes
with multiplication by nine. Therefore the rational function
delta(Q)=t([9]Q)/psi_9(Q) satisfies delta(-Q)=-delta(Q).
This identity includes its established removable values by continuity.

Under iota, the two signs in delta_1(R1)/delta_2(R2) cancel. Under s,
both z^81 and delta_2(R2) change sign. Hence Xi from ZS8 is unchanged
under either involution. The T_i change by the same signs as R_i.
The series R_0i are even and L_i are odd, so both R_0i(T_i) and
L_i(T_i)^2 in ZS9 are unchanged. All coefficients alpha_i^0 and the
target constant are fixed. This proves invariance off the exceptional
fibers. The locally analytic extensions in ZS3 give invariance there too.
The displayed involutions are distinct and commute, proving the group
assertion. QED.

## DS2. Complete orbit reduction from twelve disks to four

The twelve smooth residue disks of C(Q5) have four orbits under this group:

* the two disks above z=0;
* the four disks above z=1 or -1;
* the four disks above z=2 or -2;
* the two disks at infinity.

One representative of each orbit may be based at

    (0,sqrt(-9)), (1,8), (2,sqrt(19)), infinity with W/z^3=1,

where each displayed square root is one of its two Q5 lifts.
Use local parameter u=z-a in each finite representative and q=1/z at
infinity, in both cases ranging over 5Z5.

Any complete certified zero list on these four representative disks
determines the zero list on every disk by the explicit involutions.
Multiplicity is preserved. This conclusion requires a complete certificate
on each representative; it does not replace such a certificate by symmetry.

Proof. Modulo five the right side has value one at zero and four at all
four nonzero residues. All ten finite ordinates are nonzero. The two
infinities have W/z^3=+1 and -1. Changing W swaps the two ordinates;
changing z interchanges each nonzero pair of abscissas and preserves zero.
At infinity either involution swaps the two signs. These facts give exactly
the four stated orbits, with no missing disk.

On finite disks iota preserves u and s takes u to -u when transporting
the base a to -a. At infinity iota preserves q and s takes q to -q.
Their maps between disks are analytic isomorphisms with nonzero linear
coefficient. An analytic isomorphism preserves the order of vanishing of
a nonzero local analytic function. DS1 therefore transports zeros and
their multiplicities as claimed. QED.

## DS3. The two fixed-fiber series are even

On the representative disk at z=0, f is an even analytic series in u=z.
On the representative infinity disk, f is an even analytic series in q.
In particular, if the central point of either disk is a zero and the
function is not identically zero there, its zero multiplicity is a
positive even integer. Its first derivative at the central point vanishes
whether or not the central point is a zero.

Proof. On the zero disk the unique Hensel branch through the chosen
ordinate satisfies W(-u)=W(u): the sextic is even and both branches have
the same value at zero. Thus s preserves this representative disk and
acts by u to -u. At infinity put v=Wq^3. Its equation is

    v^2=1-27q^2+99q^4-9q^6.

The involution s o iota preserves the sign v(0)=1 and sends q to -q,
v to v. Apply DS1 in both cases. Comparing coefficients in characteristic
zero makes every odd coefficient vanish. If a nonzero series has zero
constant coefficient, its first nonzero coefficient thus has positive
even degree. QED.

This is relevant to the pending analytic certificate: simple-root tests
cannot be assumed to settle central zeros at these two fibers. No claim
about whether either central value actually vanishes is made here.
