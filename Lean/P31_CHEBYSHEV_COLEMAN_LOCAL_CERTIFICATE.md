# Prime 31: a high-precision local Coleman certificate at 5

## 0. Scope and result

Let `T_31` be the first-kind Chebyshev polynomial and put

```text
F_31(x) = 4*T_31(x) + 5.
```

The frozen SageMath calculation packaged with this note certifies the
following **local** facts for the genus-15 curve at the prime 5:

1. the chosen monic model has good reduction and its special fibre has six
   points;
2. the two endpoint Coleman logarithms, after removal of their common factor
   5, have rank two modulo 5;
3. an explicitly displayed reduced differential lies in their common kernel
   and is nonzero on every one of the six residue disks;
4. columns 0 and 1 give a unit minor, so the reduced kernel vector has a true
   `Q_5` lift annihilating both endpoint logarithms; and
5. the only finite Weierstrass residue disk contains one simple `Q_5` root,
   reducing to `x=0`.

This package does **not** certify Mordell--Weil generation or saturation, a
Selmer bound, a global-to-local localization statement, a Stoll shell, or a
complete set of rational points.  In particular it does not exclude the
prime-31 Diophantine case by itself, and it does not prove `abc`.

## 1. Exact model and endpoints

The executable constructs `T_31` from the recurrence

```text
T_0=1,  T_1=x,  T_n=2*x*T_(n-1)-T_(n-2)
```

and uses the monic Coleman model

```text
C_c: y_c^2 = f(x),       f(x)=F_31(x)/2^32.
```

Thus the original and Coleman coordinates are related by

```text
x_c=x,       y_c=y/2^16.
```

The source checks exactly that `f` is monic and that

```text
f(-1)=1/2^32,       f(1)=9/2^32.
```

Writing `O` for infinity, the two positive endpoints used for integration
are therefore

```text
P_- = (-1, 1/2^16),       P_+ = (1, 3/2^16).
```

The script also checks over `Q` that `f` is irreducible, and checks
`v_5(disc(f))=0`.  The latter is the good-reduction test used here.  The
irreducibility check implies in particular that the finite Weierstrass point
found over `Q_5` below is not being asserted to be rational over `Q`.

## 2. The six residue disks

The special fibre is enumerated exactly as

```text
(1:0:0), (0:0:1), (1:2:1), (1:3:1), (4:1:1), (4:4:1).
```

There is one disk at infinity, one finite disk over `x=0`, two over `x=1`,
and two over `x=4=-1`.  The reduction of `f` has precisely one root,

```text
[(0,1)],
```

so this is a unique simple Weierstrass residue disk.  The precision-120 root
calculation independently checks that `f` has exactly one root in `Q_5`, of
multiplicity one and reduction zero.

## 3. Endpoint logarithms

Use the regular differential basis

```text
omega_j = x^j dx/(2*y_c),       0 <= j <= 14.
```

Let `ell_-` and `ell_+` be the Coleman integral rows from `O` to `P_-` and
`P_+`.  Each row has 5-adic content exactly one.  After division by 5, their
reductions form

```text
M = [3 1 2 2 3 4 1 4 1 4 1 4 3 3 4]
    [1 3 4 0 2 3 4 2 3 3 3 4 1 2 2].
```

The script checks this entire matrix entry by entry and checks
`rank_F5(M)=2`.

The fixed reduced kernel vector is

```text
cbar=(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1).
```

Its numerator polynomial is

```text
1+x^13+x^14.
```

At the four residue types `x=0,1,-1,infinity`, its values are respectively

```text
1,3,1,1  (mod 5).
```

The source evaluates the vector separately at all six enumerated points and
asserts that every value is a unit.  It does not infer this merely from the
four-value summary.

## 4. Unit minor and the exact lift

Columns 0 and 1 of the normalized logarithm matrix reduce to

```text
[3 1]
[1 3],       determinant = 3*3-1*1 = 8 = 3 (mod 5).
```

Consequently the corresponding determinant is a unit in `Z_5`.  Fix all
coefficients outside columns 0 and 1 at the displayed **ordinary integer
lifts** of `cbar`, and solve the two normalized logarithm equations in those
two columns.  Invertibility of the exact unit minor produces a unique genuine
`Q_5` solution whose reduction is `cbar`.  Hence an actual differential over
`Q_5` annihilates both endpoint logarithms and remains nonzero on all six
residue disks.

This exact-lift conclusion comes from the unit minor.  The executable also
prints its two finite-precision dot products and their absolute precisions.
Those `O(5^N)` values are a stability check with a required margin of at
least 110 digits; they are not, by themselves, symbolic equalities in
`Q_5`.  The ordinary lifts used by the source are not Teichmuller lifts.

The completed precision-120 run gives

```text
DOTS [O(5^116), O(5^116)] DOT_PRECISIONS [116, 116].
```

Thus both numerical products retain 116 absolute 5-adic digits, six digits
beyond the enforced margin.

## 5. Why this is diskwise, not a global point bound

Here `p=5` and `2g=30`, so a Coleman bound whose hypotheses require
`p>2g` is unavailable.  The relevant elementary local statement is instead
applied disk by disk.

Let `t` be an integral regular parameter on one residue disk and suppose the
reduction of a regular differential is nonzero there.  Write

```text
eta=(u_0+u_1*t+u_2*t^2+...) dt,       u_0 in Z_5^*.
```

For distinct `t_1,t_2` in `5 Z_5`, the difference quotient of a primitive
has constant term `u_0`.  Every term of positive degree is divisible by 5:
the term arising from degree `n>=1` has valuation at least
`n-v_5(n+1)>=1`.  The difference quotient is therefore a 5-adic unit.  A
primitive consequently has at most one zero on that disk.

The six nonzero evaluations above supply the local hypothesis on every
disk.  Turning that diskwise fact into a rational-point theorem would still
require a separately certified global statement placing the relevant
rational divisor classes inside the annihilated subgroup (or its
saturation), together with identified anchor zeros.  Neither is part of this
local package.

## 6. Frozen execution and trust boundary

The final source runs at input precision 120 under

```text
SageMath version 10.9, Release Date: 2026-05-04
```

in the image

```text
sagemath/sagemath:10.9
sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667
```

The wrapper mounts the repository read-only, disables container networking,
limits the calculation to one CPU, copies the frozen source into container
temporary storage, and records the source hash, wrapper hash, image ID,
repository digest, Sage version, timestamps, and exit status.  The manifest
maker checks the complete matrix, kernel vector, all disk values, unit minor,
root data, precision margin, success markers, provenance, and clean exit
before hashing the source, wrapper, transcript, metadata, exit record, this
report, and the maker itself.

The completed run used the following immutable executable hashes:

```text
source  0a96ce2c3c1925857b612a3cced2ac2923f45c047169161fbe852a32f0ad4952
wrapper f24459e2b6b9c0439fbe57a2853fa11cb24fec30e4d3aa134e9ca5a52f2002e7
```

The Coleman phase ran from `2026-08-27T23:41:11Z` through
`2026-08-28T03:29:30Z`, a wall time of 3 hours 48 minutes 19 seconds, and
exited with code zero.

The trust boundary is explicit:

- exact polynomial arithmetic, finite-field enumeration, and all displayed
  reductions are replayed by the frozen Sage source;
- Coleman integration and `Q_5` root finding use SageMath 10.9 as an accepted
  computational interface;
- the unit-minor argument upgrades stable finite-precision reductions to the
  stated exact `Q_5` kernel lift;
- no class-group, Selmer, Mordell--Weil, Stoll, or global rational-point
  theorem is included or inferred.

## 7. Artifact ledger

The package consists of

```text
Lean/audit_scripts/p31_chebyshev_gamma2_coleman_final.sage
Lean/audit_scripts/run_p31_chebyshev_gamma2_coleman_final.sh
Lean/audit_scripts/p31_chebyshev_gamma2_coleman_final.transcript
Lean/audit_scripts/p31_chebyshev_gamma2_coleman_final.meta
Lean/audit_scripts/p31_chebyshev_gamma2_coleman_final.exit
Lean/P31_CHEBYSHEV_COLEMAN_LOCAL_CERTIFICATE.md
Lean/audit_scripts/make_p31_chebyshev_gamma2_coleman_local_manifest.sh
Lean/audit_scripts/p31_chebyshev_gamma2_coleman_local.sha256
```

Run the wrapper once to reproduce the expensive calculation, then run the
manifest maker to recheck all semantic gates and freeze the seven content
hashes.  Running the maker again verifies that the package remains
byte-for-byte unchanged.
