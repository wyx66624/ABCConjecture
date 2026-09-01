# ABC multi-route research note v33: conductor-supported moving Pell coefficients and local splitting

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Starting point

For a positive primitive abc triple, v32 constructs

\[
m=wz^2,
\qquad
M=ux^2,
\qquad
c=vy^2,
\]

where

\[
m=\min(a,b),
\qquad
M=\max(a,b),
\]

`w,u,v` are positive and squarefree, and

\[
\boxed{wz^2+ux^2=vy^2.}
\]

Moreover the three products

\[
wz,\qquad ux,\qquad vy
\]

are pairwise coprime.

This note extracts two pieces of arithmetic information that were not present
in a purely real approximation treatment:

1. the moving quadratic coefficients use no prime support outside the original
   abc conductor;
2. every prime in one term satisfies a quadratic-residue condition determined
   by the opposite two coefficients.

No global distribution estimate for the resulting prime sets is assumed.

## 2. Exact coefficient support

Since

\[
w\mid wz^2=m,
\qquad
u\mid ux^2=M,
\qquad
v\mid vy^2=c,
\]

and `w,u,v` are squarefree, each coefficient divides the radical of its
endpoint:

\[
w\mid\operatorname{rad}(m),
\qquad
u\mid\operatorname{rad}(M),
\qquad
v\mid\operatorname{rad}(c).
\]

The original endpoints are pairwise coprime, so `w,u,v` are pairwise coprime.
Consequently

\[
\boxed{
 wuv\mid\operatorname{rad}(abc).
}
\]

In particular,

\[
\boxed{
uv\mid\operatorname{rad}(abc),
}
\]

and `uv` is squarefree.  Therefore the discriminant coefficient in

\[
(vy)^2-(uv)x^2=v(wz^2)
\]

has no hidden prime support: all of it is charged to the same conductor that
appears in the abc inequality.

## 3. First local splitting condition

Let `p` be a prime divisor of `ux`.  Pairwise coprimality gives

\[
\gcd(p,wz)=1.
\]

Modulo `p`, the term `ux^2` vanishes, so

\[
wz^2\equiv vy^2\pmod p.
\]

Multiplying by `v` gives

\[
(wv)z^2\equiv(vy)^2\pmod p.
\]

Because `z` is invertible modulo `p`, this implies

\[
\boxed{
wv\text{ is a square modulo }p.
}
\]

Thus every prime in the full support of the `ux` term splits in the quadratic
extension determined by `wv`.

## 4. Second local splitting condition

Let `p` divide `wz`.  Then

\[
ux^2\equiv vy^2\pmod p.
\]

Multiplying by `v` and cancelling the invertible square `x^2` gives

\[
\boxed{
uv\text{ is a square modulo }p.
}
\]

Hence every prime in the small-endpoint term is constrained by the squarefree
moving discriminant `uv`.

## 5. Third local splitting condition

Let `p` divide `vy`.  The right-hand side of the conic vanishes modulo `p`,
so

\[
wz^2+ux^2\equiv0\pmod p.
\]

After multiplying by `u`,

\[
(uw)z^2+(ux)^2\equiv0\pmod p.
\]

Since `z` is invertible modulo `p`, one obtains

\[
\boxed{
-uw\text{ is a square modulo }p.
}
\]

The three term supports therefore satisfy a cyclic system of quadratic local
conditions:

\[
\begin{array}{c|c}
\text{prime support} & \text{forced square class}\\
\hline
p\mid ux & wv\\
p\mid wz & uv\\
p\mid vy & -uw
\end{array}
\]

## 6. What has and has not been gained

The v32 approximation identity showed that ordinary real approximation alone
is critical:

\[
\frac uv
\left(
\frac vu-\left(\frac xy\right)^2
\right)
=
\frac mc.
\]

The present result adds genuine arithmetic information.  The roots and
coefficients cannot be chosen freely; every prime entering one term lies in a
prescribed quadratic residue class, and the defining squarefree coefficients
are fully paid for by the abc radical.

However, local splitting by itself does not yet imply a pointwise height
bound.  A complete closure now requires a uniform theorem that combines:

1. these three coupled residue conditions;
2. the conductor budget `wuv | rad(abc)`;
3. pairwise coprimality of `wz,ux,vy`;
4. the height-scale square parts forced by an abc violation;
5. the small-radical numerator `m`.

Equivalently, the remaining positive target is a conductor-uniform bound for
primitive integral points on this restricted family of moving diagonal
conics.  A counterexample program would have to construct an unbounded family
satisfying all five constraints while maintaining positive abc excess.

## 7. Lean implementation

Coefficient support is formalized in

```text
Lean/IUTThreeClosures/SquarefreePellCoefficientSupport.lean
```

with principal declarations

```lean
ABCPoint.SquarefreePellWitness.w_coprime_u
ABCPoint.SquarefreePellWitness.w_coprime_v
ABCPoint.SquarefreePellWitness.u_coprime_v
ABCPoint.SquarefreePellWitness.u_mul_v_squarefree
ABCPoint.SquarefreePellWitness.w_mul_u_mul_v_squarefree
ABCPoint.SquarefreePellWitness.w_dvd_smallRadical
ABCPoint.SquarefreePellWitness.u_dvd_largeRadical
ABCPoint.SquarefreePellWitness.v_dvd_cRadical
ABCPoint.SquarefreePellWitness.coefficientProduct_dvd_abcRadical
ABCPoint.SquarefreePellWitness.discriminantCoefficient_dvd_abcRadical
```

The cyclic local conditions are formalized in

```text
Lean/IUTThreeClosures/MovingPellLocalResidue.lean
```

using natural-number congruences rather than an assumed quadratic-character
oracle.  Its principal declarations are

```lean
IsSquareMod
IsNegativeSquareMod
isSquareMod_of_mul_square_mod_square
isNegativeSquareMod_of_mul_square_add_square
ABCPoint.SquarefreePellWitness.w_mul_v_isSquareMod_of_prime_dvd_u_mul_x
ABCPoint.SquarefreePellWitness.u_mul_v_isSquareMod_of_prime_dvd_w_mul_z
ABCPoint.SquarefreePellWitness.u_mul_w_isNegativeSquareMod_of_prime_dvd_v_mul_y
```

These are unconditional structural theorems.  They do not assert the remaining
uniform moving-conic estimate or a complete proof of abc.
