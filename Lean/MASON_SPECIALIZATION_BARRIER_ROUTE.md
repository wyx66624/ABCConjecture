# Mason--Stothers deformation route: the moving-section barrier

**Status.**  Offline, non-IUT research note.  The polynomial identities,
degree calculations, resultants, specialization estimate, and logical
equivalence isolated below are formalized in
`IUTThreeClosures/MasonSpecializationBarrier.lean`.  This note does **not**
prove the number-field abc conjecture.  It identifies, by exact calculations,
why the function-field theorem does not by itself cross the specialization
boundary.

## 1. Every abc triple lies on one fixed Mason tripod

Let `a,b,c` be positive, pairwise coprime integers with `a+b=c`, and put

```
x = a/c in Q.
```

In `Q[T]` consider the fixed identity

```
F(T) = T,       G(T) = 1-T,       H(T) = -1,
F+G+H = 0.                                           (1.1)
```

The three polynomials are nonzero and `F,G` are coprime.  The product
`FGH=-T(1-T)` has the two simple roots `0,1`, so

```
deg rad(FGH) = 2,
max(deg F,deg G,deg H)+1 = 2.                        (1.2)
```

Thus Mason--Stothers is an equality for this fixed identity.  On the other
hand, evaluation at the moving rational point `x=a/c` gives

```
c F(x) = a,       c G(x) = b,       c H(x) = -c.     (1.3)
```

Consequently every primitive integer abc triple is a specialization of the
same horizontal polynomial configuration.  Its degree, horizontal radical,
and horizontal Wronskian contain no point-dependent arithmetic information.
All of that information is carried by the height and the vertical
intersections of the moving section `T=x`.

This is not merely an example of a poorly chosen deformation: it is the
canonical coordinate description of the arithmetic tripod
`P^1-{0,1,infinity}`.

## 2. The missing specialization statement is exactly abc

Because `gcd(a,c)=1` and `0<a<c`, the absolute logarithmic Weil height of
`x=a/c` is

```
h(x)=log c.                                           (2.1)
```

At a finite prime `p`, the section `x` meets the three components of the
tripod precisely as follows:

```
x meets 0          iff p | a,
x meets 1          iff p | b=c-a,
x meets infinity   iff p | c.                        (2.2)
```

Pairwise coprimality makes these alternatives disjoint.  Hence the truncated
finite intersection contribution is exactly

```
sum_{p | abc} log p = log rad(abc).                   (2.3)
```

It follows that a uniform moving-section inequality

```
h(x) <= (1+epsilon) N^(1)(x,{0,1,infinity}) + C_epsilon
                                                               (2.4)
```

is the logarithmic abc conjecture, not a routine consequence of polynomial
specialization.  The Lean theorem
`tripodSpecializationBound_iff_abc` records this exact logical boundary using
the repository's genuine Weil height and elementary conductor.  The theorem
is an equivalence audit; it does not assume either side.

## 3. Unit-discriminant family with unbounded specialization multiplicity

There is also a strict counterexample to the idea that specialization loss is
controlled by bad fibres of the polynomial family.  For an integer `n>=1`,
put

```
A_n(T)=1,       B_n(T)=T+n,       C_n(T)=T+n+1.       (3.1)
```

Then `A_n+B_n=C_n`, evaluation at `T=0` gives `(1,n,n+1)`, and the degree
triple is always `(0,1,1)`.  Moreover

```
Res(B_n,C_n)=C_n(-n)=1.                               (3.2)
```

The two finite horizontal sections are therefore disjoint over every fibre;
together with the infinity section they give a good integral tripod over
`Spec Z`.  Equivalently, the discriminant of
`(T+n)(T+n+1)` is `1`.

The change of coordinate `U=T+n` turns (3.1) into the fixed family

```
1, U, U+1
```

and sends the specialization section `T=0` to `U=n`.  Thus the apparent
coefficient growth in (3.1) and the moving-point height in the fixed gauge are
the same intrinsic datum.

Now take `n=2^m`.  The family still has unit resultant and no bad prime, but

```
B_n(0)=2^m
```

meets the `B=0` section over `p=2` with intersection multiplicity `m`.  This is
a strict counterexample to each proposed bridge of the following forms:

1. specialization height is bounded by horizontal degrees alone;
2. specialization height is bounded by horizontal degrees and the bad-fibre
   support of the family;
3. specialization intersection multiplicity is bounded by the family
   discriminant or pairwise resultants.

The counterexample does not refute an inequality which also includes the
moving section's truncated intersections.  Such an inequality is precisely
the unresolved arithmetic statement in Section 2.

## 4. Exact coefficient/point-height loss under evaluation

Let

```
P(T)=u_0+u_1 T+...+u_d T^d,
|u_i| <= H,       M=max(1,|t|).
```

The triangle inequality gives the completely explicit estimate

```
|P(t)| <= sum_{i=0}^d |u_i| |t|^i
       <= (d+1) H M^d.                                (4.1)
```

Therefore

```
log max(1,|P(t)|)
 <= log(d+1)+log max(1,H)+d log max(1,|t|).            (4.2)
```

The projective rational version is the familiar

```
h(P(t)) <= d h(t)+h(P)+O(log(d+1)).                    (4.3)
```

This inequality points in the easy direction.  It proves rigorously that a
bounded-degree embedding cannot make integer height disappear: it must occur
in the coefficient height, in the specialization-point height, or in both.
Mason--Stothers controls only horizontal degrees and reduced horizontal
zeros.  It supplies no reverse estimate for either height term in (4.2).

The Lean theorem `truncatedNatPolynomialEval_le` proves (4.1) for natural
coefficients.  This is enough for the loss audit and avoids hiding analytic or
height-theoretic assumptions in a structure field.

## 5. What survives as a genuine research direction

The preceding counterexamples retire only coefficient-free or
bad-fibre-only specialization bridges.  They do not retire arithmetic
deformation altogether.  A surviving route would have to prove a genuinely
new moving-section estimate: full height must be controlled by **truncated**
intersections with the tripod, uniformly in the section, after any auxiliary
cover or deformation is normalized.

Higher-degree substitutions do not automatically help.  For example,

```
T^d + (1-T^d) - 1 = 0
```

saturates Mason with one reduced zero from `T^d` and `d` reduced zeros from
`1-T^d`.  At `T=a/c`, clearing denominators introduces the new factor
`c^d-a^d`; the extra horizontal support has simply become extra arithmetic
support not present in `abc`.  To eliminate that new support one would need a
support-preserving cover of the thrice-punctured line, while Riemann--Hurwitz
forces every such self-map to have degree one.  To average it away one needs a
uniform truncated second-main-theorem/Subspace-Theorem input.  Neither input
is supplied by Mason itself.

Accordingly the honest frontier of this branch is:

```
fixed horizontal Mason identity
        + a new uniform arithmetic moving-section theorem
        -> abc.
```

The first term is completely formalized and constant; the second is exactly
the hard Diophantine core.  No specialization theorem, discriminant estimate,
or coefficient-height comparison proved here crosses that boundary.
