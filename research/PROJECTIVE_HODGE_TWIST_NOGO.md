# Projective invariance and the Hodge-twist no-go theorem

## 1. The issue

The cyclic kernel packet has an exact transformation weight

\[
  \omega^{\ell-1},
\]

and the associated parabolic line has degree `(ell-1)/2`.  The canonical Tate
coordinate has local coefficient `(ell-1)/12`, whose ratio with this degree is
six.  This numerical agreement is real, but it does not by itself control the
**projective** height of the cyclic packet.

Projectivization removes every common line factor.  The theorem below records
the resulting obstruction.

## 2. Centered logarithmic coordinates

Let `I` be a finite nonempty set and let `x=(x_i)_{i in I}` be real logarithmic
coordinate norms.  Define

\[
  \operatorname{avg}(x)=\frac1{|I|}\sum_{i\in I}x_i,
  \qquad
  x_i^0=x_i-\operatorname{avg}(x).
\]

The centered maximum

\[
  h_{\rm proj}(x)=\max_i x_i^0
  =\max_i x_i-\operatorname{avg}(x)
\tag{2.1}
\]

is the local projective-height contribution in the product-normalized
coordinates.

### Theorem 2.1 (common-shift invariance)

For every real number `c`,

\[
  (x_i+c)^0=x_i^0
\]

for every `i`, and consequently

\[
  h_{\rm proj}(x+c\mathbf1)=h_{\rm proj}(x).
\tag{2.2}
\]

#### Proof

Since

\[
 \operatorname{avg}(x+c\mathbf1)
 =\operatorname{avg}(x)+c,
\]

we have

\[
 (x_i+c)-(\operatorname{avg}(x)+c)
 =x_i-\operatorname{avg}(x).
\]

## 3. Line-bundle formulation

Let `L` be a line bundle and `V` a vector bundle.  There is a canonical
projective-bundle isomorphism

\[
  \mathbf P(L\otimes V)\simeq\mathbf P(V).
\tag{3.1}
\]

Choose a local nonzero frame `s` of `L` and write a packet section as

\[
  s\otimes(v_i)_i.
\]

Changing the frame or the metric of `L` adds the same logarithmic quantity to
all coordinate norms.  Theorem 2.1 therefore shows that every projective
oscillation, centered sup norm, max-minus-average norm, and max-minus-min norm
is independent of `L`.

### Theorem 3.1 (Hodge-twist no-go)

The degree of a common Hodge twist `omega^(ell-1)` cannot by itself give an
upper bound for the projective height of the cyclic-line packet.  In
particular, the identity

\[
  \frac{\deg\omega^{\ell-1}}{(\ell-1)/12}=6
\]

is not a proof of the coefficient `1/6` for a projective packet: the Hodge
factor disappears from the centered packet before the projective height is
computed.

## 4. Application to the Tate two-valued packet

At a split Tate place put

\[
 A_\ell=\frac{\ell-1}{12},
 \qquad
 B_\ell=-\frac{\ell-1}{12\ell}.
\]

The local logarithmic vector has one coordinate `A_ell L` and `ell`
coordinates `B_ell L`, where `L=-log|q|`.  Since

\[
 A_\ell+\ell B_\ell=0,
\]

it is already centered.  Hence

\[
 h_{\rm proj}=A_\ell L.
\tag{4.1}
\]

If the actual algebraic coordinates carry an additional common Hodge term
`h_v`, their logarithms are

\[
 h_v+A_\ell L,
 \quad
 h_v+B_\ell L,
 \ldots,
 h_v+B_\ell L.
\]

Projective normalization removes `h_v` exactly and leaves (4.1).  Thus the
positive q-signal lives in the Steinberg/augmentation coordinates, not in the
common Hodge line.

## 5. Consequence for active proof routes

This theorem excludes the following shortcut:

1. identify the packet as `omega^(ell-1) tensor St_ell`;
2. use `deg omega^(ell-1)=(ell-1)/2`;
3. divide by the local coefficient `(ell-1)/12`;
4. conclude the projective packet inequality.

Step 2 contributes only a common scalar and is erased by Step 3's projective
normalization.

The theorem does **not** exclude:

- an absolute determinant line in which the Hodge factor is retained and a
  calibrated algebraic trivialization is supplied;
- a canonical Hecke/theta metric whose relative Steinberg-coordinate growth is
  directly bounded by conductor and different;
- a nonlinear invariant of the packet other than projective centering;
- an IUT/ATS comparison that explicitly transports the nontrivial relative
  metric and its Jacobian.

The surviving source-facing theorem is therefore sharper:

\[
 \boxed{
 \text{bound the relative/centered Steinberg metric itself, not the common
 Hodge twist}.}
\]

## 6. Formalization boundary

The accompanying Lean module proves the centered-coordinate invariance under a
common shift and the exact centered Tate coordinates.  It does not introduce a
projective-height or Arakelov-slope axiom, and it makes no ABC conclusion.
