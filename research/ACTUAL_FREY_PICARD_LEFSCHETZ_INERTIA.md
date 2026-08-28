# Actual Frey--Legendre Picard--Lefschetz inertia in one global basis

## 1. Purpose

The two-inertia route already contains the finite-group theorem that two
nonparallel nonzero transvections generate `SL_2(F_ell)`, and the cyclotomic
selector now chooses `ell` above a threshold, avoiding both local parameters,
and satisfying `ell = 1 mod 12`.  The remaining arithmetic question is whether
the two matrices are the actual inertia matrices of one Frey--Legendre
specialization in one common global torsion basis.

This note derives that statement from standard semistable Picard--Lefschetz
monodromy and Tate uniformization.  No IUT input is used.

## 2. The globally labelled Legendre monodromy lines

Let

\[
  U=\mathbf P^1\setminus\{0,1,\infty\}
\]

and consider the Legendre family

\[
  E_\lambda:y^2=x(x-1)(x-\lambda).
\]

Fix a symplectic basis of the geometric first homology at one base point.  The
three vanishing cycles at `0`, `1`, and `infinity` determine three distinct
lines

\[
  L_0,L_1,L_\infty
  \subset H_1(E_{\bar\eta},\mathbb Z),
\]

and the local monodromies are Picard--Lefschetz transvections.  With a suitable
basis they may be represented by

\[
  T_0(t)=\begin{pmatrix}1&t\\0&1\end{pmatrix},
  \qquad
  T_1(t)=\begin{pmatrix}1&0\\t&1\end{pmatrix},
\]

and a third conjugate transvection `T_infinity(t)` fixing the third line.  The
three lines remain pairwise distinct after reduction modulo every odd prime.

For the full level-two Legendre family, the geometric monodromy around each
cusp is a transvection of step two.  Equivalently, a specialization meeting a
cusp with contact order `m` has unipotent parameter `2m`.

## 3. Arithmetic specialization at an odd boundary prime

Let `a+b=c` be primitive and use the Frey--Legendre curve

\[
  E_{a,b}: y^2=x(x-a)(x+b).
\]

The three boundary components are labelled by `a`, `b`, and `c`.  Let `p` be
an odd prime dividing exactly one of them, and write

\[
  p^m\Vert a,
  \quad\text{or}\quad
  p^m\Vert b,
  \quad\text{or}\quad
  p^m\Vert c.
\]

The integral invariants are

\[
  c_4=16(a^2+ab+b^2),
  \qquad
  \Delta=16a^2b^2c^2.
\]

Pairwise coprimality implies that `c_4` is a `p`-adic unit.  Hence the curve has
multiplicative reduction at `p`, its minimal discriminant exponent is

\[
  v_p(\Delta_{\min})=2m,
\]

and its vanishing cycle is the globally labelled line corresponding to the
boundary component divisible by `p`.

Let `ell` be an odd prime distinct from `p`.  The prime-to-`p` cyclotomic
character is trivial on inertia.  Tate uniformization, or equivalently the
semistable Picard--Lefschetz theorem, gives a tame character

\[
  t_\ell:I_p\twoheadrightarrow\mathbb F_\ell
\]

such that in the one fixed global Legendre basis

\[
  \rho_{E,\ell}(\sigma)
  =T_d\bigl(2m\,t_\ell(\sigma)\bigr),
\]

where `d in {0,1,infinity}` is the boundary direction.  Since the tame
character is surjective, the inertia image contains

\[
  T_d(2m).
\]

Thus, if

\[
  \ell\nmid 2m,
\]

the actual image contains a nonzero transvection fixing `L_d`.

The same formula holds for nonsplit multiplicative reduction: the splitting
character is unramified, and therefore is trivial on inertia.

## 4. Potentially multiplicative reduction at two

Assume the only second boundary direction is two-adic.  In the unit-leg case
with exact exponent `2^n`, the reduced Frey `j`-invariant satisfies

\[
  v_2(j)=8-2n.
\]

For `n>=5` this is negative, so the curve has potentially multiplicative
reduction.  A standard theorem on potentially multiplicative elliptic curves
gives:

1. a quadratic character
   \[
     \psi:G_{\mathbb Q_2}\to\{\pm1\};
   \]
2. a quadratic extension `K/Q_2`, of ramification degree `e<=2`, over which the
   quadratic twist is a split Tate curve;
3. a Tate parameter `q` satisfying
   \[
     N=v_K(q)=-v_K(j)=e(2n-8)>0;
   \]
4. for every odd `ell`, an inertia formula
   \[
   \rho_{E,\ell}(\sigma)
     =\psi(\sigma)\,T_d\bigl(Nt_\ell(\sigma)\bigr)
   \]
   in the same global Legendre direction `L_d`.

Choose `sigma` with `t_ell(sigma)=1`.  Since the scalar sign is central and
squares to one,

\[
  \rho_{E,\ell}(\sigma)^2
  =T_d(2N).
\]

Therefore the actual inertia image contains a nonzero transvection whenever

\[
  \ell\nmid 2N.
\]

Moreover

\[
  0<2N=2e(2n-8)\le4(2n-8)<8n.
\]

Since `2^n<=c`,

\[
  n\le\frac{\log c}{\log2},
\]

and hence the actual two-adic transvection parameter has the uniform bound

\[
  2N<\frac8{\log2}\log c.
\]

The exact parameter `2N`, rather than the preliminary candidate `2n-8`, should
therefore be supplied to the cyclotomic auxiliary-prime selector.

## 5. Two distinct directions give the actual full image

Every nontrivial primitive abc triple except `(1,1,2)` has two distinct
boundary directions carrying prime divisors.  At most one is two-adic.  Apply
Sections 3 and 4 to obtain actual inertia elements

\[
  T_{d_1}(r_1),
  \qquad
  T_{d_2}(r_2),
  \qquad d_1\ne d_2,
\]

in one global Legendre basis, with positive integer parameters satisfying

\[
  r_i\le L\log c
\]

for one absolute constant `L`.

Choose the cyclotomic prime from

\[
  M=6B!r_1r_2,
  \qquad
  \ell\mid M^4-M^2+1.
\]

The selector gives

\[
  \ell>B,
  \qquad
  \ell\nmid r_1r_2,
  \qquad
  \ell\equiv1\pmod{12},
\]

and `log ell=o(log c)` uniformly.  Both actual inertia transvections are
nonzero modulo `ell`.  Since their fixed lines are distinct, the already proved
finite-group theorem yields

\[
  \operatorname{SL}_2(\mathbb F_\ell)
  \subseteq\operatorname{im}\rho_{E,\ell}.
\]

This closes the mathematical local-monodromy input of the two-inertia route,
subject only to the standard Tate/Picard--Lefschetz theorems stated explicitly
above.

## 6. Formalization decomposition

The Lean development is split into layers.

1. **Signed transvection square.**  Prove
   \[
     (\epsilon T_d(x))^2=T_d(2x)
   \]
   for `epsilon^2=1`; this is elementary matrix algebra.
2. **Odd local source interface.**  Package the standard semistable
   Picard--Lefschetz theorem with parameter `2m` and a globally labelled line.
3. **Potentially multiplicative source interface.**  Package the standard
   quadratic-twist Tate theorem, including `N=e(2n-8)` and `e<=2`.
4. **Common-basis assembly.**  Relate the three arithmetic boundary labels to
   the already formalized three Legendre transvection directions.
5. **Cyclotomic selector integration.**  Feed the actual parameters into the
   merged selector and invoke the full-`SL_2` generation theorem.

Only Layer 1 is elementary enough for immediate Mathlib formalization.  Layers
2--4 require formal local elliptic-curve and Picard--Lefschetz interfaces which
are not currently present in Mathlib; they must not be replaced by opaque
matrix assumptions in a final unconditional theorem.

## 7. Remaining role in an abc proof

Full mod-`ell` image and a sublinear selected prime do not by themselves prove
`abc`.  They supply the admissible-prime input for the surviving global
routes.  One must still prove either:

- the stack-correct Legendre Arakelov compensation theorem;
- an independently verified IUT/ATS normed source and component estimate;
- or another global height--conductor inequality.
