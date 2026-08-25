# Straight prime-dependent second jets: the exact quadratic core

This note studies the unresolved straight-direction variant of the arithmetic
Wronskian route.  It gives the complete linear--quadratic system, diagonalizes
its Hessian equation, proves a rational existence result in the stable
indefinite range, and isolates why quantitative integral height remains as
hard as abc.  No target height bound or small-zero theorem is assumed.

## 1. The integral linear--quadratic system

For

```text
n=product_p p^{e_p}
```

and integer prime weights `x_p`, define the first directional derivative and
the straight mixed second derivative by

```text
D_x(n)=sum_{p|n} e_p (n/p) x_p,                         (1.1)

H_x(n)=sum_{p|n} e_p(e_p-1)(n/p^2)x_p^2
       +2 sum_{p<q, p,q|n} e_p e_q(n/(pq))x_p x_q.     (1.2)
```

Every coefficient in (1.2) is integral: a diagonal term occurs only when
`e_p>=2`, and then `p^2|n`; a mixed term occurs only when `pq|n`.

For a primitive triple `a+b=c`, the straight second-jet problem is the
homogeneous integral system

```text
D_x(a)+D_x(b)-D_x(c)=0,                                (1.3)
H_x(a)+H_x(b)-H_x(c)=0,                                (1.4)
W_x=aD_x(b)-bD_x(a) != 0.                              (1.5)
```

Thus it is one integral linear equation, one integral quadratic equation,
and avoidance of one further linear form.  There is no encoded abc estimate
in this formulation.

## 2. Block moments and exact Hessian diagonalization

Put

```text
y_p=x_p/p,
L_n=sum_{p|n} e_p y_p,
E_n=sum_{p|n} e_p y_p^2,
Omega_n=sum_{p|n} e_p.
```

Direct expansion of the prime monomial gives

```text
D_x(n)=n L_n,
H_x(n)=n(L_n^2-E_n),
Gamma_x(n)=D_x(n)^2-nH_x(n)=n^2 E_n.                   (2.1)
```

The local square divisibility `pow(n)^2|Gamma_x(n)` is therefore genuine.
Within one block,

```text
Omega_n E_n-L_n^2
 =sum_{p<q} e_p e_q(y_p-y_q)^2.                        (2.2)
```

This follows by expanding both sides.  In particular

```text
E_n >= L_n^2/Omega_n.                                  (2.3)
```

For two coordinates of multiplicities `e,f`, (2.2) is the exact identity

```text
(e+f)(e u^2+f v^2)-(eu+fv)^2=ef(u-v)^2.               (2.4)
```

The internal direction `(u,v)=(ft,-et)` has first moment zero and energy
`ef(e+f)t^2`.

First compatibility is

```text
aL_a+bL_b=cL_c.                                        (2.5)
```

Using `a+b=c`, weighted variance gives

```text
aL_a^2+bL_b^2-cL_c^2=(ab/c)(L_a-L_b)^2.               (2.6)
```

Substituting (2.1) into second compatibility shows that (1.4) is equivalent
to

```text
aE_a+bE_b-cE_c=(ab/c)(L_a-L_b)^2.                     (2.7)
```

This equivalence is exact for `c!=0`; it is formalized in Lean.

Equation (2.7) changes the interpretation of the second layer.  Locally the
energy retains two powerful-part factors, but globally the transverse term is
not a new normal: it is the **square of the old rank-one normal**.

Indeed, without assuming second compatibility, expansion gives

```text
bc Gamma_a+ac Gamma_b-ab Gamma_c
 +abc(H_a+H_b-H_c)=W_x^2.                              (2.8)
```

Setting the Hessian defect to zero recovers the earlier second-jet identity.
The new Lean module proves (2.8), not merely its zero-defect specialization.

## 3. The unavoidable energy lower bound

Weighted Cauchy applied to the two first blocks gives

```text
(L_b-L_a)^2 <= (Omega_a+Omega_b)(E_a+E_b).             (3.1)
```

One direct proof multiplies by `Omega_a Omega_b` and uses

```text
(Omega_b L_a+Omega_a L_b)^2 >=0
```

together with `L_a^2<=Omega_a E_a` and
`L_b^2<=Omega_b E_b`.

The Lean theorem `twoBlockMomentEnergyGap_nonneg` also covers an empty
prime block (`a=1` or `b=1`): then the corresponding `Omega`, `L`, and `E`
are zero, and the assertion reduces to the one remaining block.  Thus no
positive-support hypothesis is being silently imposed at this endpoint.

The first-order lattice calculation already proved

```text
L_b-L_a=(c/R)k,        k in Z,                          (3.2)
```

where `R=rad(abc)` and `k!=0` is precisely Wronskian nondegeneracy.  Hence

```text
E_a+E_b >= (c/R)^2/(Omega_a+Omega_b).                  (3.3)
```

Since `Omega(n)<=log_2 n`, the denominator is at most `2 log_2 c`.
Consequently, a theorem constructing a nondegenerate straight direction with

```text
E_a+E_b <<_epsilon R^{2 epsilon}                       (3.4)
```

would already imply abc, after absorbing a square root of a logarithm.
Conversely, no circle-method, geometry-of-numbers, or entropy argument can
produce (3.4) when `c/R` violates that conclusion: (3.3) says that the
claimed integral point simply does not exist in the proposed box.

Thus the global second-order energy estimate is at least as hard as abc.  The
second derivative gives a useful quadratic coordinate system, but it does not
bypass the original transverse spacing.

## 4. Explicit honest solutions and why they are tautological

The quadratic equation is often soluble.  Suppose, for example, that
`p||a` and `q||b`.  Activate only these two weights and set

```text
x_p=b/q,       x_q=-a/p.                               (4.1)
```

Pairwise coprimality makes these integers.  Then

```text
D_x(a)=ab/(pq),  D_x(b)=-ab/(pq),  D_x(c)=0.
```

Each active exponent is one and there is at most one active coordinate in
each block, so all three Hessians vanish.  Equations (1.3)--(1.5) hold and

```text
W_x=-abc/(pq).                                          (4.2)
```

The same construction works for exponent-one primes in any two of the three
blocks, with the signs dictated by `a+b-c=0`.  Therefore every triple having
an exponent-one prime in two blocks has an explicit nondegenerate integral
straight second jet.

But

```text
|W_x|/(pow(a)pow(b)pow(c))=R/(pq),                     (4.3)
```

a positive integer.  Its energy estimate is exactly the square of the
already-tautological two-prime minor.  This construction proves existence but
contains no height gain.

Small support can also be genuinely anisotropic.  For `(1,3,4)`, write the
weights at `3,2` as `x,y`.  First compatibility is `x=4y`, while second
compatibility is `0=2y^2`; hence only the degenerate zero direction exists.
For `(1,8,9)`, first compatibility gives `12x=6y`, while the Hessians are
`12x^2` and `2y^2`; again `x=y=0`.  These examples disprove universal
solubility, but they are not an infinite counterfamily and therefore do not
retire the general prime-dependent scheme.

## 5. Rational local--global existence in the stable indefinite range

Over `Q`, decompose each nonempty prime block into its longitudinal line and
the internal space

```text
K_n={y: sum e_p y_p=0}.
```

The decomposition is orthogonal for the energy form.  On the full internal
space, the Hessian quadratic form is

```text
q_K=-aE_a-bE_b+cE_c.                                   (5.1)
```

It is nondegenerate with signature

```text
d_+=max(omega(c)-1,0),
d_-=max(omega(a)-1,0)+max(omega(b)-1,0),                (5.2)
```

so unit blocks contribute zero.  Assume

```text
d_+>0,  d_->0,  d_++d_->=5.                            (5.3)
```

Then `q_K` is a nondegenerate indefinite rational quadratic form in at least
five variables.  Meyer's theorem gives a nonzero rational isotropic vector
`u in K`.

This internal zero can be converted to a transverse zero.  Let

```text
B(x,y)=q(x+y)-q(x)-q(y)
```

be the polar form.  Nondegeneracy gives `w in K` with `B(u,w)!=0`.  Choose a
longitudinal compatible vector `v_0` with `W(v_0)!=0`, and put `v=v_0+w`.
Orthogonality gives `B(u,v)=B(u,w)!=0`.  Then

```text
x=q(v)u-B(u,v)v                                         (5.4)
```

satisfies

```text
q(x)=0,       W(x)=-B(u,v)W(v_0)!=0.                   (5.5)
```

Thus under (5.3) a nondegenerate rational straight second jet always exists.
Multiplying by a common denominator, and then replacing `y_p` by the integral
prime weight `p y_p`, gives an integral solution of (1.3)--(1.5).

This is an existence theorem only.  Meyer supplies no subpower control on the
common denominator in this application.  The exact lower bound (3.3) proves
that such control cannot be obtained independently of `c/R`.  Classical
least-zero bounds in terms of the raw quadratic coefficients are polynomial
in those coefficients and are far too large; a circle-method proof would
also need uniform control of the discriminant and local densities as the
primes vary.  None of those quantitative inputs is hidden here.

## 6. Consequences for multiple tangents and Hasse jets

Taking an orthogonal sum of several copies of the Hessian form can make
rational isotropy easier.  For example, four-square identities can balance
positive and negative rational values after finitely many copies.  But every
individual first-compatible nondegenerate tangent still obeys (3.2)--(3.3),
and an aggregate identity has `sum_j W_j^2` on its right.  At least one
nonzero component retains the same transverse cost.  Stabilizing the
quadratic form does not remove the integral height obstruction.

Allowing a fresh Hasse acceleration at order two is different: its linear
contribution can solve the Hessian defect over `Q`, but it changes
`Gamma=D^2-nH` by an acceleration term and can destroy positivity.  It also
places one affine equation on a new variable rather than a new condition on
the first tangent.  Therefore it does not supply a second independent normal
without an additional positivity-preserving integral lifting theorem.

## 7. Lean coverage and exact boundary

`IUTThreeClosures/SecondJetQuadraticSystem.lean` proves:

- the two-coordinate internal-energy decomposition;
- the compatible longitudinal variance identity (2.6);
- both directions of the equivalence between Hessian compatibility and the
  energy balance (2.7);
- the nonzero-defect identity (2.8);
- finite weighted Cauchy for the actual block moments;
- the two-block energy bound (3.1), both abstractly and after direct
  composition with the nonzero projected-lattice quotient (3.2), together
  with its nonnegative endpoint form when one prime block is empty.

The Meyer argument in Section 5 is paper-level: Mathlib currently supplies no
ready quantitative theorem matching this rational quadratic-form statement,
and no unformalized height estimate is represented by a Lean hypothesis.

The unresolved core is now exact: construct a nondegenerate **integral** zero
of (1.3)--(1.4) whose normalized energy approaches the unavoidable floor
`(c/R)^2/(Omega_a+Omega_b)`, and then prove that this floor is subpower in
`R`.  The latter assertion is the abc-quality problem itself, not a routine
local--global or entropy estimate.
