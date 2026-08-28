# Nitaj's 3-full recurrence cannot reach the 4-full threshold

## Status

This note proves a route-specific no-go theorem.  It does **not** disprove the
existence of other primitive `(3,3,4)`-full families, and it does not prove or
disprove abc by itself.

## 1. The recurrence

Nitaj starts from

\[
(x_0,y_0,z_0)=(37,17,21)
\]

and iterates

\[
\begin{aligned}
x_{n+1}&=x_n(x_n^3+2y_n^3),\\
y_{n+1}&=-y_n(2x_n^3+y_n^3),\\
z_{n+1}&=z_n(x_n^3-y_n^3).
\end{aligned}
\]

The polynomial identity

\[
X^3(X^3+2Y^3)^3-Y^3(2X^3+Y^3)^3
=(X^3+Y^3)(X^3-Y^3)^3
\]

shows that

\[
x_n^3+y_n^3=6z_n^3
\]

is preserved.  After moving the negative cubic term to the other side when
necessary, this produces Nitaj's primitive 3-full abc triples.

## 2. A permanent exact 37-adic obstruction on `x_n`

We prove inductively

\[
v_{37}(x_n)=1,\qquad 37\nmid y_n,\qquad 37\nmid z_n.
\]

It is true initially because `x_0=37`, `y_0=17`, and `z_0=21`.
Assume it at stage `n`.  Modulo 37,

\[
x_n^3+2y_n^3\equiv2y_n^3\not\equiv0,
\]

so the new multiplier of `x_n` is a 37-adic unit.  Hence

\[
v_{37}(x_{n+1})=v_{37}(x_n)=1.
\]

Likewise

\[
2x_n^3+y_n^3\equiv y_n^3\not\equiv0,
\qquad
x_n^3-y_n^3\equiv-y_n^3\not\equiv0,
\]

so neither `y_{n+1}` nor `z_{n+1}` is divisible by 37.
Consequently

\[
v_{37}(|x_n|^3)=3
\]

for every `n`; in particular `|x_n|^3` is never 4-full.

## 3. A permanent exact 17-adic obstruction on `y_n`

Symmetrically,

\[
v_{17}(y_n)=1,\qquad17\nmid x_n,\qquad17\nmid z_n.
\]

Indeed, modulo 17 the multiplier of `y_n` is

\[
2x_n^3+y_n^3\equiv2x_n^3\not\equiv0,
\]

while the multipliers of `x_n` and `z_n` reduce respectively to `x_n^3`
and `x_n^3`.  Thus

\[
v_{17}(|y_n|^3)=3,
\]

and `|y_n|^3` is never 4-full.

## 4. A permanent exact 7-adic obstruction on `6z_n^3`

Initially

\[
v_7(z_0)=1,\qquad(x_0,y_0)\equiv(2,3)\pmod7.
\]

The first step gives

\[
(x_1,y_1)\equiv(5,4)\pmod7,
\]

because

\[
2^3\equiv1,\qquad3^3\equiv-1\pmod7.
\]

The residue pair `(5,4)` is fixed by the recurrence modulo 7:

\[
\begin{aligned}
5(5^3+2\cdot4^3)&\equiv5,\\
-4(2\cdot5^3+4^3)&\equiv4
\pmod7.
\end{aligned}
\]

For the initial pair,

\[
2^3-3^3\equiv2\not\equiv0\pmod7,
\]

and for the fixed pair,

\[
5^3-4^3\equiv5\not\equiv0\pmod7.
\]

Therefore every multiplier `x_n^3-y_n^3` is a 7-adic unit.  Hence

\[
v_7(z_n)=1
\]

for all `n`.  Since `7\nmid6`,

\[
v_7(6|z_n|^3)=3,
\]

so the third coordinate is never 4-full either.

## 5. No-go conclusion

Every abc triple obtained from this recurrence has, up to permutation, the
three positive coordinates

\[
|x_n|^3,\qquad |y_n|^3,\qquad6|z_n|^3.
\]

They contain prime factors 37, 17, and 7 respectively with exact exponent
three.  Thus none of the three coordinates is 4-full.  In particular this
recurrence can produce neither

- an all-4-full family, nor
- a mixed `(3,3,4)`-full family.

The obstruction is structural and persists at every iterate; it is not a
finite-search observation.

## 6. What remains open

This no-go theorem eliminates only Nitaj's displayed recurrence.  It does not
eliminate:

1. other rational points or other self-maps on `X^3+Y^3=6Z^3`;
2. different elliptic-curve constructions of primitive 3-full triples;
3. generalized-Fermat signatures with reciprocal exponent sum below one;
4. non-power k-full coordinates with varying square/cube-free kernels.

The next constructive target remains an unbounded primitive family with
signature `(3,3,4)` or any positive signature satisfying

\[
\frac1{k_a}+\frac1{k_b}+\frac1{k_c}<1.
\]

## Reference

A. Nitaj, *On a Conjecture of Erdős on 3-Powerful Numbers*, Bulletin of the
London Mathematical Society **27** (1995), 317--318,
DOI `10.1112/blms/27.4.317`.
