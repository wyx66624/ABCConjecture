# Galois-invariant tropical norms of the torsion-line packet

## 1. Motivation

The fixed weighted average of the cyclic `ell`-line energies vanishes under the
full projective Galois orbit.  This excludes symmetric **linear** packets, but
it does not imply that every Galois-invariant quantity loses the Tate
parameter.  The permutation representation has a nontrivial standard
subrepresentation, and symmetric norms on that subrepresentation retain the
complete local q-signal.

This branch develops that nonlinear successor.

## 2. The local score vector

Let

\[
  \mathcal L=\mathbb P^1(\mathbb F_\ell),
  \qquad |\mathcal L|=\ell+1,
\]

and let `C in L` be the canonical Tate line at a split multiplicative place.
Put

\[
  A_\ell=\frac{\ell-1}{12},
  \qquad
  B_\ell=-\frac{\ell-1}{12\ell}.
\]

For a Tate weight `L_v=-log|q_v|>0`, define

\[
  s_{C,L_v}(D)=
  \begin{cases}
    A_\ell L_v,&D=C,\\
    B_\ell L_v,&D\ne C.
  \end{cases}
\]

### Theorem 2.1 (standard-representation identities)

The vector `s=s_{C,L}` satisfies

\[
  \sum_{D\in\mathcal L}s(D)=0,
\]

\[
  \max_Ds(D)=A_\ell L,
  \qquad
  \min_Ds(D)=B_\ell L,
\]

\[
  \operatorname{osc}(s)
  :=\max_Ds(D)-\min_Ds(D)
  =\frac{(\ell-1)(\ell+1)}{12\ell}L,
\]

and

\[
  \|s\|_2^2
  =\frac{(\ell-1)^2(\ell+1)}{144\ell}L^2.
\]

### Proof

The zero-sum identity is `A_ell+ell B_ell=0`.  The maximum and minimum follow
from `A_ell>0>B_ell`.  Subtraction gives the oscillation.  Finally,

\[
 \|s\|_2^2=A_\ell^2L^2+\ell B_\ell^2L^2
 =A_\ell^2(1+1/\ell)L^2,
\]

which simplifies to the displayed formula.

## 3. Linear invariants cannot see q, nonlinear invariants can

Let the symmetric group of `L` act by permuting coordinates.

### Theorem 3.1 (linear invariant no-go)

Every permutation-invariant linear functional

\[
  \varphi:\mathbb R^{\mathcal L}\longrightarrow\mathbb R
\]

is a scalar multiple of the coordinate sum.  Hence

\[
  \varphi(s_{C,L})=0.
\]

### Proof

Permutation invariance forces all coordinate coefficients of `varphi` to be
equal.  The zero-sum identity then gives the conclusion.

### Theorem 3.2 (nonlinear survival)

The functions

\[
  s\longmapsto\max_Ds(D),
  \qquad
  s\longmapsto\operatorname{osc}(s),
  \qquad
  s\longmapsto\|s\|_2
\]

are permutation invariant and retain a strictly positive multiple of `L`.

Thus the Galois-average counterexample eliminates symmetric linear
functionals, not symmetric norms.

## 4. Algebraic packet and projective oscillation height

Suppose the cyclic lines admit algebraic modular-unit or determinant
coordinates

\[
  u_D(E)\in K^\times,
  \qquad D\in\mathcal L,
\]

whose local logarithmic norms at a split Tate place differ from one common
scalar by the score vector:

\[
  \log|u_D(E)^{-1}|_v
  =c_v+s_{C_v,L_v}(D).
  \tag{1}
\]

The common scalar is unavoidable because a projective packet is defined only
up to simultaneous multiplication.

For a projective vector `x=[x_D]`, define the local oscillation

\[
  \omega_v(x)
  =\max_D\log|x_D|_v-
    \min_D\log|x_D|_v.
\]

It is invariant under simultaneous scaling and coordinate permutation.
Define the global oscillation height

\[
  h_{\rm osc}(x)
  =\frac1{[K:\mathbb Q]}
   \sum_v n_v\,\omega_v(x).
\]

### Theorem 4.1 (local q-recovery)

Under (1), every split multiplicative place contributes

\[
  \omega_v([u_D(E)^{-1}]_D)
  =\frac{(\ell-1)(\ell+1)}{12\ell}
   (-\log|q_v|).
\]

Good places at which all coordinates are units with the same reduction
contribute zero.

### Proof

The common scalar cancels from max minus min.  Apply Theorem 2.1.

## 5. Reduction to a projective S-unit height theorem

The oscillation may also be written as

\[
  \omega_v([x_D])
  =\max_{D,E}\log|x_D/x_E|_v.
\]

Hence `h_osc` is controlled by the heights of the coordinate ratios.  If the
ratios are modular units, their zeros and poles are supported on the cusp
divisor and their specializations are `S`-units outside the level and the
field different.

A proof of abc through this route is reduced to the following statement.

### Target theorem 5.1 (torsion-packet oscillation bound)

For every `epsilon>0`, choose `ell` with `log ell=o(log c)` and construct a
Galois-stable algebraic packet satisfying (1) such that

\[
  h_{\rm osc}([u_D(E)^{-1}]_D)
  \le
  \left(
    \frac{(\ell-1)(\ell+1)}{2\ell}
    +o_\ell(\ell)
  \right)
  (\log\operatorname{Diff}+\log\operatorname{Cond})
  +O_\epsilon(\ell\log\ell).
  \tag{2}
\]

Combining Theorem 4.1 with (2) and dividing by the local coefficient gives

\[
  \frac16Q
  \le(1+o_\ell(1))
  (\log\operatorname{Diff}+\log\operatorname{Cond})
  +O(\log\ell),
\]

which yields abc after the standard Frey comparison.

## 6. Audit of the remaining difficulty

The nonlinear packet solves the exact Galois-average cancellation problem, but
Target theorem 5.1 is still a sharp varying-`S` unit or projective-height
estimate.  A generic height bound for a modular map is proportional to the
ordinary height of the specialization and therefore restates the quantity one
is trying to control.

A successful proof must exploit additional relations among the `ell+1`
coordinates---for example modular-unit equations, determinant identities,
Plucker relations, or an Arakelov slope theorem---to replace ordinary height by
truncated conductor height with the sharp coefficient.

The route is neither proved nor refuted.  It is strictly stronger than the
fixed-packet route in one respect: its Galois-invariant local norm retains the
entire Tate signal without choosing one geometric line.
