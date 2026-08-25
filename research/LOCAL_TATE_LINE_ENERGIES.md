# Local Tate-line energies and exact cancellation

Let `K` be a complete nonarchimedean field, let `E_q/K` be a split Tate curve,
and put

\[
  L=-\log|q|>0.
\]

Let `ell>=3` be prime to the residue characteristic, and work over a field
containing `mu_ell` and an `ell`-th root of `q`. For the standard Tate local
Neron function,

\[
 \lambda(u)=-\log|1-u|+\frac12B_2(r(u))L,
 \qquad B_2(t)=t^2-t+\frac16.
\]

The Bernoulli distribution relation gives

\[
  \sum_{j=1}^{\ell-1}B_2(j/\ell)
  =-\frac{\ell-1}{6\ell}.
\]

## Theorem 1 (canonical line)

For the canonical Tate line `C_can=mu_ell`,

\[
  \sum_{P\in C_{\rm can}\setminus\{0\}}\lambda(P)
  =\frac{\ell-1}{12}L.
\]

### Proof

Every nonzero point is represented by a nontrivial root of unity. Since the
residue characteristic does not divide `ell`, `|1-zeta|=1`, and the radial
coordinate is zero. Each term is therefore `B_2(0)L/2=L/12`.

## Theorem 2 (noncanonical line)

Every other cyclic order-`ell` subgroup `C` satisfies

\[
  \sum_{P\in C\setminus\{0\}}\lambda(P)
  =-\frac{\ell-1}{12\ell}L.
\]

### Proof

After choosing a Tate basis, its nonzero points are represented by

\[
  u_j=\zeta^{tj}q^{j/\ell},
  \qquad 1\leq j\leq\ell-1.
\]

Here `|u_j|<1`, hence `|1-u_j|=1`. Summing the Bernoulli terms proves the
formula.

## Corollary 3 (full-torsion cancellation)

There is one canonical line and `ell` noncanonical lines, so

\[
  \sum_{P\in E[\ell]\setminus\{0\}}\lambda(P)
  =\frac{\ell-1}{12}L
   +\ell\left(-\frac{\ell-1}{12\ell}L\right)
  =0.
\]

Thus a completely symmetric unweighted torsion packet erases the Tate
q-parameter exactly.

## Corollary 4 (fixed weighted packet average)

For

\[
 A_\ell=\frac{\ell-1}{12},
 \qquad B_\ell=-\frac{\ell-1}{12\ell},
\]

and fixed weights `w_D` on the `ell+1` cyclic lines, define

\[
 S_C(w)=A_\ell w_C+B_\ell\sum_{D\ne C}w_D.
\]

Then

\[
  \frac1{\ell+1}\sum_C S_C(w)=0.
\]

Every fixed line occurs once canonically and `ell` times noncanonically, while
`A_ell+ell B_ell=0`.

These are local and finite-group identities. They do not justify choosing one
fixed global line before the number-field product formula. The fixed global
packet variant is excluded by Corollary 4; only locally adaptive or globally
labelled successor constructions remain active.
