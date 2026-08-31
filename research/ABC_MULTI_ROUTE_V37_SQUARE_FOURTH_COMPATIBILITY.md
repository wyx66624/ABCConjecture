# ABC multi-route research note v37: square/fourth-power compatibility

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Why this compatibility matters

The moving-Pell reduction represents every endpoint as a squarefree
coefficient times a square.  The aggregate quartic reduction represents one
endpoint as a fourth-power-free coefficient times a fourth power.  These are
not independent representations: their canonical exponent profiles fit
together exactly.

The present note identifies that relation and thereby places the height-scale
quartic divisor *inside the Pell root variable*.

## 2. One-prime exponent identities

For an exponent \(e\ge0\), define

\[
b(e)=\left\lfloor\frac{e\bmod4}{2}\right\rfloor.
\]

Since \(e\bmod4\in\{0,1,2,3\}\),

\[
b(e)\in\{0,1\}.
\]

The exact identities are

\[
\boxed{
\left\lfloor\frac e2\right\rfloor
=
2\left\lfloor\frac e4\right\rfloor+b(e)
}
\]

and

\[
\boxed{
e\bmod4
=
(e\bmod2)+2b(e).
}
\]

## 3. Integer interpretation

Let

\[
n=\prod_p p^{e_p}.
\]

Write its canonical square decomposition as

\[
n=wz^2,
\]

where \(w\) is squarefree, and its canonical fourth-power decomposition as

\[
n=A d^4,
\]

where every prime exponent in \(A\) is at most three.

Define

\[
t=\prod_p p^{b(e_p)}.
\]

Because each \(b(e_p)\) is zero or one, \(t\) is squarefree. The exponent
identities give the exact relations

\[
\boxed{z=t d^2}
\]

and

\[
\boxed{A=w t^2}.
\]

The factors \(w\) and \(t\) need not be coprime: primes with exponent
\(3\bmod4\) occur in both. This overlap is part of the exact canonical
structure and must not be discarded.

## 4. Logarithmic identities

For a finite weighted exponent profile, let

* \(Q_2\) be the logarithmic size of the canonical square root;
* \(Q_4\) the logarithmic size of the canonical fourth root;
* \(B\) the weighted middle-bit sum;
* \(R\) the radical weight.

Then

\[
\boxed{Q_2=2Q_4+B}
\]

with

\[
0\le B\le R.
\]

Consequently

\[
\boxed{2Q_4\le Q_2\le2Q_4+R.}
\]

At the coefficient level, if \(A_4\) is the fourth-power residue weight and
\(A_2\) the parity residue weight, then

\[
\boxed{A_4=A_2+2B.}
\]

## 5. Consequence for the moving-Pell frontier

Suppose the aggregate quartic theorem selects an endpoint with

\[
Q_4\ge\gamma h-O(1).
\]

Its Pell square-root variable has logarithmic size

\[
Q_2\ge2\gamma h-O(1),
\]

and contains an actual square divisor whose logarithmic size is
\(2Q_4\). Thus the corresponding term of the moving diagonal equation

\[
wz^2+ux^2=vy^2
\]

can be rewritten in a genuine quartic form. For example, if the selected
endpoint is \(wz^2\), then

\[
z=t d^2,
\qquad
wz^2=w t^2 d^4.
\]

The moving coefficient is exactly the fourth-power-free coefficient
\(A=w t^2\), already known from v35 to have power-saving height.

Therefore the nonsplit branch has been reduced to a moving diagonal quartic
with:

* pairwise-coprime squarefree Pell coefficients;
* an exact fourth-power term;
* a power-saving fourth-power-free coefficient;
* and the existing local quadratic-residue constraints.

## 6. Lean module

```text
Lean/IUTThreeClosures/SquareFourthRootCompatibility.lean
```

Core declarations:

```lean
middleBit
div_two_eq_two_mul_div_four_add_middleBit
mod_four_eq_mod_two_add_two_mul_middleBit
quotientWeight_two_eq_two_mul_quotientWeight_four_add_middleBitWeight
residueWeight_four_eq_residueWeight_two_add_two_mul_middleBitWeight
middleBitWeight_le_radicalWeight
two_mul_fourthRootWeight_le_squareRootWeight
squareRootWeight_le_two_mul_fourthRootWeight_add_radicalWeight
squareRoot_gain_of_fourthRoot_gain
```

No ABC estimate or arithmetic-existence theorem is used.
