# Integral least zeros of the straight second jet: determinant, height, and an infinite anisotropic family

This note continues the exact linear--quadratic analysis in
`SECOND_JET_QUADRATIC_SYSTEM_ROUTE.md`.  Its purpose is quantitative.  It
computes the relevant integral discriminant, translates the classical
Meyer--Cassels mechanism without suppressing its lattice cost, identifies
what local-density information can and cannot see, and strengthens the
Mersenne obstruction from block-constant weights to arbitrary
prime-dependent weights.

The conclusions are deliberately asymmetric:

* in the stable indefinite range, an integral zero exists with a completely
  honest but very large coefficient-height bound;
* no such bound can depend only on dimension, signature, determinant
  square-class, or the radical of the determinant;
* on the infinite family `(1,2^m-1,2^m)`, the straight second-jet form is
  anisotropic already over `R`, for every `m>=3`.

No estimate of abc strength is assumed.

## 1. The internal lattice and its exact determinant

Let one prime block have distinct primes `p_1,...,p_r`, multiplicities
`e_1,...,e_r>0`, and normalized weights `y_i=x_{p_i}/p_i`.  Write

```text
L=sum_i e_i y_i,                 E=sum_i e_i y_i^2,
Omega=sum_i e_i.
```

The internal space is `K={L=0}`.  Choose the last multiplicity `e_r` as a
pivot and use the integral chart

```text
y_i=e_r t_i                       (i<r),
y_r=-sum_{i<r} e_i t_i.                         (1.1)
```

Integer `t_i` give integer `y_i`, hence integral prime weights
`x_{p_i}=p_i y_i`.  In this chart

```text
E=t^T B t,
B=e_r^2 diag(e_1,...,e_{r-1})+e_r e e^T,        (1.2)
```

where `e=(e_1,...,e_{r-1})^T`.  Thus

```text
B_ii=e_r e_i(e_r+e_i),
B_ij=e_r e_i e_j                 (i!=j).         (1.3)
```

The matrix determinant lemma gives

```text
det B
 =e_r^{2(r-1)} product_{i<r}e_i
    (1+e_r e^T(e_r^2 diag(e_i))^{-1}e)
 =e_r^{2r-3} Omega product_{i<r}e_i.             (1.4)
```

Equivalently,

```text
det B = e_r^{2(r-2)} Omega product_{i=1}^r e_i.  (1.5)
```

Therefore the discriminant square-class is exactly

```text
Omega product_i e_i.                             (1.6)
```

The actual primes `p_i` do not occur.  Passing between `y_i` and
`x_{p_i}=p_i y_i` changes a rational Gram determinant by a square, as it
must.  The chart (1.1) can be a finite-index sublattice of the saturated
integer kernel (for example, multiplicities `(1,1,2)` give index `2`).
Accordingly, the determinant below is exact for this displayed chart; its
square class and the resulting honest upper bounds remain valid, but it is
not asserted to be the saturated-kernel covolume.

For three blocks, put `d_n=omega(n)-1` when the block is nonempty and zero
otherwise.  On the full internal space the second-Hessian form is

```text
q_K=-a E_a-b E_b+c E_c.                           (1.7)
```

Consequently its exact determinant in the charts (1.1) is

```text
(-a)^{d_a}(-b)^{d_b}c^{d_c}
  product_{n in {a,b,c}} det B_n,                 (1.8)
```

and its signature is

```text
(d_c, d_a+d_b).                                   (1.9)
```

In particular it is nondegenerate.  Its bad-prime set is contained in the
primes dividing

```text
2abc product_n (Omega_n product_{p|n} e_p).        (1.10)
```

The Lean file proves the complete `r=3` chart and determinant identity; the
general determinant calculation above is the same rank-one matrix lemma.

## 2. What Meyer and Cassels actually give

Assume

```text
d_c>0,       d_a+d_b>0,       d=d_a+d_b+d_c>=5.   (2.1)
```

Then (1.7) is an indefinite rational quadratic form in at least five
variables.  Meyer's theorem gives a nonzero rational isotropic vector, and
clearing denominators gives an integral zero in the lattice (1.1).

This qualitative statement can be made effective, but the effective bound
has the wrong scale.  Let `Omega=Omega_a+Omega_b+Omega_c`.  Every entry of a
block matrix (1.3) is at most `2 Omega_n^3`, and there are at most
`Omega_n^2` entries.  Since `a,b,c<=c`, the coefficient `l^1` height of
`q_K` satisfies

```text
H(q_K) <= 2c(Omega_a^5+Omega_b^5+Omega_c^5)
       <= 2c Omega^5.                              (2.2)
```

A classical Cassels least-zero estimate, in coefficient-height form, has
the shape

```text
||t||_infinity <<_d H(q_K)^{(d-1)/2}.              (2.3)
```

Hence this route yields the honest bound

```text
||t||_infinity <<_d (c Omega^5)^{(d-1)/2}.         (2.4)
```

For varying support, even the exponent in (2.4) varies.  For fixed support
it is polynomial in `c`, not subpower in `rad(abc)`.  Writing
`c=rad(abc)*(c/rad(abc))` merely exposes the missing quotient; it does not
bound it.

The zero supplied by (2.4) lies in `K` and therefore has zero Wronskian.  The
polar construction from the preceding note converts it into a zero with
nonzero Wronskian: choose `w` with `B(u,w)!=0`, a compatible longitudinal
`v_0` with nonzero Wronskian, and set

```text
x=q(v_0+w)u-B(u,v_0+w)(v_0+w).                     (2.5)
```

All choices can be cleared integrally in the chart (1.1), but (2.5)
multiplies rather than reduces the coefficient-height bound.  Thus
qualitative Meyer plus quantitative Cassels proves existence, not the
required small normalized energy.

## 3. Why square-free discriminant reduction loses the lattice

One might try to replace `a,b,c` in (1.8) by their square-free kernels.  Over
`Q` this is legitimate: if `a=s t^2`, replacing the corresponding coordinates
by `t` times those coordinates changes `a` to `s`.  On the integral
prime-weight lattice, however, that change has index a power of `t`.

The denominator can be written exactly.  Factor each block as

```text
n=s_n t_n^2,             s_n square-free.             (3.1)
```

With `z_n=t_n y_n`, the coefficient `n E_n(y_n)` becomes
`s_n E_n(z_n)`.  Thus Cassels applied after this rational change has
coefficient height controlled by the square-free kernels, hence by the
radical.  A universal return to integral `y` may require a common projective
multiple divisible by every `t_n`; particular isotropic vectors can have
extra divisibility and need less.  Primitivity of an abc triple makes the
three blocks pairwise coprime, so the ambient lattice-index denominator is

```text
T=lcm(t_a,t_b,t_c)=t_a t_b t_c,
T^2=abc/(s_a s_b s_c).                                (3.2)
```

Since only `s_a s_b s_c<=rad(abc)` is known, (3.2) is not controlled by the
radical.  Square-free reduction moves the powerful-part cost from the
quadratic coefficients into the lattice index; it does not eliminate it.

The exact five-variable model is

```text
Q_T(u_1,u_2,v_1,v_2,v_3)
  =u_1^2+u_2^2-T^2(v_1^2+v_2^2+v_3^2).             (3.3)
```

It has dimension five, signature `(2,3)`, and the primitive integral zero

```text
(u_1,u_2,v_1,v_2,v_3)=(T,0,1,0,0).                 (3.4)
```

For every integral zero whose `v` block is nonzero,

```text
u_1^2+u_2^2
 =T^2(v_1^2+v_2^2+v_3^2) >= T^2.                  (3.5)
```

Thus the minimum positive energy is exactly `T^2`.  Yet

```text
det Q_T=-T^6,                                       (3.6)
```

whose square-class is constant.  Taking `T=2^k`, `k>=1`, also makes the radical of
the absolute determinant constantly equal to `2`, while (3.5) tends to
infinity.  Rationally, (3.3) is the constant form
`u_1^2+u_2^2-w_1^2-w_2^2-w_3^2` under `w_i=T v_i`; integrally that map has
index `T^3`.

This is a strict counterexample to any proposed least-zero bound depending
only on dimension, signature, determinant square-class, determinant radical,
or the set of bad primes.  Such a theorem can be rescued only by retaining
the integral lattice index or full coefficient valuations.  The Lean file
proves (3.4)--(3.6), the rational change of variables, the energy lower bound
for nonnegative-coordinate representatives, and the constant-radical
powers-of-two specialization.  Since the form depends only on coordinate
squares, taking absolute values supplies the immediate bridge to arbitrary
integer signs; that bridge is not packaged as a separately named Lean
theorem.

## 4. Local densities do not repair the missing index

At a prime not dividing (1.10), the reduction of `q_K` is nondegenerate.  In
dimension at least five a nondegenerate quadratic form over the residue field
has abundant nonsingular zeros, and Hensel lifting gives the expected good
local density.  Hence all genuinely delicate density factors lie at the
finite set (1.10).

This observation is useful for organizing a circle-method attack, but it is
not a height theorem.  The family (3.3) has only one bad prime when
`T=2^k`, `k>=1`, is rationally equivalent to one fixed isotropic form, and still has
least integral energy `4^k`.  The loss is the integral lattice index, which
is invisible to rational local solubility and to the determinant
square-class.  Any uniform density calculation must keep that index; after
doing so it reproduces, rather than removes, the powerful-part cost.

## 5. Arbitrary prime weights on the Mersenne endpoint

Let

```text
(a,b,c)=(1,2^m-1,2^m),          m>=3.               (5.1)
```

For arbitrary real normalized weights at the primes of `b`, define

```text
L=sum_{p|b} e_p y_p,
E=sum_{p|b} e_p y_p^2,
N=Omega(b)=sum_{p|b} e_p.                            (5.2)
```

The `c` block has one prime, `2`, of multiplicity `m`.  If its weight is
`z`, then

```text
L_c=mz,              E_c=mz^2=L_c^2/m.              (5.3)
```

First compatibility and the exact energy form of second compatibility are

```text
bL=cL_c,
c(bE-cE_c)=bL^2.                                    (5.4)
```

Multiplying the second equation by `m` and using (5.3) and the square of the
first gives

```text
mcE=(m+b)L^2.                                        (5.5)
```

Weighted Cauchy gives

```text
L^2<=NE.                                             (5.6)
```

Every prime factor is at least two, so

```text
2^N<=b=2^m-1<2^m,
N<=m-1.                                              (5.7)
```

For `m>=3`, elementary induction gives

```text
2^m-1>m(m-2).                                        (5.8)
```

Equivalently,

```text
(m-1)(m+b)<m(b+1)=mc.                                (5.9)
```

Combining (5.7) and (5.9),

```text
N(m+b)<mc.                                           (5.10)
```

If `L` were nonzero, (5.5)--(5.6) would give the reverse weak inequality
`mc<=N(m+b)`, a contradiction.  Hence `L=0`, then (5.5) gives `E=0`.
All `e_p` are positive and `E` is a sum of weighted squares, so every
`y_p=0`.  Equations (5.3)--(5.4) give `z=0` as well.

There is also a direct signature interpretation.  Write

```text
E=L^2/N+U,                  U>=0.                     (5.11)
```

on the `b` block.  On the first-compatible hyperplane the Hessian form is

```text
q=b[(N-1)/N-(b/c)(m-1)/m]L^2-bU.                    (5.12)
```

The bracket is negative precisely when `N(m+b)<mc`.  Thus (5.10) says that
the entire form is negative definite.  The absence of a nonzero solution is
real anisotropy, not a denominator or local-global failure.

At the smallest support, the same calculation is a complete
classification.  If the `b` block also has one prime coordinate of
multiplicity `N`, then `NE=L^2`; a nonzero solution exists only if

```text
N(m+b)=mc.                                            (5.13)
```

Thus `(1,3,4)` gives `1*(2+3)!=2*4`, and `(1,8,9)` gives
`3*(2+8)!=2*9`.  Their previously observed anisotropy is the first two
instances of the exact ratio obstruction.  Both numerical no-go statements
are now formalized in Lean.

This infinite family strictly retires the claim that an arbitrary
prime-dependent *straight* second derivative always supplies a nondegenerate
jet.  It does not disprove abc, mixed two-direction Hessians, or schemes with
fresh higher-order accelerations.

## 6. Exact boundary after the least-zero analysis

The stable indefinite range and the Mersenne range are now sharply
separated.

* If both internal signs occur and the internal dimension is at least five,
  Meyer gives rational existence.  Cassels gives only the coefficient-height
  scale (2.4), and the Wronskian conversion increases it.
* Dimension, signature, discriminant square-class, determinant radical, and
  good-prime local densities cannot control the integral height; (3.3) is an
  explicit counterexample.
* Some legitimate abc triples, including every triple (5.1), have no nonzero
  straight second jet even over `R`.  Therefore a universal selector of this
  type does not exist.

The remaining second-order possibilities must change at least one structural
feature: use genuinely mixed directions, allow controlled accelerations while
preserving positive energy, or restrict to a complementary class of triples
and supply another argument for anisotropic endpoints.  No amount of
quantitative refinement of a universal straight-jet least-zero theorem can
cross the Mersenne obstruction, because the required zero is absent.

## 7. Lean coverage

`IUTThreeClosures/SecondJetLeastZeroBarrier.lean` proves without extra
axioms:

1. the integral three-coordinate internal chart and its exact Gram
   determinant;
2. positivity of that internal Gram determinant;
3. the square-scaled five-form change of variables, determinant, exact
   witness, and least-energy lower bound;
4. constant determinant radical along the powers-of-two subfamily;
5. `2^Omega(n)<=n`, `Omega(2^m-1)<=m-1`, and the exponential inequality
   (5.8);
6. the exact endpoint energy equation (5.5), the strict moment-ratio lemma,
   the one-coordinate ratio classification (5.13), and the small-support
   `(1,3,4)` and `(1,8,9)` consequences;
7. the full Mersenne zero-moment theorem for arbitrary block moments;
8. zero weighted-square energy forces every individual prime coordinate to
   vanish, and the composed finite-coordinate theorem which derives Cauchy
   and annihilates all arbitrary Mersenne prime weights internally.

The general determinant formula (1.4), Meyer, Cassels, and the good-prime
local-density discussion remain paper-level.  No theorem field or hypothesis
in Lean encodes any of them or any desired abc estimate.
