# Unconditional `Cl(K)[2]=0` certificate for `K=Q(2^(1/23))`

This note documents a finite, unconditional replacement for a full
`bnfcertify` proof of `Cl(K)=1`.  It proves exactly what the p=23 descent
needs:

    Cl(K)[2] = 0.

The proof combines exact principal generators for small degree-one prime
ideals with the unconditional local-correction form of the Odlyzko--Poitou
explicit formula.  PARI's provisional class group is used only to *find*
candidate generators.  The proof verifier does not construct or trust a BNF,
a regulator, a unit index, a GRH bound, or a class group.

## 1. Arithmetic of the field

Put

    F(X)=X^23-2,   K=Q(a),   F(a)=0.

The polynomial is 2-Eisenstein and hence irreducible.  Its polynomial
discriminant is

    disc(F)=-2^22*23^23.

The power basis is the full ring of integers.  Indeed, a prime dividing
`[O_K:Z[a]]` must be 2 or 23.  Dedekind's index criterion excludes both:

- modulo 2 the only repeated factor is `X` and
  `(F-X^23)/2=-1`, which is not divisible by `X`;
- modulo 23, `F=(X-2)^23`.  For
  `M=(F-(X-2)^23)/23`, one has

      M(2)=(2^23-2)/23=11 (mod 23).

  The exact computation behind the last congruence is
  `2^22=392 (mod 23^2)`, hence `2^23-2=253=11*23 (mod 23^2)`.

Thus

    O_K=Z[a],   signature(K)=(1,11),
    |d_K|=2^22*23^23,
    rd(K)=23*2^(22/23).

There is one prime above 2 and `(a)=P_2`, so it is principal.  There is one
prime `P_23` above 23 and `(23)=P_23^23`; consequently the image of `P_23`
under any quadratic class character is trivial.

## 2. The hypothetical quadratic class field

The exact sequence

    O_K^* -> {+1,-1} -> Cl^+(K) -> Cl(K) -> 1

shows that the narrow and ordinary class groups agree: the unit `-1`
realizes the negative sign at the unique real place.

If `Cl(K)[2]` were nonzero, `Cl(K)` would have a quotient of order two.
The corresponding quadratic subextension `E/K` of the **ordinary** Hilbert
class field is unramified at all finite primes, and the unique real place
splits (ordinary principal ideals impose no positivity condition).  The
equality `Cl^+(K)=Cl(K)` equivalently says that there is no additional
infinity-ramified narrow layer.  Therefore

    [E:Q]=46,   signature(E)=(2,22),
    d_E=d_K^2,  rd(E)=rd(K)=23*2^(22/23).

Every principal prime ideal of `K` has trivial Artin symbol and hence splits
in `E/K`.  The observations above also force `P_2` and `P_23` to split.

## 3. Exact principal-prime records

The frozen cutoff is

    B=8,928,769.

For every rational prime `q<=B`, `q` different from 2 and 23, and every root
`r` of `r^23=2 (mod q)`, the compressed certificate contains one line

    (q,r,c_0,...,c_22),   G(X)=sum_{i=0}^22 c_i X^i.

The independent Sage verifier checks all of the following exactly:

1. `q` occurs in Sage's exact prime enumeration;
2. `0<=r<q`, `r^23=2 (mod q)`, and `23*r^22` is nonzero modulo `q`;
3. `G(r)=0 (mod q)`;
4. `|Res_X(F,G)|=q` over the integers;
5. all roots for each `q` occur exactly once and no extra line occurs.

For completeness in item 5, if `q` is not 1 modulo 23, the 23rd-power map
on `F_q^*` is bijective and there is one root.  If `q=1 (mod 23)`, there
are 23 roots precisely when

    2^((q-1)/23)=1 (mod q),

and otherwise there are none.  The verifier requires that exact number of
distinct validated roots, so this is root-by-root coverage rather than a
mere aggregate count.

Let `P=(q,a-r)`.  Since `O_K=Z[a]`, `P` is a prime ideal of norm `q`.
The congruence `G(r)=0` says `G(a)` belongs to `P`, hence
`(G(a))` is contained in `P`.  The exact resultant is the field norm of
`G(a)`, so both ideals have norm `q`; therefore

    (G(a))=P.

This implication is independent of how `G` was found.  If the provisional
BNF were wrong, a false candidate would simply fail one of these exact
checks.

There are 598,492 degree-one prime ideals of `K` above rational primes at
most `B`.  The compressed table verifies 598,490 of them; `P_2` and `P_23`
are the two separately proved cases above.  Hence the hypothetical `E`
contains two prime ideals of norm `q` for every one of these degree-one
prime ideals of `K`.

The completed table has 44,862,237 uncompressed bytes and 14,194,846 bytes
under deterministic `gzip -n -9`.  Its SHA256 is

    4cccc7b8209155e3650e9af2dd5e8ecb4d1f2e4bbb3df2a0e86ddf9ef052a5d6.

On the recorded host, generation took 21 minutes 18 seconds and the
independent full exact verification took 25 seconds.

## 4. Unconditional explicit-formula contradiction

The source is Sharon Brueggeman and Darrin Doud, “Local corrections of
discriminant bounds and small degree extensions of quadratic base fields,”
*International Journal of Number Theory* 4 (2008), 349–361,
Proposition 2.3, equations (2.1)–(2.2), and Theorem 2.4(1), pages 2–5:

<https://mathdept.byu.edu/~doud/Papers/Local.pdf>

DOI: [10.1142/S1793042108001389](https://doi.org/10.1142/S1793042108001389).

The audited PDF has SHA256

    69be5b06db965e8612be91e0d8b052cb8b5592112d328113bff66f9c99908cb8.

Write

    h(t)=3(sin(t)-t*cos(t))/t^3,   f(t)=h(t)^2,   f(0)=1.

Proposition 2.3 requires `f` to be continuous, even, nonnegative with
`f(0)=1`, to be integrable on the positive real axis, to have
`f(x)/cosh(x/2)` and `(1-f(x))/x` of bounded variation, and to have
nonnegative Fourier transform.  Brueggeman–Doud explicitly choose the
displayed Tartar function as satisfying these hypotheses and record

    integral_0^infinity f(x*sqrt(y)) dx=3*pi/(5*sqrt(y)).

For a degree `n` field `L` with `r_1` real places, Theorem 2.4(1) gives,
without GRH, for every positive `y`,

    log|d_L| >= r_1+n(gamma+log(4*pi))-12*pi/(5*sqrt(y))-I(y)
                 + sum_P C(P,y),

where

    I(y)=r_1 integral_0^infinity
                 (1-f(x*sqrt(y)))/(2*cosh(x/2)^2) dx
        +n integral_0^infinity
                 (1-f(x*sqrt(y)))/sinh(x) dx,

    C(P,y)=4 sum_{j>=1} log(NP)/(1+(NP)^j)
                 f(j*log(NP)*sqrt(y)).

The bounds used at zero and in the tails are global, not numerical guesses.
Integration by parts gives

    h(t)=(3/2) integral_0^1 (1-u^2) cos(tu) du.

Consequently `|h(t)|<=1`.  Also `1-cos(z)<=z^2/2`, so

    1-h(t) <= (3/4)t^2 integral_0^1 (u^2-u^4)du=t^2/10,
    0<=1-f(t)=(1-h(t))(1+h(t))<=t^2/5,

and `0<=1-f(t)<=1`.

The Sage 10.9 formula script uses 256-bit real balls and MPFI intervals,
with

    sqrt(y)=1419/10000.

It partitions `[0,32]` into 128,000 rational panels.  On each positive panel
it takes an interval upper enclosure and intersects it with the two analytic
majorants above.  On the first panel it uses

    I_1 <= s^2*epsilon^3/30,   I_2 <= s^2*epsilon^2/10,

which follow from `sinh(x)>=x` and `2*cosh(x/2)^2>=2`.  The infinite tails
are bounded exactly by

    I_1 tail <= 1-tanh(16),
    I_2 tail <= -log(tanh(16)).

Every integral appears with a minus sign, so its certified upper endpoint is
used.  Every prime correction appears with a plus sign, so its real-ball
lower endpoint is used.  The retained finite prime-power sum is `j=1,...,100`
for `q<=100` and `j=1` for `q>100`; all omitted summands are nonnegative.

After division by 46, each split degree-one `K`-prime contributes

    (8/46) sum_j log(q)/(1+q^j) f(j*s*log(q)),

because it gives two primes of `E` and Theorem 2.4 contributes a factor 4
per prime.

Before searching, the required safety margin was fixed as `1/500` in
`log(rd)`.  Among rational-prime cutoffs, the interval calculation finds

    first positive cutoff             8,618,387,
    first cutoff with margin >1/500   8,928,769.

At the frozen cutoff its rigorous output is

    target log(rd(E)) = log(23)+(22/23)log(2)
                      = 3.7985045625517060737...,
    explicit-formula lower log(rd(E))
                      > 3.8005045860646038671...,
    rigorous log margin
                      > 0.0020000235128977933...,
    explicit-formula lower rd(E)
                      > 44.72374577964408465...,
    exact target rd(E)=23*2^(22/23)
                      < 44.63438662649071549....

This contradiction proves unconditionally that

    Cl(K)[2]=0.

It does not claim that the whole class group is trivial.

## 5. Consequence for `K(S,2)` and the frozen 17 classes

Let `S` contain all primes of `K` over 2, 3 and 23.  There is one above 2,
three above 3 (residue degrees 1,11,11), and one above 23, so `|S|=5`.
The localization class group `Cl_S(K)` is a quotient of `Cl(K)`.  Since
`Cl(K)[2]=0`, `Cl(K)` has odd order, and so does every quotient; hence

    Cl_S(K)[2]=0.

The standard exact sequence

    0 -> O_{K,S}^*/O_{K,S}^{*2} -> K(S,2) -> Cl_S(K)[2] -> 0

therefore identifies `K(S,2)` with the S-unit squareclasses.  Dirichlet's
S-unit theorem gives rank

    r_1+r_2-1+|S|=1+11-1+5=16,

and the torsion class of `-1` contributes one more dimension.  Thus

    dim_F2 K(S,2)=17.

The existing exact local Hilbert-symbol audit proves that its frozen 17
classes are independent.  The dimension equality above therefore proves
that those 17 classes are a complete basis.  Its rerun now explicitly prints

    P3COUNT 3 P3_DEGREES [1, 11, 11]

and ends in `P23_GLOBAL_DYADIC_OVERAPPROX_PASS`.  Full certification of
`Cl(K)=1` is unnecessary.

## 6. Reproduction and acceptance gates

To reproduce the table from scratch, run the generator wrapper:

    bash Lean/audit_scripts/run_p23_chebyshev_cl2_explicit_cert.sh

The canonical acceptance run is then the read-only frozen recheck.  Before
executing either mathematical stage it records SHA256 hashes of the formula,
generator, verifier, source ledger, original wrapper, recheck wrapper and
compressed certificate:

    bash Lean/audit_scripts/run_p23_chebyshev_cl2_frozen_recheck.sh

Finally generate and immediately verify the non-self-referential manifest:

    bash Lean/audit_scripts/make_p23_chebyshev_cl2_explicit_manifest.sh

The run is accepted only if all of the following hold:

- the formula transcript ends its section with
  `P23_CL2_EXPLICIT_FORMULA_PASS`;
- the independent exact verifier prints
  `P23_CL2_PRINCIPAL_EXACT_VERIFY_PASS`;
- the transcript ends with `EXIT_CODE=0` and the separate exit file is `0`;
- metadata contains start/end times, exact software/image versions, the
  cutoff and both expected counts;
- deterministic `gzip -n -9` output and every proof input/output listed in
  the SHA256 manifest pass `sha256sum -c`.

The frozen recheck completed with both stage exit codes and its final exit
code equal to zero.  It reproduced the same real-ball margin and reverified
all 598,490 resultants while the certificate and executable-input hashes
were already recorded in its metadata.

The manifest intentionally does not hash itself.
