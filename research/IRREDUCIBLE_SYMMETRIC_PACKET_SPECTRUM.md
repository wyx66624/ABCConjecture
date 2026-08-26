# Complete finite Fourier spectrum of the irreducible symmetric packet

## 1. Set-up

Let `ell` be a prime congruent to `3 mod 4`, let

\[
 F=\mathbb F_\ell,
\]

and let `eta` be the quadratic character of `F`, extended by `eta(0)=0`.
Fix a nontrivial additive character `psi:F->C`.  Define

\[
 P=\{(v,w)\in F^2:\eta(v^2+w^2)=-1\}.
\]

The first theta-average theorem only needed the free trace parameter `u`.
This note computes the full Fourier transform of the radial packet `P`.
The result identifies a three-eigenvalue finite association scheme and gives a
starting point for second-moment theta estimates at nonrectangular periods.

## 2. Quadratic Gauss representation

Let

\[
 G=\sum_{t\in F}\eta(t)\psi(t)
\]

be the quadratic Gauss sum.  Since `ell=3 mod 4`,

\[
 G^2=\eta(-1)\ell=-\ell.
\tag{2.1}
\]

For every `r in F`,

\[
 \eta(r)=G^{-1}\sum_{s\in F^\times}\eta(s)\psi(sr).
\tag{2.2}
\]

For `s!=0`, completing the square gives

\[
 \sum_{x\in F}\psi(sx^2+ax)
 =\eta(s)G\,\psi\!\left(-\frac{a^2}{4s}\right).
\tag{2.3}
\]

## 3. Fourier transform of the quadratic character of the norm

Put

\[
 Q(v,w)=v^2+w^2.
\]

### Theorem 3.1

For every nonzero `(a,b) in F^2`,

\[
 \boxed{
 \sum_{v,w\in F}
  \eta(Q(v,w))\psi(av+bw)
 =\ell\,\eta(a^2+b^2).}
\tag{3.1}
\]

#### Proof

Insert (2.2) and use (2.3) in the two coordinates:

\[
 \begin{aligned}
 S(a,b)
 &=G^{-1}\sum_{s\ne0}\eta(s)
   \sum_v\psi(sv^2+av)
   \sum_w\psi(sw^2+bw)\\
 &=G\sum_{s\ne0}\eta(s)
   \psi\!\left(-\frac{a^2+b^2}{4s}\right).
 \end{aligned}
\]

The norm form is anisotropic, so `a^2+b^2!=0`.  Substitute `t=s^{-1}` and
apply the Gauss-sum identity once more:

\[
 S(a,b)
 =G^2\eta\!\left(-\frac{a^2+b^2}{4}\right).
\]

Using `G^2=-ell`, `eta(-1)=-1`, and `eta(4)=1` yields (3.1).

## 4. Spectrum of the nonsquare-norm packet

For nonzero `r`, the indicator of nonsquares is

\[
 1_{\eta(r)=-1}=\frac{1-\eta(r)}2.
\]

Anisotropy gives `Q(v,w)=0` only at `(0,0)`.  Therefore, for
`(a,b)!=(0,0)`,

\[
 \begin{aligned}
 \widehat{1_P}(a,b)
 &=\sum_{(v,w)\in P}\psi(av+bw)\\
 &=\frac12\left(
   \sum_{(v,w)\ne(0,0)}\psi(av+bw)
   -\sum_{v,w}\eta(Q(v,w))\psi(av+bw)
  \right).
 \end{aligned}
\]

The first sum is `-1`, and Theorem 3.1 evaluates the second.

### Theorem 4.1 (complete spectrum)

\[
 \boxed{
 \widehat{1_P}(a,b)=
 \begin{cases}
  (\ell^2-1)/2,&(a,b)=(0,0),\\[1mm]
  -(\ell+1)/2,&a^2+b^2\text{ is a nonzero square},\\[1mm]
  (\ell-1)/2,&a^2+b^2\text{ is a nonsquare}.
 \end{cases}}
\tag{4.1}
\]

The zero-frequency value is the previously proved cardinality of `P`.

## 5. Plancherel check

There are `(ell^2-1)/2` nonzero square-norm frequencies and the same number of
nonsquare-norm frequencies.  Hence (4.1) gives

\[
 \begin{aligned}
 \sum_{a,b}|\widehat{1_P}(a,b)|^2
 &=\left(\frac{\ell^2-1}{2}\right)^2\\
 &\quad+\frac{\ell^2-1}{2}
       \left(\frac{\ell+1}{2}\right)^2
 +\frac{\ell^2-1}{2}
       \left(\frac{\ell-1}{2}\right)^2\\
 &=\ell^2\frac{\ell^2-1}{2}
 =|F^2|\,|P|,
 \end{aligned}
\]

as required by finite Plancherel.

## 6. Full symmetric-matrix packet

Let

\[
 \mathcal I_\ell
 =\{T(u,v,w):u\in F,(v,w)\in P\}.
\]

For a linear frequency `(alpha,beta,gamma) in F^3`,

\[
 \sum_{T\in\mathcal I_\ell}
 \psi(\alpha u+\beta v+\gamma w)
\]

vanishes when `alpha!=0`.  When `alpha=0`, it equals

\[
 \ell\,\widehat{1_P}(\beta,\gamma),
\]

and is therefore given explicitly by (4.1).

The earlier rank-one orthogonality is the special case where

\[
 \alpha=x^2+y^2.
\]

For nonzero `(x,y)`, anisotropy forces `alpha!=0`, explaining the exact
vanishing without requiring the remaining two spectral values.

## 7. Research consequence

The packet is not merely an averaging device.  It is a finite three-eigenvalue
object whose Fourier transform is completely explicit.  This creates two new
subroutes.

1. **Second-moment theta route.**  Expand
   `sum_T |Theta_T(tau)|^2` and evaluate the finite inner sums using the full
   spectrum.  This may remove the rectangular-period restriction.
2. **Determinant/association-scheme route.**  Use the two nontrivial eigenvalues
   to construct a controlled finite Fourier determinant on the transverse
   kernel packet.  Such a determinant is a candidate boundary modular section
   whose archimedean singular values are explicit.

Neither conclusion is asserted without the corresponding analytic and
integral calculations.  The theorem supplies exact finite data for those
calculations and is suitable for a later Lean formalization using quadratic
characters and Gauss sums.
