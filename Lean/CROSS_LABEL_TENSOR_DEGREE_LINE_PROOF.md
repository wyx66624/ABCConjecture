# Cross-label tensor degree line: mathematical proof

This note isolates the smallest source theorem in Step (x) of the proof of
IUT III, Corollary 3.12 that is both mathematically precise and independent of
the Corollary 3.12 inequality.

## 1. Balanced tensor packet theorem

Let `R` be a commutative ring, let `I` be a label set, let `M_i` be an
`R`-module for every `i in I`, and put

\[
  T=\bigotimes_{i\in I,R} M_i.
\]

For `r in R` and `j in I`, let `m_{j,r}:T -> T` be the linear map induced by
the identity on every factor other than `j` and by multiplication by `r` on
the `j`-th factor. Then

\[
  m_{j,r}=r\,\mathrm{id}_T.
\]

Indeed, on a pure tensor one has

\[
  m_{j,r}\left(\bigotimes_i x_i\right)
    =x_1\otimes\cdots\otimes (r x_j)\otimes\cdots
    =r\left(\bigotimes_i x_i\right).
\]

The second equality is precisely the balancing relation in the tensor
product. Pure tensors span `T`, hence the two linear maps are equal. It follows
immediately that `m_{j,r}=m_{k,r}` for any two labels `j,k`. In particular,
when `r` is the image of an integer, integer multiplication has literally the
same action at every tensor label. The same theorem applies without change to
the local packet factors

\[
  M_i=\bigoplus_v K_{i,v}.
\]

Thus this is an actual cross-label theorem on the tensor packet, not a
fixed-place scalar calibration.

## 2. The real tensor degree line and Haar log-volume

Now take `R = Real` and `M_i = Real` for every label. For finite `I`, the
multiplication map

\[
  \pi:T\longrightarrow \mathbb R,\qquad
  \pi\left(\bigotimes_i x_i\right)=\prod_i x_i,
\]

is a linear equivalence. We call this canonical copy of `Real` the tensor
degree line. Conjugating `m_{j,r}` by `pi` gives the ordinary map
`x |-> r*x`, independently of `j`.

Let `n` be a nonzero integer and let `U` be a measurable subset of the degree
line with finite positive Lebesgue measure. The image `nU` is again measurable
and finite-positive. The one-dimensional Haar change-of-variables formula
gives

\[
  \operatorname{vol}(nU)=|n|\operatorname{vol}(U).
\]

Taking logarithms (which is legitimate because both measures are finite and
strictly positive) yields

\[
  \log\operatorname{vol}(nU)
   =\log|n|+\log\operatorname{vol}(U).
\]

Since the conjugated maps for any two labels are equal, both the image region
and its Haar log-volume effect are equal across labels. No volume formula is
stored as an input field: it is derived from tensor balancing and Lebesgue
measure scaling.

## 3. Exact boundary

This proves the algebraic/log-volume assertion about integer multiplication
*after the local factors have been placed in one tensor packet over a common
scalar ring*. It does not construct the IUT arithmetic holomorphic structures,
untilts, Kummer embeddings, or log-links that are supposed to place the alien
labelled objects into that common packet. It also does not prove the Ind1--Ind3
possible-image estimate or Corollary 3.12. In particular, it does not identify
the fixed-field rescalings `1/j^2` with the missing AHS/untilt comparison.

There is also a sharp obstruction to the most naive attempted construction.
Take the label-one and label-two copies of one `p`-adic field equipped with the
rescaled absolute values `|x|` and `|x|^(1/4)`. If both copies admitted
isometric embeddings into one metric packet that identified their zero points
and their copies of the integer `p`, then preservation of distance to zero
would give

\[
  |p|=|p|^{1/4}.
\]

Taking logarithms contradicts `log |p| != 0`. Hence a genuine AHS/untilt
construction cannot be a common *isometric* realization of the fixed-field
`1/j^2` rescalings. It must change either the comparison maps, the objects being
compared, or the measure normalization before applying the balanced tensor
theorem.
