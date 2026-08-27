# Prime 29: complete S-squareclasses and dyadic Selmer injection

## Status

This certificate closes the global-to-dyadic input needed by the prime-29
Stoll route.  Let

```text
K=Q(a),  a^29=2,
S={prime ideals of K above 2,3,29}.
```

The separate BDF principal-factor-base certificate proves unconditionally
that `Cl(K)=1`.  The present exact calculation then proves

```text
dim_F2 K(S,2)=19,
dim_F2 W=14,
localization W -> K_2^*/K_2^{*2} is injective.
```

Here `W` is the norm-square, 3-adically admissible global
over-approximation to the odd-degree hyperelliptic 2-Selmer image.  Therefore
the actual 2-Selmer image is also dyadically injective.  This is condition (1)
in the Stoll saturation argument used in the lower-prime certificates.

This result does **not** by itself determine the rational points of the
prime-29 curve.  The Stoll shell recursion and its tail inequality remain a
separate finite calculation.

## 1. The 19 supported squareclasses

The signature of `K` is `(1,14)`.  The primes in `S` have residue degrees

```text
2 : (1)
3 : (1,28)
29: (1),
```

so `|S|=4`.  The standard S-unit exact sequence, Dirichlet's unit theorem,
and `Cl(K)=1` give

```text
dim_F2 K(S,2)=1+(1+14-1)+4=19.
```

The Sage source freezes nineteen explicit power-basis elements.  It constructs
no BNF, class group, regulator, or unit group.  Every element is checked to be
integral, nonzero, and supported only above `{2,3,29}`.  Their exact norms are

```text
-1; fourteen further units of norm +/-1; 2; -3; -3^28; -29.
```

The combined exact norm, 3-adic Hilbert, and dyadic Hilbert signature matrix
has rank 19.  A global square has zero signature in every one of these
coordinates, so the nineteen classes are independent.  Since they lie in the
19-dimensional space `K(S,2)`, they form a complete basis.  PARI was used only
to discover convenient representatives; no claim of fundamental-unit
completeness is imported from it.

## 2. Curve, endpoints, and the 3-adic condition

The monic model is

```text
f_29(X)=2^28*(4*T_29(X/4)+5),
disc(f_29)=2^784*3^28*29^29.
```

With `theta=-(2*a+a^28)`, the exact endpoint factorizations identify the two
Kummer classes as

```text
d1=a-1,       d9=3*(a+1).
```

More precisely, these are the Kummer classes of the rational half-divisors
`H1,H9` used as the generators of `Gamma_2`; the corresponding endpoint
divisor classes satisfy `[P-infinity]=-2*H`.  Calling `d1,d9` the endpoint
divisor classes themselves would conflate a divisor with its chosen half.

The rational norm-square matrix on the basis `(-1,2,3,29)` has rank four.
The Hilbert-pairing signatures at the two places above 3 have rank four.  The
product of the two local squareclass spaces relevant here has dimension four;
nondegeneracy of the local Hilbert pairings and equality of these ranks make
the frozen signatures faithful on that ambient space.  The endpoint
signatures span a nonzero one-dimensional line `L3`.

For completeness, `x^29-2` has two irreducible factors over `Q_3`, so
`J(Q_3)[2]` has dimension one.  Multiplication by two is an automorphism on an
open pro-3 subgroup of `J(Q_3)`.  On the remaining finite quotient, the kernel
and cokernel of multiplication by two have the same cardinality.  Hence
`J(Q_3)/2J(Q_3)` also has dimension one, and the nonzero endpoint line `L3` is
the full local Kummer image.

Define `W` to consist of coefficient vectors whose rational norm is a square
and whose 3-adic signature lies in `L3`.  Turning membership in `L3` into
homogeneous equations gives a constraint matrix of rank five.  Therefore

```text
dim W=19-5=14,       |W|=16384.
```

The accepted odd-degree hyperelliptic descent theorem places the actual
2-Selmer image inside `W`.  Omitting all other local conditions deliberately
makes `W` an over-approximation and cannot create a false Selmer upper bound.

## 3. Exact dyadic injection

At the unique place above 2 the script uses the first eighteen classes from

```text
[a] + [1+a^i : i=1,3,...,57] + [1+a^58].
```

It computes exact Hilbert symbols, not finite-precision p-adic samples.  On a
frozen basis of `W`, the resulting `14 x 18` signature matrix has rank 14.
If an element of `W` localized to a square, every one of these Hilbert symbols
would vanish; full row rank therefore forces that element to be zero.  Thus

```text
ker(W -> K_2^*/K_2^{*2})=0.
```

The two endpoint rows have dyadic rank two.  In particular, the exact output
is

```text
SQUARECLASS_DETECTION_RANK 19
NORM_RANK 4
P3COUNT 2 P3_DEGREES [1, 28] LOCAL3_PAIR_RANK 4 L3_DIM 1
COMBINED_CONSTRAINT_RANK 5 W3DIM 14 COUNT 16384
DYADIC_TEST_CLASSES 18 ... W2_SIGNATURE_RANK 14 KERNEL_DIM 0 GAMMA2_RANK 2
P29_GLOBAL_DYADIC_OVERAPPROX_PASS
P29_GLOBAL_DYADIC_FROZEN_RUN_PASS
EXIT_CODE=0
```

## 4. Reproducibility and trust boundary

Run from the repository root:

```console
bash Lean/audit_scripts/run_p29_chebyshev_global_dyadic_overapprox.sh
```

The frozen SageMath 10.9 run took 638 seconds.  Before performing any descent
arithmetic, the wrapper checks the full 39-item SHA256 manifest of the
independent class-number-one certificate.  It then records the Sage source,
wrapper, container image, transcript, metadata, and exit status.

The mathematical trust boundary is:

* the published unconditional BDF factor-base theorem and its separate exact
  class-number-one certificate;
* Dirichlet's S-unit theorem and the standard ideal-parity exact sequence;
* accepted Poonen--Schaefer/Schaefer/Stoll odd-degree hyperelliptic
  2-descent and local Kummer theory;
* Sage's exact number-field arithmetic, finite-field linear algebra, and
  Hilbert-symbol implementation.

No GRH, BSD, parity conjecture, finiteness of Sha, provisional BNF
completeness, or `abc` input is used.  The Lean file
`IUTThreeClosures/P29SelmerLinearCore.lean` kernel-checks only the transparent
linear implication that injectivity on `W` descends to every subspace of `W`,
together with the scalar dimension ledger.  It does not pretend to reimplement
the number-field or Hilbert-symbol certificate in the kernel.
