# Prime 29 fixed-index feasibility scout

This note began as a read-only Sage/PARI feasibility scout and is retained for
provenance.  Its formerly provisional stages have since been superseded by the
frozen accepted-interface closure in
`P29_CHEBYSHEV_STOLL_COLEMAN_CLOSURE.md`; this note must not be used in place
of that certificate.

## 1. Exact field arithmetic

Put `K=Q(a)`, `a^29=2`.  The polynomial is 2-Eisenstein.  Dedekind's index
criterion also excludes 29 because

    2^28 = 30 (mod 29^2),
    (2^29-2)/29 = 2 (mod 29).

Thus

    O_K=Z[a],
    signature(K)=(1,14),
    d_K=2^28*29^29,
    rd(K)=29*2^(28/29)=56.6301417736569....

For `S` above `2,3,29`, the residue degrees are

    2 : (1),
    3 : (1,28),
    29: (1).

Hence `|S|=4`.  The later unconditional BDF principal-factor-base certificate
proves `Cl(K)=1`, so the standard `S`-unit exact sequence gives, at the
accepted published-theorem/exact-certificate interface,

    dim_F2 K(S,2)=1+14+4=19.

PARI `bnfinit` initially returned the candidate trivial class group in 0.507
seconds.  That output alone was discovery-only.  A later exact diagnostic
under PARI 2.17.1
again found the tentative class number one, but `bnfcertify(b,1)` then
announced that it had to test primes through

    2,660,292,872,242,387.

It was manually stopped after reaching 572,827.  An independent
Oscar 1.8.1 / Hecke 0.39.22 call with `GRH=false, redo=true` announced the
adjacent bound 2,660,292,872,242,388 and was likewise manually stopped.
Both transcripts say `CERTIFICATE_COMPLETED=false`; neither is a class-group
certificate.  They show that the generic unconditional full-class-group
verification path is computationally inappropriate here, rather than
disproving the tentative answer.  The exact files, interruption semantics,
and checksum manifest are indexed in
`P29_CLASS_GROUP_CERTIFICATION_BARRIER.md`.

## 2. Why the prime-23 explicit-prime table does not scale directly

A hypothetical real-split unramified quadratic extension has degree 58,
signature `(2,28)`, and the same root discriminant.  A 256-bit RealBall
evaluation of the unconditional Tartar--Brueggeman--Doud formula through
`B=30,000,000` remained far below contradiction.  Representative rigorous
log margins were

    s=0.090 : -0.4705925495...
    s=0.095 : -0.4286139201...
    s=0.100 : -0.3950828248...
    s=0.120 : -0.3239780023...
    s=0.140 : -0.3187864351...

A hybrid actual-prime/PNT-tail estimate, used only for planning, predicts
zero margin near `B=3.535*10^10` and safety margin `0.002` near
`B=3.703*10^10`, about `1.522*10^9` degree-one records.  A generator
benchmark through `10^5` produced 9,506 exact resultant records in 38.197
seconds.  Naive single-core extrapolation is roughly 71 days and tens of
gigabytes compressed.  These extrapolations are not proof outputs.

At the scout stage this showed that a literal clone of the p=23
principal-prime certificate was possible in principle but operationally
unattractive, and identified a compact unconditional proof of `Cl(K)[2]=0` as
the immediate gate.  That gate was later closed by the BDF certificate below.

### 2.1 Unconditional BDF factor-base gate

The generic Minkowski route is no longer the smallest complete-generation
interface.  Belabas--Diaz y Diaz--Friedman, Corollary 5.2, gives an
unconditional criterion for all prime ideals of norm below `T` to generate
the full class group.  A 256-bit RealBall run at

    T=40,000,000

uses only the positive degree-one-prime sub-sum and has strict lower margin

    0.603060850068841328285187034766... > 0.

It therefore proves, without GRH, that the prime ideals of norm below this
cutoff generate `Cl(K)`.  The formula, primary-source ledger, frozen
transcript and checksum manifest are documented in
`P29_CL2_BDF_FACTORBASE_ROUTE.md`.

The exact splitting law gives 2,434,529 degree-one ideals and only 424
additional higher-residue-degree ideals under the same strict cutoff, for a
total factor base of 2,434,953 ideals.  The full 16-shard producer run and the
independent BNF-free verifier have now checked an exact principal generator for
every ideal, with the expected residue-degree counts.  Combining these
principalities with the BDF generation theorem proves unconditionally

```text
Cl(Q(2^(1/29))) = 1.
```

The class-group gate and the earlier analytic odd-cokernel problem are both
closed.

## 2.2 Historical alternative: amplification of the former class-group gate

There is now a paper-level reduction that makes a different compact target
available.  Put

    N=Q(a,zeta_29),
    G=Gal(N/Q)=C_29 semidirect_product C_28.

If `Cl(K)[2]` were nonzero, the conjugates over `N` of its quadratic Hilbert
class extension would give a nonzero quotient of the 29-point permutation
module `F_2[G/C_28]`.  Since `ord_29(2)=28`, its augmentation constituent is
irreducible of dimension 28.  The only possible quotient dimensions are
therefore 1, 28, and 29.

The one-dimensional case can also be excluded.  Splitting of the unique
prime above 29 gives a complement to the resulting central `C_2` extension,
so the field is `N M` for a rational quadratic field `M`.  Its finite
discriminant is supported on `{2,29}`.  Exhausting all seven signed
squareclasses

    -1, -2, -29, -58, 2, 29, 58

against the unique quadratic subfields of `N_2` and `N_29` leaves only
`M=Q(sqrt(29))`, already contained in `N`, a contradiction.  Consequently

    Cl(K)[2] != 0  ==>  dim_F2 Cl(N)/2 >= 28.

The full proof and its exact formalization boundary are recorded in
`P29_CL2_GALOIS_MODULE_AMPLIFICATION_AUDIT.md`.  This alternative route alone
is not a proof that `Cl(K)[2]=0`: it would still require an independent upper
bound below 28 for the 2-rank of `Cl(N)`, or another exclusion of the
28-dimensional augmentation constituent.  In particular, an unfrozen
`S`-unit enumeration would have been circular at that stage.  The independent
BDF route in Section 2.1 has instead proved the stronger statement `Cl(K)=1`.

The finite calculation `orderOf (2 : ZMod 29)=28` is separately checked by
Lean in `IUTThreeClosures/P29FiniteCore.lean`, with no `sorryAx` or
`native_decide` axiom.  The irreducible-module and class-field-theoretic
bridges above remain paper-level and are not consequences of that small
kernel theorem alone.

The construction strengthens for several independent characters: if
`r_K=dim_F2 Cl(K)/2` and `r_N=dim_F2 Cl(N)/2`, block projection and finite-
field semilinear descent give `r_N >= 28*r_K`.  A tempting subfield shortcut
using the odd-denominator norm relations of Biasse--Fieker--Hofmann--Page was
audited and does not improve this coefficient.  Their class-group direct sum
has one subfield copy for every term of the group-ring relation.  On the
augmentation module `N_C28` has rank one, so any such relation needs at least
28 terms involving `C_28`; the resulting upper bound already contains
`28*r_K`.  The exact no-go calculation is recorded in
`P29_CL2_NORM_RELATION_AUDIT.md`.

## 3. Certified descent architecture

The monic genus-14 model is

    f_29(X)=2^28*(4*T_29(X/4)+5),
    disc(f_29)=2^784*3^28*29^29.

There are exact endpoint factorizations

    f_29-(2^14)^2       =(X+4)*U_-(X)^2,
    f_29-(3*2^14)^2     =(X-4)*U_+(X)^2,

where

    U_-(X)=X^14-2X^13-52X^12+96X^11+1056X^10-1760X^9
           -10560X^8+15360X^7+53760X^6-64512X^5
           -129024X^4+114688X^3+114688X^2-57344X-16384,
    U_+(X)=U_-(-X).

With `theta=-(2a+a^28)`, exact square tests identify the two Kummer classes
as `a-1` and `3(a+1)`.  Their dyadic Hilbert signatures have rank two.

The frozen certificate in `P29_CHEBYSHEV_GLOBAL_DYADIC_CERTIFICATE.md` uses 19
explicit supported representatives.  Exact finite-field and Hilbert-symbol
linear algebra gives:

    norm rank                         4,
    Q_3 local-pairing rank            4,
    endpoint Q_3 image dimension      1,
    combined codimension              5,
    dim W                            14.

The first 18 dyadic test classes give rank 14 on `W`, so the global
over-approximation injects into the dyadic squareclass space.  Any square
relation among the 19 representatives would lie in `W` and have zero dyadic
signature; injectivity forces it to be zero.  The representatives are
therefore independent and, by the dimension-19 theorem, complete.  The
accepted descent interface now proves the actual 2-Selmer localization is
injective.  No provisional fundamental-unit completeness is used.

## 4. Completed Stoll and Coleman certificates

The target residue is `T=23 (mod 24)`, hence `T+1 in 8 Z_2`.  The complete
Stoll computation tests 48 shell representatives, with maxima `5,6,7`; every
branch terminates outside the global image, and the tail closes at equality
in the fifth shell.  The frozen `Q_5` Coleman run has endpoint-log contents
`(1,1)`, normalized rank two, unit minor in columns `(0,2)`, and reduced unit
values `(4,3,4,1)`.  The exact-lift and diskwise difference-quotient argument,
not a global `p>2g` point-count bound, gives at most one zero in each of the
six residue disks.  All inputs and trust boundaries are assembled in
`P29_CHEBYSHEV_STOLL_COLEMAN_CLOSURE.md`.

## 5. Completed outcome

At the accepted published-theorem plus frozen-computation interface, the
prime-29 target-disk certificate proves

```text
(T+1) % 8 = 0  and  y^2 = 4*T_29(T)+5  ==>  T=-1.
```

Thus there is no solution with `T>1` and `T=23 (mod 24)` at index 29.  Lean
checks the polynomial/model/scalar bridges and keeps this rational-point
certificate as an explicit external proposition; it is not a hidden kernel
axiom.  The active uniform prime-index residual now begins at odd primes
`p>=31`.  Neither that uniform statement nor the subsequent moving square-base
radical estimate is proved here, so this fixed-index closure does not prove
`abc`.

[Pure-prime-degree class-number results](https://colinandmargaret.co.uk/Research/CDW_PureFields_76.pdf)
such as Parry--Walter do not directly prove the required 2-class-group
vanishing, so they cannot be substituted for step 1 without an additional
theorem.
