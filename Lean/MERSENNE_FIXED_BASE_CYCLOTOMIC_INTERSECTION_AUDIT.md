# Fixed-base cyclotomic intersections and the order-level Wieferich mass

**Author:** ChatGPT

**Status:** offline research note.  The valuation classification in Sections
2--3 is an exact theorem.  The arithmetic-intersection discussion separates
identities from proposed analytic inputs.  This note does not prove

```text
sum_{d<=X} log E_d=o(X),
```

a power saving for `E_d`, or the abc conjecture.

The finite prime-step multiplicity theorem is formalized in
`IUTThreeClosures/MersenneFixedBaseCyclotomicIntersection.lean`.

## 1. The fixed-base object

Put

```text
C_d=Phi_d(2),
r_p=ord_p(2),
w_p=v_p(2^r_p-1),
E_d=product_{r_p=d} p^(w_p-1).
```

Here and below products indexed by `p` run over rational primes.  The target
mass is

```text
e_d=log E_d,
S(X)=sum_{d<=X} e_d
    =sum_{r_p<=X} (w_p-1) log p.                 (1.1)
```

The order in (1.1) is the order at which `p` first occurs.  Consequently each
prime contributes to at most one block.  This is much more rigid than the
full factorization of `2^n-1`, in which the same prime occurs at every
multiple of its order.

The first new point is that `E_d` is not merely a divisor of the powerful
part of `C_d`: it is exactly that powerful part.

## 2. Exact cyclotomic valuation classification

### Theorem 2.1

Let `p` be an odd prime, let

```text
r=ord_p(2),       w=v_p(2^r-1).
```

For every `N>=1`,

```text
v_p(Phi_N(2)) = w,  if N=r;
                  1,  if N=r p^j for some j>=1;
                  0,  otherwise.                         (2.1)
```

### Proof

Cyclotomic factorization and Moebius inversion give

```text
v_p(Phi_N(2))
  = sum_{a|N} mu(N/a) v_p(2^a-1).                         (2.2)
```

If `r` does not divide `N`, no divisor `a|N` is a multiple of `r`, so every
term in (2.2) is zero.  Now write `N=r k`.  The only nonzero terms have
`a=r s`, where `s|k`.  Since `p` is odd and `p` does not divide `r`, LTE gives

```text
v_p(2^(r s)-1)=w+v_p(s).                                  (2.3)
```

Thus

```text
v_p(Phi_(r k)(2))
 = sum_{s|k} mu(k/s)(w+v_p(s)).                            (2.4)
```

For `k=1`, (2.4) is `w`.  If `k>1`, the constant part vanishes because
`sum_{s|k}mu(k/s)=0`.  The remaining convolution satisfies

```text
sum_{s|k} mu(k/s)v_p(s)
 = 1  if k=p^j, j>=1,
 = 0  otherwise.                                          (2.5)
```

Indeed, write `v_p(s)` as the number of positive powers `p^j` dividing `s`
and interchange the two finite sums.  For a fixed `j`, the inner Moebius sum
is one precisely when `k/p^j=1`, and zero otherwise.  Equations (2.4)--(2.5)
prove (2.1).

Finally, `Phi_N(2)` is odd.  This follows either directly from cyclotomic
factorization of the odd integer `2^N-1`, or by reduction modulo two.
Therefore no missing `p=2` case contributes.  This completes the proof.

### Corollary 2.2: exact powerful-part identity

Let `rad` denote the product of the distinct prime divisors.  Then

```text
E_d = C_d/rad(C_d).                                       (2.6)
```

Every prime with exact order `d` contributes exponent `w_p-1` to the right
side.  By Theorem 2.1, every imprimitive prime divisor occurs in `C_d` with
exponent exactly one and hence contributes nothing.  In particular,

```text
e_d=log C_d-log rad(C_d).                                 (2.7)
```

Thus the desired mass is exactly the nilpotent, or nonreduced, part of the
fixed cyclotomic evaluation.  It has not been inserted into a definition as
an assumed estimate.

If an imprimitive prime divides `C_d`, it is the largest prime divisor `q`
of `d`, it occurs once, and `d=r_q q^j`.  Hence one can write

```text
C_d=I_d R_d E_d,                                          (2.8)
```

where `I_d` is either one or that single imprimitive prime and `R_d` is the
product of the exact-order primes.  Further consequences are

```text
gcd(E_d,d)=1,
gcd(E_d,E_m)=1  for d!=m.                                 (2.9)
```

The pairwise coprimality in (2.9) records uniqueness of multiplicative
order.  By itself it gives no upper bound for the product of the `E_d`.

## 3. Arithmetic Bezout and resultants see only the radical copy

For `m>n>=1`, the classical cyclotomic resultant formula is

```text
abs Res(Phi_m,Phi_n)
 = q^phi(n),  if m/n=q^j for a prime q and j>=1;
 = 1,         otherwise.                                 (3.1)
```

One proof starts from the product over primitive roots, evaluates the norm of
`zeta^n-1`, and uses

```text
Phi_t(1)=q  if t is a positive q-power,
Phi_t(1)=1  otherwise, for t>1.
```

Equivalently, (3.1) follows recursively from
`Res(Phi_m,X^n-1)=product_{a|n}Res(Phi_m,Phi_a)`.

An integral Bezout identity for two monic polynomials shows that

```text
gcd(Phi_m(2),Phi_n(2)) divides abs Res(Phi_m,Phi_n).        (3.2)
```

The valuation classification sharpens (3.2) to an exact evaluated formula:

```text
gcd(Phi_m(2),Phi_n(2))
 = q,  if m=n q^j and q divides Phi_n(2);
 = 1,  otherwise.                                         (3.3)
```

Indeed, a common prime `q` forces both indices to be of the form
`r_q q^a`; once the upper index is strictly above `r_q`, its valuation is
exactly one.  Formula (3.3) remains valid when the lower occurrence is
already imprimitive.

This is a particularly sharp obstruction to a cross-level resultant
argument.  If

```text
v_p(Phi_d(2))=w_p>=2,
```

then every later `p`-power level satisfies

```text
v_p(Phi_(d p^j)(2))=1,
v_p(gcd(Phi_d(2),Phi_(d p^j)(2)))=1.                      (3.4)
```

The common value and the resultant retain the one radical copy of `p` and
discard precisely the desired exponent `w_p-1`.

The discriminant is equally orthogonal.  Its absolute value is

```text
abs Disc(Phi_d)
 = d^phi(d) / product_{q|d} q^(phi(d)/(q-1)),               (3.5)
```

with the degree-one cases interpreted as discriminant one.  Its prime
support is contained in the support of `d`.  An exact-order prime satisfies
`d|p-1`, and hence `p` does not divide `d`.  Therefore

```text
gcd(E_d,Disc(Phi_d))=1.                                   (3.6)
```

Modulo such a prime, `Phi_d` is separable and its derivative at the root
`2 mod p` is nonzero.  A square divisor of the integer value is therefore
not a multiple root of the polynomial.

In fact the derivative gcd can be computed exactly:

```text
gcd(Phi_d(2),Phi'_d(2))=gcd(Phi_d(2),d).                   (3.7)
```

To prove (3.7), inspect one prime `q|Phi_d(2)`.  If `ord_q(2)=d`, then
`q` does not divide `d`, and the derivative `d*2^(d-1)` of `X^d-1` is
nonzero at `2 mod q`.  In the product
`X^d-1=product_{a|d}Phi_a(X)`, only the exact-order factor vanishes there,
so `Phi'_d(2)` is nonzero modulo `q`.  If `q` is imprimitive, then
`d=ord_q(2)q^j`, `j>=1`.  In characteristic `q`, the corresponding
cyclotomic polynomial is a positive power of the lower cyclotomic
polynomial, so its derivative vanishes at the common root.  Theorem 2.1 says
that `q` occurs only once in the evaluated value, which completes the gcd
calculation.  Thus the derivative gcd detects exactly the optional
imprimitive factor `I_d` in (2.8), and none of `E_d`.

There is also an exact cumulative lcm reformulation.  Let

```text
L_X=lcm_{1<=d<=X} Phi_d(2).
```

For a prime with first order `r`, Theorem 2.1 says that its valuations along
the cyclotomic tower are `w_p,1,1,...`.  Hence the maximum valuation in the
lcm is `w_p`, and therefore

```text
powerfulPart(L_X)=product_{d<=X} E_d,
log powerfulPart(L_X)=S(X).                               (3.8)
```

This is a natural single-integer realization of the cumulative mass, but it
does not itself bound that mass.  Standard lcm-height estimates control
`log L_X`, whose main scale is quadratic in `X`; they do not separate its
radical from the powerful part.

For comparison, put

```text
ell_p(X)=max {j>=0 : r_p p^j<=X}.
```

The same classification gives the finite identities

```text
v_p(product_{d<=X}Phi_d(2))=w_p+ell_p(X),                  (3.9)
sum_{n<m<=X} log gcd(Phi_m(2),Phi_n(2))
 = sum_{r_p<=X} binomial(ell_p(X)+1,2) log p.              (3.10)
```

The cross-level term (3.10) depends on the tower length but not on the
desired depth `w_p-1`.  Consequently inclusion--exclusion based only on
pairwise resultants or gcds cannot recover the powerful part in (3.8).

### The strict `1093` test

The prime `1093` has exact order `364`, and

```text
v_1093(Phi_364(2))=2.
```

Here `phi(364)=144`.  With `m=364*1093=397852`, formulas (3.1)--(3.4) give

```text
abs Res(Phi_m,Phi_364)=1093^144,
gcd(Phi_m(2),Phi_364(2))=1093,
v_1093(Phi_m(2))=1.                                      (3.11)
```

Moreover

```text
abs Disc(Phi_364)=2^144 * 7^120 * 13^132,                 (3.12)
```

so `1093` is absent from the discriminant.  An offline exact polynomial
calculation gives

```text
Phi'_364(2) mod 1093             = 666,
Phi_364(2) mod 1093^3            = 558*1093^2,
Phi_364(2+1093) mod 1093^2       = 666*1093.               (3.13)
```

Thus the same smooth cyclotomic divisor, with the same resultant and
discriminant, has square contact at the literal lift `2` and only simple
contact at the adjacent lift `2+1093`.  This is a strict finite example of
why the fixed lift cannot be replaced by a root density over lifts.

## 4. Torsion sections and the formal-group coordinate

Let `G_m` be the multiplicative group over `Spec Z`, and let

```text
T_d=V(Phi_d(X))
```

be the horizontal divisor of points of exact order `d`.  Pulling it back by
the fixed section `s_2 : X=2` gives

```text
s_2^* T_d = div(Phi_d(2)).                                (4.1)
```

Let `p` have exact order `d`.  Since `p` does not divide `d`, `T_d` is finite
etale at `p`.  Also `p=1 mod d`, so all `d`-th roots split over `Z_p`.
There is a unique Teichmuller root `zeta in Z_p` satisfying

```text
zeta^d=1,       zeta=2 mod p.                             (4.2)
```

All the other local linear factors are units at `X=2`, and therefore

```text
v_p(Phi_d(2))=v_p(2-zeta)=w_p.                            (4.3)
```

In the regular local surface `Z_p[[T]]`, the two sections have local
equations `T-zeta` and `T-2`.  Their intersection ring is

```text
Z_p/(2-zeta),
```

of length `w_p`; its excess over reduced intersection has length `w_p-1`.
The multiplicity is therefore an honest intersection length, but it occurs
between two smooth sections of an etale divisor.  Smoothness and
transversality of the horizontal divisor do not force the intersection of a
chosen integral lift to be reduced.

Equivalently put `u=2/zeta in 1+p Z_p`.  For odd `p`,

```text
v_p(u-1)=v_p(log_p u)=w_p,
d log_p(u)=log_p(2^d).                                    (4.4)
```

Because `p` does not divide `d`, (4.4) is an exact change of coordinates,
not a saving.  A varying-prime lower bound for this logarithm would have to
be uniform in both the residue characteristic and the varying torsion order.
The usual fixed-`p` logarithmic-form constants do not provide that uniformity.

The ramified `p`-power torsion tower also does not recover the lost depth.
Theorem 2.1 says that each layer `d p^j`, `j>=1`, has valuation exactly one,
independent of `w_p`.  Geometrically, the collision of torsion branches in
characteristic `p` records the radical prime, while the high contact of the
fixed section is confined to the bottom etale layer.

## 5. Norms and Arakelov degree

Let `K_d=Q(zeta_d)`.  The norm identity is

```text
abs Norm_{K_d/Q}(2-zeta_d)=Phi_d(2).                       (5.1)
```

For an exact-order prime `p`, splitting is complete and exactly one prime
ideal above `p` contains `2-zeta_d`; its valuation is `w_p`.  Removing one
copy of each finite prime from the principal ideal gives an effective excess
divisor, equivalently a finite quotient module of order `E_d`.  With the
effective-divisor/finite-module convention its degree is

```text
degree(effective excess divisor)=log E_d.                   (5.2)
```

This is a genuine construction of the required `log p` weight.  It is the
cyclotomic specialization of the general excess module
`Z/(n/rad(n))`; it does not furnish an upper bound for that module.

The product formula gives the total intersection height

```text
log Phi_d(2)
 = sum_{a in (Z/dZ)^*} log |2-zeta_d^a|
 = phi(d) log 2+O(1),                                    (5.3)
```

where the error is uniform.  For example, Moebius inversion writes the
error as a subsum of the convergent series
`sum_{j>=1}|log(1-2^(-j))|`.

Arithmetic Bezout or Hilbert--Samuel theory controls the total in (5.3).
The leading term is already `degree(T_d)*h(2)=phi(d)log 2`.  Subtracting the
degree of the reduced pullback is a truncated-counting operation, not a
linear intersection operation.  Neither the cyclotomic discriminant nor a
Hilbert--Samuel coefficient bounds this difference; (3.6) shows that the
discriminant support is disjoint from the exact-order excess.

There is also a scale mismatch.  Summing total heights gives

```text
sum_{d<=X} log Phi_d(2)=Theta(X^2),                        (5.4)
```

whereas the proposed target is `S(X)=o(X)`.  In particular, the target says
that the average value of `log E_d` tends to zero.  It even implies that the
number of indices `d<=X` with `E_d>1` is `o(X)`.  A normalized statement such
as `log E_d=o(phi(d))`, even if available, is far too weak for (1.1).

## 6. Dynamical height and equidistribution boundary

On `G_m`, multiplication by `d` sends the section `2` to `2^d`.  The exact
torsion divisors `T_d` are the primitive components of the pullback of the
unit section.  The canonical height identity

```text
h(2^d)=d log 2                                             (6.1)
```

and dynamical or group-theoretic Zsigmondy theorems control total height and
the existence of primitive support.  They do not bound the nonreduced part
of that support.

Even the abc conjecture, applied separately to
`1+(2^d-1)=2^d`, would give a qualitative

```text
log((2^d-1)/rad(2^d-1))=o(d).                              (6.2)
```

It does not by itself give a fixed power saving, and summing separate
`o(d)` statements does not imply the much stronger `S(X)=o(X)`.  Thus the
cumulative first-order target requires uniform information beyond a
pointwise height inequality with constants depending on an epsilon.

Archimedean equidistribution of primitive roots explains the main term in
(5.3).  Nonarchimedean weak equidistribution tests bounded continuous
functions.  The function measuring `-log|2-zeta|_p` is singular exactly at
the congruence classes responsible for `E_d`.  Weak convergence does not
control the tail of an unbounded test function.  A successful
equidistribution argument would need a new fixed-base, varying-`p` uniform
integrability estimate for these tails.  This is a precise missing theorem,
not an assertion that all quantitative equidistribution methods are
impossible.

## 7. Strict scope barriers

Over any arithmetic DVR with uniformizer `pi`, the two smooth sections

```text
T=0,       T=pi^M
```

of the affine line have intersection length `M`, while their reduced
intersection support is the single closed point.  Hence etaleness,
regularity, intersection positivity, and Hilbert--Samuel formalism alone do
not bound excess contact by reduced support.  The coefficient `pi^M`
contains the large height, so arithmetic Bezout correctly reproduces rather
than removes it.

This local family is not a counterexample inside the fixed base-two
cyclotomic sequence.  The strict fixed cyclotomic example is instead (3.13):
at `d=364` two adjacent lifts of the same residue root have different
intersection depths.  It rules out substituting the exact average over
lifts for a theorem about the literal section `2`.

Similarly, pairwise coprimality of the `E_d`, the congruence
`p=1 mod d`, and the archimedean size budget are structural constraints, but
none is a truncated height inequality.  No counterexample to (1.1) is known,
so the fixed-base route remains open.

## 8. Offline finite diagnostics

An exact integer scan for `1<=d<=45` verifies (2.6) at every level.  The only
imprimitive factors in that range are

```text
d=6:  3,      ord_3(2)=2;
d=18: 3,      ord_3(2)=2;
d=20: 5,      ord_5(2)=4;
d=21: 7,      ord_7(2)=3,
```

and each occurs to exponent one.  The congruences in (3.13) were independently
recomputed from the degree-144 integer polynomial `Phi_364`.  These are
finite computational checks, not evidence upgraded to an asymptotic theorem,
and they are not assumptions in the Lean module.

## 9. Verdict and surviving inputs

The exact advance is

```text
E_d=powerfulPart(Phi_d(2)).                                (9.1)
```

It identifies the hard object canonically as the excess intersection of the
fixed section with the exact torsion divisor.  It also proves that the three
most immediate auxiliary invariants miss the desired depth:

1. cross-level resultants and evaluated gcds retain only one radical copy;
2. the cyclotomic discriminant is coprime to `E_d`;
3. the ramified `p`-power torsion tower has valuation one at every upper
   layer, independently of the bottom depth.

Arithmetic Bezout, Hilbert--Samuel asymptotics, canonical heights, and weak
torsion equidistribution therefore reproduce the total height but do not
prove either proposed saving in their standard forms.  A successful proof
must add at least one genuinely fixed-base input, for example:

* a varying-prime uniform-integrability theorem for the singular local
  proximity `-log|2-zeta_d|_p`;
* an average squarefree-value theorem for the varying sequence `Phi_d(2)`,
  strong enough to control the logarithmically weighted powerful part;
* a theorem excluding infinitely many exponentially large repeated
  primitive factors, together with a summable estimate for the remaining
  small-prime and higher-valuation tails;
* a global truncated-intersection inequality uniform over all exact torsion
  divisors up to level `X`, rather than a separate height inequality at each
  level.

No one of these inputs is presently proved here.  In particular, (9.1) is an
exact reformulation and structural improvement, not an abc proof.

## 10. Lean boundary

`IUTThreeClosures/MersenneFixedBaseCyclotomicIntersection.lean` formalizes:

1. the geometric prime-step quotient identity
   `(1+A+...+A^(p-1))(A-1)=A^p-1`;
2. for an odd prime `p` and `A=1 mod p`, the quotient has exact
   `p`-multiplicity one;
3. the specialization `A=2^(d p^j)`, showing every imprimitive `p`-tower
   step carries exactly one copy of `p`.

The full Moebius classification, the cyclotomic resultant and discriminant
formulas, `p`-adic Teichmuller sections, Arakelov intersections, and the
analytic target remain paper mathematics.  No estimate for `E_d`, hidden
target field, or abc-type assumption is included in the Lean file.
