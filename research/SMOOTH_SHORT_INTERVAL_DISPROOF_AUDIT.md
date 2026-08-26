# Audit of the smooth-short-interval disproof route

## 1. Scope

A recent preprint, N. A. Carella, *Note on the Exceptional Set in the ABC
Conjecture*, arXiv:2608.16764v2, claims an unconditional infinite family of
abc counterexamples. Since a valid proof would settle the conjecture in the
negative, this branch treats it as a serious independent route and audits the
argument theorem by theorem.

The construction starts with a large prime power

\[
  x=p^k,
\]

chooses a `y`-smooth integer

\[
  c\in[x,x+x^{3/5}],
\]

and sets

\[
  a=c-p^k,
  \qquad b=p^k.
\]

Because the chosen smoothness bound satisfies `y<p`, one has
`gcd(a,b,c)=1`. The intended radical estimate is

\[
  \operatorname{rad}(abc)
  \le x^{3/5+1/k+o(1)}.
\]

If established for infinitely many `x`, this would indeed disprove abc for
fixed positive `epsilon` satisfying

\[
  (3/5+1/k)(1+\epsilon)<1.
\]

The construction is therefore logically meaningful. The failure occurs in
the claimed control of the number of distinct prime factors of the smooth
integer `c`.

## 2. An exact conditional disproof criterion

### Theorem 2.1 (smooth neighbour criterion)

Fix real numbers `0<theta<1`, `delta>=0`, an integer `k>=2`, and
`epsilon>0` such that

\[
  (\theta+1/k+\delta)(1+\epsilon)<1.
\]

Suppose there are infinitely many primes `p` and integers `c` such that

\[
  p^k<c\le p^k+p^{k\theta},
  \qquad
  \gcd(p,c)=1,
  \qquad
  \operatorname{rad}(c)\le p^{k\delta}.
\]

Then the abc conjecture is false.

#### Proof

Put

\[
  a=c-p^k,
  \qquad b=p^k.
\]

Then `a+b=c`, and `gcd(a,b,c)=1`: indeed `gcd(b,c)=1` by hypothesis,
and every common divisor of `a` with `b` or `c` also divides the other one.
Moreover

\[
 \operatorname{rad}(a)\le a\le p^{k\theta},
 \qquad
 \operatorname{rad}(b)=p,
 \qquad
 \operatorname{rad}(c)\le p^{k\delta}.
\]

Hence

\[
  \operatorname{rad}(abc)
  \le p^{k\theta+1+k\delta}.
\]

On the other hand `c>p^k`, so

\[
 \operatorname{rad}(abc)^{1+\epsilon}
 \le p^{k(\theta+1/k+\delta)(1+\epsilon)}
 =o(p^k)<c.
\]

Thus infinitely many primitive triples violate the fixed-`epsilon` abc
inequality.

## 3. The fatal absolute-versus-relative error

Let

\[
 y=\exp\!\left(c_0(\log x)^{2/3}(\log\log x)^{4/3}\right),
 \qquad
 u=\frac{\log x}{\log y}.
\]

Then `u` tends to infinity. The Dickman--de Bruijn asymptotic is

\[
 \rho(u)=
 \exp\{-u(\log u+\log\log u-1+o(1))\}.
\]

In particular, for every fixed `A>0`,

\[
  u^A\rho(u)\longrightarrow0.
\]

The preprint uses the absolute Taylor estimate

\[
 \rho\!\left(u-\frac{\log p}{\log y}\right)
 =\rho(u)
 +O\!\left(
   \frac{\log p}{\log y}\,u^{-6}
  \right).
\]

Summing the error in the proposed first-moment computation gives

\[
 O(h/u^6),
\]

whereas the claimed main term is

\[
 h\rho(u)\log\log y.
\]

But

\[
 \frac{h/u^6}{h\rho(u)\log\log y}
 =\frac1{u^6\rho(u)\log\log y}
 \longrightarrow\infty.
\]

Thus the available error is larger than the proposed main term, not smaller.
The same defect occurs in the second-moment calculation. Consequently the
few-prime-factor selection and radical bound are not proved.

## 4. Saddle-point interpretation

If

\[
 \delta_p=\frac{\log p}{\log y},
\]

then the de Bruijn asymptotic predicts

\[
 \log\frac{\rho(u-\delta_p)}{\rho(u)}
 \approx \delta_p(\log u+\log\log u).
\]

Thus the conditional divisibility weight is tilted toward a factor of the form
`p^{-alpha}`, with `alpha<1`, rather than the unconditioned `1/p`. Conditioning
an integer near `x` on being `y`-smooth strongly biases it toward small prime
divisors. This explains why the asserted `log log y` moment is implausible.
The strict invalidation already follows from the error comparison above.

## 5. Additional defects and no-go results

1. A `y`-smooth integer may be squarefree, in which case `rad(c)=c`.
   Smoothness alone never implies the required radical bound.
2. Divisibility conditions rescale the short interval; the required theorem
   must be uniform at the rescaled base and length.
3. The same-exponent perfect-power repair is impossible. If `q>p`, then

   \[
     q^k-p^k\ge k p^{k-1},
   \]

   so a neighbour `q^k` forces `theta>=1-1/k` and violates the strict budget
   `theta+1/k+delta<1`.
4. The radical-small counting theorem in
   `RADICAL_SMALL_INTEGER_COUNTING.md` shows that

   \[
   \#\{n\le X:\operatorname{rad}(n)\le X^\delta\}
   \ll_\eta X^{\delta+\eta}.
   \]

   Hence any dense/all-centres prime-power construction must pay at least the
   corresponding radical exponent. For all prime `k`-th-power centres this
   forces `delta>=1/k`, and therefore `theta+2/k<1`.

## 6. Corrected open disproof target

The smooth-neighbour strategy remains logically alive in the following form.

### Target 6.1

Find fixed `theta<1`, `delta>=0`, and `k>=2` with

\[
  \theta+1/k+\delta<1,
\]

and prove that infinitely many prime powers `p^k` admit an integer `c` such
that

\[
 p^k<c\le p^k+p^{k\theta},
 \qquad
 \gcd(p,c)=1,
 \qquad
 \operatorname{rad}(c)\le p^{k\delta}.
\]

By Theorem 2.1 this would rigorously disprove abc.

Existing short-interval smooth-number theorems control the largest prime
factor. They do not currently supply the required radical bound in these
specially centred intervals. The new counting theorem also shows that any
successful construction must generally be sparse.

## 7. Route status

The specific Carella moment argument and the same-exponent perfect-power repair
are excluded by proved errors/no-go theorems. Dense radical-small-neighbour
constructions are constrained by a sharp counting barrier. The broader sparse
smooth-neighbour route remains active until Target 6.1 is contradicted or
proved.
