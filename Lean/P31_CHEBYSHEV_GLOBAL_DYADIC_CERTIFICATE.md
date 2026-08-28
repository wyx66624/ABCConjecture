# Prime 31: global descent conditions and dyadic injection

## Result

For `K=Q(a)`, `a^31=2`, and `S` the four primes above `{2,3,31}`, the
separately frozen certificate supplies a 20-dimensional basis of `K(S,2)`.
The present exact calculation applies the rational norm-square condition and
the complete local Kummer condition at the two places over 3.  The resulting
global over-approximation `W` satisfies

```text
dim_F2 W=15,       |W|=32768.
```

Exact Hilbert signatures at the unique dyadic completion have rank 15 on
`W`.  Consequently

```text
ker(W -> K_2^*/K_2^{*2})=0.
```

Thus localization is injective on `W`, and hence on the actual 2-Selmer image
contained in `W`, subject to the accepted odd-degree hyperelliptic descent
interface.  This is the global-to-dyadic input needed by a later p31 Stoll
saturation calculation.  It does not itself run the Stoll shell, certify a
Coleman computation, determine rational points, or prove an abc case.

## Curve and endpoint classes

The monic model is

```text
f_31(X)=2^30*(4*T_31(X/4)+5).
```

Exact polynomial arithmetic verifies

```text
f_31(X)-2^30   =(X+4)*Uminus(X)^2,
f_31(X)-9*2^30=(X-4)*Uplus(X)^2.
```

With `theta=-(2*a+a^30)`, the two endpoint-half Kummer classes are

```text
d1=a-1,       d9=3*(a+1).
```

Since the genus is 15, the exact square identities include the conventional
factor `(-1)^15`:

```text
(-1)^15*Uminus(theta)/d1 is a square,
(-1)^15*Uplus(theta)/d9 is a square.
```

This is the only parity-sensitive change from p29, whose genus 14 makes the
factor invisible.  In the frozen 20-element global basis, the independently
recovered coordinates are

```text
d1=(0,1,0,...,0),
d9=(1,1,0,...,0,1,0),
```

where the penultimate displayed `1` is coordinate 19.  Coordinates are solved
using the already certified injective signature matrix and then checked by a
direct exact global square test; they are not imported from BNF output.

## Norm and 3-adic conditions

The rational norm-square signature on the 20 global representatives has rank
four.  At 3, `x^31-2` has irreducible factor degrees `(1,30)`, hence there are
two completions and `J(Q_3)[2]` has dimension one.  For odd residue
characteristic, multiplication by two is an automorphism on the open pro-3
part, while its finite quotient has equal kernel and cokernel sizes.  Thus
`J(Q_3)/2J(Q_3)` also has dimension one.

The exact Hilbert-pairing signatures at the two completions have combined rank
four.  The endpoint signatures span a nonzero line `L3`, so this line is the
complete local Kummer image.  Defining `W` by square rational norm and 3-adic
localization in `L3` gives a homogeneous constraint matrix of rank five:

```text
NORM_RANK 4
P3COUNT 2 P3_DEGREES [1, 30] LOCAL3_PAIR_RANK 4 L3_DIM 1
COMBINED_CONSTRAINT_RANK 5 W_DIM 15 W_COUNT 32768
```

Standard Poonen--Schaefer/Schaefer/Stoll odd-degree descent places the actual
2-Selmer image inside `W`.  Other local conditions are deliberately omitted,
so `W` is an over-approximation.

## Exact dyadic injection

At the unique place above 2, the verifier pairs against

```text
[a] + [1+a^i : i=1,3,...,61] + [1+a^62],
```

a family of 33 exact local test classes.  On the frozen basis of `W`, the
resulting `15 x 33` matrix has rank 15.  A local square pairs trivially with
every test class, so full row rank proves injectivity.  No assertion that the
test family is a complete local basis is needed for this implication.  The
two endpoint classes have dyadic rank two.  The decisive output is

```text
DYADIC_TEST_CLASSES 33 GLOBAL_REP_DYADIC_RANK 19
W_DYADIC_RANK 15 KERNEL_DIM 0 GAMMA2_RANK 2
P31_GLOBAL_DYADIC_INJECTION_PASS
EXIT_CODE=0
```

## Trust ledger

The verifier loads the separately frozen 20-dimensional squareclass verifier
and reconstructs every exact matrix.  Neither source constructs a BNF, class
group, unit group, or regulator.  The wrapper first validates the complete
base manifest and records source hashes and the exact SageMath 10.9 image
digest.

The trust boundary consists of the frozen accepted-interface proof
`Cl(K)=1`, Dirichlet and S-unit exact-sequence dimension formulas, accepted
odd-degree hyperelliptic descent and local Kummer theory, and Sage's exact
number-field, Hilbert-symbol, polynomial, square-test, and finite-field linear
algebra implementations.  No GRH, BSD, parity conjecture, Sha finiteness, or
BNF completeness is used.

The first exploratory scout is retained as a failure ledger.  It copied the
p29 endpoint assertion without `(-1)^g`, passed the entire base squareclass
verification, and stopped before constructing `W`.  The corrected genus-15
sign is both explained above and checked by exact square assertions in the
final source.
