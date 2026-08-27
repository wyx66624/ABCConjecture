# Prime 29: unconditional Stoll--Coleman closure of the Pell target disk

## 0. Result and exact status

Let `T_29` denote the first-kind Chebyshev polynomial and put

```text
F_29(T)=4*T_29(T)+5.
```

The certificates assembled here prove, at the accepted published-theorem and
exact-computation interface,

```text
P in {y^2=F_29(T)}(Q),  P affine,  T(P)+1 in 8 Z_2
    ==> T(P)=-1.
```

Consequently the rational points in this dyadic target disk are exactly the
two points `(-1,+1)` and `(-1,-1)`.  In particular,

```text
T,y in Z,  T>1,  T=23 (mod 24)  ==>  y^2 != 4*T_29(T)+5.
```

This conclusion is unconditional in the usual mathematical sense: it uses
published BDF, hyperelliptic descent, Stoll, and Coleman results, together
with frozen exact or precision-certified computer algebra, but no unproved
conjecture.  It is an **accepted-interface** certificate rather than a full
Lean-kernel formalization of those theories.  The Lean companion therefore
keeps the final rational-point certificate as an explicit hypothesis and
kernel-checks only the polynomial bridges and scalar consequences.

This document proves only the fixed index `29`.  It does not prove the
remaining uniform prime-index statement for primes at least `31`, and it does
not prove `abc`.

## 1. The three models and the half-divisors

The original, Coleman, and monic dyadic models are

```text
C0: y^2   = F_29(T),
Cc: y_c^2 = F_29(x)/2^30,
Cm: Y^2   = fm(X) = 2^28*F_29(X/4).
```

They are related exactly by

```text
x=T,       y_c=y/2^15,
X=4x,      Y=2^29*y_c=2^14*y.
```

The polynomial `fm` is monic of degree `29`.  The Lean theorem
`pellChebyshevTwentyNine_stollColemanMonicModelBridge` checks the copied
polynomial identity, and
`pellChebyshevTwentyNine_stollColemanEndpointScaleLedger` checks the endpoint
scaling.  Thus the five rational Coleman anchors correspond as follows:

| original model `C0` | Coleman model `Cc` | monic model `Cm` |
|---|---|---|
| infinity | infinity | infinity |
| `(-1,+1)` | `(-1,+2^-15)` | `(-4,+2^14)` |
| `(-1,-1)` | `(-1,-2^-15)` | `(-4,-2^14)` |
| `(1,+3)` | `(1,+3*2^-15)` | `(4,+3*2^14)` |
| `(1,-3)` | `(1,-3*2^-15)` | `(4,-3*2^14)` |

Let `O` be infinity and let `P_-` and `P_+` denote the positive endpoints on
`Cm`.  The exact endpoint factorizations define rational half-divisors
`H1,H9` with the sign convention

```text
D_-=[P_--O]=-2*H1,
D_+=[P_+-O]=-2*H9.
```

The subgroup used throughout the Stoll calculation is

```text
Gamma2=<H1,H9>.
```

It is important not to identify the endpoint divisor classes `D_-,D_+` with
their halves.  The Coleman script integrates to the endpoints, hence computes
the logarithms of `D_-,D_+`; multiplication by `-2` is invertible over
`Q_5`, so annihilating those two logarithms is equivalent to annihilating the
logarithms of `H1,H9`.

## 2. Class number one and the global-to-dyadic bridge

Put

```text
K=Q(a),  a^29=2,       S={prime ideals above 2,3,29}.
```

The BDF real-ball certificate uses the strict norm bound `40,000,000`.  The
degree-one prime-ideal sub-sum alone exceeds the unconditional BDF threshold
by a rigorously positive real-ball margin.  The independent exact resultant
verifier then checks principal generators for every prime ideal in the BDF
factor base:

```text
residue degree 1 : 2,434,529,
residue degree 2 :       406,
residue degree 4 :        14,
residue degree 7 :         4,
total             : 2,434,953.
```

Since these ideals generate the full ideal class group and every one is
principal, `Cl(K)=1`.  No GRH, provisional BNF completeness, regulator, or
unit-group computation enters this implication.

The global certificate next constructs nineteen explicit supported
squareclasses.  Exact norm and `3`-adic Hilbert conditions cut out a space
`W` with

```text
dim_F2 K(S,2)=19,       dim_F2 W=14.
```

Standard odd-degree hyperelliptic descent places the actual 2-Selmer image
inside `W`; equality is not claimed or needed.  On `W`, eighteen exact dyadic
Hilbert tests have rank `14`, so

```text
W --> K_2^*/K_2^{*2}
```

is injective.  Its restriction to the actual Selmer image is therefore also
injective.  This supplies the global localization hypothesis in Stoll's
theorem without a Mordell--Weil rank assumption.

## 3. The complete Stoll calculation

On `Cm`, write

```text
X=4T,       Y=2^14*(2z+1),       t=T+1.
```

The characteristic-two equation is `z^2+z=T_29(T)+1`, whose derivative in
`z` is one.  Hence `t` is a regular parameter at the target disk.  The Pell
residue `T=23 (mod 24)` lies in

```text
t in 8 Z_2,       X in -4+32 Z_2.
```

The exact dyadic Kummer signatures of `H1,H9` have rank two.  Therefore

```text
Gamma2 intersection 2J(Q_2) = 2Gamma2.
```

Irreducibility of `fm` over `Q_2` gives `J(Q_2)[2]=0` and hence no nonzero
dyadic 2-power torsion.  The closure of a two-generator subgroup has Lie
dimension at most two, strictly below `dim J(Q_2)=14`, so the required
non-finite-index condition also holds.

The frozen precision-8000 computation performs literal translated halving,
checks the Mumford and halving identities at every step, and tests terminal
membership against the exact fourteen-dimensional image of `W`.  It covers
sixteen odd-unit representatives at each of the three shells and obtains

| shell `m` | representatives | maximum `nu` | minimum identity valuation |
|---:|---:|---:|---:|
| 3 | 16 | 5 | 7148 |
| 4 | 16 | 6 | 7347 |
| 5 | 16 | 7 | 7168 |

All 48 terminal classes lie outside `loc_2(W)`.  The tail inequality closes
at `m=5`:

```text
2*m-3=7=nu_max.
```

The hyperelliptic involution changes the base-point embedding by the
correction `4H1`, which lies in `Gamma2`; therefore the same calculation
covers both signs of `Y`.  Applying the accepted Stoll interface gives

```text
P in Cm(Q),  T(P)+1 in 8 Z_2
    ==> [P-P0] in Sat_Q(Gamma2),
```

where `P0=(-4,2^14)` and `Sat_Q` denotes rational saturation in `J(Q)`.

## 4. The frozen Coleman unit-minor

The Coleman model `Cc` has genus `14`.  The exact checks

```text
v_5(disc(f))=0,       f irreducible over Q
```

give good reduction at `5` and exclude a rational Weierstrass point.  Its
special fibre has exactly six points:

```text
(1:0:0), (0:0:1), (1:1:1), (1:4:1), (4:2:1), (4:3:1).
```

The reduction of `f` has the unique simple root `(0,1)`.  In the regular
differential basis

```text
omega_j=x^j dx/(2*y_c),       0<=j<=13,
```

let `ell_-` and `ell_+` be the Coleman logarithms from `O` to the positive
endpoints.  Both rows have 5-adic content exactly one.  After division by
five, their exact reductions are

```text
M = [1 0 3 1 4 0 3 3 0 2 2 0 1 0]
    [2 0 2 3 2 0 4 2 2 1 4 3 2 3].
```

This matrix has rank two.  Columns `0` and `2` form the minor

```text
[1 3]
[2 2],       determinant = 1*2-3*2 = -4 = 1 (mod 5).
```

The reduced vector

```text
cbar=(4,1,2,0,0,0,0,0,0,0,0,0,0,1)
```

satisfies `M*cbar=0`.  Its numerator is

```text
4+x+2*x^2+x^13,
```

whose values at `x=0,1,-1,infinity` are respectively

```text
4,3,4,1  (mod 5).
```

Here is the exact-lift argument.  Lift every coefficient outside columns
`0,2` by its displayed **ordinary integer representative** in `Z_5`, then
solve the two exact normalized logarithm equations in columns `0,2`.  The
corresponding exact `2 x 2` minor is a unit, so it is invertible over `Z_5`.
Reduction of the unique solution is `cbar`, because the reduced equations are
`M*cbar=0`.  This constructs an actual differential `omega` over `Q_5` that
annihilates both endpoint logarithms and reduces to the displayed vector.

The executable line `K(ZZ(cbar[j]))` uses ordinary integer lifts; it does
not compute Teichmuller lifts.  A comment in the frozen source uses the latter
word informally, but the operation, proof, and present trust ledger use the
correct ordinary-lift interpretation.  The source is left byte-for-byte
unchanged so that its recorded hash remains valid.

At input precision `110`, the solved products are

```text
[O(5^107), O(5^107)].
```

These finite-precision zeros are a stability margin, not a claim of symbolic
equality by themselves.  The true exact `Q_5` kernel lift exists because the
exact minor is a unit; the precision computation certifies its reduction and
shows a 107-digit margin.

Since `D_-=-2H1` and `D_+=-2H9`, the differential annihilates `Gamma2`.  If
`nQ` lies in `Gamma2` for a nonzero integer `n`, then

```text
n*log_omega(Q)=log_omega(nQ)=0.
```

The target is a characteristic-zero field, so `n` is invertible in `Q_5`
and `log_omega(Q)=0`.  Thus `omega` annihilates the full rational saturation
of `Gamma2`, including when `5` divides `n`.

## 5. The diskwise one-zero lemma at `p=5`

The often quoted global Coleman bound with a hypothesis such as `p>2g`
cannot be used here: `p=5` and `2g=28`.  Instead we prove injectivity of the
primitive separately on every residue disk.

Let `t` be an integral regular parameter on a disk and suppose a regular
differential has nonzero reduction there.  Then

```text
eta=(u_0+u_1*t+u_2*t^2+...) dt,       u_0 in Z_5^*.
```

For two distinct parameters `t_1,t_2 in 5 Z_5`, a primitive `Lambda`
satisfies

```text
(Lambda(t_1)-Lambda(t_2))/(t_1-t_2)
  = u_0 + sum_(n>=2) (u_(n-1)/n)
        * (t_1^n-t_2^n)/(t_1-t_2).
```

Writing `t_i=5s_i`, every term in the sum after `u_0` has valuation at least

```text
n-1-v_5(n) >= 1       (n>=2).
```

The difference quotient is therefore a 5-adic unit.  A primitive is
injective on the disk and has at most one zero there.  This argument is
applied with the standard integral uniformizer at infinity.  At the simple
Weierstrass point, `y_c` is a regular parameter and the identity
`2*y_c*dy_c=f'(x)dx`, with `f'(x)` a unit, gives the same conclusion.  Thus
the four nonzero values of the reduced numerator prove nonvanishing on all
six disks without any `p>2g` assumption.

## 6. Five rational anchors, one non-rational zero, and `T=-1`

There is a known zero of the Coleman primitive in every residue disk:

1. `O` is a zero by normalization.
2. The four signed endpoints over `x=-1,1` are zeros because `omega`
   annihilates the endpoint classes; the negative signs give the negatives
   of the positive divisor classes.
3. The unique simple root modulo five lifts by Hensel's lemma to one point
   `W=(alpha,0)` in `Cc(Q_5)`.  The divisor identity
   `div(x-alpha)=2W-2O` makes `[W-O]` 2-torsion.  The 5-adic abelian
   logarithm kills torsion, so the Coleman primitive vanishes at `W`.

These are six zeros in the six distinct residue disks.  By the diskwise
lemma, there are no others.  The point `W` is not rational: a rational
Weierstrass point would give a rational root of the exactly checked
irreducible degree-29 polynomial `f`.

Now let `P` be a rational point in the dyadic target disk.  Stoll gives
`[P-P0] in Sat_Q(Gamma2)`, while `[P0-O]=-2H1` lies in `Gamma2`.  Hence
`[P-O]` also lies in `Sat_Q(Gamma2)`, so its Coleman primitive is zero.
Therefore `P` is one of the five rational anchors.  The point at infinity is
not affine, and the two anchors with `T=1` fail `T+1 in 8 Z_2`.  Only the two
anchors with `T=-1` remain.  This proves the target-disk assertion in
Section 0.

## 7. Lean boundary and remaining uniform problem

`IUTThreeClosures/FreyPellChebyshevIndexTwentyNineStollGammaCertificate.lean`
checks:

- the degree-29 Chebyshev polynomial and model-scaling identity;
- endpoint scaling and the copied class-number and shell counts;
- the negative-branch correction;
- the characteristic-zero saturation scalar step;
- the exact modulo-five unit-minor and unit-value ledgers; and
- the implication from the transparent external target-disk proposition to
  the integral exclusion at `T>1`, `T=23 (mod 24)`.

The file introduces no axiom for BDF, Sage, Stoll, or Coleman.  Its external
proposition is

```text
PARISageRationalTargetDiskCertificateIndexTwentyNine.
```

`FreyPellChebyshevPrimeIndexReduction.lean` then uses this explicit
hypothesis to move the exact uniform residual from odd primes `p>=29` to odd
primes `p>=31`.  The repository still has to prove that latter uniform
statement before the Pell route, and hence `abc`, can close.

## 8. Reproduction and byte-level closure

From the repository root under WSL, the relevant frozen checks are

```console
bash Lean/audit_scripts/run_p29_chebyshev_cl1_bdf_principal_frozen_recheck.sh
bash Lean/audit_scripts/run_p29_chebyshev_global_dyadic_overapprox.sh
bash Lean/audit_scripts/run_p29_chebyshev_stoll_gamma2.sh
bash Lean/audit_scripts/run_p29_chebyshev_gamma2_coleman.sh
bash Lean/audit_scripts/make_p29_chebyshev_stoll_coleman_closure_manifest.sh
```

The Coleman run used SageMath 10.9 at precision `110`, ran from
`2026-08-27T17:39:18Z` to `2026-08-27T19:52:59Z`, and ended with exit code
zero.  Its final markers are

```text
P29_GAMMA2_COLEMAN_LOCAL_CERTIFICATE_PASS
P29_GAMMA2_COLEMAN_FROZEN_RUN_PASS
EXIT_CODE=0
```

The full closure manifest recursively verifies the already frozen global and
Stoll manifests.  It directly binds the Coleman source, wrapper, transcript,
metadata, and exit record; the current Lean companion, prime-index reduction,
and axiom audit; this document; and the manifest-maker itself.  The manifest
does not hash itself.

The accepted external interfaces are:

- K. Belabas, F. Diaz y Diaz, and E. Friedman, *Small generators of the ideal
  class group*, Math. Comp. 77 (2008),
  [DOI 10.1090/S0025-5718-07-02003-0](https://doi.org/10.1090/S0025-5718-07-02003-0);
- standard odd-degree Poonen--Schaefer/Schaefer/Stoll hyperelliptic descent
  and local Kummer theory;
- Michael Stoll, *Chabauty Without the Mordell-Weil Group*,
  [DOI 10.1007/978-3-319-70566-8_28](https://doi.org/10.1007/978-3-319-70566-8_28);
- J. Balakrishnan, R. Bradshaw, and K. Kedlaya,
  [*Explicit Coleman integration for hyperelliptic curves*](https://arxiv.org/abs/1004.4936);
- R. Coleman,
  [*Torsion points on curves and p-adic Abelian integrals*](https://annals.math.princeton.edu/1985/121-1/p03);
- exact number-field, finite-field, Hilbert-symbol, hyperelliptic-Jacobian,
  and certified finite-precision `Q_5` arithmetic in the frozen SageMath 10.9
  environment.

No GRH, BSD, parity conjecture, finiteness of a Tate--Shafarevich group,
`abc`, or Szpiro is assumed.
