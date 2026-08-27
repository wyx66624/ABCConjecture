# Power-difference lifts of abc triples

## 1. Construction

Let `a,b,c` be positive pairwise coprime integers with `a+b=c`, and let
`m>=2`. Define

\[
  S_m(a,c)=\frac{c^m-a^m}{c-a}
  =\sum_{j=0}^{m-1}c^{m-1-j}a^j.
\]

Set

\[
  A_m=a^m,
  \qquad
  B_m=bS_m(a,c),
  \qquad
  C_m=c^m.
\]

Then

\[
  A_m+B_m=C_m.
\]

### Theorem 1.1 (primitive lift)

The triple `(A_m,B_m,C_m)` is pairwise coprime.

#### Proof

Clearly `gcd(A_m,C_m)=1`.  Modulo `a`,

\[
  S_m(a,c)\equiv c^{m-1},
\]

so `gcd(a,S_m)=1`; together with `gcd(a,b)=1` this gives
`gcd(A_m,B_m)=1`.  Similarly,

\[
  S_m(a,c)\equiv a^{m-1}\pmod c,
\]

so `gcd(c,S_m)=1`, and `gcd(B_m,C_m)=1` follows from `gcd(b,c)=1`.

## 2. Radical and quality

Put

\[
  R=\operatorname{rad}(abc),
  \qquad
  R_m=\operatorname{rad}(A_mB_mC_m).
\]

### Lemma 2.1

\[
  R_m\leq mRc^{m-1}.
\]

#### Proof

Taking positive powers does not change prime support, and radical is
submultiplicative. Hence

\[
  R_m=\operatorname{rad}(abcS_m(a,c))
  \leq R\,\operatorname{rad}(S_m(a,c))
  \leq R\,S_m(a,c).
\]

Every summand in `S_m` is at most `c^{m-1}`, so

\[
  S_m(a,c)\leq mc^{m-1}.
\]

### Theorem 2.2 (explicit quality transfer)

Assume `epsilon>0` and

\[
  c>R^{1+\epsilon}.
\]

Define

\[
  D_{m,\epsilon}=(1+\epsilon)(m-1)+1,
  \qquad
  \eta_{m,\epsilon}
  =\frac{\epsilon}{2D_{m,\epsilon}}.
\]

If

\[
  c>m^{3(1+\epsilon)/\epsilon},
\]

then

\[
  C_m>R_m^{1+\eta_{m,\epsilon}}.
\]

#### Proof

The original exceptional inequality gives

\[
  \log R<\frac{\log c}{1+\epsilon}.
\]

By Lemma 2.1,

\[
 \frac{\log R_m}{\log c}
 <m-1+\frac1{1+\epsilon}
   +\frac{\log m}{\log c}.
\]

Put

\[
  d_0=m-1+\frac1{1+\epsilon}.
\]

A direct calculation gives

\[
 \frac{m}{1+\eta_{m,\epsilon}}-d_0
 =
 \frac{\epsilon\bigl(m+(m-1)\epsilon\bigr)}
 {(1+\epsilon)\bigl(2m+(2m-1)\epsilon\bigr)}.
\]

Since

\[
  2m+(2m-1)\epsilon
  \leq3\bigl(m+(m-1)\epsilon\bigr)
\]

for `m>=2`, this gap is at least

\[
  \frac{\epsilon}{3(1+\epsilon)}.
\]

The lower bound on `c` implies

\[
  \frac{\log m}{\log c}
  <\frac{\epsilon}{3(1+\epsilon)}.
\]

Therefore

\[
  \log R_m
  <\frac{m}{1+\eta_{m,\epsilon}}\log c
  =\frac{1}{1+\eta_{m,\epsilon}}\log C_m,
\]

which is the desired inequality.

## 3. Exceptional-set transfer

For fixed `epsilon>0`, let `E_epsilon(X)` count primitive triples `a+b=c`
with `c<=X` and `c>rad(abc)^(1+epsilon)`.

### Corollary 3.1

For fixed `m>=2`, put `eta=eta_{m,epsilon}` and

\[
  X_0=m^{3(1+\epsilon)/\epsilon}.
\]

Then for all `X>=X_0`,

\[
  E_\eta(X^m)
  \geq E_\epsilon(X)-E_\epsilon(X_0).
\]

#### Proof

The lift is injective for fixed `m`, because the positive integers `a` and `c`
are recovered uniquely as the positive `m`-th roots of `A_m` and `C_m`.
Theorem 2.2 applies to every input above the fixed threshold.

Thus a family of `epsilon`-exceptions forces a family of exceptions at the
explicitly smaller exponent `eta`.

## 4. A strict limitation for exceptional-set amplification

The preceding construction is a genuine quality-preserving lift, but it does
not by itself satisfy the amplification criterion currently used in the
repository.

### Theorem 4.1 (bounded-degree no-go on a dyadic shell)

Fix `X>1` and a height exponent `kappa>=1`.  Let the input satisfy

\[
  X\leq c\leq2X.
\]

If a power-difference lift also satisfies

\[
  C_m=c^m\leq X^\kappa,
\]

then

\[
  m\leq\kappa.
\]

Consequently only the integers

\[
  2\leq m\leq\lfloor\kappa\rfloor
\]

may occur.  The number of such outputs per input is at most
`floor(kappa)-1`, or twice this number if the symmetric construction obtained
by exchanging `a` and `b` is included.

#### Proof

Since `c>=X>1`,

\[
  X^m\leq c^m=C_m\leq X^\kappa.
\]

Strict monotonicity of `r -> X^r` for `X>1` gives `m<=kappa`.

In the notation of the exceptional-set amplification theorem, this mechanism
therefore has exponent

\[
  \beta=0.
\]

It cannot satisfy

\[
  \beta>\gamma+\kappa\alpha
\]

when `alpha>0` and `gamma>=0`.

### Consequence

The simple power-difference family is retained as an exact transfer theorem
between exceptional exponents, but it is eliminated as a stand-alone
power-saving amplification mechanism.  A successful amplification route must
produce polynomially many outputs at one fixed polynomial height scale, not
merely finitely many bounded-degree lifts.

## 5. Surviving refinements

The no-go theorem does not exclude:

1. a parameterized family containing polynomially many distinct maps of one
   fixed degree;
2. a correspondence on a modular or Hurwitz space whose fiber cardinality
   grows polynomially with the input height;
3. compositions whose overlap is much smaller than their number and whose
   effective height exponent remains bounded;
4. a lift in which the new factor `S_m(a,c)` is forced to have unusually small
   radical by additional arithmetic structure.

These refinements remain active until proved impossible or supplied with a
counterexample.
