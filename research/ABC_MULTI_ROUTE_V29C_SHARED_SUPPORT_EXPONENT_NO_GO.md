# ABC multi-route research note v29c: support sharing alone cannot bound exponent height

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. A canonical counterfamily to an over-strong intermediate claim

The canonical conditions

\[
RA+m=SB,\qquad
A,B\text{ squarefree},\qquad
\operatorname{rad}(R)\mid A,\qquad
\operatorname{rad}(S)\mid B
\]

do not by themselves bound `log R+log S` in terms of `log A+log B`.

For every integer `n>=1`, take

\[
A=2,\qquad R=2^n,\qquad
B=3,\qquad S=3^n,
\]

and

\[
m=3^{n+1}-2^{n+1}.
\]

Then

\[
RA=2^{n+1},\qquad SB=3^{n+1},\qquad RA+m=SB.
\]

The two residual supports are fixed and squarefree, and

\[
\operatorname{rad}(R)=2\mid A,\qquad
\operatorname{rad}(S)=3\mid B.
\]

Moreover the three integers

\[
2^{n+1},\qquad 3^{n+1}-2^{n+1},\qquad 3^{n+1}
\]

are pairwise coprime.  Hence this is an actual primitive abc family.

But

\[
\log R+\log S=n\log 6\longrightarrow\infty,
\]

while

\[
\log A+\log B=\log6
\]

is fixed.

Therefore any proposed theorem of the form

\[
\log R+\log S\le F(\log A+\log B)
\]

with a fixed finite function `F` is false, even on genuine primitive abc
triples.

## 2. What compensates the exponent growth

In this family the missing arithmetic datum is the gap radical

\[
\operatorname{rad}(m)
=
\operatorname{rad}(3^{n+1}-2^{n+1}).
\]

Any correct exponent-height theorem must force the growth of this radical, or
more generally exploit the interaction between the cross-endpoint contact
depths and the prime support of the gap.

Thus the correct target necessarily contains all three support layers:

\[
A,\qquad B,\qquad \operatorname{rad}(m).
\]

This no-go prevents a circular or false proof that treats modulus/residual
support sharing as sufficient by itself.

## 3. Refined target

The exact identities from v29b give

\[
\log R
=
\sum_{p\mid A}
\bigl(v_p(SB-m)-1\bigr)\log p,
\]

\[
\log S
=
\sum_{q\mid B}
\bigl(v_q(RA+m)-1\bigr)\log q.
\]

The remaining theorem must show that large simultaneous lifting depths force
new prime support into `m`, or force enough support into `A` and `B` to pay for
the height.  In schematic form, one needs a genuinely three-support estimate
such as

\[
\log R+\log S
\le
\varepsilon\log c
+(1+O(\varepsilon))
\log\bigl(\operatorname{rad}(m)AB\bigr)
+O_\varepsilon(1).
\]

The two-prime family above shows why the `rad(m)` term cannot be removed.
