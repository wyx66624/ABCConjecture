# Galois-averaged cancellation of fixed torsion-line packets

## 1. Local score function

Let `L=P^1(F_ell)` be the set of cyclic order-`ell` lines.  At a split Tate
place, let `C in L` be the canonical line.  Put

\[
 A_\ell=\frac{\ell-1}{12},
 \qquad
 B_\ell=-\frac{\ell-1}{12\ell}.
\]

For a fixed real weight system `w=(w_D)_{D in L}`, define the local packet
score

\[
 S_C(w)=A_\ell w_C+B_\ell\sum_{D\ne C}w_D.
\]

This contains as special cases a fixed subset of lines, a fixed three-line
packet, and arbitrary multiplicities attached to fixed geometric lines.

## 2. Exact average cancellation

### Theorem 2.1

\[
 \frac1{\ell+1}\sum_{C\in L}S_C(w)=0.
\]

#### Proof

Every fixed line `D` occurs once as the canonical line and `ell` times as a
noncanonical line.  Hence

\[
 \sum_C S_C(w)
 =(A_\ell+\ell B_\ell)\sum_Dw_D=0.
\]

### Corollary 2.2

For a fixed subset of `k` lines, the average local q-slope is zero, even though
at a place where one selected line is canonical the local score is positive.

## 3. Arithmetic consequence

Assume the projective mod-`ell` Galois image is transitive on `L`.  Let `M` be
a number field over which a fixed weighted packet of geometric lines is
defined.  When the product formula is normalized by summing over all
embeddings/places above a rational multiplicative prime, the canonical line is
sampled through its full projective Galois orbit.  The q-part of the normalized
local sum is therefore the average in Theorem 2.1 and vanishes.

In particular, the naive fixed three-line determinant packet proposed in the
first version of the classical Hodge--Arakelov route does not retain a positive
q-slope after the field-of-definition/Galois normalization required by the
global product formula.

This is a strict no-go theorem for **fixed, place-independent packets** under
transitive projective image.  It does not exclude:

1. a place-dependent canonical-line packet;
2. an adelic vector bundle whose local filtrations depend on the inertia line;
3. a normed comparison that transports a locally selected generator while
   recording its Jacobian and different;
4. a route in which the projective image is deliberately nontransitive and the
   resulting loss is controlled by another theorem.

## 4. Corrected target

A surviving classical route must construct a locally adaptive packet
`w_v`, correlated with the canonical inertia line `C_v`, and prove an adelic
selection inequality.  Abstractly, it must compare

\[
 \sum_v n_v S_{C_v}(w_v)
\]

with the Arakelov degree or maximal slope of one globally defined adelic vector
bundle.  The discrepancy caused by the failure of the local packets to arise
from one global algebraic line must be bounded with the sharp coefficient
needed for abc.

The cyclic-line different bound remains relevant to this discrepancy, but it
does not by itself prevent the cancellation above.
