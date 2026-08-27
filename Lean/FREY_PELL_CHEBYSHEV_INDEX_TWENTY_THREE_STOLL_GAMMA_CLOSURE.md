# Prime 23: Stoll–Gamma closure on the Pell 2-adic disk

This is a standalone fixed-index ledger for the prime-23 Chebyshev curve.
It uses accepted number-field descent, Stoll's saturation theorem, and
Coleman integration.  It uses no GRH, BSD, parity conjecture, finiteness of
a Tate–Shafarevich group, `abc`, or Szpiro.

## 0. Current verdict and the exact gate

The local and analytic parts are complete.  In particular, an exact Hilbert
certificate proves that the eleven-dimensional global odd-place
over-approximation injects at 2, the literal Stoll recursion closes the full
Pell disk with shell maxima `(5,6,7)`, and the independent Coleman
calculation leaves only the known rational anchors.

The only remaining gate at the time this ledger was first written is the
unconditional completion of PARI `bnfcertify` for

    K=Q(a),  a^23=2.

Logically, vanishing of the relevant S-class 2-torsion would suffice; the
running certificate proves the stronger and simpler statement `Cl(K)=1`.

PARI has already returned the candidate `CLGP=[1,[],[]]`; that candidate is
not used as a theorem unless the same run returns the literal line
`CLASS_QUOTIENT_CERT=1` and exits with code zero.  Thus, until both records
are present, the rigorous residual is exactly

    prove Cl(K)=1 and thereby certify completeness of the 17 frozen
    S-squareclasses.

No finite computation below is extrapolated to another prime.  Everything
in this note is pointwise at `p=23`.

## 1. The curve and the regular dyadic parameter

Put

    F(T)=4*T_23(T)+5,
    fm(X)=2^22*F(X/4).

The monic polynomial is

    X^23 -92X^21 +3680X^19 -83904X^17 +1201152X^15
    -11210752X^13 +68583424X^11 -269434880X^9
    +646643712X^7 -862191616X^5 +530579456X^3
    -96468992X +20971520.

On `C: Y^2=fm(X)`, write `X=4T` and `Y=2048(2z+1)`.  The integral
characteristic-two model is

    z^2+z=T_23(T)+1.

Its derivative with respect to `z` is one.  Hence it is smooth at `T=-1`,
and

    t=T+1

is a regular analytic parameter.  The Pell congruence `T=23 mod 24` gives

    t in 8 Z_2,   X=-4+4t in -4+32 Z_2.

The base point on the positive branch is `P0=(-4,2048)`.

## 2. The rational subgroup Gamma2

Let `J=Jac(C)` and define `H1=[U1,2048]`, `H9=[U9,6144]`, with

    U1=X^11-2X^10-40X^9+72X^8+576X^7-896X^6-3584X^5
       +4480X^4+8960X^3-7680X^2-6144X+2048,

    U9=X^11+2X^10-40X^9-72X^8+576X^7+896X^6-3584X^5
       -4480X^4+8960X^3+7680X^2-6144X-2048.

The exact identities are

    fm-2048^2=(X+4)U1^2,
    fm-6144^2=(X-4)U9^2.

With `O` the point at infinity, the sign convention is

    [(-4,2048)-O]=-2H1,
    [(4,6144)-O]=-2H9.

The exact Cantor sum is `H1+H9=[UG,VG]`, where

    UG=X^11-X^10-40X^9+36X^8+576X^7-448X^6-3584X^5
       +2240X^4+8960X^3-3840X^2-6144X+1024,

    VG=-3X^10+108X^8-1344X^6+6720X^4-11520X^2+3072.

The script asserts `fm-VG^2` is divisible by `UG`.  We use

    Gamma2=<H1,H9>.

The exact dyadic Hilbert signatures of `H1,H9` have rank two.  Therefore
the four classes `0,H1,H9,H1+H9` are distinct modulo `2J(Q_2)`, and

    Gamma2 intersection 2J(Q_2)=2Gamma2.

## 3. Global squareclasses and exact dyadic injection

Let `S` contain every place of `K=Q(a)`, `a^23=2`, over `2,3,23`.  There
are five such places.  If the separate PARI certificate returns
`CLASS_QUOTIENT_CERT=1` with exit code zero,
then the ordinary and S-class groups have no 2-torsion.  Since `K` has
signature `(1,11)`, the S-unit theorem gives

    dim K(S,2)=1+11+5=17.

The exact curve discriminant assertion

    disc(fm)=-2^484*3^22*23^23

shows that these are all places needed for the global 2-descent support.

The deterministic PARI S-unit companion prints eleven fundamental units
and five S-unit complement generators; together with `-1` these are exactly
the seventeen frozen representatives in the Sage certificate.  It is kept
separate from the long `bnfcertify` input so that a successful proof run
does not need to be repeated merely to print generators.  Sage verifies
that every representative is integral and has norm supported only on
`2,3,23`.

Their independence does not rest only on the generator labels.  Any global
square relation among the seventeen coefficient vectors would satisfy the
norm and 3-adic conditions, hence would lie in `W`; its dyadic localization
would be square.  The exact injectivity of `W` proved below forces that
coefficient vector to be zero.  Thus the seventeen supported classes are
independent, and the class certificate plus the dimension formula makes
them a complete basis.

The exact norm matrix has rank four.  Over `Q_3`, the script verifies that
`X^23-2` has three field factors.  Hilbert pairing against the global
representatives has the full six-dimensional ambient rank.  The endpoint
classes

    d1=a-1,   d9=3(a+1)

are independent.  Because 2 is invertible on the pro-3 subgroup of
`J(Q_3)`, the quotient `J(Q_3)/2J(Q_3)` has the same dimension as its
2-torsion; the three field factors give dimension two.  Thus `d1,d9` span
the complete local Kummer image.  Exhausting the `2^17`
coefficient vectors under the norm and 3-adic conditions gives exactly
`2048` vectors spanning an eleven-dimensional space `W`.  Every global
2-Selmer class lies in `W`; using an over-approximation is deliberate.

For the dyadic place, the script uses

    B=[a] + [1+a^i : i=1,3,...,45] + [1+a^46].

The exact 25-by-25 Hilbert matrix on `B` has rank 25.  Since
`dim K_2^*/K_2^{*2}=23+2=25`, this is a squareclass basis.  The seventeen
raw S-unit representatives have local rank 16, so there is one raw
dyadic kernel.  Crucially, the eleven signatures of `W` have rank eleven:

    ker(W -> K_2^*/K_2^{*2})=0.

Thus the raw kernel is removed by the norm/3-adic conditions and no
locally trivial class survives in the Selmer over-approximation.  This
proves condition (1) of Stoll Theorem 2.1 for the actual Selmer group.

## 4. Local torsion and literal halving

Inside `K_2=Q_2(a)`, the element

    theta=-(2a+a^22)

has minimal polynomial `fm`.  The polynomial `a^23-2` is Eisenstein, and
the change-of-basis matrix from powers of `a` to powers of `theta` is
invertible.  Hence `fm` is irreducible over `Q_2`.  Standard odd-degree
hyperelliptic Kummer theory gives

    J(Q_2)[2]=0,

and consequently there is no 2-power torsion.  Every divisible branch in
Stoll Lemma 2.4 therefore has a unique half.

For a reduced Mumford pair `R=[A,B]`, the script represents its Kummer
class by

    (-1)^deg(A) A(theta).

At every node it tests the four translates by
`0,H1,H9,H1+H9`.  When the class is in the Gamma2 image, exactly one
translate is divisible by two.  Its half is constructed by Stoll
Proposition 5.1 or the two-Mumford system of Remark 5.2.  Every defining
polynomial identity, inverse identity, and output Mumford identity is
asserted with a large p-adic precision margin.  At every input and output,
the script also asserts monicity, the reduced degree bound, squarefreeness,
and coprimality with `fm`; the two-Mumford branch additionally asserts all
required pairwise coprimalities.

When the class leaves the Gamma2 image, recursion stops.  Its terminal
class is compared with all `2048` elements of the full localized `W`, and
the script asserts nonmembership.  This is stronger than testing only a
candidate Selmer subgroup.

## 5. The complete target disk

For each `m=3,4,5`, all sixteen odd residues `u mod 32` are tested at

    t0=2^m u.

The exact output is

    m                              3  4  5
    max nu(i_P0(P(t0))+Gamma2)     5  6  7.

All 48 terminal classes lie outside `loc(W)`.  Points with the same `u`
modulo 32 satisfy

    v_2(t-t0) >= m+5 = (m+2)+3,

which is exactly the threshold in Stoll Corollary 3.2.  The sixteen
representatives cover each shell.  At `m=5`, Lemma 3.10 gives

    2m-3=7 >= n_(5,Gamma2)=7.

Thus the `m=5` shell controls every deeper shell.  Combining the three
shells proves condition (2) of Stoll Theorem 2.1 on the positive branch.

For the negative branch, put `D0=[P0-O]=-2H1`.  If `iota` is the
hyperelliptic involution, then

    i_P0(iota(P))=-i_P0(P)-2D0=-i_P0(P)+4H1.

The correction lies in `Gamma2`, and negation is invisible in the mod-two
Kummer quotient.  Hence the same conclusion holds on both branches.
Stoll's theorem now gives

    [P-P0] in saturation_J(Q)(Gamma2)

for every rational point in the target disk.

The frozen canonical run uses precision 16000.  Its transcript records all
48 shell representatives; at `m=5` it gives identity valuations at least
11747, depth seven, and terminal nonmembership.  No unfrozen preliminary run
is used as evidence.

## 6. Coleman finish at 5

Use the good-reduction model

    C5: y_c^2=F(x)/2^24.

The exact identity `fm(4x)=2^22 F(x)` gives the isomorphism

    X=4x,   Y=2^23 y_c.

In particular,

    (-1,1/4096) -> (-4,2048),
    ( 1,3/4096) -> ( 4,6144).

The Sage script computes the two Coleman logarithms from infinity to these
points.  Both rows have 5-adic content exactly one.  After division by 5,
their reductions have rank two and columns zero and one form a unit minor.
The reduced vector

    (1,0,0,0,0,0,0,0,0,0,3)

annihilates both rows.  Holding columns 2 through 10 fixed and solving the
unit minor defines an exact Q_5 differential annihilating `Gamma2`.  Its
reduction evaluates to

    1,4,4,3

at the residue types `x=0,1,-1,infinity`; hence its Coleman primitive has
at most one zero in each of the six `F_5` residue disks.  Here this last
assertion does not use the usual sufficient hypothesis `p>2g`, which would
fail for `p=5`, `g=11`.  The needed diskwise argument is elementary.  Choose
an integral regular parameter `t` centred at a residue point, so the disk is
`t in 5 Z_5`.  Nonvanishing of the reduced differential says

    omega = (u_0 + u_1*t + u_2*t^2 + ...) dt,   u_0 in Z_5^*.

For `t=5s`, the difference quotient of its primitive at two parameters is

    u_0 + sum_(n>=2) u_(n-1) * 5^(n-1)
              * (s_1^n-s_2^n)/(n*(s_1-s_2)).

Every term in the sum is divisible by `5`, because
`n-1-v_5(n)>=1` for `n>=2`.  The quotient is therefore a 5-adic unit.
Thus the primitive is injective on the whole residue disk and has at most
one zero there.  This also covers the disk at infinity after taking its
standard integral regular parameter.

The script directly checks that the six residue points have x-types
`infinity,0,1,1,-1,-1` and that the reduced differential is nonzero at
each one.  Five rational anchors occupy five disks: infinity and the two
signs over each of `x=-1,1`.  In the sixth disk, the unique Q_5
Weierstrass point `W` is a zero because `[W-O]` is 2-torsion, so its
Coleman logarithm vanishes.  Irreducibility of `f` over `Q` proves that
`W` is not rational.  Therefore the target dyadic disk contains only its
known rational anchors and supplies no solution with `T>1`.

## 7. Reproduction and trust boundary

PARI class-quotient and S-unit input:

    bash Lean/audit_scripts/run_p23_chebyshev_class_quotient_cert.sh
    gp -q Lean/audit_scripts/p23_chebyshev_sunit_basis.gp

The generator output is frozen in
`p23_chebyshev_sunit_basis.transcript`.  The class run is accepted only when
`p23_chebyshev_class_quotient_cert.transcript` contains
`CLASS_QUOTIENT_CERT=1`, the separate `.exit` file contains zero, and the
metadata contains an end timestamp.  The latest wrapper attempt stopped
before producing any of those three acceptance conditions, so its partial
generated files are deliberately not versioned.  The older
`p23_chebyshev_class_cert_interrupted.transcript` is retained as negative
provenance, not as a certificate.

Exact SageMath 10.9 global and dyadic input:

    sage Lean/audit_scripts/p23_chebyshev_global_dyadic_overapprox.sage
    sage Lean/audit_scripts/p23_chebyshev_stoll_gamma2.sage

The corresponding frozen outputs are split into
`p23_chebyshev_global_dyadic_overapprox.transcript` (the exact global
prefix) and `p23_chebyshev_stoll_gamma2.transcript` (all 48 shell lines and
the tail conclusion).

Exact SageMath 10.9 Coleman input:

    sage Lean/audit_scripts/p23_chebyshev_gamma2_coleman.sage

Its output is `p23_chebyshev_gamma2_coleman.transcript`; the software
versions are recorded in `p23_chebyshev_stoll_gamma2_versions.transcript`.

The proof accepts PARI/Sage exact number-field and local-field kernels,
standard hyperelliptic Kummer theory, Stoll Theorem 2.1, Lemma 2.4,
Corollary 3.2, Lemma 3.10, Proposition 5.1 and Remark 5.2, and standard
Coleman integration.  It does not infer a theorem for any other prime.

The frozen byte manifest is
`Lean/audit_scripts/p23_chebyshev_stoll_gamma2.sha256`.  At this stage it binds
the ledger, conditional Lean companion, reproduction scripts, and every
completed PARI/Sage transcript.  It intentionally omits the incomplete class
run outputs.  After the literal success line and exit code zero appear, the
manifest must be regenerated to add the executed metadata, transcript, and
exit record.  The manifest does not hash itself.

Reference: Michael Stoll, “Chabauty Without the Mordell-Weil Group,” in
*Algorithmic and Experimental Methods in Algebra, Geometry, and Number
Theory*, Springer (2017), pp. 623–663,
DOI [10.1007/978-3-319-70566-8_28](https://doi.org/10.1007/978-3-319-70566-8_28).
