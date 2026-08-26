# The irreducible symmetric kernels form a positive frame on even theta space

## 1. Purpose

The first transverse-theta average used only the sum of all kernel evaluations
and therefore selected one non-small theta value only for a rectangular period.
The complete finite spectrum yields a stronger theorem.

Let `ell` be a prime congruent to `3 mod 4`.  The phase vectors attached to all
irreducible symmetric graph kernels form a frame for the entire **even
Schrodinger theta space**.  Its Gram operator is explicitly block diagonal and
positive definite.  Consequently, for every complex even theta vector, at
least one universally transverse kernel evaluates it with norm at least
`1/sqrt(2)` times the Euclidean norm of the vector.

This removes the rectangular-period restriction and any unproved
archimedean-equidistribution step from the finite theta-selection problem.
The remaining arithmetic problem is to realize the frame evaluation as an
integral boundary theta morphism and control its finite-place elementary
divisors.

## 2. The phase matrix

Let

\[
 F=\mathbb F_\ell,
 \qquad
 Q(x,y)=x^2+y^2.
\]

Since `-1` is a nonsquare, `Q` is anisotropic.  Let

\[
 \mathcal Z=F^2/\{z\sim-z\}.
\]

It has cardinality

\[
 d=1+\frac{\ell^2-1}{2}=\frac{\ell^2+1}{2}.
\tag{2.1}
\]

This is the dimension of the even functions in the Schrodinger model on
`F^2`.

Let

\[
 \mathcal I_\ell
 =\left\{
 T(u,v,w)=
 \begin{pmatrix}u+v&w\\w&u-v\end{pmatrix}:
 v^2+w^2\text{ is nonsquare}
 \right\}.
\]

Then

\[
 M:=|\mathcal I_\ell|=\frac{\ell(\ell^2-1)}2.
\tag{2.2}
\]

Fix a nontrivial additive character `psi:F->C`.  Define the `M by d` matrix

\[
 \Phi_{T,[z]}=\psi(z^tTz).
\tag{2.3}
\]

It is well defined on `[z]`, because the quadratic phase is unchanged by
`z -> -z`.

## 3. The Gram matrix

For `z,w in F^2`, write

\[
 \alpha=Q(z)-Q(w),
\]

\[
 \beta=(z_1^2-z_2^2)-(w_1^2-w_2^2),
\]

\[
 \gamma=2(z_1z_2-w_1w_2).
\tag{3.1}
\]

Then

\[
 z^tT(u,v,w)z-w^tT(u,v,w)w
 =u\alpha+v\beta+w\gamma.
\tag{3.2}
\]

The complete packet spectrum gives the inner product of two columns.

### Lemma 3.1

If `Q(z)=Q(w)`, then

\[
 \boxed{\beta^2+\gamma^2=4\det(z,w)^2.}
\tag{3.3}
\]

#### Proof

A direct expansion gives the more general identity

\[
 \beta^2+\gamma^2
 =(Q(z)+Q(w))^2-4(z\cdot w)^2.
\]

When the two norms are equal to `r`, the right side is

\[
 4(r^2-(z\cdot w)^2)=4\det(z,w)^2.
\]

### Lemma 3.2

If `Q(z)=Q(w)!=0` and `[z]!=[w]`, then

\[
 \beta^2+\gamma^2
\]

is a nonzero square.

#### Proof

It is a square by Lemma 3.1.  If it were zero, then
`det(z,w)=0`, so `w=lambda z`.  Equality of the nonzero norms gives
`lambda^2=1`, hence `w=±z`, contrary to `[z]!=[w]`.

### Theorem 3.3 (exact Gram entries)

For classes `[z],[w] in Z`,

\[
 (\Phi^*\Phi)_{[z],[w]}=
 \begin{cases}
 M,&[z]=[w],\\
 0,&Q(z)\ne Q(w),\\
 -\ell(\ell+1)/2,
   &Q(z)=Q(w)\ne0,\ [z]\ne[w].
 \end{cases}
\tag{3.4}
\]

#### Proof

If the norms differ, the sum over the free parameter `u` is a nontrivial
additive-character sum and vanishes.

If the classes agree, every phase quotient equals one, giving `M`.

In the remaining case, the sum over `u` is `ell`.  Lemma 3.2 says that the
remaining frequency `(beta,gamma)` has nonzero square norm.  The nonsquare-norm
packet Fourier transform is then `-(ell+1)/2`.  Multiplication by the free
`u`-sum gives the last entry.

## 4. Block spectrum

For every `r in F^x`, the anisotropic norm fibre

\[
 Q^{-1}(r)
\]

has `ell+1` vectors, hence

\[
 k=\frac{\ell+1}{2}
\]

classes modulo sign.  The corresponding Gram block has diagonal

\[
 D=M=\frac{\ell(\ell^2-1)}2
\]

and constant off-diagonal

\[
 c=-\frac{\ell(\ell+1)}2.
\]

### Theorem 4.1 (exact frame eigenvalues)

Each nonzero-norm block has eigenvalues

\[
 \boxed{
 \lambda_{\rm const}
 =D+(k-1)c
 =\frac{\ell(\ell^2-1)}4}
\tag{4.1}
\]

on its constant vector, and

\[
 \boxed{
 \lambda_{\rm aug}
 =D-c
 =\frac{\ell^2(\ell+1)}2}
\tag{4.2}
\]

on the orthogonal complement, with multiplicity `(ell-1)/2`.
The zero class is a one-dimensional block with eigenvalue `M`.

All eigenvalues are strictly positive.  Thus

\[
 \boxed{\operatorname{rank}\Phi=d.}
\tag{4.3}
\]

In particular, the irreducible symmetric transverse kernels separate every
even theta vector.

## 5. Uniform archimedean selection

Let

\[
 a=(a_{[z]})_{[z]\in\mathcal Z}\in\mathbb C^d.
\]

The smallest eigenvalue in Theorem 4.1 is

\[
 \lambda_{\min}
 =\frac{\ell(\ell^2-1)}4
 =\frac M2.
\tag{5.1}
\]

### Theorem 5.1 (positive frame inequality)

\[
 \boxed{
 \sum_{T\in\mathcal I_\ell}
 \left|
  \sum_{[z]\in\mathcal Z}
   a_{[z]}\psi(z^tTz)
 \right|^2
 \ge\frac M2\sum_{[z]}|a_{[z]}|^2.}
\tag{5.2}
\]

### Corollary 5.2 (one non-small universally transverse evaluation)

There exists `T in I_ell` such that

\[
 \boxed{
 \left|
  \sum_{[z]}a_{[z]}\psi(z^tTz)
 \right|
 \ge\frac1{\sqrt2}
   \left(\sum_{[z]}|a_{[z]}|^2\right)^{1/2}.}
\tag{5.3}
\]

#### Proof

Equation (5.2) is the lower spectral bound for `Phi^*Phi`.  Divide it by `M`;
at least one summand is at least the average.

## 6. Theta-group interpretation

In the even Schrodinger model of the second-order genus-two theta space, the
coordinates `a_[z]` are the even theta coefficients in a fixed Lagrangian
basis.  Evaluation at the symmetric graph kernel `T` is precisely the finite
quadratic-phase transform in (5.3), up to the standard unitary root-of-unity
normalization.

Therefore Corollary 5.2 gives an archimedean lower bound for **every** period
matrix for which this theta structure is defined.  It is not restricted to a
rectangular elliptic period and does not use a limiting equidistribution
argument.

The normalized complex transform loses at most the absolute constant

\[
 \frac12\log2.
\]

There is no factor proportional to the Frey height, the field degree, or the
number of kernels.

## 7. Integral minor

Since `Phi` has rank `d`, it contains a nonzero `d by d` minor consisting
entirely of universally transverse kernels.  Cauchy--Binet gives

\[
 \sum_{J\subset\mathcal I_\ell,\ |J|=d}
 |\det\Phi_J|^2
 =\det(\Phi^*\Phi).
\tag{7.1}
\]

The right side is explicit from Theorem 4.1:

\[
 M
 \left(
   \lambda_{\rm const}
   \lambda_{\rm aug}^{(\ell-1)/2}
 \right)^{\ell-1}.
\tag{7.2}
\]

Thus one may select a square transverse theta transform with an explicit
nonzero determinant.  Combining (7.1) with

\[
 \binom Md\le(eM/d)^d
\]

shows that its determinant has level-sized normalized logarithm.  This is a
second route to the integral theta-lattice comparison, complementary to the
nonsquare-norm convolution operator.

## 8. Research consequence

The previously open archimedean question is now closed at the finite theta
representation level:

\[
 \boxed{
 \text{every even theta vector has a universally transverse evaluation of
 uniformly comparable norm}.}
\]

The decisive remaining theorem is arithmetic and integral:

### Target theorem 8.1

Realize the finite frame morphism on integral theta lattices over the relevant
level field, and prove that:

1. the nonarchimedean elementary divisors at multiplicative places encode the
   full Tate `q`-weight with coefficient compatible with `1/6`;
2. good places away from `ell` are unimodular;
3. level and descent defects contribute `O(log ell)` after normalized degree;
4. the chosen determinant or boundary section has arithmetic degree bounded by
   `(1+o(1))(Different+Conductor)`.

The frame theorem proves that the complex metric comparison in this target
costs only an absolute constant.  The remaining difficulty is no longer an
archimedean nonvanishing or equidistribution problem.

## 9. Formalization plan

The finite Lean development should proceed through:

1. the identity (3.3);
2. exact Gram entries using the packet spectrum;
3. cardinality of each norm fibre modulo sign;
4. eigenvalues of a constant-off-diagonal block;
5. positivity and full rank;
6. the real/complex frame inequality;
7. Cauchy--Binet and the explicit determinant.

No unresolved arithmetic geometry is needed through step 7.
