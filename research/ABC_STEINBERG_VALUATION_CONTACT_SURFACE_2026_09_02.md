# The Steinberg valuation contact surface of an abc point

**Author:** ChatGPT
**Date:** 2026-09-02
**Status:** algebraic core and quadratic peeling proved; two single-cell gates refuted; calibrated five-term filling gate open

## 1. Scope and separation from the existing routes

This note starts again from a primitive positive equation

\[
  a+b=c,\qquad \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1,
\]

and studies the two-dimensional object carried by its prime valuations.  It
does not assume an abc inequality, a Vojta inequality, an IUT comparison, or a
small-vector theorem.

The construction is distinct from two earlier parts of this repository.

* `MultiDerivationExteriorEnergy` takes exterior minors of several arithmetic
  derivative *values*.  Its main theorem is a rank-one obstruction.  The
  object below instead takes the exterior product of the actual prime-divisor
  vectors of `a/c` and `b/c` and has a five-term gluing law.
* The v29 affine-contact series applies a Bezout parametrization to powerful
  residuals.  Its contact factors are scalar quadratic expressions.  The
  object below is a functorial two-vector in the free prime-divisor lattice;
  it uses neither that parametrization nor its scalar contacts.
* The Fermat--Belyi/Kummer route pulls the punctured tripod through finite
  covers.  The present construction stays in the rational function field at
  degree one.  Its higher-dimensional feature is an exterior two-cell and a
  five-term relation, not a Kummer cover.

Thus the word *contact* here refers specifically to simultaneous contact of
two rational functions with the three boundary components of
`P^1 - {0,1,infinity}`.

## 2. The divisor triangle and its oriented surface

Let

\[
  \operatorname{Div}_{\mathbb Q}
    =\bigoplus_{p\ \mathrm{prime}}\mathbb Z[p]
\]

be the free lattice of finite prime divisors, and put

\[
  d(q)=\sum_p v_p(q)[p]\qquad(q\in\mathbb Q^\times).
\]

Write

\[
  A=d(a),\qquad B=d(b),\qquad C=d(c).
\]

For `x=a/c`, the equation gives `1-x=b/c`, and therefore

\[
 d(x)=A-C,\qquad d(1-x)=B-C.
\]

### Definition 2.1 (Steinberg valuation contact surface)

The oriented contact surface of the ordered divisor triangle `(A,B,C)` is

\[
 \boxed{\ \Omega(A,B,C)=(A-C)\wedge(B-C)\ }
 \quad\in\bigwedge^2\operatorname{Div}_{\mathbb Q}.
\]

Equivalently, `Omega(x)=d(x) wedge d(1-x)`.  It is the affine area bivector
of the triangle with vertices `A,B,C`; hence it is translation invariant.

### Proposition 2.2 (three-leg expansion)

\[
 \boxed{\ \Omega(A,B,C)=A\wedge B+B\wedge C+C\wedge A.\ }
\]

**Proof.** Bilinearity and alternation give

\[
 (A-C)\wedge(B-C)
 =A\wedge B-A\wedge C-C\wedge B
 =A\wedge B+B\wedge C+C\wedge A.\qedhere
\]

This is not an abc estimate.  It is an exact decomposition of one oriented
two-cell into its three pairwise boundary contacts.

### Proposition 2.3 (translation, scaling, and `S_3` orientation)

For every divisor vector `T`, integer `m`, and permutation `sigma` of the
three vertices,

\[
 \begin{aligned}
 \Omega(A+T,B+T,C+T)&=\Omega(A,B,C),\\
 \Omega(mA,mB,mC)&=m^2\Omega(A,B,C),\\
 \Omega(A_{\sigma(1)},A_{\sigma(2)},A_{\sigma(3)})
   &=\operatorname{sgn}(\sigma)\Omega(A,B,C).
 \end{aligned}
\]

**Proof.** Translation cancels in both differences, scaling factors out of
both exterior arguments, a cyclic permutation preserves the three-term sum
in Proposition 2.2, and one transposition reverses its orientation.  These
generate `S_3`.  QED.

For an abc point, this `S_3` action is the divisor shadow of the six Mobius
transforms permuting `0,1,infinity`.  Some transformed coordinates have a
negative rational representative, but `d(-1)=0`, so signs of rational
numbers do not affect the finite divisor surface.

## 3. Primitive support and a positive mixed-area identity

Put `S_a={p:p|a}`, and define `S_b,S_c` similarly.  Primitivity makes these
three sets pairwise disjoint.  If

\[
 A=\sum_{p\in S_a}\alpha_p[p],\quad
 B=\sum_{q\in S_b}\beta_q[q],\quad
 C=\sum_{r\in S_c}\gamma_r[r],
\]

then every exponent is positive.  Proposition 2.2 has no cancellation
between the three rectangular blocks

\[
 S_a\times S_b,\qquad S_b\times S_c,\qquad S_c\times S_a.
\]

For example, the coefficient on `[p] wedge [q]`, with `p` on the `a` leg and
`q` on the `b` leg, is `alpha_p beta_q`, up to the fixed ordering sign of the
basis.  This is a useful positivity statement that is absent from a generic
exterior product.

Let `w_p>=0` be arbitrary prime weights and put

\[
 L_w(A)=\sum_{p\in S_a}\alpha_pw_p
\]

and similarly for `B,C`.  Give a two-vector the weighted coefficient norm

\[
 \left\|\sum_{p<q}z_{pq}[p]\wedge[q]\right\|_{1,w}
 =\sum_{p<q}|z_{pq}|w_pw_q.
\]

### Proposition 3.1 (exact mixed contact area)

For pairwise-disjoint nonnegative supports,

\[
 \boxed{
 \|\Omega(A,B,C)\|_{1,w}
 =L_w(A)L_w(B)+L_w(B)L_w(C)+L_w(C)L_w(A). }
\]

**Proof.** On each of the three disjoint rectangular support blocks, the
absolute coefficient factors as a product.  Summing first in each coordinate
turns the block sum into the product of the two leg masses.  The three blocks
are disjoint, so their norms add.  QED.

With `w_p=log p`, unique factorization gives

\[
 \Phi(a,b,c):=\|\Omega(A,B,C)\|_{1,\log}
 =\log a\log b+\log b\log c+\log c\log a.                 \tag{3.1}
\]

This is a genuine two-dimensional invariant: it is quadratic in the three
leg heights, rather than another name for `log c` or `log rad(abc)`.

## 4. Radical skeleton and exact excess area

For a nonnegative divisor `D=sum e_p[p]`, let

\[
 \tau D=\sum_{e_p>0}[p]
\]

be its coefficient-one truncation.  Put

\[
 A_0=\tau A,\quad B_0=\tau B,\quad C_0=\tau C,
 \qquad A_+=A-A_0,\quad B_+=B-B_0,\quad C_+=C-C_0.
\]

Let `r_a=L_w(A_0)` and `delta_a=L_w(A_+)`, and use analogous notation on
the other legs.  Thus `L_w(A)=r_a+delta_a`.

The radical contact skeleton has area

\[
 \Psi_w=r_ar_b+r_br_c+r_cr_a.                            \tag{4.1}
\]

### Proposition 4.1 (mixed-depth excess decomposition)

\[
\begin{aligned}
 \|\Omega(A,B,C)\|_{1,w}-\Psi_w
  ={}&r_a\delta_b+\delta_ar_b+\delta_a\delta_b\\
    &+r_b\delta_c+\delta_br_c+\delta_b\delta_c\\
    &+r_c\delta_a+\delta_cr_a+\delta_c\delta_a.
                                                               \tag{4.2}
\end{aligned}
\]

In particular, the radical skeleton never has greater area than the full
valuation surface.

**Proof.** Substitute `L_w(A)=r_a+delta_a` and its two analogues in
Proposition 3.1, expand the three products, and subtract (4.1).  Every
remaining term is nonnegative.  QED.

For logarithmic weights,

\[
 r_a=\log\operatorname{rad}(a),\quad
 r_b=\log\operatorname{rad}(b),\quad
 r_c=\log\operatorname{rad}(c).
\]

Primitivity gives

\[
 \rho:=r_a+r_b+r_c=\log\operatorname{rad}(abc),           \tag{4.3}
\]

and elementary quadratic algebra gives

\[
 3\Psi_w\le \rho^2,                                      \tag{4.4}
\]

because

\[
 \rho^2-3\Psi_w
 =\tfrac12\big((r_a-r_b)^2+(r_b-r_c)^2+(r_c-r_a)^2\big).
\]

Equations (4.2)--(4.4) isolate a concrete target: repeated-prime depth is
the positive area added when the divisor triangle is thickened away from
its radical skeleton.

## 5. The five-term gluing law

The surface has more structure than the scalar area.  Let `x,y` be nonzero
rationals, different from `1` and from each other, and assume all five
arguments below are defined and avoid `0,1`.  Set

\[
\begin{aligned}
 z_1&=x,& z_2&=y,& z_3&=y/x,\\
 z_4&=\frac{y(1-x)}{x(1-y)},&
 z_5&=\frac{1-x}{1-y}.
\end{aligned}
\]

### Theorem 5.1 (Steinberg five-term surface relation)

\[
 \boxed{\Omega(z_1)-\Omega(z_2)+\Omega(z_3)
       -\Omega(z_4)+\Omega(z_5)=0.}                       \tag{5.1}
\]

**Proof.** Abbreviate

\[
 X=d(x),\ U=d(1-x),\ Y=d(y),\ V=d(1-y),\ Z=d(x-y).
\]

Multiplicativity of divisors and `d(-1)=0` give

\[
\begin{array}{c|c|c}
z&d(z)&d(1-z)\\ \hline
x&X&U\\
y&Y&V\\
y/x&Y-X&Z-X\\
y(1-x)/(x(1-y))&Y+U-X-V&Z-X-V\\
(1-x)/(1-y)&U-V&Z-V.
\end{array}
\]

Substitution in the left side of (5.1) yields

\[
\begin{aligned}
 X\wedge U-Y\wedge V
 &+(Y-X)\wedge(Z-X)\\
 &-(Y+U-X-V)\wedge(Z-X-V)
 +(U-V)\wedge(Z-V),
\end{aligned}
\]

and direct bilinear expansion cancels every basis wedge.  QED.

This is the divisor image of the classical five-term relation under the
boundary map `[z] -> z wedge (1-z)`.  It suggests a concrete **Steinberg
contact 2-complex**: its oriented cells are rational tripod contacts and its
elementary gluing moves are (5.1).  A move can replace one difficult surface
by four others and introduces the new divisor `d(x-y)`.  This is a precise
higher-dimensional operation, not a metaphor.  What is not yet known is how
to choose repeated moves with a uniform gain in radical skeleton area and a
controlled cost in height.

Terminology matters here.  `Omega(x)` is the image under
`wedge^2 d` of the standard Bloch boundary
`delta([x])=x wedge (1-x)`.  It is not a new nonzero Milnor `K_2`
invariant: in Milnor `K_2` the Steinberg relation sets `{x,1-x}=0`.
All calculations in this note occur before that quotient.

### Proposition 5.2 (quadratic Veronese peeling)

For `x in Q` with `x != 0, 1, -1`,

\[
 \boxed{\Omega(x^2)=2\Omega(x)
          -2\Omega\!\left(\frac{x}{1+x}\right).}        \tag{5.2}
\]

**Proof.** Specialize Theorem 5.1 to `y=x^2`.  Its five arguments become

\[
 x,\qquad x^2,\qquad x,\qquad \frac{x}{1+x},\qquad
 \frac1{1+x}.
\]

The last argument is the complement of the fourth.  Since
`Omega(1-z)=-Omega(z)`, (5.1) is

\[
 \Omega(x)-\Omega(x^2)+\Omega(x)
 -\Omega\!\left(\frac{x}{1+x}\right)
 -\Omega\!\left(\frac{x}{1+x}\right)=0,
\]

which is (5.2).  QED.

If `x=X/Z` with `0<X<Z` and `gcd(X,Z)=1`, this is the exact primitive-cell
identity

\[
 \Omega(X^2,Z^2-X^2,Z^2)
 =2\Omega(X,Z-X,Z)-2\Omega(X,Z,X+Z).                    \tag{5.3}
\]

Thus a coherent square direction can be replaced by two cells whose entries
are linear in `X,Z`; primes of `Z-X` and `Z+X` are exposed to the filling
cost.  This is a positive structural result, not an estimate.  In
particular, the Pythagorean-square obstruction below cannot by itself rule
out every five-term filling policy.  The coefficientwise identity (5.2) is
formalized in Lean as `quadraticVeronese_peeling`.

## 6. A first non-circular gate and its implication to abc

The coefficient-one skeleton area is not the only natural polarization.  Put

\[
\begin{aligned}
 \mathcal M={}&h_ar_b+r_ah_b+h_br_c+r_bH+Hr_a+r_ch_a,
\end{aligned}                                                   \tag{6.1}
\]

where `h_a=log a`, `h_b=log b`, `H=log c`, and the `r_i` are the three
radical log masses.  This replaces exactly one side of every pair in `Phi`
by its radical truncation.  If every leg is squarefree, then
`mathcal M=2 Phi`.

### Gate MC (single-cell mixed-area domination)

For every `epsilon>0`, there is a real constant `C_epsilon` such that every
primitive positive abc point satisfies

\[
 \boxed{\Phi\le\frac{1+\epsilon}{2}\mathcal M+C_\epsilon H.}
                                                                  \tag{MC}
\]

This gate is stated solely in terms of the full contact surface, its
one-sided radical polarization, and a linear boundary allowance.  It does
not contain an abc conclusion as a field.

### Theorem 6.1 (Gate MC implies logarithmic abc)

**Proof.** Every leg height is at most `H`, and (4.3) gives

\[
 \mathcal M\le 2H(r_a+r_b+r_c)=2H\rho.                \tag{6.2}
\]

As in the earlier argument, `c<=2ab` gives

\[
 \Phi\ge H(h_a+h_b)\ge H(H-\log2).                    \tag{6.3}
\]

Combining (MC), (6.2), and (6.3), and cancelling the positive number `H`,
gives

\[
 H\le(1+\epsilon)\rho+C_\epsilon+\log2.
\]

This is exactly the required uniform logarithmic abc conclusion.  QED.

The Lean theorem `abcConjecture_of_uniformSingleCellMixedAreaGate` proves
this implication from the repository's definition of `ABCConjecture`.

### Circularity audit

Gate MC is not obtained by expanding the desired height inequality: its
left side is quadratic, and its proposed sharp normalization comes from the
identity `mathcal M=2 Phi` on coefficient-one surfaces.  Nevertheless, an
implication to abc is not evidence that the gate is true.  The next section
tests all of its quantifiers and refutes it.

For completeness, define the fully quantified earlier candidate by requiring
that for every `epsilon>0` there exist a real `K_epsilon` such that every
primitive positive abc point satisfies

\[
 \Phi\le3(1+\epsilon)^2\Psi+K_\epsilon^2                \tag{SC}
\]

also implies abc by `3 Psi<=rho^2` and (6.3), but it is refuted by the same
family below.  It is retained only as a failed proposition, not as an open
input.

## 7. Two full-premise counterexamples

### 7.1 A finite coefficient counterexample

The positive pairwise-coprime equation

\[
 9+16=25
\]

has divisor vertices

\[
 A=2[3],\qquad B=4[2],\qquad C=2[5].
\]

The `a-b` block of `Omega` has absolute coefficient `2*4=8`, whereas its
radical-skeleton coefficient is `1`.  Thus universal coefficient-one thin
contact and the identity `Omega=Omega(tau A,tau B,tau C)` are refuted with
all abc premises present.  One isolated point would not refute a gate with
an arbitrary uniform additive constant; the next family supplies the
necessary unbounded quantifier.

### 7.2 Primitive Pythagorean squares refute the uniform single-cell gates

For every integer `t>=1`, set

\[
 x=2t+1,\qquad y=2t(t+1),\qquad z=2t^2+2t+1.
\]

Direct expansion gives

\[
 x^2+y^2=z^2.                                           \tag{7.1}
\]

Moreover `x` is coprime to `2`, `t`, and `t+1`, hence `gcd(x,y)=1`.
Equation (7.1) then gives pairwise coprimality of `x,y,z`.  Therefore

\[
 (a,b,c)=(x^2,y^2,z^2)                                  \tag{7.2}
\]

is a positive primitive abc point for every `t>=1`.

For a square leg `u^2`,

\[
 \log\operatorname{rad}(u^2)=\log\operatorname{rad}(u)
 \le\log u=\tfrac12\log(u^2).                           \tag{7.3}
\]

Applying (7.3) on all six terms of (6.1) gives

\[
 \mathcal M\le\Phi.                                    \tag{7.4}
\]

On the other hand, `Phi>=h_b H`, so

\[
 \frac{\Phi}{H}\ge h_b=2\log(2t(t+1))\longrightarrow\infty.  \tag{7.5}
\]

Take `epsilon=1/2` in Gate MC.  Equations (7.4) and (MC) would give

\[
 \Phi\le\frac34\Phi+C_{1/2}H,
 \qquad\text{hence}\qquad
 \Phi\le4C_{1/2}H,
\]

contradicting (7.5).  Thus

\[
 \boxed{\text{Uniform Gate MC is REFUTED under all premises.}}
\]

The Lean theorem `not_uniformSingleCellMixedAreaGate` formalizes the
identity, coprimality, radical half-bound, unbounded ratio, and quantified
contradiction.

The same family refutes Gate SC: (7.3) gives `Psi<=Phi/4`, so for any

\[
 0<\epsilon<2/\sqrt3-1
\]

the coefficient `3(1+epsilon)^2/4` is strictly below one, while `Phi` is
unbounded.  No fixed `K_epsilon^2` can repair the inequality.  Lean
formalizes this complete quantifier block and its contradiction as
`not_uniformSingleCellSkeletonGate` (using `epsilon=1/10`).

Neither result is a counterexample to abc.  They retire only estimates that
compare one contact cell with its own coefficient-one truncation.

## 8. Veronese correction and the surviving five-term route

The square family identifies the missing geometry.  Coherent dilation of an
entire divisor leg is a Veronese direction, and radical truncation erases
that direction before area is compared.

For `n>1`, let

\[
 g(n)=\gcd_{p\mid n}v_p(n),\qquad n=u^{g(n)},
\]

with `g(1)=1`.  On a unit leg set `h=r=u_h=0`, so both defect
components vanish.  Write `h=log n`, `r=log rad(n)`, and `u_h=h/g`.
Then the exponent defect has the exact split

\[
 \boxed{h-r=(g-1)u_h+(u_h-r).}                          \tag{8.1}
\]

The first term is **coherent Veronese-ray thickness**.  The second is
**primitive-base residual thickness**; the exponents of the base have gcd
one.  Substitution of (8.1) in the exact polarization identity

\[
 2\Phi-\mathcal M
 =\sum_{i<j}\big((h_i-r_i)h_j+(h_j-r_j)h_i\big)          \tag{8.2}
\]

splits the contact loss as

\[
 2\Phi-\mathcal M=\mathcal V+\mathcal R,                \tag{8.3}
\]

More explicitly, put `nu_i=(g_i-1)u_i` and `sigma_i=u_i-r_i`, where here
`u_i=h_i/g_i`, and define

\[
 \mathcal V=\sum_{i<j}(\nu_i h_j+\nu_j h_i),\qquad
 \mathcal R=\sum_{i<j}(\sigma_i h_j+\sigma_j h_i).       \tag{8.4}
\]

Both costs are nonnegative and their definitions are total on unit legs.
The original Lean module formalizes the abstract scalar decompositions (8.1)
and (8.3) after their integer data are supplied.  The supplemental module
`SteinbergIntegerFiniteChain20260902` now constructs
`g(n)=gcd_p v_p(n)`, proves `n=u^g` with primitive-base exponent gcd one for
the nonunit scope, and connects the actual finite-support cell norm to these
costs.  The inductive relation generated by permitted rational five-term
moves and its boundary theorem remain open.  On the Pythagorean-square
family, `mathcal V` alone is already large enough to supply the obstruction;
this does not assert `mathcal R=0` and does not refute separate control of
`mathcal R`.

The revised route uses the full five-term contact complex rather than the
failed single-cell truncation.  For a finite signed chain

\[
 \Gamma=\sum_j n_j[z_j]
\]

obtained from `[a/c]` by five-term moves, the scalar data must be normalized
canonically.  Write every rational cell as `z=m/n` in lowest terms with
`n>0` and `m(n-m) != 0`.  Use the signed relation
`m+(n-m)=n` for orientation and the pairwise-coprime absolute legs
`|m|,|n-m|,n` for valuations, heights, radicals, and exponent gcds.  This
removes all scaling ambiguity; cells in `(0,1)` are ordinary positive abc
cells.  Let each cell carry its exact `Phi_j`, `mathcal M_j`,
`mathcal V_j`, and `mathcal R_j`.

For a conservative positive subcomplex, restrict every elementary move to
`0<y<x<1`.  Then all five arguments in Theorem 5.1 lie in `(0,1)` and have
unique reduced positive primitive triples.  The quadratic move `y=x^2`
lies in this domain for `0<x<1`.  Gate VF may be read in this positive
subcomplex; the signed normalization above also makes the broader domain
well-defined.

Define the calibrated nonnegative boundary cost

\[
 \mathcal Q(\Gamma)=\sum_j|n_j|(\mathcal M_j+\mathcal V_j),
 \qquad
 \mathcal R(\Gamma)=\sum_j|n_j|\mathcal R_j.             \tag{8.5}
\]

### Proposition 8.1 (the filling-boundary inequality is automatic)

If `Gamma` is five-term-equivalent to the original cell, so that

\[
 \Omega_0=\sum_j n_j\Omega_j,
\]

then

\[
 \boxed{\Phi_0\le\tfrac12\big(\mathcal Q(\Gamma)
                                  +\mathcal R(\Gamma)\big).}       \tag{8.6}
\]

**Proof.** Give each prime-pair coordinate its logarithmic product weight.
The weighted `ell^1` triangle inequality and the cellwise identity
`2 Phi_j=mathcal M_j+mathcal V_j+mathcal R_j` give

\[
 \Phi_0=\|\Omega_0\|_{1,\log}
 \le\sum_j|n_j|\|\Omega_j\|_{1,\log}
 =\frac12\sum_j|n_j|(\mathcal M_j+\mathcal V_j+\mathcal R_j),
\]

which is (8.6).  Only finitely many primes occur in a finite chain, so the
sum is finite.  QED.

The Lean theorem `finiteFilling_boundary_le_calibratedCost` formalizes the
finite-coordinate weighted `ell^1` argument.  Thus (8.6) is a theorem, not
one of the open estimates.

### Open Gate VF (Veronese-calibrated five-term filling)

For every `epsilon>0`, there should be constants `K_epsilon,L_epsilon`
such that every primitive abc cell admits a five-term-equivalent chain
`Gamma` satisfying

\[
\begin{aligned}
 \mathcal R(\Gamma)&\le\epsilon\mathcal Q(\Gamma)
                         +K_\epsilon H,\\
 \mathcal Q(\Gamma)&\le2H\rho+L_\epsilon H.             \tag{VF}
\end{aligned}
\]

These are the two genuinely open filling and calibrated-boundary estimates.
Together with Proposition 8.1 and (6.3), they give

\[
 \Phi\le(1+\epsilon)H\rho
 +\tfrac12\big((1+\epsilon)L_\epsilon+K_\epsilon\big)H,
\]

and hence the logarithmic abc inequality.  Gate VF is not an algebraic
renaming of that inequality because it demands an actual five-term chain
and separately bounds its residual and coherent costs.  The new divisor
`d(x-y)` in every five-term move is the proposed source of radical gain.

Gate VF is **OPEN**.  No controlled filling policy is constructed here, and
no reverse implication from abc is claimed.  Primitive Pythagorean squares
refute the choice `Gamma=[a/c]` with `mathcal V` discarded; they do not
refute all auxiliary-cell fillings or the calibrated cost (8.5).  A failed
fixed policy should therefore be marked refuted without abandoning the
contact-complex route.

The exponent signature also gives a second interpretation.  Writing
`a=u_a^{g_a}`, `b=u_b^{g_b}`, `c=u_c^{g_c}` produces a generalized Fermat
curve with orbifold characteristic

\[
 \chi_{\rm orb}=1/g_a+1/g_b+1/g_c-1.
\]

Fixed hyperbolic signatures can be studied by generalized-Fermat methods,
but fixed-signature finiteness is not a uniform estimate over varying
signatures and does not close VF.  This boundary is left explicit.

The current status table is:

| Claim | Status |
|---|---|
| Three-leg expansion, affine/`S_3` laws, five-term gluing | **PROVED** |
| Quadratic Veronese peeling/distribution | **PROVED** |
| Mixed-area, radical-skeleton, polarization, Veronese splits | **PROVED** |
| Filling-boundary `ell^1` inequality | **PROVED** |
| Universal coefficient-one thin contact | **REFUTED by `9+16=25`** |
| Single-cell Gates MC and SC | **REFUTED by primitive Pythagorean squares** |
| Veronese-calibrated five-term Gate VF | **OPEN** |
| Unconditional abc or a counterexample to abc | **OPEN** |

## 9. Relation to recent primary literature

Recent work supports treating the tripod boundary in higher dimension, but
none of the following papers supplies Gate VF over the rational integers.

* Min Ru and Julie Tzu-Yueh Wang, *Vojta's abc conjecture for entire curves
  in toric varieties highly ramified over the boundary*, arXiv:2410.19395v2
  (2026), proves an entire-curve result over the complex numbers under high
  boundary ramification and extends it to projective toric varieties.
* Hector Pasten, *On the arithmetic case of Vojta's conjecture with truncated
  counting functions*, arXiv:2205.07841v3 (2022), proves arithmetic
  approximation inequalities in arbitrary dimension and bounds toward abc;
  its abstract describes several bounds as subexponential and a separate
  implication from Lang--Waldschmidt.
* Carlo Gasbarri, Ji Guo, and Julie Tzu-Yueh Wang, *Campana conjecture for
  coverings of toric varieties over function fields*, arXiv:2401.13186v2
  (2025), works over function fields and proves a high-multiplicity Campana
  version for toric coverings.

The complex entire-curve and function-field theorems must not be imported as
integer abc theorems over `Q`.  Their relevance here is structural: high
boundary multiplicity and truncated counting are precisely the two layers
separated by the valuation surface `Omega` and its radical skeleton.

Local copies of the three primary PDFs, retrieval metadata, and SHA-256
digests are sealed in
`research/sources/steinberg_contact_surface_2026_09_02/`.

## 10. Formalization ledger and next mathematical target

The companion Lean module formalizes, in theorem order after the proofs in
this note:

1. the coefficient model of the exterior contact surface;
2. its three-leg expansion, translation, scaling, cyclic invariance, and
   transposition sign;
3. all three disjoint-leg coefficient product laws;
4. the five-term surface relation;
5. the quadratic Veronese-peeling specialization;
6. the scalar full-area, radical-skeleton, and excess identities;
7. the quadratic skeleton inequality and the exact mixed polarization;
8. the formal implication `Gate MC -> ABCConjecture`;
9. the full `9+16=25` ABC point and its exact coefficient `8`;
10. the infinite primitive Pythagorean-square family, its half-radical and
   quarter-skeleton bounds, and the quantified theorems
   `not_uniformSingleCellMixedAreaGate` and
   `not_uniformSingleCellSkeletonGate`;
11. the abstract scalar Veronese-ray/primitive-residual defect and
   contact-loss splits, for supplied data;
12. the finite-coordinate filling-boundary `ell^1` inequality.

The supplemental `SteinbergIntegerFiniteChain20260902` module proves the
integer exponent-gcd construction, primitive-base power decomposition, the
actual finite-support cell norm, and the concrete filling inequality under an
explicit exact surface-boundary premise.  The later
`SteinbergFiveTermBoundaryBridge20260903` module defines both the rational
five-term-generated submodule and the smaller positive-realization-generated
submodule, and proves that membership supplies this exact boundary equality.
What remains open is a positive filling-existence theorem for an arbitrary
target, together with the two analytic Gate VF cost estimates; none follows
from generated-submodule membership alone.  The Lean Pythagorean-square
theorems close both single-cell Gates MC and SC, and no arbitrary multi-cell
gate.

No open axiom or proof placeholder is introduced.  The next positive target
is not to repeat either failed single-cell assertion.  It is to construct an
actual five-term reduction policy satisfying Gate VF, with new-prime gain
from `d(x-y)` paying for the primitive-base residual part of (8.3) while the
Veronese part is retained in the calibrated cost.  Failure of one fixed
policy would retire only that policy; the surface and its other possible
fillings remain active unless their exact premises are contradicted.
