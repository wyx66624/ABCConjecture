# A Quantitative Kernel for the Mersenne Farey Swarm

**Author:** ChatGPT
**Date:** 3 September 2026
**Status:** unconditional harmonic and finite quantitative bridge; exact
counterexample to a strict universal prefix-coefficient improvement;
conditional frequent-subsequence transfer.  The base-two
super-Wieferich counting estimate and the abc conjecture remain open.

## 1. Purpose and scope

The denominator-entropy route writes a finite endpoint energy as a sum of
slopes `r/q`.  The preceding checkpoint proved the exact finite split

\[
 E\le E_{\le T}+E_{>T},\qquad
 E_{\le T}\le C_H\mathcal H_T,qquad
 E_{>T}\le \frac HT N_{>T},                         \tag{1.1}
\]

where

\[
 C_H=\sum_{1\le r<H}r,qquad
 \mathcal H_T=\sum_{1\le q\le T}\frac1q .          \tag{1.2}
\]

This note closes three parts of the paper-to-kernel gap.

1. It identifies `\mathcal H_T` with the classical harmonic number and
   proves its analytic upper bound in Lean.
2. It packages (1.1) into one quantitative swarm theorem with no asymptotic
   notation.
3. It proves the exact quantifier passage from failure of a little-oh
   estimate to a frequently occurring linear lower bound, and transports
   that lower bound through the finite theorem whenever the structural
   estimates hold eventually.
4. It replaces the unformalized prime-number-theorem estimate for the
   common-index scale by unconditional, kernel-checked Chebyshev brackets.
5. It maps every finite packet of actual prime, depth-three, exact-order
   endpoint rows injectively into the corresponding finite set of
   base-two super-Wieferich primes.

The note also tests the prefix estimate adversarially.  Full numerator
fibres attain equality, so no universal multiplicative coefficient smaller
than one can replace the coefficient in (1.1).  This is a counterexample to
that stronger auxiliary statement, not to the Mersenne route or to abc.

## 2. Harmonic identification and an explicit prefix budget

### Proposition 2.1 (harmonic identification)

For every integer `T>=0`,

\[
 \mathcal H_T=H_T^{\rm classical}.
\]

For `T>=1`,

\[
 \mathcal H_T\le 1+\log T.                          \tag{2.1}
\]

#### Proof

The classical definition is

\[
 H_T^{\rm classical}=\sum_{q=1}^{T}q^{-1},
\]

so the first identity is termwise.  For the second inequality, isolate the
term `q=1`.  Since `x\mapsto1/x` is decreasing on the positive real axis,

\[
 \sum_{q=2}^{T}\frac1q
 \le \int_1^T\frac{dx}{x}=\log T.
\]

Adding the isolated term proves (2.1).  This is the theorem
`harmonic_le_one_add_log` already available in Mathlib, after casting the
rational harmonic number to the reals.  \(\square\)

### Proposition 2.2 (square prefix budget)

Let every denominator fibre `R_q` be contained in
`{1,...,H-1}`.  If `T>=1`, then

\[
 E_{\le T}\le H^2(1+\log T).                        \tag{2.2}
\]

#### Proof

The exact numerator capacity is

\[
 C_H=\frac{H(H-1)}2\le H^2.
\]

Both factors in (1.1) are nonnegative.  Proposition 2.1 therefore gives

\[
 E_{\le T}\le C_H\mathcal H_T
 \le H^2(1+\log T).
\]

The deliberately weaker `H^2` form avoids every integer-division side
condition and is enough for the asymptotic choice of a smaller positive
power.  \(\square\)

### Proposition 2.3 (unconditional common-index scale bracket)

Let

\[
 M_n=\operatorname{lcm}(1,\ldots,n).
\]

Then for every `n>=0`,

\[
 n\log2-\log(n+1)
 \le \log M_n
 \le (\log4+4)n.                                    \tag{2.3}
\]

#### Proof

Mathlib identifies `log M_n` with Chebyshev's function `psi(n)`.  The
elementary binomial-coefficient argument

\[
 2^n\le(n+1)M_n
\]

gives the lower bound after taking logarithms.  Mathlib's explicit
Chebyshev estimate

\[
 \psi(x)\le(\log4+4)x\qquad(x\ge0)
\]

gives the upper bound.  Thus the logarithmic common-index scale is already
linear up to absolute constants without invoking the prime number theorem.
The sharper ratio `log M_n/n -> 1` used for the numerical constant in the
old countermodel remains outside this result.  \(\square\)

## 3. The finite quantitative swarm theorem

### Theorem 3.1 (cleared quantitative swarm)

Let `A,epsilon,kappa,E` be real numbers and let `T,Q,H` be natural
numbers.  Suppose:

1. `T>0`;
2. all prefix fibres lie in `{1,...,H-1}`;
3. every numerator in a tail fibre is at most `H`;
4. `epsilon A <= E`;
5. `E <= E_{<=T}+E_{>T}`;
6. `H^2(1+log T) <= kappa A`.

Then

\[
 T(\varepsilon-\kappa)A\le N_{>T}H.                \tag{3.1}
\]

In particular, if `A>0`, `H>0`, and `0<=kappa<epsilon`, then

\[
 N_{>T}\ge
 \frac{T(\varepsilon-\kappa)A}{H}.                 \tag{3.2}
\]

#### Proof

Proposition 2.2 and assumption 6 give

\[
 E_{\le T}\le\kappa A.
\]

Assumptions 4 and 5 now imply

\[
 (\varepsilon-\kappa)A
 \le E_{>T}.
\]

The tail estimate in (1.1) yields

\[
 (\varepsilon-\kappa)A
 \le\frac HTN_{>T}.
\]

Multiplication by the positive integer `T` proves (3.1).  Division by the
positive integer `H` proves (3.2).  \(\square\)

Both forms are kernel checked: `quantitativeSwarm_cleared` proves (3.1),
and `quantitativeSwarm_count_lower` proves the divided form (3.2) under
the displayed positivity assumption on `H`.

This theorem is the exact finite algebra behind the exponent gain in the
swarm argument.  The arithmetic work still required is to produce enough
actual endpoint rows satisfying primality, exact order and depth at least
three, and then to bound the resulting primes globally.

### Proposition 3.2 (finite exact-order rows enter the actual prime count)

For `X>=0`, define

\[
 \mathcal W_3(X)=\{p\le X:p\text{ is prime and }
 p^3\mid 2^{p-1}-1\}.
\]

Fix a common index `m` and a finite set `S` of actual endpoint rows.  Each
row carries a prime coordinate `p`, a divisor coordinate `d`, the exact
order identity `ord_p(2)=d`, and `d\mid m`.  Suppose, for every `x` in `S`,

\[
 p_x\text{ is prime},\qquad p_x^3\mid2^{d_x}-1,
 \qquad p_x\le X.                                  \tag{3.3}
\]

Then

\[
 |S|\le |\mathcal W_3(X)|.                          \tag{3.4}
\]

#### Proof

The exact-order endpoint transport theorem gives

\[
 p_x^3\mid2^{p_x-1}-1,
\]

so (3.3) sends every row into `\mathcal W_3(X)`.  If two rows have the same
prime coordinate, exact multiplicative order forces their divisor
coordinates to agree; proof irrelevance then identifies the rows.  Thus the
prime-coordinate map is injective.  Restricting that injection to `S` and
comparing finite cardinalities proves (3.4).  \(\square\)

This proposition closes the row-to-actual-prime bookkeeping for any finite
packet whose three arithmetic premises have already been proved.  It does
not prove that abstract Farey rows satisfy those premises, nor does it
estimate `|\mathcal W_3(X)|`.

## 4. Failure of little-oh and the sequence quantifiers

Write `Frequently(P_m)` for

\[
 \forall N\ \exists m\ge N:\ P_m.
\]

### Proposition 4.1 (exact failure witness)

Let `f,g:N->R` be nonnegative.  Then

\[
 f\ne o(g)
 \quad\Longleftrightarrow\quad
 \exists\varepsilon>0:\
 \operatorname{Frequently}(\varepsilon g(m)<f(m)). \tag{4.1}
\]

#### Proof

By definition, `f=o(g)` means that for every `epsilon>0`, eventually

\[
 |f(m)|\le\varepsilon|g(m)|.
\]

Nonnegativity removes the absolute values.  Negating the universal
quantifier produces one `epsilon>0` for which the displayed inequality is
not eventual.  The negation of an eventual inequality is precisely the
frequent strict reverse inequality.  Reversing this argument proves the
converse.  \(\square\)

### Theorem 4.2 (frequent swarm transfer)

Fix `epsilon,kappa`.  Suppose

\[
 \operatorname{Frequently}(\varepsilon A_m<E_m),  \tag{4.2}
\]

and suppose all six structural hypotheses of Theorem 3.1, with
`kappa A_m` as the prefix budget, hold eventually.  Then

\[
 \operatorname{Frequently}
 \left(T_m(\varepsilon-\kappa)A_m
       \le N_{>T_m}(m)H_m\right).                  \tag{4.3}
\]

#### Proof

The intersection of a frequent set with an eventual set is frequent.  At
each index in that intersection, replace the strict inequality in (4.2) by
its weak form and apply Theorem 3.1.  \(\square\)

Combining Propositions 4.1 and Theorem 4.2 gives a kernel-level version of
the paper's statement “failure of little-oh forces a swarm along an
unbounded subsequence.”  It does not manufacture any of the eventual
arithmetic or scale estimates: those remain named premises.

## 5. Exact counterexample to a stronger prefix claim

For a fixed `H`, take the full fibre

\[
 R_q=\{1,\ldots,H-1\}
\]

at every denominator.  Then each fibre attains its entire numerator
capacity, and hence

\[
 E_{\le T}=C_H\mathcal H_T.                         \tag{5.1}
\]

Consequently the following proposed strengthening is false:

> There exists a real `c<1` such that, for every admissible finite family,
> `E_{<=T} <= c C_H H_T`.

Indeed take `T=1` and `H=2`.  The fibre is `{1}`, and every factor in (5.1)
equals one.  The proposed inequality becomes `1<=c`, contradicting `c<1`.
Every premise of the proposed strengthening is satisfied.

This counterexample proves that any further gain must use arithmetic
structure absent from arbitrary denominator fibres: primality, exact order,
depth, or correlation between different fibres.  It does not justify
abandoning the denominator-entropy route.

## 6. Remaining arithmetic gate

The formalized conclusions stop before the open statement

\[
 \limsup_{x\to\infty}
 \frac{\log\max\{1,W_3(x)\}}{\log\log x}\le\frac12.
\]

They also do not prove that an arbitrary abstract tail row is an actual
base-two super-Wieferich prime.  Proposition 3.2 now bundles depth transport,
injectivity and finite cardinality comparison for rows that are already
actual exact-order endpoints.  A future all-in-one arithmetic packet must
connect the frequent swarm of Theorem 4.2 to such rows, establish their
three arithmetic premises, and then attack the displayed counting bound.

No counterexample to that counting bound, to the Mersenne endpoint
statement, or to the standard abc conjecture is claimed here.
