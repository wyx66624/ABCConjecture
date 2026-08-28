# Prime 31: unconditional Stoll--Coleman closure of the Pell target disk

## 0. Result and exact status

Let `T_31` be the first-kind Chebyshev polynomial and put

```text
F_31(T)=4*T_31(T)+5.
```

The frozen certificates assembled below prove, at the accepted
published-theorem and exact-computation interface,

```text
P in {y^2=F_31(T)}(Q),  P affine,  T(P)+1 in 8 Z_2
    ==> T(P)=-1.
```

Thus the rational points in the target disk are exactly `(-1,+1)` and
`(-1,-1)`.  In particular,

```text
T,y in Z,  T>1,  T=23 (mod 24)  ==>  y^2 != 4*T_31(T)+5.
```

This is unconditional in the usual mathematical sense: it uses accepted
BDF, odd-degree hyperelliptic descent, Stoll, and Coleman theorems together
with frozen exact or precision-certified computer algebra.  It is not a
Lean-kernel formalization of those theories.  No GRH, BSD, parity
conjecture, finiteness or vanishing of a Tate--Shafarevich group, `abc`, or
Szpiro is assumed.

Neither half of the argument suffices alone.  The local Coleman certificate
does not put rational divisor classes in its annihilated subspace.  The
Stoll certificate puts target-disk classes only in the rational saturation
of `Gamma2`; it does not by itself determine those rational points.  Their
accepted-interface composition is the content of this document.

## 1. Three models, endpoint scaling, and half-divisors

Use the original, Coleman, and monic dyadic models

```text
C0: y^2   = F_31(T),
Cc: y_c^2 = F_31(x)/2^32,
Cm: Y^2   = fm(X) = 2^30*F_31(X/4).
```

They are related exactly by

```text
x=T,       y_c=y/2^16,
X=4x,      Y=2^31*y_c=2^15*y.
```

The polynomial `fm` is monic of degree `31`.  The five rational anchors
correspond as follows.

| `C0` | `Cc` | `Cm` |
|---|---|---|
| infinity | infinity | infinity |
| `(-1,+1)` | `(-1,+2^-16)` | `(-4,+2^15)` |
| `(-1,-1)` | `(-1,-2^-16)` | `(-4,-2^15)` |
| `(1,+3)` | `(1,+3*2^-16)` | `(4,+3*2^15)` |
| `(1,-3)` | `(1,-3*2^-16)` | `(4,-3*2^15)` |

Let `O` be infinity and let `P_-` and `P_+` be the positive endpoints on
`Cm`.  The exact endpoint factorizations give rational half-divisors `H1`
and `H9`, with the frozen sign convention

```text
D_-=[P_--O]=-2*H1,       D_+=[P_+-O]=-2*H9,
Gamma2=<H1,H9>.
```

The endpoint classes must not be confused with their halves.  Coleman
integration computes the logarithms of `D_-` and `D_+`.  Since multiplication
by `-2` is invertible over `Q_5`, their common annihilator is also the
annihilator of `Gamma2`.

## 2. Class number one and the global-to-dyadic injection

Put

```text
K=Q(a),  a^31=2,       S={prime ideals above 2,3,31}.
```

The unconditional BDF Corollary 5.2 computation has strict cutoff
`80,000,000` and rigorous full-formula lower endpoint

```text
0.2944058601757084546999811576257929871041149041402660860920359033230486824475.
```

The degree-one lower sub-sum is still negative there; the theorem uses the
complete BDF formula.  An independent exact verifier proves principal all
`4,668,356` prime ideals in the strict factor base, with residue-degree
counts `{1:4667696, 2:600, 3:60}`.  Therefore `Cl(K)=1` at the accepted BDF
interface.  The verifier constructs no BNF, class group, unit group, or
regulator; discovery output is not evidence.

Here `K` has signature `(1,15)`.  There is one prime above 2, two above 3
of residue degrees `(1,30)`, and one above 31.  The exact supported
squareclass certificate gives

```text
dim_F2 K(S,2)=20.
```

The rational norm-square condition has rank four.  The complete local
condition at both places above 3, whose local Kummer image is the nonzero
endpoint line, combines with it to a rank-five constraint.  The resulting
global over-approximation satisfies

```text
dim_F2 W=15,       |W|=32768.
```

Accepted odd-degree Poonen--Schaefer/Schaefer/Stoll descent places the actual
2-Selmer image inside `W`; equality is neither asserted nor needed.  At the
unique dyadic completion, 33 exact Hilbert test classes give rank 15 on
`W`, hence

```text
ker(W --> K_2^*/K_2^{*2})=0.
```

In the monic model the local field is `Q_2(a)`, `a^31=2`, and
`theta=-(2*a+a^30)`.  The exact endpoint Kummer classes are `a-1` and
`3*(a+1)`.  Because the genus is odd, the two endpoint identities include
the essential factor `(-1)^15`.  Their dyadic signatures have rank two.

The exact degree-31 local-field/irreducibility check makes the Galois action
on the roots transitive.  For an odd-degree hyperelliptic curve, rational
2-torsion corresponds to Galois-stable even root subsets modulo complements;
transitivity here leaves only the trivial class.  Thus

```text
J(Q_2)[2]=0.
```

Repeated doubling would carry any nonzero dyadic 2-power torsion to nonzero
2-torsion, so there is no such torsion.  This is an explicit theorem
obligation in the accepted Stoll interface, not a numerical inference.

## 3. The formal precision-12000 Stoll shell

On `Cm`, write

```text
X=4T,       Y=2^15*(2z+1),       t=T+1.
```

The characteristic-two equation is `z^2+z=T_31(T)+1`; its derivative with
respect to `z` is one.  Hence `t` is a regular parameter at the target disk.
The Pell residue `T=23 (mod 24)` lies in

```text
t in 8 Z_2,       X in -4+32 Z_2.
```

The frozen formal source uses precision `12000` and the immutable strict
identity-valuation threshold `2000`.  It checks the global injection,
performs eight exact Cantor reductions, proves the independence of `H1,H9`,
and freezes the signature-minor columns

```text
[3,4,5,6,7,8,9,10,11,12,13,14,15,17,18].
```

They equal the pivot columns and their `15 x 15` minor has determinant one.
The source then checks every node and every translated-halving layer.  There
are sixteen odd-unit representatives `1,3,...,31` in each shell `m=3,4,5`,
for 48 nodes total.  Every initial residual is strictly above 2000: exactly
`12021` on the 16 `m=3` nodes, `12018` on the 16 `m=4` nodes, and `12015`
on the 16 `m=5` nodes.  The shell summaries are

| shell `m` | representatives | maximum `nu` | minimum identity valuation |
|---:|---:|---:|---:|
| 3 | 16 | 5 | 9795 |
| 4 | 16 | 6 | 7419 |
| 5 | 16 | 7 | 4017 |

All 48 terminal flags `TERMINAL_IN_W` are false.  They fall into exactly two
local squareclasses, and a direct exact local-square test rejects membership
in `loc_2(W)` for each class.  Local constancy is checked on each shell, and
the accepted Stoll tail lemma closes with equality

```text
2*5-3=7=nu_max.
```

The hyperelliptic involution supplies the negative branch.  Relative to the
positive base point its divisor class is the negative of the positive-branch
class plus `4H1`; since `4H1` lies in `Gamma2`, the same saturation statement
covers both signs of `Y`.

The precise output of the accepted Stoll interface is only

```text
P in Cm(Q),  T(P)+1 in 8 Z_2
    ==> [P-P_-] in Sat_Q(Gamma2).
```

This is a saturation conclusion, not Mordell--Weil generation, a rank
calculation, or a rational-point classification.

## 4. The precision-120 Coleman certificate

The Coleman model `Cc` has genus 15.  Exact checks of irreducibility over
`Q` and `v_5(disc(f))=0` give the required absence of a rational finite
Weierstrass point and good reduction at 5.  The special fibre has exactly
six points:

```text
(1:0:0), (0:0:1), (1:2:1), (1:3:1), (4:1:1), (4:4:1).
```

Thus there is one disk at infinity, one over `x=0`, two over `x=1`, and two
over `x=-1=4`.  The reduced polynomial has the unique simple root `(0,1)`.
The precision-120 calculation independently finds exactly one simple root
in `Q_5`, reducing to zero.

For

```text
omega_j=x^j dx/(2*y_c),       0<=j<=14,
```

let `ell_-` and `ell_+` be the Coleman logarithms from `O` to the positive
endpoints.  Each row has 5-adic content exactly one.  After division by five,
their complete reductions are

```text
M = [3 1 2 2 3 4 1 4 1 4 1 4 3 3 4]
    [1 3 4 0 2 3 4 2 3 3 3 4 1 2 2].
```

This matrix has rank two.  Columns 0 and 1 reduce to

```text
[3 1]
[1 3],       determinant=3 (mod 5),
```

so the corresponding exact minor is a `Z_5` unit.  The fixed reduced kernel
vector is

```text
cbar=(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1),
```

with numerator `1+x^13+x^14`.  Its values at the residue types
`x=0,1,-1,infinity` are `1,3,1,1` modulo 5, and the source separately checks
a unit value at each of all six special-fibre points.

Fixing ordinary integer lifts outside columns 0 and 1 and solving the two
exact normalized logarithm equations in those columns gives, by the unit
minor, a genuine `Q_5` differential annihilating both endpoint logarithms.
Its reduction is exactly `cbar`, so it remains nonzero on every disk.  The
precision run prints

```text
DOTS [O(5^116), O(5^116)] DOT_PRECISIONS [116,116].
```

These finite-precision zeros certify a stability margin; exact existence is
supplied by the unit-minor lift, not by treating `O(5^116)` as symbolic zero.
Since `D_-=-2H1` and `D_+=-2H9`, this differential annihilates `Gamma2`.
If `nQ` lies in `Gamma2` for nonzero `n`, then
`n*log_omega(Q)=0`; characteristic zero makes `n` invertible in `Q_5`.
Therefore it annihilates all of `Sat_Q(Gamma2)`, including when `5|n`.

## 5. One zero on each residue disk

No global Coleman bound requiring `5>2g` is available, since `2g=30`.
Instead use the elementary lemma separately on every disk.  If `t` is an
integral regular parameter and

```text
eta=(u_0+u_1*t+u_2*t^2+...)dt,       u_0 in Z_5^*,
```

then for distinct `t_1,t_2 in 5 Z_5` the difference quotient of a primitive
has leading term `u_0`.  Every later degree-`n` contribution has valuation at
least `n-v_5(n+1)>=1`.  The quotient is a unit, so the primitive is injective
and has at most one zero on that disk.  At infinity one uses the standard
integral uniformizer.  At the simple Weierstrass point use `y_c` and
`2*y_c*dy_c=f'(x)dx`, where `f'(x)` is a unit.  The six unit evaluations of
the lifted differential therefore prove the one-zero lemma on all six disks.

There is also a known zero in every disk:

1. `O` is a zero by normalization.
2. The four signed endpoints over `x=-1,1` are zeros.  The positive endpoint
   classes are annihilated, and the negative classes are their negatives.
3. Hensel's lemma lifts the unique reduced root to `W=(alpha,0)`.  The exact
   identity `div(x-alpha)=2W-2O` makes `[W-O]` 2-torsion, so the 5-adic
   abelian logarithm kills it.

These are six zeros in six distinct disks and hence all local zeros.  The
Weierstrass zero is not rational: a rational `alpha` would be a rational root
of the exactly checked irreducible degree-31 polynomial.

## 6. Accepted-interface composition and the Pell residue

Let `P` be rational and lie in the dyadic target disk.  Stoll gives
`[P-P_-] in Sat_Q(Gamma2)`, while `[P_--O]=-2H1` lies in `Gamma2`.  Hence
`[P-O]` lies in the same saturation and its Coleman primitive vanishes.
The diskwise classification leaves only the five rational anchors: infinity
and the four signed endpoints.  Infinity is not affine; the two points with
`T=1` do not satisfy `T+1 in 8 Z_2`.  Therefore the target disk contains
only the two points with `T=-1`.

For the Pell residual, `T=23 (mod 24)` implies `T+1 in 8 Z_2`, whereas the
target problem also has `T>1`.  The forced value `T=-1` is impossible, giving
the stated index-31 exclusion.  When combined with the already established
fixed-prime reductions through 31, this moves the still-unproved uniform
prime-index residual to primes `p>=37`.  That bookkeeping consequence is not
a proof of the uniform `p>=37` statement, of a moving square-base statement,
or of `abc`.

## 7. Frozen artifacts and hashes

The closure uses the following existing packages.  Each listed SHA-256 is
the hash of the manifest file itself; the manifest contains the individual
content hashes of every artifact named in its package.  A separate outer
closure manifest binds these nested manifests to this composition report and
the Lean/status integration; it is not an input to either numerical package.

| package | artifacts bound by its manifest | manifest-file SHA-256 |
|---|---|---|
| BDF threshold and principal factor base | threshold source/Sage/wrapper/transcript/meta/exit/report; producer, exact verifier, smoke and two failure ledgers; recovery run; 16 compressed shards and `SHARDS.sha256`; maker/report | `770fee14473ddd0502f4ab5bb62afd7d6a92dba2c6ac126cf4d2fab3f0bbea7f` |
| supported squareclasses | discovery source; independent verifier; wrapper; three failed-attempt ledgers; final transcript/meta/exit; reports; prerequisite manifest; maker | `190933f8a0d499056906522900d833849aaa78ac32ec21c5e93a0d4837d8eb7d` |
| global conditions and dyadic injection | verifier; wrapper; genus-sign failure ledger; transcript/meta/exit; squareclass manifest; report; maker | `cc599c302d21df20f86acf4670c8ed3759fba6386e6671a4b46a422a1ab84ecb` |
| precision-8000 Stoll failure | source/wrapper; three scout ledgers; transcript/meta/exit; global manifest; report; maker | `fa7201adf18c6106fd0255dd4c32ec5c6b2916e310f9db904307fe7afc985cec` |
| 10000/12000 single-node diagnostic | diagnostic source/wrapper; both transcripts/meta/exit records; 8k manifest; report; maker | `46cf4a4b9d529fdce2e59ec23c271dcd8963068b7a0751698760ee59d1f13490` |
| formal precision-12000 Stoll | source/wrapper/transcript/meta/exit; global, 8k, and diagnostic manifests; report; maker | `a39293f97325a9c01504b9677581c2ad95f666bb75d3c619457a8fdf47e6eee8` |
| precision-120 Coleman | source/wrapper/transcript/meta/exit; local report; maker | `11d357f22f234edb018f1f5406d81e963dc4f135ae0f4e1040c6df9ade5542b0` |

For direct audit, the principal executable artifacts in the final two local
packages have these hashes:

```text
formal12k source      56bcec8ebfd3a908ccd352d1e1ba404d920e60bd30c7bf82a697025d9f496744
formal12k wrapper     5cf7ff2ede61e1cdcac2f01092410cd982116fe00dba51e6258c56a0a8482570
formal12k transcript  af96f0fcae84560f46838ac1f6a5ca66fc9d03677889c10579695e76669d431a
formal12k metadata    6594bdc2373fe96a230b1ca5c99b0f9c7d590114d61e1f9bb04db0f2741a5bb6
formal12k exit        9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa
Coleman source        0a96ce2c3c1925857b612a3cced2ac2923f45c047169161fbe852a32f0ad4952
Coleman wrapper       f24459e2b6b9c0439fbe57a2853fa11cb24fec30e4d3aa134e9ca5a52f2002e7
Coleman transcript    5692d8a2d6c934b07fa8ff07570a18c4e4ce3b79c0ea5dff25a7abdd25a69325
Coleman metadata      63da26a2884a76dca544385b343738ee325684c29262803993969396e4bda018
Coleman exit          9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa
```

The concrete artifact paths are:

```text
Lean/P31_CL1_BDF_FACTORBASE_ROUTE.md
Lean/P31_CHEBYSHEV_S_SQUARECLASS_CERTIFICATE.md
Lean/P31_CHEBYSHEV_GLOBAL_DYADIC_CERTIFICATE.md
Lean/P31_CHEBYSHEV_STOLL_GAMMA2_8K_FAILURE.md
Lean/P31_STOLL_M5_PRECISION_DIAGNOSTIC.md
Lean/P31_CHEBYSHEV_STOLL_GAMMA2_FORMAL12K.md
Lean/P31_CHEBYSHEV_COLEMAN_LOCAL_CERTIFICATE.md
Lean/audit_scripts/p31_chebyshev_cl1_bdf_principal.sha256
Lean/audit_scripts/p31_chebyshev_s_squareclass.sha256
Lean/audit_scripts/p31_chebyshev_global_dyadic.sha256
Lean/audit_scripts/p31_chebyshev_stoll_gamma2_8k_failure.sha256
Lean/audit_scripts/p31_chebyshev_stoll_m5_diagnostic.sha256
Lean/audit_scripts/p31_chebyshev_stoll_gamma2_formal12k.sha256
Lean/audit_scripts/p31_chebyshev_gamma2_coleman_local.sha256
Lean/audit_scripts/make_p31_chebyshev_stoll_coleman_closure_manifest.sh
Lean/audit_scripts/p31_chebyshev_stoll_coleman_closure.sha256
```

The final computations used SageMath 10.9 in image
`sagemath/sagemath:10.9` with digest
`sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667`.
The formal Stoll transcript ends in `P31_STOLL_GAMMA2_OVERAPPROX_PASS`; the
Coleman transcript ends in `P31_GAMMA2_COLEMAN_LOCAL_FINAL_CERTIFICATE_PASS`;
both frozen wrappers record `EXIT_CODE=0`.

## 8. Trust boundary

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
  Arb real-ball, and certified finite-precision `Q_2` and `Q_5` arithmetic in
  the frozen SageMath environment.

The frozen calculations certify their finite arithmetic and the hypotheses
fed into these accepted theorems.  No statement in this document upgrades
those theorem interfaces to a Lean-kernel proof, and no statement extends
the fixed-index result to the remaining uniform problem.
