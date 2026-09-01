# ABC multi-route v29: cross-support exponent-depth attack

## 1. Canonical setting

For a primitive positive triple

\[
a+b=c,
\]

put

\[
m=\min(a,b),\qquad M=\max(a,b).
\]

Write

\[
A=\operatorname{rad}(M),\qquad
B=\operatorname{rad}(c),\qquad
C=\operatorname{rad}(m),
\]

and

\[
R=M/A,\qquad S=c/B.
\]

Then

\[
m+RA=SB.
\]

The canonical residual core gives

\[
\gcd(A,B)=\gcd(A,C)=\gcd(B,C)=1,
\]

\[
A,B\text{ squarefree},
\]

and

\[
\operatorname{rad}(R)\mid A,\qquad
\operatorname{rad}(S)\mid B.
\]

Thus, if

\[
M=\prod_{p\mid A}p^{e_p},\qquad
c=\prod_{q\mid B}q^{f_q},
\]

then

\[
R=\prod_{p\mid A}p^{e_p-1},\qquad
S=\prod_{q\mid B}q^{f_q-1}.
\]

Define the two-vector excess height

\[
E:=\log R+\log S
 =\sum_{p\mid A}(e_p-1)\log p
  +\sum_{q\mid B}(f_q-1)\log q.
\]

This is the exact total height of the two exponent vectors beyond their
squarefree first layers.

## 2. Exact equivalence with the abc height target

Let

\[
W=\log A+\log B,\qquad G=\log C,
\]

and

\[
h_M=\log M=\log A+\log R,
\qquad
h_c=\log c=\log B+\log S.
\]

Since \(m\le M\),

\[
M<c=M+m\le 2M,
\]

so

\[
h_M\le h_c\le h_M+\log 2.
\]

Consequently an abc bound

\[
h_c\le (1+\varepsilon)(W+G)+K
\]

implies

\[
\boxed{
E\le (1+2\varepsilon)W
  +2(1+\varepsilon)G+2K.
}
\]

Conversely, if

\[
\boxed{
E\le (1+2\varepsilon)W
  +2(1+\varepsilon)G+K,
}
\]

then

\[
h_c\le (1+\varepsilon)(W+G)
  +\frac{K+\log 2}{2}.
\]

Therefore controlling the total height of the two exponent vectors with the
displayed coefficients is not merely sufficient: it is equivalent to the
logarithmic abc estimate up to the harmless endpoint-balance constant
\(\log 2\).

This prevents a hidden circularity.  A proposed uniform bound for \(E\) must
be proved from additional arithmetic input, not installed as an abstract
"exponent-control lemma".

## 3. Threshold and tail decomposition

Put

\[
\rho_p=e_p-1,\qquad \sigma_q=f_q-1.
\]

For every integer cutoff \(D\ge 0\),

\[
\rho_p\le D+(\rho_p-D)_+,
\qquad
\sigma_q\le D+(\sigma_q-D)_+.
\]

Hence

\[
\boxed{
E\le D W+T_D,
}
\]

where

\[
T_D=
\sum_{p\mid A}(\rho_p-D)_+\log p
+
\sum_{q\mid B}(\sigma_q-D)_+\log q.
\]

In particular,

\[
E>DW
\]

forces at least one prime on one of the two endpoint supports to have depth
strictly larger than \(D\).

This is the exact combinatorial gate needed for a Pasten-style strategy:
low-depth primes are absorbed by \(DW\); all remaining difficulty is placed in
a high-depth tail whose support should be controlled by modular/Shimura input
and whose remaining exponent size should be controlled by linear forms in
logarithms.

## 4. Exact cross-support lifting depths

For \(p\mid A\), one has \(p\nmid mc\) and

\[
c-m=M.
\]

Therefore

\[
\boxed{
p^k\mid c-m
\iff k\le v_p(M)=e_p.
}
\]

Equivalently,

\[
c\equiv m\pmod{p^{e_p}}.
\]

For \(q\mid B\), one has \(q\nmid mM\) and

\[
M+m=c,
\]

so

\[
\boxed{
q^k\mid M+m
\iff k\le v_q(c)=f_q,
}
\]

or

\[
M\equiv -m\pmod{q^{f_q}}.
\]

Thus the exponent vectors are exactly the maximal local lifting depths of two
opposite-support unit equations.  For odd local primes these can be read as
p-adic logarithmic forms:

\[
v_p\!\left(\log_p(c/m)\right)=e_p,
\]

and, after the usual sign normalization,

\[
v_q\!\left(\log_q(-M/m)\right)=f_q.
\]

The important point is symmetry: the \(M\)-support constrains the
\((c,m)\)-support exponent vector, while the \(c\)-support constrains the
\((M,m)\)-support exponent vector.

## 5. One-sided failure and a deep-lift/source-size dichotomy

The one-sided abc target is exactly

\[
\log S\le
(1+\varepsilon)(\log A+\log C)
+\varepsilon\log B+K.
\]

If it fails, then the weighted average depth on the \(B\)-support satisfies

\[
\frac{\sum_{q\mid B}\sigma_q\log q}{\log B}
>
\varepsilon
+(1+\varepsilon)
 \frac{\log A+\log C}{\log B}
+\frac{K}{\log B}.
\]

Hence some \(q\mid B\) has at least this depth.  This gives a precise
dichotomy:

1. if \(\log B\) is small relative to \(\log A+\log C\), a very deep
   q-adic lifting relation is forced;
2. if \(\log B\) is large, then the source support \(A C\) is comparatively
   small, reducing the generator height and entropy in the q-adic logarithmic
   form.

The same statement holds with the two endpoint supports reversed.

## 6. The viable hybrid attack

The most credible remaining route is now:

1. choose an adaptive cutoff \(D\);
2. absorb the low-depth contribution by \(DW\);
3. attach the Frey curve to the abc point and use conductor/discriminant or
   Shimura-curve information to control the number or weighted support of
   primes with depth above \(D\);
4. compress all low-depth factors into one generator, as in the
   modular-plus-linear-forms method;
5. apply archimedean and p-adic logarithmic-form estimates only to the reduced
   high-depth generator set;
6. run the argument on both endpoint supports and use
   \(0\le h_c-h_M\le\log 2\) to combine the two estimates;
7. optimize \(D\) against the radical weights.

Pasten's work on subexponential abc explicitly separates large-exponent
primes from small-exponent primes, bounds the number of large-exponent primes
using modular/Shimura input, and then returns to linear forms in logarithms.
The present canonical decomposition identifies the exact symmetric
quantity to which that architecture must be applied.

## 7. Precise missing theorem

The unresolved core can be stated without ambiguity as the following weighted
tail estimate.

For every \(\varepsilon>0\), prove that there are a cutoff rule \(D\) and a
constant \(K_\varepsilon\), uniform in the primitive abc point, such that

\[
T_D\le
\bigl(1+2\varepsilon-D\bigr)W
+2(1+\varepsilon)G
+K_\varepsilon.
\]

Together with \(E\le DW+T_D\), this is exactly the two-vector excess budget and
therefore yields abc.

No such estimate has been inserted as an assumption.  The Lean module in this
stage formalizes only the exact first-layer/excess decomposition, the
threshold-tail reduction, the deep-coordinate selector, and the two-way
balanced-height conversion.
