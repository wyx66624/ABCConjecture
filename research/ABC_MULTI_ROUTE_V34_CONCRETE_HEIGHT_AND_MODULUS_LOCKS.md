# ABC multi-route research note v34: concrete height-scale roots and full-modulus square locks

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Purpose

The v31 square-root theorem was formulated at the level of finite exponent
profiles.  V32 and v33 constructed a concrete squarefree moving-Pell witness
for every actual abc point and established its coefficient support and
primewise residue restrictions.

This note closes the remaining bookkeeping gap in two directions:

1. it transfers an actual abc height violation directly to the integral roots
   `z,x,y` of the concrete witness;
2. it upgrades the primewise quadratic-residue restrictions to congruences
   modulo the complete endpoint integers.

No global estimate for the moving conic is assumed.

## 2. Concrete square-root height inequalities

Let

\[
m=\min(a,b)=wz^2,
\qquad
M=\max(a,b)=ux^2,
\qquad
c=vy^2,
\]

with `w,u,v` squarefree and positive.

Because

\[
w\mid\operatorname{rad}(m),
\qquad
u\mid\operatorname{rad}(M),
\qquad
v\mid\operatorname{rad}(c),
\]

we obtain

\[
\boxed{
\log m-\log\operatorname{rad}(m)
\le2\log z,
}
\]

\[
\boxed{
\log M-\log\operatorname{rad}(M)
\le2\log x,
}
\]

and

\[
\boxed{
\log c-\log\operatorname{rad}(c)
\le2\log y.
}
\]

Since `c<=2M`,

\[
\log c-\log2\le\log M.
\]

Each endpoint radical divides the full abc radical, so all three individual
radical logarithms are at most the abc conductor

\[
R=\log\operatorname{rad}(abc).
\]

## 3. Actual height violation forces actual large roots

Suppose

\[
h=\log c>(1+\varepsilon)R+C,
\qquad
\varepsilon>0.
\]

Then the two large roots in the concrete witness satisfy

\[
\boxed{
\log x>
\frac{\varepsilon h+C}{2(1+\varepsilon)}
-
\frac{\log2}{2},
}
\]

and

\[
\boxed{
\log y>
\frac{\varepsilon h+C}{2(1+\varepsilon)}.
}
\]

Thus the moving-Pell coordinates are not merely nonzero auxiliary variables:
they have a fixed positive height slope in every hypothetical abc violation.

## 4. Concrete short-gap or three-root dichotomy

The same violation satisfies one of two alternatives.

### Short-gap branch

\[
\boxed{
2(1+\varepsilon)\log m<(2+\varepsilon)h.
}
\]

Equivalently,

\[
m<c^{\frac{2+\varepsilon}{2(1+\varepsilon)}}.
\]

### Three-root branch

All three concrete roots are large, with

\[
\boxed{
\log z>
\frac{\varepsilon h+2C}{4(1+\varepsilon)},
}
\]

and the two bounds for `x,y` above.

This is now a theorem about the actual integers occurring in

\[
wz^2+ux^2=vy^2,
\]

not an abstract interface populated by unrelated real parameters.

## 5. Full-modulus square classes

The v33 primewise local restrictions can be upgraded to the complete endpoint
moduli.

### Modulo the large summand

Since

\[
ux^2=M,
\]

the conic gives

\[
wz^2\equiv vy^2\pmod M.
\]

Multiplying by `v` gives

\[
(wv)z^2\equiv(vy)^2\pmod M.
\]

The small root `z` is coprime to `M`, hence invertible modulo `M`. Therefore

\[
\boxed{
wv\text{ is a square modulo }M.
}
\]

### Modulo the small endpoint

Likewise,

\[
\boxed{
uv\text{ is a square modulo }m.
}
\]

### Modulo the output

Finally,

\[
wz^2+ux^2\equiv0\pmod c.
\]

After multiplying by `u` and cancelling the square `z^2`,

\[
\boxed{
-uw\text{ is a square modulo }c.
}
\]

Thus the concrete witness satisfies the coupled system

\[
\begin{aligned}
wv&\in (\mathbb Z/M\mathbb Z)^{\times2},\\
uv&\in (\mathbb Z/m\mathbb Z)^{\times2},\\
-uw&\in (\mathbb Z/c\mathbb Z)^{\times2}.
\end{aligned}
\]

These are considerably stronger than three isolated Legendre-symbol
conditions: they hold modulo the entire pairwise-coprime endpoint moduli,
including all prime-power multiplicities.

## 6. Exact remaining core

A hypothetical counterexample must now provide, simultaneously:

1. a primitive conic
   \[
   wz^2+ux^2=vy^2;
   \]
2. positive squarefree, pairwise-coprime coefficients with
   \[
   wuv\mid\operatorname{rad}(abc);
   \]
3. the exact relative approximation identity
   \[
   \frac uv\left(\frac vu-(x/y)^2\right)=m/c;
   \]
4. height-scale lower bounds for `x,y`, and either a power-saving `m` or a
   height-scale lower bound for `z`;
5. the three full-modulus square-class locks above;
6. an overall radical small enough to violate the chosen abc inequality.

The ordinary real approximation identity alone is critical, and local
solubility alone permits infinite Pell families.  The unresolved theorem must
therefore be genuinely support-sensitive and uniform in the moving
squarefree coefficients.  A useful next formulation is an upper bound for
primitive integral points on this restricted family of diagonal conics whose
constant grows subcritically with

\[
\log\operatorname{rad}(wzuxvy).
\]

## 7. Lean implementation

The concrete height transfer is formalized in

```text
Lean/IUTThreeClosures/ConcreteMovingPellRootScale.lean
```

with principal declarations

```lean
ABCPoint.height_sub_log_two_le_log_largeEndpoint
ABCPoint.log_smallRadical_le_conductor
ABCPoint.log_largeRadical_le_conductor
ABCPoint.log_cRadical_le_conductor
ABCPoint.SquarefreePellWitness.log_small_sub_radical_le_two_log_z
ABCPoint.SquarefreePellWitness.log_large_sub_radical_le_two_log_x
ABCPoint.SquarefreePellWitness.log_c_sub_radical_le_two_log_y
ABCPoint.SquarefreePellWitness.large_roots_height_scale
ABCPoint.SquarefreePellWitness.shortGap_or_three_roots_height_scale
```

The complete-modulus congruences are formalized in

```text
Lean/IUTThreeClosures/MovingPellCompositeModulus.lean
```

with principal declarations

```lean
isSquareMod_of_mul_square_mod_square_of_coprime
isNegativeSquareMod_of_mul_square_add_square_of_coprime
ABCPoint.SquarefreePellWitness.w_mul_v_isSquareMod_largeEndpoint
ABCPoint.SquarefreePellWitness.u_mul_v_isSquareMod_endpointMin
ABCPoint.SquarefreePellWitness.u_mul_w_isNegativeSquareMod_c
```

These are non-circular structural results.  They do not assert the remaining
uniform conic-height estimate or a complete proof of abc.
