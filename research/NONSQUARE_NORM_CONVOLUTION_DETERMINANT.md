# The nonsquare-norm convolution determinant

## 1. Purpose

The complete Fourier spectrum of the packet

\[
 P=\{(v,w)\in\mathbb F_\ell^2:
      v^2+w^2\text{ is a nonsquare}\},
 \qquad \ell\equiv3\pmod4,
\]

produces an explicit **integral** lattice transform.  Unlike the complex
Fourier matrix, this transform has entries in `{0,1}`; unlike a fixed torsion
line, it is invariant under translations and the orthogonal symmetry of the
anisotropic norm form.  Its determinant is nonzero and its logarithmic cost per
coordinate is at most `log ell`.

This supplies a concrete candidate for the finite integral theta-lattice
comparison in the transverse-kernel route.  It does not yet identify the
operator with an algebraic theta pullback over the integral modular stack.

## 2. The convolution operator

Let

\[
 G=\mathbb F_\ell^2,
 \qquad N=|G|=\ell^2.
\]

On the free abelian group `Z[G]`, define

\[
 (A_Pf)(x)=\sum_{p\in P}f(x-p).
\tag{2.1}
\]

In the delta-function basis, `A_P` is the `N by N` integral matrix

\[
 (A_P)_{x,y}=1_P(x-y).
\tag{2.2}
\]

Every additive character

\[
 \chi_\xi(x)=\psi(\xi\cdot x),
 \qquad \xi\in G,
\]

is an eigenvector, with eigenvalue

\[
 \lambda_\xi=\widehat{1_P}(\xi).
\tag{2.3}
\]

The spectrum computed in the companion note is

\[
 \lambda_0=\frac{\ell^2-1}{2},
\]

\[
 \lambda_\xi=-\frac{\ell+1}{2}
 \quad\text{if }\xi\ne0
       \text{ and }\xi_1^2+\xi_2^2\text{ is square},
\]

\[
 \lambda_\xi=\frac{\ell-1}{2}
 \quad\text{if }\xi_1^2+\xi_2^2\text{ is nonsquare}.
\tag{2.4}
\]

Each nonzero class occurs with multiplicity

\[
 m=\frac{\ell^2-1}{2}.
\tag{2.5}
\]

## 3. Exact determinant

### Theorem 3.1

The integral convolution matrix is invertible over `Q`, and

\[
 \boxed{
 \det A_P
 =\frac{\ell^2-1}{2}
  \left(\frac{\ell^2-1}{4}\right)^m.}
\tag{3.1}
\]

In particular, its determinant is a positive integer.

### Proof

Diagonalize over the complex character basis.  Multiplying all eigenvalues
from (2.4) gives

\[
 \det A_P
 =\frac{\ell^2-1}{2}
  \left(-\frac{\ell+1}{2}\right)^m
  \left(\frac{\ell-1}{2}\right)^m.
\]

For an odd `ell`, `ell^2-1` is divisible by eight, so `m` is even.  The sign is
therefore positive, and combining the two nontrivial eigenvalues yields (3.1).
Every eigenvalue is nonzero, proving invertibility over `Q`.

## 4. Level-sized determinant cost

### Theorem 4.1

For every prime `ell>=3`,

\[
 \boxed{
 \frac1{\ell^2}\log|\det A_P|\le\log\ell.}
\tag{4.1}
\]

### Proof

By (3.1),

\[
 |\det A_P|
 \le \frac{\ell^2}{2}
       \left(\frac{\ell^2}{4}\right)^{(\ell^2-1)/2}.
\]

The right side divided by `ell^(ell^2)` is

\[
 \frac12\,2^{-(\ell^2-1)}\,\ell
 =\frac{\ell}{2^{\ell^2}},
\]

which is at most one for `ell>=2`.  Hence

\[
 |\det A_P|\le\ell^{\ell^2},
\]

and taking logarithms proves (4.1).

Thus this integral change of lattice costs no more than `log ell` per theta
coordinate, exactly within the error budget used by the quantifier-correct abc
closures in the repository.

## 5. An explicit rational inverse

The three eigenvalues show that `A_P` satisfies the cubic polynomial

\[
 (X-\lambda_0)
 (X+(\ell+1)/2)
 (X-(\ell-1)/2)=0.
\tag{5.1}
\]

Since the constant term is nonzero, (5.1) gives an explicit expression for
`A_P^{-1}` as a quadratic polynomial in `A_P` with denominator dividing

\[
 \frac{\ell^2-1}{2}
 \left(\frac{\ell^2-1}{4}\right).
\]

Consequently all denominators of the inverse are supported on primes dividing
`2(ell-1)(ell+1)`.  They are level-sized rather than dependent on the Frey
height or the multiplicative exponents.

## 6. Research consequence

The finite Heisenberg--Fourier bridge uses a complex Fourier matrix whose
normalized transform is unitary.  The operator `A_P` supplies a complementary
integral transform:

- entries are integral and uniformly bounded;
- the determinant and inverse denominators are explicit;
- the normalized determinant cost is `O(log ell)`;
- the same packet consists entirely of universally transverse graph kernels;
- the Fourier spectrum is exact.

The surviving arithmetic problem is to realize `A_P` as the matrix of a
morphism between **integral theta lattices** attached to the transverse graph
quotients, and to identify an integral boundary section whose tropical order is
the full Tate `q`-weight.  If such a realization is established, neither the
archimedean determinant nor the finite lattice index can contribute an
uncontrolled multiple of the input height.

## 7. Formalization plan

After the finite spectrum is formalized, the determinant theorem splits into:

1. diagonalization of finite-group convolution by characters;
2. the three eigenvalue multiplicities;
3. the scalar product formula (3.1);
4. the elementary inequality `|det A_P| <= ell^(ell^2)`;
5. the cubic annihilating polynomial and rational inverse.

No unresolved arithmetic geometry is needed for these finite layers.
