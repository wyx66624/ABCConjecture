# Full rational 2-isogeny graph and the modular-height route

## 1. Scope

This is an offline calculation for the primitive positive Frey curve

```text
E : y^2 = x(x-a)(x+b),       a+b=c.
```

It has the three nonzero rational two-torsion points with x-coordinates
`0`, `a`, and `-b`.  We compute all three immediate degree-two quotient
models, determine the best displayed discriminant among them, and use an
infinite endpoint family to classify the entire rational 2-isogeny graph.
The second half isolates the exact quantitative modular-height statement
which would be needed to obtain slope six.  No modular-degree bound,
Faltings-height bound, Neron-conductor theorem, Szpiro estimate, or abc
estimate is assumed to be proved.

## 2. The three quotient models

For

```text
y^2 = u^3 + A u^2 + B u,
```

the quotient attached to `(0,0)` has displayed equation

```text
Y^2 = X^3 - 2 A X^2 + (A^2-4B) X.                 (2.1)
```

The affine formula away from the kernel is

```text
X = y^2/u^2,       Y = y(B-u^2)/u^2.
```

The earlier Lean module verifies the cleared-denominator identity.  Formula
(2.1), by itself, is not yet a formal group-homomorphism or isogeny object.

### 2.1 Kernel at `x=0`

Here `A=b-a` and `B=-ab`.  The quotient is

```text
E_0 : Y^2 = X^3 + 2(a-b)X^2 + c^2 X,
```

and

```text
c4(E_0) = 16(a^2-14ab+b^2),
Delta(E_0) = -256 ab c^4.                          (2.2)
```

### 2.2 Kernel at `x=a`

Put `u=x-a`.  Then

```text
E : y^2 = u(u+a)(u+c)
          = u^3+(a+c)u^2+ac u.
```

Thus

```text
E_a : Y^2 = X^3 - 2(a+c)X^2 + b^2 X,
```

and direct substitution into the Weierstrass invariant formulas gives

```text
c4(E_a) = 16(16a^2+16ab+b^2),
Delta(E_a) = 256 ac b^4.                           (2.3)
```

### 2.3 Kernel at `x=-b`

Put `u=x+b`.  Then

```text
E : y^2 = u(u-b)(u-c)
          = u^3-(b+c)u^2+bc u.
```

The third quotient is

```text
E_{-b} : Y^2 = X^3 + 2(b+c)X^2 + a^2 X,
```

with

```text
c4(E_{-b}) = 16(a^2+16ab+16b^2),
Delta(E_{-b}) = 256 bc a^4.                        (2.4)
```

All three discriminants are nonzero for a positive abc point.

## 3. Average and optimal choice

Write

```text
D_0 = 256 ab c^4,
D_a = 256 ac b^4,
D_b = 256 bc a^4.
```

Since `a<c` and `b<c`, factoring out `256abc` gives

```text
D_a = 256abc b^3 <= 256abc c^3 = D_0,
D_b = 256abc a^3 <= 256abc c^3 = D_0.              (3.1)
```

Thus the `(0,0)` quotient already used in the repository is the optimal
choice among all three immediate rational two-quotients.  Switching kernels
or taking the largest cannot improve its exponent.

The product identity is also exact:

```text
D_0 D_a D_b = 256^3 (abc)^6.                       (3.2)
```

Consequently their mean logarithmic discriminant is

```text
(log D_0 + log D_a + log D_b)/3
  = log 256 + 2 log(abc).
```

This average is only `log 16` above the original displayed Frey
discriminant `16(abc)^2`; averaging does not create a sixth-power lower
bound either.

## 4. The complete rational 2-isogeny graph on an endpoint family

A curve of the form

```text
Y^2 = X(X^2-2AX+(A^2-4B))
```

has extra rational two-torsion beyond `(0,0)` precisely when the quadratic
factor splits, equivalently when its discriminant `16B` is a rational
square.  Thus the quotient leaf has only one rational two-torsion point when
`B` is not a rational square.  A rational degree-two isogeny in
characteristic zero is determined by a rational point of order two, so such
a leaf has only the dual edge back to `E`.

Now take the primitive endpoint family

```text
a=1,       b=c-1,       c = 256K+2.                (4.1)
```

Here `c` is `2 modulo 8`, so it is not a rational square.  The three values
of the pre-quotient coefficient `B` are

```text
-(c-1),       c,       c(c-1).
```

The first is negative; the other two are `2 modulo 8`.  None is a rational
square.  Hence every quotient leaf has exactly one rational two-torsion
point, so its only outgoing rational degree-two isogeny is the dual edge
back to `E`.  Consequently the complete rational 2-isogeny graph over `Q`,
up to `Q`-isomorphism, is exhausted by `E` and the three curves in Section
2.  Before identifying accidentally isomorphic vertices this is the
four-model star.  Pairwise nonisomorphism is neither asserted nor needed:
any such identification can only shrink the list of vertices.

On (4.1), the four displayed absolute discriminants are

```text
16(c-1)^2 c^2,
256(c-1)c^4,
256c(c-1)^4,
256(c-1)c.
```

Every one is at most `256c^5`.  A global minimal discriminant is no larger
prime by prime than the discriminant of any displayed integral model of the
same curve.  Therefore every vertex in the complete graph satisfies

```text
|Delta_min| <= 256 c^5.                             (4.2)
```

Since `256K<c`, equations (4.1)--(4.2) give

```text
K * max_vertex |Delta_min| < c^6.                   (4.3)
```

This is the required infinite-family obstruction: no choice anywhere in the
complete rational 2-isogeny graph supplies a uniform sixth-power lower bound.
It applies a fortiori to the four canonical displayed models.  Without a
minimal or otherwise fixed normalization a "bare discriminant" is
meaningless, since a nonminimal change of variables can multiply it by an
arbitrary twelfth power.

## 5. What modularity gives exactly

Let `E/Q` be a modular elliptic curve of Neron conductor `N`, let `f` be its
normalized weight-two newform, and let

```text
phi : X_0(N) -> E
```

be a chosen modular parametrization.  For a Neron differential `omega_E`,
write

```text
phi^* omega_E = c_phi (2 pi i f(z) dz),
```

where `c_phi` is the corresponding Manin factor.  Fix the **unnormalized
geometric** norm

```text
||alpha||_geom^2 = (i/2) integral alpha wedge conjugate(alpha)
```

on both curves; in particular, the integral over `X_0(N)` is not divided by
the volume of the modular curve.  With this convention, change of variables
gives the exact covolume identity

```text
deg(phi) ||omega_E||_geom^2
  = |c_phi|^2 ||2 pi i f(z) dz||_geom^2.             (5.1)
```

If `omega_E` is a global Neron differential, its associated relative
Neron-differential height therefore has the form

```text
h_Ner(E)
 = (1/2) log(
     deg(phi) /
       (|c_phi|^2 ||2 pi i f(z) dz||_geom^2))
       + O(1).                                       (5.2)
```

This line is a normalization identity, not yet a stable-height theorem.  To
use the stable Faltings height later, one must also prove that the local
base-change/minimal-differential correction is uniformly bounded on the Frey
family (the only expected varying issue here is the place above `2`).  If a
volume-normalized Petersson norm is used instead, an additional modular-curve
volume factor of order `N` enters (5.1); every exponent below must then be
recalibrated.

Qualitative modularity supplies `f` and `phi`; it supplies no useful upper
bound for the ratio in (5.2).

## 6. The minimum quantitative modular statement

With the preceding geometric norm, define the modular covolume ratio

```text
R_phi(E) = deg(phi) /
  (|c_phi|^2 ||2 pi i f(z) dz||_geom^2).
```

Composing `phi` with multiplication by an integer multiplies its degree by
the square of that integer and `c_phi` by the same integer, so this ratio does
not provide a hidden freedom to improve the bound by choosing a nonoptimal
parametrization.  It should be regarded as the covolume ratio attached to the
fixed target curve and the chosen newform normalization.

The precise exponent needed for slope six is the following.

### Modular covolume estimate

For every `eta>0`, every curve in the Frey family has

```text
R_phi(E) <= C_eta N^(1+2 eta),                       (MC_eta)
```

with `C_eta` independent of the abc point.  By (5.2), this says for the
relative Neron-differential height

```text
h_Ner(E) <= (1/2+eta) log N + O_eta(1).              (6.1)
```

A sufficient, but stronger and normalization-dependent, decomposition would
have the asymptotic exponents

```text
deg(phi) <= N^(2+o(1)),
|c_phi|   >= N^(-o(1)),
||2 pi i f dz||_geom^2 >= N^(1-o(1)).                (6.2)
```

For an optimal parametrization with an integral Manin constant at least one,
the Manin term helps an upper bound; for a nonoptimal target it cannot simply
be deleted.  The combined statement `(MC_eta)` is the invariant requirement
and avoids concealing this issue.

To turn (6.1) into a model or `j`-height estimate, one first needs the
uniform relative-to-stable correction just noted, and then a genuine
two-sided stable-Faltings--`j` comparison of the form

```text
h(j(E)) <= 12 h_F(E) + A log(2+h(j(E))) + B,         (6.3)
```

with absolute `A,B`.  The logarithmic error is sublinear and can be absorbed:
for every `rho>0`,

```text
A log(2+H) <= rho H + O_{A,rho}(1).
```

Choosing `eta` and `rho` sufficiently small in (6.1)--(6.3) yields

```text
h(j(E)) <= (6+delta) log N + O_delta(1).             (6.4)
```

Finally, a separate local minimal-model theorem is required for the Frey
family:

```text
log N <= log rad(abc) + O(1).                        (6.5)
```

Together with the already formalized exact corridor

```text
log c <= h(j(E))/6 + O(1),
```

equations (6.4)--(6.5) give abc.

## 7. Circularity audit

Neither modularity, the existence of a Manin factor, nor the area identity
(5.1) proves `(MC_eta)`.  The latter is the entire missing exponent bound.
On the Frey family, `(MC_eta)` plus the standard height and conductor bridges
implies abc.  Conversely, after the corresponding reverse height comparison
and the fact that the Frey Neron conductor has the same varying prime support,
abc gives the same exponent for `R_phi(E)` through (5.2).  Thus the modular
covolume estimate is essentially a modular reformulation of the slope-six
modified-Szpiro input, not established progress unless it is independently
proved by new modular-degree/Petersson estimates.

In particular:

* modularity alone is qualitative;
* a Manin-constant assertion alone has the favorable sign but is insufficient;
* a modular-degree upper bound without the Petersson lower bound is
  insufficient;
* replacing the actual Neron conductor by the displayed discriminant radical
  must be justified by local minimal models, not by notation.

The new unconditional content of this route is therefore Section 2--4: the
full immediate quotient calculation, optimality of the existing quotient,
and the complete-graph endpoint obstruction.  The modular part identifies a
sharp missing theorem but does not prove it.

## 8. Intended Lean boundary

The accompanying Lean module formalizes only:

1. the two quotient models not previously present;
2. their exact integral and rational `c4` and discriminants;
3. the product identity and optimality of the `(0,0)` quotient;
4. the numerical endpoint `c^5` ceiling and resulting `c^6` no-go.

It does not call a displayed map an actual isogeny and does not formalize the
four-vertex graph classification, minimal discriminants, modularity,
Faltings heights, Manin constants, modular degrees, Petersson norms, Neron
conductors, Szpiro, or abc.
