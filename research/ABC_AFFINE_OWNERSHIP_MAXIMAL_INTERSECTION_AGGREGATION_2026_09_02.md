# Ownership-preserving maximal-intersection aggregation in the affine catalogue

**Author:** ChatGPT
**Date:** 2026-09-02
**Status:** unconditional finite aggregation theorems and exact adversarial
boundaries; the final arithmetic comparison remains open

## 1. Scope and inherited notation

This note continues the canonical affine-catalogue route developed in
`ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md`.  It does not
prove the abc conjecture.  It resolves the specific combinatorial problem of
compressing the non-arm pair cover without losing ownership, and converts the
result into a normalized global energy inequality.  Proving that the strict
reverse of that inequality holds for every hypothetical exceptional affine
selection is still open.

Let \(X\) be a finite selected set of canonical parameter points in a square
of side difference \(N\).  A point \(x\) has powerful-kernel triple
\(\kappa(x)=(k_U(x),k_V(x),k_W(x))\).  Coordinatewise divisibility is denoted
by \(\preceq\), and coordinatewise gcd by \(\gcd_{\rm coord}\).  A large label
is a divisor triple

\[
 \lambda=(d_U,d_V,d_W)\preceq\kappa(x),\qquad
 D_\lambda=d_Ud_Vd_W>N^2,
\]

with weight \(w_\lambda=\varphi(d_U)\varphi(d_V)\varphi(d_W)\).  Its occupancy
is \(n_\lambda\).  Every repeated large label has a unique supporting affine
line.  On a non-arm line with primitive direction \((s,t)\), put

\[
 A=(A_U,A_V,A_W)=(s,s+Ct,s+Bt),
 \qquad
 T_\lambda=\prod_Z\frac{d_Z}{\gcd(d_Z,|A_Z|)}.
\]

The non-arm inverse-period mass and shifted energy are

\[
 S_{\rm non}=\sum_{\lambda\ {\rm repeated,nonarm}}
                  \frac{w_\lambda}{T_\lambda^2},\qquad
 E_{\rm non}=\sum_{\lambda\ {\rm repeated,nonarm}}
                  w_\lambda(n_\lambda-1)^3.             \tag{1.1}
\]

The signed-ray capacity theorem gives, term by term,

\[
 (n_\lambda-1)^3T_\lambda^2<KN,
 \qquad K=(B+1)(C+1).                                   \tag{1.2}
\]

The strict sign in (1.2) comes from the strict count of available nonzero
steps on a ray inside a side-\(N\) box; it is not a rounding convention.
Multiplication by \(w_\lambda/T_\lambda^2>0\) and summation over the exact
domain in (1.1) gives

\[
                         E_{\rm non}<KN S_{\rm non}       \tag{1.3}
\]

whenever that domain is nonempty.  Both sides are zero when it is empty.

We also retain the global quantities

\[
 W=\sum_{\lambda\in\mathcal L}w_\lambda,
 \quad J=\sum_{\lambda\in\mathcal L}w_\lambda(n_\lambda-1)
       =A_1+\Omega,
 \quad W=A_0-\Omega,                                    \tag{1.4}
\]

and weighted Hölder inequality

\[
                             J^3\le W^2E_{\rm sh}.        \tag{1.5}
\]

Here and below every sum states its domain explicitly.  In particular, the
notation \(W_{\rm repeated}\), when used, means
\(\sum_{\lambda\in\mathcal L:\,n_\lambda\ge2}w_\lambda\).

## 2. Divisibility-maximal exact pair tops

For distinct \(x,y\in X\), define their exact pair top

\[
                 \gamma(x,y)=\gcd_{\rm coord}(\kappa(x),\kappa(y)).
\]

Let \(\Gamma\) be the set of distinct values \(\gamma(x,y)\) for which
\(\prod_Z\gamma_Z(x,y)>N^2\) and the line through \(x,y\) is non-arm.  Let
\(\mathcal M\) be the set of divisibility-maximal elements of the finite
poset \((\Gamma,\preceq)\).  Elements of \(\mathcal M\) are called maximal
intersection tops.  For \(\mu\in\mathcal M\), define

\[
 \operatorname{Supp}(\mu)=\{x\in X:\mu\preceq\kappa(x)\},
 \qquad r_\mu=|\operatorname{Supp}(\mu)|.                \tag{2.1}
\]

### Proposition 2.1 (maximal cover without arm migration)

Every repeated non-arm large label \(\lambda\) divides at least one
\(\mu\in\mathcal M\).  The unique line supporting \(\mu\) is the unique line
supporting \(\lambda\).  In particular, global maximalization cannot move a
non-arm label to an arm.

#### Proof

Choose two distinct points supporting \(\lambda\).  Their exact gcd top
\(\gamma\) contains \(\lambda\), so its coordinate product is greater than
\(N^2\).  The two points lie on the unique line of \(\lambda\), which is
non-arm; hence \(\gamma\in\Gamma\).  A finite poset has a maximal element
\(\mu\in\mathcal M\) above \(\gamma\).

The triple \(\mu\) is itself a large label: a coordinatewise gcd of powerful
integers is powerful, it divides the kernels of a realizing pair, and its
product exceeds \(N^2\).  A realizing pair for \(\mu\) also supports
\(\lambda\), because \(\lambda\preceq\gamma\preceq\mu\).  Thus its line is
the unique large-label line of \(\lambda\).  This is the same non-arm line as
the original pair.  ∎

### Proposition 2.2 (all support pairs realize the maximal top)

For \(\mu\in\mathcal M\), one has \(r_\mu\ge2\).  If distinct
\(x,y\in\operatorname{Supp}(\mu)\), then

\[
                         \gamma(x,y)=\mu.                \tag{2.2}
\]

#### Proof

A realizing pair gives \(r_\mu\ge2\).  Any two distinct support points have
exact top \(\gamma(x,y)\succeq\mu\).  Since they support the large label
\(\mu\), large-label line uniqueness puts them on the non-arm line of
\(\mu\); hence \(\gamma(x,y)\in\Gamma\).  Maximality gives
\(\gamma(x,y)\preceq\mu\), proving equality.  ∎

### Corollary 2.3 (a linear support hypergraph)

If \(\mu,\nu\in\mathcal M\) are distinct, then

\[
 |\operatorname{Supp}(\mu)\cap\operatorname{Supp}(\nu)|\le1.          \tag{2.3}
\]

Consequently

\[
             \sum_{\mu\in\mathcal M}\binom{r_\mu}{2}
             \le\binom{|X|}{2}.                         \tag{2.4}
\]

#### Proof

If two distinct support points belonged to both supports, their exact pair
top would equal \(\mu\) and \(\nu\) by Proposition 2.2.  This is impossible
when \(\mu\ne\nu\).  Thus the unordered two-subsets contributed by the
different supports are disjoint subsets of \(\binom X2\), and (2.4) follows.
∎

This is an actual codegree-one statement.  It is stronger than merely saying
that the maximal tops form a divisibility antichain.

### Proposition 2.4 (the reduced class skeleton has the same maxima)

Let \(\Gamma_{\rm sk}\) be the class-support skeleton of the predecessor
report: one loop for every kernel class of multiplicity at least two, and
one edge for every pair of singleton classes, retaining only large non-arm
tops.  Then \(\Gamma_{\rm sk}\subseteq\Gamma\), it is divisibility-cofinal in
\(\Gamma\), and

\[
                    \operatorname{Max}(\Gamma_{\rm sk})
                    =\operatorname{Max}(\Gamma).         \tag{2.5}
\]

#### Proof

Loops and singleton-pair edges are actual point pairs, so
\(\Gamma_{\rm sk}\subseteq\Gamma\).  Let \(\gamma\in\Gamma\) come from a
pair of kernel classes.  If both classes are singletons, their skeleton edge
has top \(\gamma\).  Otherwise one endpoint lies in a class \(\kappa\) of
multiplicity at least two.  Then \(\gamma\preceq\kappa\).  Every point in
that class supports the large label \(\gamma\), so its chosen loop lies on
the unique non-arm line of \(\gamma\).  Its top \(\kappa\) is large and is a
skeleton element dominating \(\gamma\).  Thus the skeleton is cofinal.

In any finite poset, a cofinal subset has the same maximal elements as the
whole poset.  Indeed, a maximal whole-poset element is dominated by a subset
element and hence equals it.  Conversely, if a subset-maximal element is
dominated in the whole poset, cofinality supplies a subset element above the
dominator; subset maximality and antisymmetry force all three elements to be
equal.  This proves (2.5).  ∎

Thus pair saturation may be used for the transparent support proof without
reintroducing a pair-count loss: after maximalization it gives exactly the
same top values as the sparse class skeleton.

## 3. Ownership and the exact catalogue direction

Fix a total order on \(\mathcal M\).  For every repeated non-arm label
\(\lambda\), let \(o(\lambda)\) be the least maximal top divisible by
\(\lambda\).  Proposition 2.1 makes this definition total.  Write

\[
 \begin{aligned}
 \mathcal O_\mu&=\{\lambda:\lambda\text{ is repeated non-arm and }
                                  o(\lambda)=\mu\},\\
 S_\mu&=\sum_{\lambda\in\mathcal O_\mu}
                    \frac{w_\lambda}{T_\lambda^2},\\
 E_\mu&=\sum_{\lambda\in\mathcal O_\mu}
                    w_\lambda(n_\lambda-1)^3.
 \end{aligned}                                          \tag{3.1}
\]

The owner sets are disjoint and cover precisely the summation domain in
(1.1).  Therefore

\[
               S_{\rm non}=\sum_{\mu\in\mathcal M}S_\mu,
 \qquad       E_{\rm non}=\sum_{\mu\in\mathcal M}E_\mu. \tag{3.2}
\]

For a top \(\mu\), let \(Q(\mu)\) be the exact threshold pair catalogue on
its unique line:

\[
 Q(\mu)=\sum_{\substack{d\preceq\mu\\D_d>N^2}}
                     \frac{w_d}{T_d^2}.                 \tag{3.3}
\]

Every period in (3.3) is computed using the line of \(\mu\).  Let
\(B_\mu\) be any nonnegative **owned** cap with the coverage direction

\[
                              S_\mu\le B_\mu.             \tag{3.4}
\]

A sufficient, owner-independent way to obtain (3.4) is
\(S_\mu\le Q(\mu)\le B_\mu\).  For example, the proved pair-catalogue
theorem permits the three-term minimum

\[
 B_\mu=\min\left\{
 F(\mu,A_\mu),\frac{C_\mu^2G_\mu}{N^4},
                       \frac{C_\mu^2H(G_\mu)}{N^2}\right\},            \tag{3.5}
\]

where \(G_\mu=\prod_Z\mu_Z\),
\(C_\mu=\prod_Z\gcd(\mu_Z,|A_{\mu,Z}|)\), and \(F\) and \(H\) are the
exact Euler and divisor factors from the preceding report.  Tree subtraction
in Proposition 5.4 instead constructs smaller caps that majorize the owned
catalogue directly.  The inequality direction in (3.4) matters in both
cases.

### Lemma 3.1 (support and period monotonicity)

If \(\lambda\in\mathcal O_\mu\), then

\[
 n_\lambda\ge r_\mu,
 \qquad T_\lambda\mid T_\mu.                            \tag{3.6}
\]

Moreover \(\mu\in\mathcal O_\mu\); hence no owner set is empty.

#### Proof

The divisibility \(\lambda\preceq\mu\) gives
\(\operatorname{Supp}(\mu)\subseteq\operatorname{Supp}(\lambda)\), so
the occupancy inequality follows.  On the common line, for each coordinate
and integers \(d\mid m\), valuation comparison gives

\[
 \frac d{\gcd(d,a)}\ \bigm|\ \frac m{\gcd(m,a)}.
\]

Multiplying the three coordinate divisibilities proves
\(T_\lambda\mid T_\mu\).  Finally, if a maximal top \(\nu\) is divisible by
\(\mu\), maximality forces \(\nu=\mu\).  Thus \(\mu\) has exactly one
eligible owner and belongs to \(\mathcal O_\mu\).  ∎

The correct period direction in (3.6) does **not** give an upper bound on
\(T_\lambda^{-2}\) by \(T_\mu^{-2}\).  Section 8 gives an actual canonical
example with \(T_\lambda=1<T_\mu=3\).

## 4. The ownership Cauchy inequality

Define the support-normalized catalogue pressure

\[
                  \mathcal H_3=
                  \sum_{\mu\in\mathcal M}
                    \frac{B_\mu}{(r_\mu-1)^3}.           \tag{4.1}
\]

Every denominator is positive by Proposition 2.2.

### Theorem 4.1 (ownership-preserving catalogue aggregation)

With the exact summation domains (1.1), (3.1), and (4.1),

\[
                         \boxed{S_{\rm non}^2
                         \le E_{\rm non}\mathcal H_3.}   \tag{4.2}
\]

#### Proof

Fix \(\mu\in\mathcal M\).  The owned-cap premise gives

\[
                              S_\mu\le B_\mu.             \tag{4.3}
\]

For the full-catalogue choice (3.5), this follows from the more explicit
chain \(S_\mu\le Q(\mu)\le B_\mu\), because every owned label divides
\(\mu\) and is evaluated on the same line.

Also \(T_\lambda\ge1\), and Lemma 3.1 gives
\((n_\lambda-1)^3\ge(r_\mu-1)^3\).  Therefore

\[
 S_\mu\le\sum_{\lambda\in\mathcal O_\mu}w_\lambda
       \le\frac{E_\mu}{(r_\mu-1)^3}.                    \tag{4.4}
\]

Multiplying the two nonnegative bounds (4.3) and (4.4) yields

\[
 S_\mu^2\le E_\mu\frac{B_\mu}{(r_\mu-1)^3}.             \tag{4.5}
\]

Cauchy--Schwarz is now applied over the finite index set
\(\mathcal M\), not over labels or point pairs:

\[
 \begin{aligned}
 S_{\rm non}^2
 &=\left(\sum_{\mu\in\mathcal M}S_\mu\right)^2\\
 &\le\left(\sum_{\mu\in\mathcal M}E_\mu\right)
       \left(\sum_{\mu\in\mathcal M}
          \frac{B_\mu}{(r_\mu-1)^3}\right)
 =E_{\rm non}\mathcal H_3,
 \end{aligned}
\]

where the last equality uses the owner partition (3.2).  ∎

### Theorem 4.2 (strict ray closure and global upper energy)

Put \(c=KN\).  Then

\[
 S_{\rm non}\le c\mathcal H_3,
 \qquad E_{\rm non}\le c^2\mathcal H_3.                 \tag{4.6}
\]

If the non-arm domain is nonempty, both inequalities in (4.6) are strict.
If

\[
 \mathcal A_{\rm arm}=\frac1{N^3}\sum_\kappa L_\kappa
  \left(k_U(\kappa)^3+\frac{k_V(\kappa)^3}{C^3}
                         +\frac{k_W(\kappa)^3}{B^3}\right),            \tag{4.7}
\]

then

\[
                         \boxed{E_{\rm sh}
                         \le c^2\mathcal H_3+\mathcal A_{\rm arm}.}    \tag{4.8}
\]

#### Proof

When the non-arm domain is empty, \(S_{\rm non}=E_{\rm non}=0\), so (4.6)
is immediate.  Otherwise all summands in \(S_{\rm non}\) are positive, so
\(S_{\rm non}>0\).  Combine (4.2) with the strict ray sum (1.3):

\[
 S_{\rm non}^2\le E_{\rm non}\mathcal H_3
                 <cS_{\rm non}\mathcal H_3.
\]

Division by the positive number \(S_{\rm non}\) gives the first strict
inequality in (4.6); inserting it into (1.3) gives the second.  The three
proved arm caps give \(E_{\rm arm}\le\mathcal A_{\rm arm}\).  Since
\(E_{\rm sh}=E_{\rm non}+E_{\rm arm}\), (4.8) follows.  ∎

### Corollary 4.3 (the normalized maximal-top gate)

If \(W>0\), every selected canonical configuration satisfies

\[
 \boxed{
 \left(\frac JW\right)^3
 \le c^2\frac{\mathcal H_3}{W}
       +\frac{\mathcal A_{\rm arm}}W.}                  \tag{4.9}
\]

Consequently the strict reverse of (4.9) is a sufficient contradiction.

#### Proof

Combine weighted Hölder inequality (1.5) with (4.8), then divide by \(W^3>0\).  ∎

This is the promised reversal of the normalized global-energy bookkeeping:
the raw sum over skeleton edges is replaced by one owned pressure term per
maximal exact top, with a cubic support denominator.  No assertion is made
here that the strict reverse always holds; its remaining arithmetic content
is isolated in Sections 5 and 9.

### Proposition 4.4 (full-catalogue multiplicity is paid by energy)

The complete maximal-top catalogues satisfy the unconditional global bound

\[
                  \boxed{\sum_{\mu\in\mathcal M}Q(\mu)
                  \le E_{\rm non}.}                    \tag{4.10}
\]

Consequently, if the exact caps \(B_\mu=Q(\mu)\) are used, then

\[
             \mathcal H_3\le\sum_{\mu\in\mathcal M}Q(\mu)
             \le E_{\rm non}.                           \tag{4.11}
\]

#### Proof

For a repeated non-arm label \(\lambda\), let

\[
 m_\lambda=
 \#\{\mu\in\mathcal M:\lambda\preceq\mu\}.            \tag{4.12}
\]

Every catalogue term in every \(Q(\mu)\) is an actual repeated non-arm
label: it divides the top, and the realizing pair of the top supports it on
the same unique line.  Conversely its period in \(Q(\mu)\) is therefore its
global period \(T_\lambda\).  Thus, with no omitted or enlarged summation
domain,

\[
 \sum_{\mu\in\mathcal M}Q(\mu)
 =\sum_{\lambda\ {\rm repeated,nonarm}}
       \frac{w_\lambda}{T_\lambda^2}m_\lambda.          \tag{4.13}
\]

For each top counted by \(m_\lambda\), choose one realizing unordered point
pair.  It lies in the \(n_\lambda\)-point support of \(\lambda\).  This choice
is injective in the top: one point pair has one exact gcd top, and by
Proposition 2.2 that top is the chosen maximal element.  Hence

\[
                       m_\lambda\le\binom{n_\lambda}{2}. \tag{4.14}
\]

For every integer \(n\ge2\),

\[
 \frac1{T^2}\binom n2\le\binom n2
       \le(n-1)^3,\qquad T\ge1;                         \tag{4.15}
\]

the second inequality is equivalent to
\(n\le2(n-1)^2\).  Multiply (4.14)--(4.15) by the
nonnegative weight and sum over exactly the domain in (4.13).  The result is
(4.10).  Since \(r_\mu\ge2\), division by \((r_\mu-1)^3\) can only decrease
each \(Q(\mu)\), proving (4.11).  ∎

This theorem removes a possible hidden singleton/catalogue multiplicity:
all reuse of one label by distinct maximal tops is charged to distinct
support pairs.  It does not by itself close the gate, because the right side
is the energy being bounded.  Section 8.4 gives a canonical equality boundary, while Section 8.5 gives an
abstract ledger equality boundary.  A strict improvement therefore requires
additional canonical geometry or catalogue sparsity.

## 5. Catalogue inflation eliminates raw top multiplicity

Let

\[
 w_\mu=\prod_Z\varphi(\mu_Z),\qquad
 \beta_\mu=\frac{B_\mu}{w_\mu},\qquad
 \beta_* =\max_{\mu\in\mathcal M}\beta_\mu              \tag{5.1}
\]

when \(\mathcal M\ne\varnothing\), and put \(\beta_*=0\) otherwise.

### Proposition 5.1 (top-weight compression)

One has

\[
 \mathcal H_3
 =\sum_{\mu\in\mathcal M}
       \frac{\beta_\mu w_\mu}{(r_\mu-1)^3}
 \le\beta_*\sum_{\mu\in\mathcal M}w_\mu
 \le\beta_*W.                                           \tag{5.2}
\]

Thus the easier, but weaker, normalized necessary condition is

\[
             \left(\frac JW\right)^3
             \le (KN)^2\beta_*+\frac{\mathcal A_{\rm arm}}W.           \tag{5.3}
\]

#### Proof

Every \(r_\mu\ge2\), so \((r_\mu-1)^{-3}\le1\).  The maximal tops are
distinct large labels, and their weights therefore form a sub-sum of the
deduplicated union weight \(W\).  This proves (5.2); insert it into (4.9) to
obtain (5.3).  ∎

When \(B_\mu\) is chosen no larger than the full Euler cap, the Euler formula
also gives an elementary bound for each inflation factor.
Indeed

\[
 F(\mu_Z,A_Z)=\sum_{d\mid\mu_Z}
        \varphi(d)\frac{\gcd(d,|A_Z|)^2}{d^2}
 \le\sum_{d\mid\mu_Z}\varphi(d)=\mu_Z.
\]

Hence

\[
 B_\mu\le F(\mu,A_\mu)\le G_\mu,
 \qquad
 \beta_\mu\le\frac{G_\mu}{w_\mu}
 =\prod_Z\frac{\mu_Z}{\varphi(\mu_Z)}.                  \tag{5.4}
\]

Formula (5.4) is only a fallback.  The exact minimum (3.5), divided by
\(w_\mu\), retains capture and the strict large tail and is usually much
smaller.  A universal claim \(B_\mu\le w_\mu\) is false even for the abstract
maximal-owner axioms; Section 8 gives equality-sharp certificates.

### Theorem 5.2 (one pairwise-coprime envelope per direction)

Let \(\mathscr D\) be the finite set of directions of maximal tops.  For
\(\alpha\in\mathscr D\), let \(\mathcal M_\alpha\) be the maximal tops on
that direction and put

\[
 K_{\alpha,Z}=\operatorname{lcm}_{\mu\in\mathcal M_\alpha}\mu_Z.
                                                               \tag{5.5}
\]

Define the pairwise-coprime threshold envelope

\[
 \widehat Q^{\rm pc}_\alpha=
 \sum_{\substack{d_Z\mid K_{\alpha,Z}\ (Z=U,V,W)\\
                   D_d>N^2,\ \gcd(d_Z,d_{Z'})=1\ (Z\ne Z')}}
       \frac{w_d}{T_d(A_\alpha)^2}.                       \tag{5.6}
\]

Then the **deduplicated** non-arm mass satisfies

\[
                  \boxed{S_{\rm non}
                  \le\sum_{\alpha\in\mathscr D}
                         \widehat Q^{\rm pc}_\alpha.}     \tag{5.7}
\]

This cover counts every real label once before it is enlarged; it does not
sum overlapping rectangular catalogues of different tops.

For \(e_{pZ}=v_p(K_{\alpha,Z})\), define

\[
 \begin{aligned}
 \widehat F^{\rm pc}_\alpha
 &=\prod_p\left[1+\sum_Z
   \bigl(F(p^{e_{pZ}},|A_{\alpha,Z}|)-1\bigr)\right],\\
 W^{\rm pc}(K_\alpha)
 &=\prod_p\left[1+\sum_Z(p^{e_{pZ}}-1)\right],\\
 H^{\rm pc}(K_\alpha)
 &=\prod_p\left[1+\left(1-\frac1p\right)
                         \sum_Ze_{pZ}\right],\\
 C_\alpha&=\prod_Z\gcd(K_{\alpha,Z},|A_{\alpha,Z}|).
 \end{aligned}                                            \tag{5.8}
\]

Empty prime-power entries have \(F(1,a)=1\).  The envelope has the explicit
three-way upper cap

\[
 \boxed{
 \widehat Q^{\rm pc}_\alpha\le
 \min\left\{\widehat F^{\rm pc}_\alpha,
       \frac{C_\alpha^2W^{\rm pc}(K_\alpha)}{N^4},
       \frac{C_\alpha^2H^{\rm pc}(K_\alpha)}{N^2}\right\}.}           \tag{5.9}
\]

#### Proof

Every actual label has pairwise-coprime coordinates because it divides the
three pairwise-coprime arms at any one of its supporting points.  By
Proposition 2.1 it divides an owner top of the same direction, hence it
divides \(K_\alpha\) coordinatewise and occurs in (5.6).  The real label
sets for distinct directions are disjoint by large-label line uniqueness.
This proves the ownership-preserving cover (5.7).

For one prime \(p\), pairwise coprimality permits a positive exponent in at
most one coordinate.  The choices are therefore: use no \(p\), or choose
one coordinate \(Z\) and one exponent between \(1\) and \(e_{pZ}\).  The
local inverse-period sum is exactly the first factor in (5.8).  Multiplying
over primes and dropping the threshold proves the first term of (5.9).

The same local choice, without inverse periods, has total totient weight

\[
 1+\sum_Z\sum_{j=1}^{e_{pZ}}\varphi(p^j)
 =1+\sum_Z(p^{e_{pZ}}-1),
\]

which gives \(W^{\rm pc}\).  For any summand let
\(C_d=\prod_Z\gcd(d_Z,|A_{\alpha,Z}|)\).  Then
\(C_d\le C_\alpha\), while \(D_d>N^2\) gives
\(T_d=D_d/C_d>N^2/C_\alpha\).  Thus
\(T_d^{-2}<C_\alpha^2/N^4\), and summing proves the second term.

Alternatively,

\[
 \frac{w_d}{T_d^2}=\frac{w_dC_d^2}{D_d^2}
 <\frac{C_\alpha^2}{N^2}\frac{w_d}{D_d}.
\]

The local sum of \(w_d/D_d\) is

\[
 1+\sum_Z\sum_{j=1}^{e_{pZ}}
       \frac{\varphi(p^j)}{p^j}
 =1+\left(1-\frac1p\right)\sum_Ze_{pZ},
\]

which proves the third term.  ∎

There is also a useful capture form in the canonical consecutive-coefficient
setting \(C=B+1\).  Let
\(Q_\alpha=\lfloor N/L_\alpha\rfloor\), and remove the primes of
\(R=\operatorname{rad}(BC)\) from the direction coefficients.  Their three
remaining parts are pairwise coprime: the first two pairwise gcds divide
\(C\) and \(B\), respectively, while the third divides \(C-B=1\).  For a
prime \(p\), at most one
coordinate contributes a captured power to (5.8).  Every uncaptured prime
in \(K_\alpha\) occurs in the residual quotient of some realizing top and
hence satisfies \(p\le Q_\alpha\).  The primewise formula gives

\[
 \widehat F^{\rm pc}_\alpha
 \le P_{0,\alpha}\prod_{p\le Q_\alpha}\left(1+\frac3p\right)
 \ll P_{0,\alpha}\log^3(2Q_\alpha),                    \tag{5.10}
\]

where \(P_{0,\alpha}=\prod_Z|A_{\alpha,Z}|^{(R)}\).  The first inequality is
elementary: after extracting the unique captured factor \(p^b\), the three
possible coordinate contributions are at most
\(p^b(1+3/p)\).  The second is the standard Mertens product estimate, using
\(1+3/p\le(1-1/p)^{-3}\).

Combining (5.7), (5.10), and the corrected excess-filtered coefficient count
from Section 6 yields

\[
 S_{\rm non}\ll
 K\log^3(2N)\min\{N^5,CN^{29/6}\}.                     \tag{5.11}
\]

The exact minimum (5.9) should be used instead of (5.10) whenever its strict
tail terms are smaller.

### Corollary 5.3 (two complementary global-energy caps)

Put

\[
                  \widehat Q_{\rm dir}
                  =\sum_{\alpha\in\mathscr D}
                          \widehat Q^{\rm pc}_\alpha.     \tag{5.12}
\]

Then

\[
 E_{\rm sh}\le
 \min\{KN\widehat Q_{\rm dir},(KN)^2\mathcal H_3\}
 +\mathcal A_{\rm arm},                                 \tag{5.13}
\]

and, for \(W>0\),

\[
 \left(\frac JW\right)^3\le
 \min\left\{KN\frac{\widehat Q_{\rm dir}}W,
              (KN)^2\frac{\mathcal H_3}W\right\}
 +\frac{\mathcal A_{\rm arm}}W.                        \tag{5.14}
\]

#### Proof

The ray sum (1.3) and (5.7) give
\(E_{\rm non}<KN\widehat Q_{\rm dir}\) when the non-arm domain is nonempty;
the empty case is zero.  Theorem 4.2 supplies the other cap.  Add the arm
bound and combine with (1.5).  ∎

### Proposition 5.4 (tree-owner overlap subtraction)

There is an explicit intermediate cap which retains the separate top
catalogues while subtracting certified overlap.  On one direction, order the
maximal tops \(\mu_1,\ldots,\mu_m\), and assign each real label to the first
catalogue containing it.  For every \(i>1\), choose a parent
\(p(i)<i\).  Let \(U_i\ge Q(\mu_i)\), and let

\[
 L_{i,p(i)}\le
 Q\!\left(\gcd_{\rm coord}(\mu_i,\mu_{p(i)})\right)       \tag{5.15}
\]

be any nonnegative lower bound, with the gcd catalogue evaluated on the
common direction.  Then valid owner caps are

\[
 B_1=U_1,\qquad B_i=U_i-L_{i,p(i)}\quad(i>1),             \tag{5.16}
\]

and in particular

\[
 \sum_iS_{\mu_i}\le
 \sum_iU_i-\sum_{i>1}L_{i,p(i)}.                         \tag{5.17}
\]

#### Proof

The intersection of two full threshold divisor catalogues is exactly the
threshold catalogue of their coordinatewise gcd.  If that intersection is
nonempty, any one of its large labels is supported by realizing pairs for
both tops; large-label line uniqueness forces the two top lines to coincide,
so all three catalogues use the same period on the intersection.  If it is
empty, its mass and every permitted lower bound \(L_{i,p(i)}\) are zero, and
the following argument is unchanged.
Write \(\mathcal C_i\) for the set of labels in the full threshold
catalogue of \(\mu_i\).  The first-owner set for \(\mu_i\) is
disjoint from every earlier catalogue and therefore is contained in
\(\mathcal C_i\setminus\mathcal C_{p(i)}\).  Its mass satisfies

\[
 S_{\mu_i}\le Q(\mu_i)-
 Q\!\left(\gcd_{\rm coord}(\mu_i,\mu_{p(i)})\right)
 \le U_i-L_{i,p(i)}.
\]

For \(i=1\), use \(S_{\mu_1}\le Q(\mu_1)\le U_1\), and sum.  ∎

Also
\(0\le L_{i,p(i)}\le Q(\gcd_{\rm coord}(\mu_i,\mu_{p(i)}))
\le Q(\mu_i)\le U_i\), so every cap in (5.16) is nonnegative, as
required in (3.4).

Choosing a rooted spanning tree and an order in which every parent precedes
its children gives (5.17).  Thus one may maximize the certified tree-overlap
subtraction instead of paying all full top catalogues.  In the cubic pressure
\(\mathcal H_3\), the root and orientation can additionally be optimized
against the denominators \((r_\mu-1)^3\).  A single top-label term supplies a
fully explicit lower bound in (5.15) whenever the gcd top is large; the exact
gcd catalogue gives the strongest finite correction.

## 6. Arithmetic enumeration of maximal tops

For the remainder of this section assume the canonical relation
\(1\le B\) and \(C=B+1\).  Write a primitive non-arm direction as \((s,t)\),
orient it by a fixed sign convention, and set

\[
 L=\max(|s|,|t|),\quad
 A=(s,s+Ct,s+Bt),\quad P=|A_UA_VA_W|.
\]

By definition, non-arm means \(A_UA_VA_W\ne0\).  Thus every divisor count
\(\tau(q|A_Z|)\) below is applied to a positive integer.

If two selected points on that line differ by \(q(s,t)\), then \(qL\le N\).
Every coordinate of their exact top is coprime to
\(R=\operatorname{rad}(BC)\), and subtraction of the two affine arms gives

\[
                         \gamma_Z(x,y)\mid q|A_Z|.        \tag{6.1}
\]

### Proposition 6.1 (closest-pair witness)

For \(\mu\in\mathcal M\), there is a realizing support pair with step
\(q_\mu(s,t)\) satisfying

\[
                         q_\mu(r_\mu-1)L\le N.            \tag{6.2}
\]

#### Proof

Order the \(r_\mu\) support points by their integer scalar coordinate along
the primitive line.  Their total scalar diameter is at most \(N/L\).  One of
the \(r_\mu-1\) consecutive gaps is therefore at most
\(N/(L(r_\mu-1))\).  Proposition 2.2 says that this closest pair has exact
top \(\mu\), proving (6.2).  ∎

For a positive integer \(u\), put
\(\mathfrak E(u)=u/\operatorname{rad}(u)\).  We record the elementary bound

\[
 \#\{n\le X:\mathfrak E(n)>Y\}=O(XY^{-1/2}).             \tag{6.3}
\]

To prove it, write \(n=\prod p^e\) and
\(m=\prod p^{\lfloor e/2\rfloor}\).  Then \(m^2\mid n\) and
\(m^2\ge\mathfrak E(n)>Y\); summing \(X/m^2\) over \(m>\sqrt Y\) gives
(6.3).

Every top \(\mu\) is itself a repeated non-arm large label.  The inherited
direction filter therefore gives

\[
 \mathfrak E(|A_U|^{(R)})
 \mathfrak E(|A_V|^{(R)})
 \mathfrak E(|A_W|^{(R)})>L.                            \tag{6.4}
\]

The three \(R\)-free coefficients are pairwise coprime.  Thus some factor in
(6.4) exceeds \(L^{1/3}\).  Since
\(\mathfrak E(|A_Z|)\ge\mathfrak E(|A_Z|^{(R)})\), one first passes back to
the **original** coefficient and only then applies (6.3).  On each side of
the square \(\max(|s|,|t|)=L\), the original coefficients \(s+Ct\) and
\(s+Bt\) are injective before absolute value and at most two-to-one after
absolute value; \(s\) has the same property on the horizontal sides.  The
constant values \(s=\pm L\) on the vertical sides are treated as a separate
spike.  This explicitly repairs the possible false step of treating the
\(R\)-free map itself as injective.

### Theorem 6.2 (maximal-top count and Euler-mass aggregation)

Assume the inherited canonical range \(1\le B\), \(C=B+1\), and \(N\ge1\).
For every \(\varepsilon>0\), with constants depending only on
\(\varepsilon\),

\[
 |\mathcal M|=
 O_\varepsilon\!\left((CN)^\varepsilon
            \min\{N^2,CN^{11/6}\}\right),              \tag{6.5}
\]

and, for owned caps satisfying
\(S_\mu\le B_\mu\le F(\mu,A_\mu)\),

\[
 \sum_{\mu\in\mathcal M}B_\mu=
 O_\varepsilon\!\left(K(CN)^\varepsilon
            \min\{N^5,CN^{29/6}\}\right).              \tag{6.6}
\]

For every real \(R_0\ge1\), the high-support tail satisfies

\[
 \sum_{\substack{\mu\in\mathcal M\\r_\mu-1\ge R_0}}
       \frac{B_\mu}{(r_\mu-1)^3}
 =O_\varepsilon\!\left(
   \frac{K(CN)^\varepsilon}{R_0^4}
       \min\{N^5,CN^{29/6}\}\right).                   \tag{6.7}
\]

#### Proof

Choose a deterministic realizing pair for each top; for (6.7), choose a
closest pair as in Proposition 6.1.  For fixed \((s,t,q)\), (6.1) leaves at
most

\[
                  \tau(q|A_U|)\tau(q|A_V|)\tau(q|A_W|)  \tag{6.8}
\]

possible top triples.  A large top cannot occur on two distinct affine lines,
because it is itself a large label and has a unique supporting line.  Hence
there is no uncounted intercept multiplicity in (6.8).

Let \(q_0=q^{(R)}\), \(P_0=\prod_Z|A_Z|^{(R)}\).  The exact Euler estimate
from the preceding report gives

\[
 B_\mu\le P_0\frac{q_0}{\varphi(q_0)}
          \le P\tau(q).                                \tag{6.9}
\]

For completeness, if \(p^e\parallel\mu_Z\) and
\(b=v_p(A_Z)\), the local Euler factor is \(p^e\) when \(e\le b\), and is
\(p^b(1+p^{-1}-p^{-(e-b+1)})\le p^b(1+p^{-1})\) when
\(e>b\).  Thus

\[
 F(\mu,A)\le C_\mu\prod_{p\mid T_\mu}(1+p^{-1}).
\]

Writing \(c_Z=\gcd(\mu_Z,|A_Z|)\) and \(u_Z=\mu_Z/c_Z\), (6.1) and
Euclid's lemma give \(u_Z\mid q\).  The three \(u_Z\)'s are pairwise
coprime, so \(T_\mu=\prod_Zu_Z\mid q\); all are \(R\)-free, hence
\(T_\mu\mid q_0\).  Similarly \(C_\mu\mid P_0\).  This proves
\(F(\mu,A)\le P_0q_0/\varphi(q_0)\), and
\(q_0/\varphi(q_0)\le\tau(q_0)\le\tau(q)\) proves (6.9).

The standard divisor estimate \(\tau(n)=O_\varepsilon(n^\varepsilon)\),
applied to (6.8) and (6.9), absorbs all divisor factors into
\(O_\varepsilon((CN)^\varepsilon)\), after renaming \(\varepsilon\).

On a shell of scale \(L\), (6.3)--(6.4) give
\(O(CL^{5/6})\) ordinary eligible directions.  The vertical spike occurs
only for \(L\) satisfying
\(\mathfrak E(L)>L^{1/3}\).  In a dyadic interval \((X,2X]\), (6.3) counts
\(O(X^{5/6})\) such \(L\)'s.

For (6.5), sum \(q\le N/L\).  The ordinary shells contribute

\[
 \sum_{L\le N}CL^{5/6}\frac NL=O(CN^{11/6}),
\]

and the spikes contribute
\(O(N)\) per exceptional \(L\), hence \(O(N^{11/6})\).  The raw square-shell
count gives the alternative \(O(N^2)\).

For (6.6), use \(P\le KL^3\).  The ordinary contribution is

\[
 \sum_{L\le N}CL^{5/6}\frac NL\,KL^3
       =O(KCN^{29/6}).                                  \tag{6.10}
\]

At an exceptional vertical scale, the \(O(L)\) directions contribute
\(O(KNL^3)\).  Partial summation of the dyadic
\(O(X^{5/6})\) bound gives
\(\sum_{L\le N,\,L\ {\rm exceptional}}L^3=O(N^{23/6})\), again yielding
\(O(KN^{29/6})\).  The unrestricted shell count gives \(O(KN^5)\).

Finally, if \(r_\mu-1\ge R_0\), (6.2) replaces the number of possible steps
by \(N/(R_0L)\), while the summand in (6.7) supplies a further factor
\(R_0^{-3}\).  Repeating the same count proves (6.7).  ∎

The hypotheses used in this count should not be weakened silently:

1. \(\gcd(\mu_Z,R)=1\) is what reduces
   \(\mu_Z\mid RqA_Z\) to (6.1).
2. Pairwise coprimality of the three coordinates makes the residual product
   \(T_\mu\) divide the single step \(q\); coordinatewise divisibility alone
   would permit a product as large as \(q^3\).
3. Removing an intercept factor uses \(G_\mu>N^2\) and unique large-label
   collinearity.
4. The factor \(R_0^{-1}\) in (6.7) uses the closest support pair from
   Proposition 6.1, rather than an arbitrary realizing pair.
5. The excess-shell count applies finite-to-one counting to the original
   coefficients \(A_Z\), after passing from the \(R\)-free excess inequality;
   it does not assume that \(A_Z\mapsto A_Z^{(R)}\) is injective.

A counterexample after deleting one of these items would retire only that
weakened count, not the complete theorem or the affine route.

Theorem 6.2 fills the earlier missing intercept/top multiplicity count.  Its
exponent is still too large by itself to prove the strict reverse of (4.9),
because low-support tops can dominate \(\mathcal H_3\).

## 7. Relation to incidence, containers, and powerful-number distribution

The point sets \(\operatorname{Supp}(\mu)\) form a finite linear hypergraph
by Corollary 2.3.  This is the exact codegree information available without a
new arithmetic input.  The hypergraph-container theorems of
Saxton--Thomason and Balogh--Morris--Samotij require degree/codegree or
supersaturation hypotheses in addition to linearity.  Those hypotheses are
not presently known for the selected powerful-kernel system, so invoking a
container theorem at this point would be circular.

The Szemeredi--Trotter theorem controls incidences with geometrically distinct
rich lines.  Here a single affine line may carry several divisibility tops;
Theorem 6.2 removes that extra multiplicity arithmetically through (6.1) and
large-label line uniqueness.  A raw point-line incidence estimate alone does
not see the catalogue labels or their inverse periods.

Classical work of Bateman--Grosswald, following Erdos--Szekeres, gives the
square-root main scale for the counting function of powerful integers, and
Golomb systematized their elementary structure.  For the present problem a
top coordinate is not an arbitrary powerful integer: it must divide the fixed
integer \(qA_Z\).  The divisor count (6.8) is therefore sharper for one
direction/step.  Conversely, the global powerful-number count does not
preserve which top owns which inverse-period mass.  This is why it cannot
replace Sections 2--5.

Primary sources used for this comparison are listed in Section 10.  No
secondary summary is used as a theorem input.

## 8. Exact adversarial boundaries

### 8.1 A canonical period-direction counterexample

Take

\[
 B=7,\quad C=8,\quad R=14,\quad M=400,\quad N=399,
\]

and the two admissible points

\[
                         x=(349,301),\qquad y=(358,73).   \tag{8.1}
\]

Their arms, factorizations relevant to the powerful kernels, and kernels are

\[
\begin{array}{c|ccc|ccc}
 &U&V&W&k_U&k_V&k_W\\ \hline
x&4887=3^3\cdot181&38599=11^3\cdot29&34385=5\cdot13\cdot23^2
  &27&1331&529\\
y&5013=3^2\cdot557&13189=11^2\cdot109&12167=23^3
  &9&121&12167
\end{array}                                             \tag{8.2}
\]

For both points \(\gcd(U,k)=1\), and the three arms are pairwise coprime.
The unique exact pair top for the selected two-point set is therefore maximal:

\[
                         \mu=(9,121,529),\qquad
 G_\mu=576081>N^2=159201.                                \tag{8.3}
\]

The difference is \(3(3,-76)\), and

\[
 A=(3,-605,-529),\qquad T_\mu=3.                         \tag{8.4}
\]

The proper owned large label

\[
 \lambda=(3,121,529),\qquad D_\lambda=192027>N^2        \tag{8.5}
\]

has \(T_\lambda=1\).  Both labels have occupancy two, the line is non-arm,
and \(\lambda\preceq\mu\), so all maximality, ownership, threshold, and
period premises are satisfied.  The exact catalogue terms are

\[
 \frac{w_\lambda}{T_\lambda^2}=111320,
 \qquad
 \frac{w_\mu}{T_\mu^2}=\frac{111320}{3},
 \qquad Q(\mu)=\frac{445280}{3}.                         \tag{8.6}
\]

For this selected set, \(r_\mu=2\), the owner set is exactly
\(\{\lambda,\mu\}\), and

\[
 E_\mu=w_\lambda+w_\mu=445280.
\]

Indeed, lowering the \(V\)-exponent gives product at most
\(9\cdot11\cdot529=52371<N^2\), lowering the \(W\)-exponent gives at most
\(9\cdot121\cdot23=25047<N^2\), and taking \(U=1\) gives
\(121\cdot529=64009<N^2\).  Hence the two listed \(U\)-choices are the
entire threshold catalogue.

The full Euler factor is

\[
 F(\mu,A)=\frac{11}{3}\cdot121\cdot529=\frac{704099}{3}.
\]

It is smaller than both tail caps in (3.5), namely
\(262254607552729/312900721\) and \(33635513329/7581\).
Thus the explicit hybrid cap is \(B_\mu=704099/3\), and every premise of
Theorem 4.1 is visible in this two-label catalogue.

This refutes exactly any proposed strengthening that replaces an owned
\(T_\lambda^{-2}\) by \(T_\mu^{-2}\), or asserts
\(T_\lambda\ge T_\mu\).  It confirms the opposite divisibility direction in
Lemma 3.1.  It does not refute ownership aggregation.

### 8.2 A canonical three-pair collapse and sharp cubic denominator

Take \(B=4,C=5,R=10,M=390,N=389\), and select the three complete-box
singleton-class points

\[
                     (240,248),\quad(289,166),\quad(387,2).             \tag{8.7}
\]

Their arms and powerful kernels are

\[
\begin{array}{c|ccc|ccc}
(h,k)&U&V&W&k_U&k_V&k_W\\ \hline
(240,248)&2401=7^4&14801=19^2\cdot41&12321=3^2\cdot37^2
 &(2401,361,12321)\\
(289,166)&2891=7^2\cdot59&11191=19^2\cdot31&9531=3^3\cdot353
 &(49,361,27)\\
(387,2)&3871=7^2\cdot79&3971=11\cdot19^2&3951=3^2\cdot439
 &(49,361,9)
\end{array}                                                            \tag{8.8}
\]

Each row is admissible and has pairwise-coprime arms.  All three pairs have
the same exact top

\[
 \mu=(49,361,9),\qquad G_\mu=159201>N^2=151321,                        \tag{8.9}
\]

and lie on the primitive non-arm direction \((49,-82)\), with pair steps
\(1,3,2\).  Here \(A=(49,-361,-279)\), so \(T_\mu=1\).  Dividing
\(G_\mu\) by its smallest prime already falls below \(N^2\); the common
large catalogue therefore contains only \(\mu\), of weight

\[
                w_\mu=\varphi(49)\varphi(361)\varphi(9)=86184.          \tag{8.10}
\]

The all-pair cover pays \(3w_\mu\).  Deduplication by top value gives one
maximal top with \(r_\mu=3\), owner mass \(S_\mu=w_\mu\), and

\[
 E_\mu=8w_\mu,\qquad
 \mathcal H_3=\frac{w_\mu}{8},\qquad
 S_\mu^2=E_\mu\mathcal H_3.                            \tag{8.11}
\]

Thus both top-value deduplication and the cubic support denominator are
sharp in an actual canonical local configuration.  This example does not
assert that the three points satisfy the exceptional-point inequality.

### 8.3 One canonical class can lie in two maximal tops

Take \(B=5,C=6,R=30,M=254,N=253\), and the points

\[
                       a=(35,139),\quad b=(59,135),\quad z=(186,254).
                                                                        \tag{8.12}
\]

Their arms and kernels are

\[
\begin{array}{c|ccc|c}
 &U&V&W&\kappa\\ \hline
 a&1051&26071=29^2\cdot31&21901=11^2\cdot181&(1,841,121)\\
 b&1771&26071=29^2\cdot31&22021=19^2\cdot61&(1,841,361)\\
 z&5581&51301=29^2\cdot61&43681=11^2\cdot19^2&(1,841,43681)
\end{array}                                             \tag{8.13}
\]

The exact tops of \(a,z\) and \(b,z\) are, respectively,

\[
 \begin{array}{c|c|c|c|c}
 \text{top}&\text{primitive direction}&A&D&T\\ \hline
 (1,841,121)&(151,115)&(151,841,726)&101761&1\\
 (1,841,361)&(127,119)&(127,841,722)&303601&1
 \end{array}                                             \tag{8.14}
\]

Both products exceed \(N^2=64009\); the two tops are incomparable and are
the maximal tops of this three-point selection.  Their large catalogues each
contain only the top label, with masses \(89320\) and \(277704\).  The
singleton class \(\kappa_z\) belongs to both maximal supports, whose
intersection is exactly \(\{z\}\).

All three points satisfy \(\gcd(U,k)=1\), and each row's arms are pairwise
coprime.  This is a complete canonical local counterexample to the proposed
strengthening “each kernel class belongs to at most one maximal top.”  It is
fully consistent with the correct linear bound (2.3), and it does not retire
the maximal-top route.

### 8.4 A canonical exact-catalogue inflation above two

There is no universal bound \(Q(\mu)\le2w_\mu\) under only canonical
admissibility, maximal-top ownership, and the full-catalogue premises.  Take

\[
 B=55123=199\cdot277,\quad C=55124=2^2\cdot13781,
 \quad R=1519300126,\quad M=3,\quad N=2,                 \tag{8.15}
\]

and select \(x=(1,1)\) and \(y=(3,2)\).  Their arm triples factor as

\[
\begin{array}{c|ccc|c}
 &U&V&W&\kappa\\ \hline
x&3581\cdot424267&109211\cdot766877141&
  3^2\cdot5^4\cdot7^2\cdot389\cdot781117&(1,1,275625)\\
y&17\cdot439\cdot610733&317\cdot528404915431&
  3^2\cdot5^3\cdot7^3\cdot11^2\cdot3587453&(1,1,46690875)
\end{array}                                             \tag{8.16}
\]

(the unfactored arms are respectively
\((1519300127,83751419445751,83749900145625)\) and
\((4557900379,167504358191627,167501319591375)\)).
Every factor displayed to the first power is prime; the finite certificate
checks each factorization and primality by complete trial division.  The
displayed
factorizations show pairwise coprimality in each row, while
\(\gcd(U_x,1)=\gcd(U_y,2)=1\).  Thus both points satisfy all local canonical
admissibility conditions.

Their exact pair top and primitive direction are

\[
 \mu=(1,1,55125),\qquad (s,t)=(2,1),qquad
 A=(2,55126,55125).                                    \tag{8.17}
\]

Indeed \(55125=3^2\cdot5^3\cdot7^2\) is the coordinate gcd of the two displayed
kernels, \(55125>N^2=4\), and all three direction coefficients are nonzero.
For this two-point selection, \(\Gamma=\{\mu\}\); hence \(\mu\) is globally
maximal, is its unique owner, and has \(r_\mu=2\).  Every threshold divisor
label is \((1,1,d)\) with \(d\mid55125\) and \(d>4\).  Since
\(d\mid A_W\), every such label has period one.  The only divisors of
\(55125\) not exceeding four are \(1\) and \(3\), so

\[
 \begin{aligned}
 Q(\mu)&=\sum_{\substack{d\mid55125\\d>4}}\varphi(d)
       =55125-\varphi(1)-\varphi(3)=55122,\\
 w_\mu&=\varphi(55125)
       =\varphi(3^2)\varphi(5^3)\varphi(7^2)=25200,\\
 \frac{Q(\mu)}{w_\mu}&=\frac{9187}{4200}>2.           \tag{8.18}
 \end{aligned}
\]

Every one of the 34 catalogue labels has occupancy two, so this same
selection also has

\[
 S_{\rm non}=Q(\mu)=E_{\rm non}=\mathcal H_3=55122.                \tag{8.19}
\]

Thus both (4.10) and the ownership Cauchy inequality are equalities here.
The three-term explicit cap (3.5) does not hide a smaller bound.
Complete capture gives \(F(\mu,A)=55125\), whereas
\(C_\mu=G_\mu=55125\), so both tail terms exceed \(55125\).  Therefore that
cap has

\[
                  \frac{B_\mu}{w_\mu}
                  =\frac{55125}{25200}=\frac{35}{16}>2. \tag{8.20}
\]

This is a complete-premise counterexample to the exact proposed local
strengthenings \(Q(\mu)\le2w_\mu\) and “the cap (3.5) always has
\(B_\mu\le2w_\mu\).”  It is a canonical admissible local selection, but is
not asserted to satisfy the exceptional-point inequality.  Consequently it
does not refute a bound that adds exceptional-point geometry, cross-top
catalogue sparsity, or a global energy hypothesis, and it does not retire
the affine mother route.

### 8.5 Sharp abstract linear-hypergraph certificate

Let \(V\) be a finite vertex set and assign a distinct prime \(p_{uv}\) to
each unordered pair.  Give vertex \(v\) the one-coordinate powerful kernel

\[
\kappa_v=\left(\prod_{u\ne v}p_{uv}^2,1,1\right).       \tag{8.21}
\]

Then the exact gcd top of \(u,v\) is
\(\mu_{uv}=(p_{uv}^2,1,1)\).  These tops are pairwise incomparable,
divisibility-maximal, and have two-point supports; their support hypergraph is
the complete graph and is linear.  With threshold \(N=1\) and formal
periods one, the owned catalogue of \(\mu_{uv}\) consists of
\((p_{uv},1,1)\) and \((p_{uv}^2,1,1)\), so

\[
 B_{\mu_{uv}}=Q(\mu_{uv})=p_{uv}^2-1,
 \quad E_{\mu_{uv}}=p_{uv}^2-1,
 \quad r_{\mu_{uv}}=2.                                  \tag{8.22}
\]

Thus \(|\mathcal M|=\binom{|V|}{2}\), and equality holds in the global
Cauchy inequality (4.2):

\[
             S_{\rm non}=E_{\rm non}=\mathcal H_3,
 \qquad S_{\rm non}^2=E_{\rm non}\mathcal H_3.          \tag{8.23}
\]

This is a complete-premise counterexample to any theorem deducing a strict
saving, a linear number of tops, or bounded catalogue inflation from only
maximality, ownership, cap coverage, \(r_\mu\ge2\), and linear support.
It is deliberately not claimed to be a canonical affine configuration: its
one-coordinate labels would be arm-like, and it ignores (6.1) and the
powerful-excess filter.  It retires only the pure ledger/hypergraph
strengthening.  The affine route with cross-class geometry remains active.

### 8.6 Corrections inherited from the frozen report

Three true statements in the frozen predecessor need explicit wording when
reused:

1. In its Corollary 5.4, one first deduces
   \(\mathfrak E(|A_Z|)>L^{1/3}\) from the corresponding \(R\)-free
   inequality, and then applies the square-divisor count to the original
   coefficient, whose side restriction is injective.  The \(R\)-free map
   itself need not be injective.  This is incorporated before Theorem 6.2.
2. In its Section 7.3 example,
   \(\gcd(54,29929)=1\).  Together with \(M<29929\), this is the missing
   explicit reason that the congruence permits at most one \(k\) in the box.
3. There \(W_{\rm repeated}\) means
   \(\sum_{d\in\mathcal L:\,n_d\ge2}w_d\).  Any reproduced numerical table
   must include the header naming its kernel, multiplicity, and tail columns.

These are clarifications, not changes to the frozen files.

## 9. Exact remaining gate

Here \(W=A_0-\Omega>0\) in the nonempty selected configurations under
discussion.  The new unconditional necessary inequality is

\[
 (A_1+\Omega)^3
 \le(A_0-\Omega)^2
 \left[\min\{KN\widehat Q_{\rm dir},(KN)^2\mathcal H_3\}
       +\mathcal A_{\rm arm}\right],                    \tag{9.1}
\]

where one fully explicit owner-cap choice is

\[
 \mathcal H_3=\sum_{\mu\in\mathcal M}
 \frac1{(r_\mu-1)^3}
 \min\left\{F(\mu,A_\mu),
       \frac{C_\mu^2G_\mu}{N^4},
       \frac{C_\mu^2H(G_\mu)}{N^2}\right\}.             \tag{9.2}
\]

The exact remaining affine task is to prove the strict reverse of (9.1) for
every hypothetical exceptional selected set, or to find an actual standard
abc counterexample.  Sections 5--6 provide two unconditional controls:

\[
 \mathcal H_3\le\beta_*W,
 \qquad
 \mathcal H_3=O_\varepsilon\!\left(
 K(CN)^\varepsilon\min\{N^5,CN^{29/6}\}\right),          \tag{9.3}
\]

as well as the direction-envelope bound (5.9)--(5.11), plus the
\(R_0^{-4}\) high-support tail.  None yet controls the low-support
inflation strongly enough, from the present hypotheses alone, to force the
strict reverse.  The precise unresolved requirement is a canonical
supersaturation or catalogue-sparsity estimate coupling

\[
 \frac{A_1+\Omega}{A_0-\Omega},\qquad
 \frac{\mathcal H_3}{A_0-\Omega},\qquad
 \frac{\mathcal A_{\rm arm}}{A_0-\Omega}.                \tag{9.4}
\]

Linearity alone cannot supply it by Section 8.5.  The additional usable
arithmetic is (6.1), the explicit three-term cap, the excess filter (6.4), and
the fact that every maximal top is an actual label on one unique affine line.
No finite no-hit result closes or abandons this mother route.

## 10. Primary literature and verification map

The roles of the primary sources are deliberately separated.  The
Rosser--Schoenfeld Mertens prime-product estimate is the only theorem input
from the six papers below, and only its coarse logarithmic upper bound is
used in (5.10).  The standard divisor estimate
\(\tau(n)=O_\varepsilon(n^\varepsilon)\) is an elementary input to
Theorem 6.2, while the square-divisor excess estimate (6.3) is proved in this
report.  Saxton--Thomason, Balogh--Morris--Samotij, Szemeredi--Trotter,
Bateman--Grosswald, and Golomb are comparison background only.  In
particular, no container hypothesis and no incidence bound is invoked in a
proof.

Publicly retrievable primary PDFs and citation metadata are sealed under
`research/sources/affine_ownership_aggregation_2026_09_02/`.  The archived
SHA-256 values include `23dd1542...2437` (Saxton--Thomason),
`2e2a7973...47fe` (Balogh--Morris--Samotij), `17aa8309...5fcc`
(Szemeredi--Trotter), and `8e37b06f...b556` (the Rosser--Schoenfeld article
from a public mirror); the complete hashes and source URLs are in
`SHA256SUMS.txt` and `SOURCES.json`.  The official Bateman--Grosswald
endpoint was bot-blocked and the Golomb article was paywalled at retrieval,
so those two entries seal DOI metadata without claiming to archive a PDF.

The literature list is:

- D. Saxton and A. Thomason, *Hypergraph containers*, Inventiones
  Mathematicae 201 (2015), 925--992; preprint
  <https://arxiv.org/abs/1204.6595>.
- J. Balogh, R. Morris, and W. Samotij, *Independent sets in hypergraphs*,
  Journal of the American Mathematical Society 28 (2015), 669--709;
  preprint <https://arxiv.org/abs/1204.6530>.
- E. Szemeredi and W. T. Trotter, *Extremal problems in discrete geometry*,
  Combinatorica 3 (1983), 381--392,
  <https://doi.org/10.1007/BF02579194>.
- P. T. Bateman and E. Grosswald, *On a theorem of Erdos and Szekeres*,
  Illinois Journal of Mathematics 2 (1958), 88--98,
  <https://projecteuclid.org/euclid.ijm/1255380836>.
- S. W. Golomb, *Powerful numbers*, American Mathematical Monthly 77
  (1970), 848--852, <https://doi.org/10.2307/2317020>.
- J. Barkley Rosser and Lowell Schoenfeld, *Approximate formulas for some
  functions of prime numbers*, Illinois Journal of Mathematics 6 (1962),
  64--94, <https://doi.org/10.1215/ijm/1255631807>.

### 10.1 Exact formalization boundary

The companion module contains 24 theorem declarations and 24 matching
`#print axioms` commands.  A separate axiom-audit module imports it and
prints the same list.  Lean proves the generic finite-poset cofinality lemma,
the abstract maximal-support equality and codegree contradiction, owner
partition identities, local and global Cauchy inequalities, algebraic
strict-ray closure, the polynomial normalized gate, generic tree-subtraction
inequalities, and the displayed numerical cores of the boundary examples.

The following paper arguments are **not** claimed to be Lean-closed:

1. the concrete affine construction of the maximal cover, powerful-kernel
   coordinate gcd, large-label line uniqueness, and no-arm migration;
2. the concrete support/cardinality and reduced-class-skeleton cofinality
   arguments (Lean proves their abstract order-theoretic skeleton);
3. the general facts (n_\lambda\ge r_\mu) and
   (T_\lambda\mid T_\mu);
4. the identification of the real canonical catalogue (Q(\mu)), its
   three-term Euler/tail cap, and the concrete inclusion
   (S_\mu\le Q(\mu));
5. the exact double-sum rearrangement in Proposition 4.4 and its injection
   from maximal tops containing a fixed label into support pairs (Lean starts
   from the resulting multiplicity hypothesis and proves the algebraic sum
   bound);
6. the direction envelope, local Euler products, strict tails, Mertens
   estimate, and formula (5.11);
7. the concrete gcd-catalogue intersections, first-owner set differences,
   and spanning-tree construction (Lean proves the associated real
   subtraction inequality);
8. all closest-pair, shell, vertical-spike, and asymptotic counts in
   Proposition 6.1 and Theorem 6.2;
9. the concrete arm estimates, signed-ray capacity, and weighted Hölder
   instantiation before the formalized algebraic consequences; and
10. the assertion that the displayed integers in Section 8 are the complete
    canonical powerful kernels, threshold catalogues, maximal systems, and
    owner systems.  Those finite premises are exhaustively replayed by the
    Python certificates; Lean proves their exact numerical cores.  The
    arbitrary-size complete-graph construction of Section 8.5 is likewise a
    paper proof, with a four-vertex numerical certificate in Lean.

The independent computation directory replays all four canonical boundary
families, all pair-top/maximal/owner premises on 2,208 finite canonical
boxes, and the abstract complete-graph sharpness certificate.  Analytic
big-O statements (6.5)--(6.7) remain conventional proofs rather than a
formalized asymptotic library development.
