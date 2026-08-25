# A cyclotomic auxiliary prime congruent to one modulo twelve

## 1. Purpose

The Legendre discriminant-section route is simplest when

\[
  \ell\equiv1\pmod{12},
\]

because then `Delta_Leg^((ell-1)/12)` is an integral section of
`omega^(ell-1)`.  At the same time, the two-inertia route requires an auxiliary
prime larger than a prescribed threshold and avoiding two positive local
inertia parameters.

This note gives a completely elementary selector satisfying all of these
conditions simultaneously.  It avoids Dirichlet's theorem and global Serre
exceptional-set estimates.

## 2. The twelfth cyclotomic value

Let

\[
  \Phi_{12}(X)=X^4-X^2+1.
\]

For a positive integer `M`, choose any prime divisor

\[
  \ell\mid\Phi_{12}(M).
\]

The identity

\[
  (X^4-X^2+1)(X^2+1)=X^6+1
\]

will determine the order of `M` modulo `ell`.

## 3. Exact order theorem

### Theorem 3.1

Assume

\[
  6\mid M.
\]

Every prime divisor `ell` of `Phi_12(M)` satisfies

\[
  \operatorname{ord}_\ell(M)=12,
\]

and hence

\[
  \ell\equiv1\pmod{12}.
\]

### Proof

First, `ell` divides neither `2` nor `3`.  Indeed, since `6|M`,

\[
  \Phi_{12}(M)\equiv1\pmod2,
  \qquad
  \Phi_{12}(M)\equiv1\pmod3.
\]

Also `ell` does not divide `M`, since the same polynomial is congruent to one
modulo every prime divisor of `M`.

In `F_ell`, the cyclotomic identity gives

\[
  M^6\equiv-1\pmod\ell,
\]

so

\[
  M^{12}\equiv1\pmod\ell.
\]

The order therefore divides `12` but does not divide `6`, because `ell` is
odd and `M^6` is `-1`, not `1`.  The only divisors of `12` which do not divide
`6` are `4` and `12`.

If the order were `4`, then `M^2\equiv-1\pmod\ell`, and

\[
  \Phi_{12}(M)
  =M^4-M^2+1
  \equiv1-(-1)+1
  \equiv3\pmod\ell.
\]

Since `ell` divides `Phi_12(M)`, this would force `ell=3`, already excluded.
Thus the order is exactly `12`.

Finally the order of an element of `F_ell^x` divides `ell-1`, so

\[
  12\mid\ell-1.
\]

## 4. Avoidance and threshold theorem

### Theorem 4.1

Let `B,m_1,m_2` be positive integers and put

\[
  M=6\,B!\,m_1m_2.
\]

Choose any prime divisor

\[
  \ell\mid\Phi_{12}(M).
\]

Then:

1. `ell>B`;
2. `ell` divides neither `m_1` nor `m_2`;
3. `ell` is congruent to `1` modulo `12`;
4. the explicit upper bound

   \[
     \ell\leq M^4-M^2+1<M^4+1
   \]

   holds.

### Proof

Theorem 3.1 gives the congruence.

If `ell<=B`, then primality implies `ell|B!`, hence `ell|M`.  But every prime
dividing `M` sees

\[
  \Phi_{12}(M)\equiv1\pmod\ell,
\]

contradicting `ell|Phi_12(M)`.  Thus `ell>B`.

The same argument applies if `ell|m_1` or `ell|m_2`, since both divide `M`.
The upper bound follows because a prime divisor of a positive integer is at
most that integer.

## 5. Quantitative consequence for abc inputs

Suppose the actual local inertia parameters satisfy

\[
  m_i\leq L\log c
\]

for one input-independent constant `L`, as in the odd/odd and corrected
odd/two-adic Frey boundary estimates.  At fixed threshold `B`, Theorem 4.1
gives

\[
  \log\ell
  \leq4\log(6B!m_1m_2)+O(1)
  =O_B(\log\log c).
\]

Consequently, for every `eta>0`, there exists `C_{B,L,eta}` independent of the
abc triple such that

\[
  \log\ell\leq\eta\log c+C_{B,L,\eta}.
\]

The selector therefore preserves the quantifier-correct sublinear prime bound
while adding the useful congruence `ell=1 mod 12`.

## 6. Research significance

This closes a compatibility problem between two previously separate routes:

- the local two-inertia/large-image construction needs a prime avoiding the
  inertia exponents;
- the stack-correct discriminant section needs an integral exponent
  `(ell-1)/12`.

The twelfth cyclotomic value supplies one prime satisfying both requirements.
The remaining source-facing inputs are the actual simultaneous local inertia
matrices and the global stack/Arakelov compensation theorem.

## 7. Formalization plan

Lean formalization is split into four lemmas:

1. positivity and the identity
   `(M^4-M^2+1)(M^2+1)=M^6+1`;
2. avoidance of every prime divisor of `M`;
3. exact multiplicative order `12` in `(ZMod ell)^x`;
4. the threshold, congruence, and upper-bound package.

The mathematical proof is complete here.  The branch will not be merged as a
Lean-verified result until these four lemmas pass the all-module kernel audit.
