# The Fermat--Kummer discriminant route

**Status.**  Offline research note.  The polynomial-discriminant formula and
the numerical boundary--different coefficient identity are formally verified
in `IUTThreeClosures/FermatKummerDiscriminant.lean`.  The passage from an
actual local Kummer extension to the ramification index and different
exponent below is proved on paper here, but is **not yet formalized in Lean**.
No Vojta estimate, field-discriminant estimate with hidden target, or `abc`
conclusion is assumed.

## 1. Integral generators without a full-degree assumption

Let `a,b,c` be positive, pairwise coprime integers with `a+b=c`, let `n>=2`,
and choose

```text
x^n = a/c,       y^n = b/c,
L = Q(x,y).
```

Set `alpha=cx` and `beta=cy`.  Then

```text
alpha^n = A := a c^(n-1),
beta^n  = B := b c^(n-1).
```

Thus `alpha` and `beta` are algebraic integers and `L=Q(alpha,beta)`.  The
tower law gives only

```text
[L:Q] <= n^2.
```

We do not assume equality.  Either binomial can be reducible, the two
extensions can intersect, and `Z[alpha,beta]` need not be the full ring of
integers.

## 2. Three discriminants that must not be conflated

For

```text
f_A(T)=T^n-A,
```

the resultant calculation gives

```text
Disc(f_A)
  = (-1)^(n(n-1)/2+n-1) n^n A^(n-1),
|Disc(f_A)| = n^n A^(n-1).
```

The Lean module proves exactly this identity.  It is a **polynomial
discriminant** statement.

If `f_A` is irreducible, then `1,alpha,...,alpha^(n-1)` is a basis of the
monogenic order `Z[alpha]`, and its **order discriminant** equals
`Disc(f_A)`.  Even then,

```text
Disc(Z[alpha])
  = Disc(O_{Q(alpha)}) [O_{Q(alpha)}:Z[alpha]]^2,
```

so it is not generally the field discriminant.  If `f_A` is reducible, the
selected field `Q(alpha)` has smaller degree, and the rank-`n` algebra
`Z[T]/(f_A)` is not even the selected root order.  The same warnings apply
twice to `alpha,beta`; a rank-`n^2` tensor algebra must not be silently
identified with `O_L`.

The displayed formula nevertheless gives the honest support statement for
the displayed polynomial:

```text
p | Disc(f_A)  =>  p | n a c,
p | Disc(f_B)  =>  p | n b c.
```

This support implication is also formalized.

Using the tensor-order discriminant as though it were `Disc(L)` is not only
logically invalid but quantitatively disastrous.  Its degree-normalized
logarithm would contain

```text
(1/n)(log|Disc(f_A)|+log|Disc(f_B)|)
 = 2 log n
   + (1-1/n)(log(ab)+2(n-1)log c),
```

which has a height term of order `2n log c`, not a small conductor error.

## 3. Actual field-discriminant support

The field support can be proved without assuming irreducibility or a maximal
power order.  Let `p` be a prime not dividing `nabc`.  Over `Z_p`, both `A`
and `B` are units.  In

```text
Z_p[T]/(T^n-A)
```

the class of `T` is a unit and `f_A'(T)=nT^(n-1)` is a unit.  Hence this
algebra is finite etale over `Z_p`; the same holds for `f_B`, and finite
etale algebras remain finite etale under tensor product and base change.
Every field factor selected by the simultaneous roots is therefore
unramified over `Q_p`.  Consequently

```text
Supp Disc(L) subseteq {p : p | nabc}.
```

This is a field-discriminant conclusion, but the finite-etale-to-integral-
closure argument has not yet been assembled in Lean's number-field ideal
API.  The current Lean theorem proves only the polynomial support precursor.

## 4. The exact tame local calculation

Fix `p` with `p` not dividing `n` and `p | abc`.  Pairwise coprimality means
that precisely one boundary component is met.  Let `m>0` be the absolute
valuation of that component and put

```text
g = gcd(n,m),       e_0 = n/g.
```

### 4.1 Ramification index

For a local Kummer root `z^n=q` with `|v_p(q)|=m`, the ramification index is
exactly `e_0`.

Indeed, after replacing `z` by `z^{-1}` if needed, suppose `v_p(q)=m`.
In an extension of ramification index `e`, integrality of the extended
valuation of `z` gives

```text
e m/n in Z,
```

so `n/g | e`.  Write `n=gn_0`, `m=gm_0`.  The element

```text
u = z^n_0 / p^m_0
```

satisfies `u^g` equal to a `p`-adic unit.  Since `p` does not divide `g`,
adjoining `u` is unramified.  Over that unramified extension, `z` satisfies
a polynomial of degree `n_0`; hence `e<=n_0`.  Therefore `e=n_0=n/g`.

At `p|a`, the root `y` is a root of a unit and adds only an unramified
extension.  At `p|b` the roles are reversed.  At `p|c`, both `x,y` have
valuation `-m/n`, but `(x/y)^n=a/b` is a unit, so the second root again adds
only an unramified extension.  Thus every completion of `L` above `p` has
the same ramification index `e=n/g`.

### 4.2 Boundary plus different

Put `d=[L:Q]`.  The normalized truncated boundary contribution is

```text
N_p^(1)
 = (1/d) sum_{P|p} f_P log p
 = (1/e) log p
 = (g/n) log p,
```

because all primes above `p` meet the relevant reduced boundary and
`sum e f_P=d`.

The extension is tame, so the local different exponent is `e-1`.  Hence the
normalized field-discriminant contribution is

```text
delta_p(L)
 = (1/d) sum_{P|p} f_P(e-1) log p
 = (1-1/e) log p
 = (1-g/n) log p.
```

The cancellation is exact:

```text
N_p^(1) + delta_p(L) = log p.                 (4.1)
```

The Lean definitions `kummerTameBoundaryWeight` and
`kummerTameDifferentWeight` encode the two numerical terms `g/n` and
`1-g/n`, and Lean proves their local and finite-sum identity.  It does
**not** yet derive these definitions from actual DVRs, `e=n/g`, or the
different ideal.

## 5. Wild primes are an `n`-dependent constant

Only primes dividing `n` remain.  For a completion with ramification index
`e_P`, the standard local different bound is

```text
d_P <= e_P-1+v_P(e_P)
    <= e_P(1+floor(log_p(n^2))),
```

because `[L:Q]<=n^2`.  Therefore

```text
delta_p(L) <= (1+floor(log_p(n^2))) log p,
N_p^(1)    <= log p.
```

One explicit global allowance is

```text
B(n) = sum_{p|n} (2+floor(log_p(n^2))) log p
     <= 2 log rad(n) + 2 omega(n) log n.
```

This is constant when `n` is fixed.  It is emphatically **not uniform in
`n`**, so it cannot be discarded while sending the covering degree to
infinity.

Combining (4.1) with the wild allowance gives the genuine target estimate

```text
N_{D_n}^(1)(P) + (1/[L:Q]) log|Disc(L)|
  <= log rad(abc) + B(n).                     (5.1)
```

The paper proof of (5.1) is unconditional.  Its local-field and ideal-theory
implementation is the next formalization gap.

## 6. Final coefficient in a Fermat/Vojta argument

Numerically and, after the remaining divisor functoriality is built,
geometrically,

```text
K_{C_n}+D_n = beta_n^*(K_{P^1}+[0]+[1]+[infinity]),
deg(K_{C_n}+D_n)=n^2.
```

For the lift `P` of `lambda=a/c`, normalized height functoriality gives

```text
h_{K_{C_n}+D_n}(P) = log c + O_n(1).
```

Choose the rational ample divisor

```text
A = (K_{C_n}+D_n)/n^2.
```

Thus the associated heights satisfy

```text
h_A(P) = (1/n^2) h_{K_{C_n}+D_n}(P) + O_n(1)
       = (1/n^2) log c + O_n(1).
```

It is important to make this proportional choice: an arbitrary integral
degree-one divisor need not differ from `(K_{C_n}+D_n)/n^2` by a bounded
height.  If one had the bounded-degree Vojta inequality on `(C_n,D_n)`

```text
h_{K_{C_n}+D_n}(P)
 <= N_{D_n}^(1)(P) + d(P) + eta h_A(P) + O_{n,eta}(1),
```

for all these points of degree at most `n^2`, with `A` chosen as above, then
the displayed height identity is available without an additional
degree-zero height comparison.

Substituting (5.1) yields

```text
(1-eta/n^2) log c
  <= log rad(abc) + O_{n,eta}(1).
```

Thus the final conductor coefficient would be

```text
1/(1-eta/n^2).
```

Taking `eta=n^2 epsilon/(1+epsilon)` gives `1+epsilon`.  This bookkeeping is
sharp and promising, but the required bounded-degree truncated Vojta
inequality is precisely the missing arithmetic theorem; neither the Kummer
cover nor the discriminant calculation proves it.

## 7. Strict obstruction to the bare dilution trick

Equation (4.1) also supplies a strict counterexample to the claim that
increasing `n` alone changes the tame conductor coefficient to some
`alpha<1`.  For fixed `n`, the tame budget is

```text
sum_{p|abc, p not dividing n} log p
 >= log rad(abc)-log rad(n).
```

There are primitive triples `(1,q-1,q)` with primes `q` arbitrarily large
and `q` not dividing `n`; their conductors tend to infinity.  Hence an
inequality

```text
tame budget <= alpha log rad(abc) + C_n
```

with `alpha<1` would force an unbounded positive multiple of the conductor
to be at most the fixed number `C_n+log rad(n)`, a contradiction.

This retires only the **bare coefficient-dilution trick**.  It does not
retire the Fermat/Kummer route: (5.1) shows that the lift preserves the
optimal coefficient one, and a genuinely new truncated second-main-theorem
estimate on the lifted points would still prove `abc`.

## 8. Exact remaining Lean tasks

1. Construct the two local Kummer extensions for each prime of an
   `ABCPoint` and prove `e=n/gcd(n,m)` for `p` not dividing `n`.
2. Connect `LocalPowerRamificationIndex` to the arithmetic DVRs and prove
   the tame different exponent `e-1` with `differentIdeal`.
3. Prove unramifiedness outside `nabc` via finite-etale localization and
   `NumberField.not_dvd_discr_iff_isUnramifiedIn`.
4. Formalize the wild bound for fixed `n` and assemble (5.1).
5. Add extension-invariance and divisor-height functoriality.  The Vojta
   inequality itself must remain an explicit theorem hypothesis unless it
   is independently proved.
