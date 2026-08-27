# Prime 29 fixed-index feasibility scout

This note records a read-only Sage/PARI feasibility study.  It is **not** a
rational-point certificate and none of its provisional class-group or Selmer
outputs may be used as a theorem.  Its purpose is to identify the shortest
credible next computation after the unconditional prime-23 closure.

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

Hence `|S|=4`.  Conditional on the still unproved gate `Cl(K)[2]=0`,

    dim_F2 K(S,2)=1+14+4=19.

PARI `bnfinit` returned the candidate trivial class group in 0.507 seconds.
This is discovery output only.  A separate `bnfcertify` trial ran for more
than eight minutes without returning and was stopped; this scout has not
produced a class-group certificate.

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

Therefore a literal clone of the p=23 principal-prime certificate appears
possible in principle but is operationally unattractive.  The immediate gate
is a compact unconditional proof of `Cl(K)[2]=0` (or eventual independent
full class-group certification), not a billion-record table.

## 3. Conditional descent architecture

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

Using 19 provisional S-unit candidates, exact finite-field and Hilbert-symbol
linear algebra gives, **conditional on their completeness**:

    norm rank                         4,
    Q_3 local-pairing rank            4,
    endpoint Q_3 image dimension      1,
    combined codimension              5,
    dim W                            14.

The first 18 dyadic test classes already give rank 14 on `W`, so the
candidate global over-approximation injects into the dyadic squareclass
space.  This is strong feasibility evidence, not an unconditional Selmer
bound, because the class-group gate remains open.

## 4. Local and Coleman pilot

The target residue is again `T=23 (mod 24)`, hence `T+1 in 8 Z_2`.  A full
Stoll shell recursion has not yet been run.  Its main cost will be repeated
halving in dimension 14; terminal membership should use Hilbert signatures
rather than enumerate all `2^14` products.

At 5 the curve has good reduction, six `F_5` points, and one simple
Weierstrass root.  A 25-digit pilot gave endpoint-log contents `(1,1)` and
rank two modulo five.  The annihilator reduction

    cbar=(4,1,2,0,...,0,1)

takes the unit values `(4,3,4,1)` at `0,1,-1,infinity`; columns 0 and 2 have
unit determinant.  Thus the Coleman finish has the same shape as p=23, but
a frozen high-precision run remains to be made.

## 5. Actionable conclusion

No structural obstruction was found on the curve side.  The next steps, in
order, are:

1. find a compact unconditional `Cl(Q(2^(1/29)))[2]=0` certificate;
2. certify the 19 S-squareclasses and rerun the exact global/dyadic matrices;
3. execute the complete optimized Stoll shells on `T+1 in 8 Z_2`;
4. freeze a high-precision Coleman unit-minor certificate;
5. expose the resulting target-disk proposition transparently in Lean.

[Pure-prime-degree class-number results](https://colinandmargaret.co.uk/Research/CDW_PureFields_76.pdf)
such as Parry--Walter do not directly prove the required 2-class-group
vanishing, so they cannot be substituted for step 1 without an additional
theorem.
