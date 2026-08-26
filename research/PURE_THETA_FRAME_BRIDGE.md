# Pure theta extension and the transverse finite frame

## 1. Purpose

The transverse-kernel route previously separated into two unresolved
interfaces:

1. an integral/adelic extension of the theta section whose boundary norm is the
   tropical Riemann theta function;
2. an archimedean selection theorem producing a transverse kernel at which the
   theta section is not too small.

The second interface is closed by the exact irreducible-symmetric frame theorem
on `research/abc-irreducible-symmetric-theta-average-v12`.

The first interface is supplied at the level of universal line bundles and
metrics by Botero--Burgos Gil--Holmes--de Jong,
*Pure extension of the theta divisor over the moduli space of abelian
varieties* (2026).  Their theorem constructs the canonical pure weight-two
adelic/log-b extension of the universal theta divisor, proves the extended
Moret--Bailly key formula, and identifies its complex metric and
nonarchimedean tropical correction.

This note records exactly what these two ingredients prove together and what
is still missing.  It does not identify the remaining arithmetic-degree bound
with a theorem that has already been proved.

## 2. The universal pure theta object

Let `N_g` be the moduli stack of principally polarised abelian varieties with a
chosen theta divisor, and let

\[
 \pi:N_{g,1}\longrightarrow N_g
\]

be the universal abelian variety.  Write `L` for the universal rigidified
polarising line, `Theta` for the universal theta divisor, and `omega_g` for the
determinant of the Hodge bundle.

The classical Moret--Bailly key formula is

\[
 L^{\otimes8}
 \simeq
 \mathcal O(8\Theta)\otimes\pi^*\omega_g^{-4}.
\tag{2.1}
\]

The 2026 pure-extension theorem constructs an adelic/log-b theta divisor

\[
 \Theta^{\rm pure}
 =\overline\Theta+\operatorname{div}(\theta^{\rm inv})
\]

and a pure adelic line `L^pure`, satisfying

\[
 [n]^*L^{\rm pure}
 =L^{{\rm pure},\otimes n^2}
\]

and the extended key formula

\[
 \boxed{
 L^{{\rm pure},\otimes8}
 =\mathcal O(8\Theta^{\rm pure})
  \otimes\pi^*\overline\omega_g^{-4}.}
\tag{2.2}
\]

The pure theta metric has two explicit realizations.

- At a complex place it is the normalized Riemann theta norm.
- At a nonarchimedean semistable place, the correction from the Zariski closure
  is the invariant tropical Riemann theta function on the Berkovich skeleton.

Thus the archimedean and tropical terms which occurred separately in earlier
branches are values of one canonical adelic object.

## 3. Universal height formula for torsion evaluations

Let `(A,L,D)` be a principally polarised abelian variety over a number field
`K`, with split semiabelian reduction, and let `x in A(K)` avoid the theta
divisor.  The pure key formula gives

\[
 \begin{aligned}
 \widehat h_L(x)
 ={}&-\frac12 h_F(A)\\
 &+\frac1{[K:\mathbb Q]}
 \sum_{v<\infty}
 \left(i_v(x,D)+
       \theta^{\rm inv}_{0,v}
       (\operatorname{val}_v(x)+\kappa_v)
 \right)\log N v\\
 &+\frac1{[K:\mathbb Q]}
 \sum_{\sigma:K\hookrightarrow\mathbb C}
 -\log\left((2\pi)^{g/2}
     \|\vartheta\|_\sigma(x+\kappa_\sigma)
 \right).
 \end{aligned}
\tag{3.1}
\]

For a torsion point the left-hand side is zero.  Equation (3.1) is therefore an
exact product-formula identity connecting:

- Hodge/Faltings degree;
- integral intersection multiplicities;
- tropical theta values;
- normalized complex theta values.

No independent choice of Haar normalization or boundary trivialization is
left in this formula.

## 4. The transverse finite frame

Fix a prime

\[
 \ell\equiv3\pmod4.
\]

Let `I_ell` be the packet of irreducible symmetric matrices

\[
 T(u,v,w)=
 \begin{pmatrix}u+v&w\\w&u-v\end{pmatrix}
\]

with `v^2+w^2` nonsquare.  Their graphs are maximal-isotropic kernels in
`E[ell]^2` and are transverse to every scalar Tate inertia line.

Index the even Schrodinger theta coordinates by

\[
 \mathcal Z=\mathbb F_\ell^2/\{\pm1\}.
\]

The phase matrix

\[
 \Phi_{T,[z]}=
 \exp(2\pi i z^tTz/\ell)
\]

satisfies the exact frame inequality

\[
 \boxed{
 \sum_{T\in I_\ell}
 |(\Phi a)_T|^2
 \ge\frac{|I_\ell|}{2}\|a\|_2^2.}
\tag{4.1}
\]

Consequently, at every complex embedding and for every even theta vector,
there exists a universally transverse kernel for which the finite theta
transform loses at most

\[
 \frac12\log2
\]

in logarithmic norm.

The associated nonsquare-norm convolution operator is integral and invertible;
its normalized logarithmic determinant is at most `log ell`.  Hence the finite
change of theta lattice can have only level-sized determinant cost.

## 5. What the combination closes

Equations (2.2), (3.1), and (4.1) close the following conceptual seams.

### 5.1 Canonical boundary metric

The nonarchimedean `q`-term is not inserted by a chosen local normalization.
It is the tropical component of the pure theta metric.

### 5.2 Canonical archimedean metric

The complex norm is the normalized Riemann theta norm appearing in the same
adelic line bundle.

### 5.3 Transverse nonvanishing

At the finite theta-representation level, a universally transverse kernel with
controlled complex norm always exists.  No asymptotic Hecke equidistribution is
needed.

### 5.4 Level-sized finite transform

The integral finite transform has determinant cost `O(log ell)` per coordinate,
so it cannot by itself create a term proportional to the Frey height.

These conclusions apply independently of IUT.  They also specify the exact
normed comparison which an IUT/ATS source would have to reproduce.

## 6. The global-selection issue

The frame theorem chooses a kernel separately at each complex embedding.  A
single algebraic kernel over a number field has all of its conjugates at once.
The correct global replacement for pointwise selection is therefore a
nonzero **algebraic determinant or packet section**.

Let `J` be a square set of transverse kernels for which a theta-frame minor is
nonzero.  The corresponding determinant section

\[
 \Delta_J^{\theta}
\]

is algebraic.  If it is integral outside the conductor, the level prime and the
descent different, then its nonzero algebraic norm gives a global lower bound
on the product of all complex conjugate norms.  This converts finite-frame
nonvanishing into the logarithmic form required by (3.1).

Thus no separate simultaneous choice of one kernel at all embeddings is
needed.  What is needed is an integral realization of one nonzero frame minor.

## 7. Exact surviving theorem

The remaining theorem can now be stated without an unspecified theta source.

### Target theorem 7.1 (integral pure-theta frame determinant)

For the Frey--Legendre elliptic curve `E` and an auxiliary prime
`ell = 3 mod 4`, construct over a finite level field:

1. the universally transverse graph quotients
   \[
     A_T=E^2/H_T,
     \qquad T\in I_\ell;
   \]
2. the pullbacks of the pure theta sections and metrics from (2.2);
3. a square frame minor `Delta_J^theta` which is algebraically nonzero;

and prove:

#### (a) Multiplicative places

The order of `Delta_J^theta` contains the full tropical improvement from the
transverse quotient, with total lower bound

\[
 \frac{\ell-1}{12}\,Q
 -O(\ell)N.
\tag{7.1}
\]

The precise coefficient may equivalently be expressed through the tropical
moments of the source and quotient skeleta.

#### (b) Good finite places

The frame determinant is a unit at every good place away from `ell`.

#### (c) Level and descent places

After normalized degree, the total negative contribution is

\[
 O(\ell\log\ell)
 +o(\ell)(D+N).
\tag{7.2}
\]

#### (d) Complex places

The product of the normalized complex norms is bounded below by the finite
frame determinant, with total loss

\[
 O(\ell\log\ell).
\tag{7.3}
\]

Then the number-field product formula applied to the nonzero determinant gives

\[
 \frac{\ell-1}{12}Q
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)(D+N)
 +O(\ell\log\ell).
\tag{7.4}
\]

After division by `(ell-1)/2`,

\[
 \frac16Q
 \le(1+o(1))(D+N)+O(\log\ell).
\tag{7.5}
\]

The quantifier-correct auxiliary-prime theorem already present in the repository
then implies the logarithmic abc conjecture.

## 8. Which parts of Target theorem 7.1 are already available

- Algebraic transverse kernels and their period lattices: developed in the
  universal-transverse and period-matrix branches.
- Pure adelic theta divisor and normalized boundary metric: supplied by the
  2026 pure-extension theorem.
- Exact finite frame and archimedean lower singular value: supplied by the
  irreducible-symmetric frame branch.
- Good-place unitness for a cyclic determinant complex: proved in the
  cyclic-line determinant branch; the analogous transverse frame-minor
  statement still requires base-change/determinant functoriality.
- Root discriminant of the full torsion field: bounded by conductor plus
  `O(log ell)` in the full-torsion root-discriminant branch.

The genuinely new missing calculation is the integral elementary-divisor
comparison for the transverse pure-theta frame at multiplicative and level
places.  This is much narrower than an unspecified global maximal-slope
conjecture.

## 9. Lean order

The formalization should proceed only after the mathematics of the local
frame determinant is fixed.

1. finish the finite frame Gram matrix and determinant in Lean;
2. formalize the tropical quadratic-form change under the transverse lattice
   quotient;
3. package the scalar product-formula implication;
4. expose the required log-adelic pure-theta theorem as a cited source boundary;
5. formalize the integral elementary divisors;
6. compose with the existing quantifier-correct abc closure.

No unresolved version of Target theorem 7.1 is to be inserted as an axiom or a
field of the final source object.
