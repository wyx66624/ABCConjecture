# ABC multi-route research note v29d: the exact one-sided contact target

**Author:** ChatGPT  
**Date:** 2026-08-31

## Correction and sharpening

This note sharpens the endpoint-contact reduction and supersedes the schematic
symmetric inequality displayed in Section 6 of the v29b note.  A symmetric
bound for `log R+log S` with an `epsilon*log c` term is not, by itself, sharp
enough to recover the coefficient `1+epsilon`.  The correct target is
one-sided because

\[
c=SB.
\]

## 1. Exact equivalence on the right endpoint

Let

\[
H_m=\log\operatorname{rad}(m),\qquad
H_A=\log A,\qquad H_B=\log B.
\]

Since

\[
\log c=\log S+H_B
\]

and

\[
\log\operatorname{rad}(abc)=H_m+H_A+H_B,
\]

the standard abc estimate

\[
\log c\le
(1+\varepsilon)
\log\operatorname{rad}(abc)+C_\varepsilon
\]

is equivalent to

\[
\boxed{
\log S\le
(1+\varepsilon)(H_m+H_A)
+\varepsilon H_B+C_\varepsilon.
}
\]

Indeed, adding `H_B` to the boxed inequality gives exactly the desired abc
coefficient:

\[
\log c\le
(1+\varepsilon)(H_m+H_A+H_B)+C_\varepsilon.
\]

## 2. Contact-depth formulation

The v29b exact contact theorem gives, for every prime `q|B`,

\[
v_q(RA+m)=v_q(S)+1.
\]

Therefore

\[
\log S
=
\sum_{q\mid B}
\bigl(v_q(RA+m)-1\bigr)\log q.
\]

The exact remaining theorem is thus

\[
\boxed{
\sum_{q\mid B}
\bigl(v_q(RA+m)-1\bigr)\log q
\le
(1+\varepsilon)
\log\bigl(\operatorname{rad}(m)A\bigr)
+
\varepsilon\log B
+C_\varepsilon.
}
\]

This formulation exposes the required coefficient allocation:

- the opposite endpoint support `A` and the gap support `rad(m)` may be charged
  with coefficient `1+epsilon`;
- the right residual support `B` may be charged only with coefficient
  `epsilon`, because its first radical layer is already present in `c=SB`.

## 3. Cross-coupled p-adic system

For every prime `p|A`, the equation

\[
SB-m=RA
\]

gives

\[
v_p(SB-m)=v_p(R)+1.
\]

Thus the left support supplies high-order p-adic equations for the right
exponent vector `(v_q(S))_{q|B}`.  Conversely, the right support supplies
high-order equations for the left exponent vector.

The proof must use this cross-coupling to bound the right lifting excess by
`rad(m)A` plus only an `epsilon` fraction of `B`.  A theorem that charges a full
copy of `B` before adding `log B` back into `log c` loses the critical
coefficient and cannot close abc.

## 4. Immediate audit rule

Any proposed determinant, p-adic logarithm, sieve, or height estimate should be
rejected unless its final right-side budget has the form

\[
(1+\varepsilon)\log(\operatorname{rad}(m)A)
+
\varepsilon\log B+O_\varepsilon(1).
\]

This coefficient ledger prevents future conditional interfaces from silently
assuming the missing `B`-saving.
