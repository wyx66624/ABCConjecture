# First-hit primes and Hensel depth in the Pell radical pair

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad
 b_n=s_n^2-3,
 \qquad
 c_n=s_n^2-2=b_n+1,
\]

and put

\[
 \lambda=97+56\sqrt3,
 \quad
 \gamma_b=5+2\sqrt6,
 \quad
 \gamma_c=3+2\sqrt2.
\]

The toric identities are

\[
 4\lambda^n b_n=(\lambda^n-\gamma_b)
                    (\lambda^n-\gamma_b^{-1}),
 \qquad
 4\lambda^n c_n=(\lambda^n-\gamma_c)
                    (\lambda^n-\gamma_c^{-1}).       \tag{0.1}
\]

This note pushes the local analysis of (0.1) beyond primitive-divisor
existence.  Every odd prime in either recurrence is congruent to
\(\pm1\pmod {24}\), hence splits completely in
\(L=\mathbf Q(\sqrt2,\sqrt3)\).  At such a prime the hit indices for either
target are two residue classes modulo the order of \(\lambda\), and on each
class the full valuation is an affine \(p\)-adic logarithm.  This gives an
exact index-lifting law and a unique residue class at every additional Hensel
level.

There are also explicit cross-index gcd carriers.  If

\[
 B_j=\gamma_b^j+\gamma_b^{-j},
 \qquad
 C_j=\gamma_c^j+\gamma_c^{-j},
\]

then, for \(m,n\ge1\),

\[
 \gcd_{\rm odd}(b_m,c_n)\mid |B_n-C_m|.             \tag{0.2}
\]

For two values of the same target, splitting the common primes according to
whether the two local roots agree or are inverse gives square divisibility by
explicit Pell terms.

These are genuine new restrictions, but they do not control the depth of a
prime at its first target hit.  A finite local model, stated with its exact
quantifiers below, shows that first occurrence, large multiplicative order,
simple roots, one-class Hensel lifting, and disjoint gcd support alone are
compatible with logarithmic radical and linear logarithmic size.  The model
is not a counterexample to the actual Pell sequence: it deliberately omits
the global realization of the same three algebraic units at every prime.
Thus the remaining problem is sharply localized to a uniform global bound on
moving-prime first-hit Hensel depth (or an equivalent weighted truncation
theorem).

## 1. Normalizations

The Pell coordinates satisfy

\[
 s_n^2-3r_n^2=1,
 \qquad
 s_{n+1}=7s_n+12r_n,
 \qquad
 r_{n+1}=4s_n+7r_n.                                \tag{1.1}
\]

In particular \(s_n\) is odd.  Consequently

\[
 v_2(b_n)=1,
 \qquad
 c_n\equiv7\pmod8.                                 \tag{1.2}
\]

Modulo \(3\), (1.1) gives \(s_n^2\equiv1\), so neither \(b_n\) nor
\(c_n\) is divisible by \(3\).

The exponential formula

\[
 s_n={ (7+4\sqrt3)^n+(7-4\sqrt3)^n\over2}
\]

gives

\[
 b_n={\lambda^n+\lambda^{-n}-10\over4},
 \qquad
 c_n={\lambda^n+\lambda^{-n}-6\over4},             \tag{1.3}
\]

and hence (0.1).  Equivalently, for

\[
 F_b(X)=X^2-10X+1,
 \qquad
 F_c(X)=X^2-6X+1,
\]

one has \(4\lambda^n b_n=F_b(\lambda^n)\) and
\(4\lambda^n c_n=F_c(\lambda^n)\).

Two elementary polynomial certificates will be used repeatedly:

\[
 F_c(X)-F_b(X)=4X,                                  \tag{1.4}
\]

and

\[
 4F_b(X)+(10-X)(F_c(X)-F_b(X))=4.                  \tag{1.5}
\]

Thus the two toric polynomials have no common root in odd characteristic.
Their roots are simple away from \(2,3\), as witnessed by

\[
 (2X-10)^2-4F_b(X)=96,
 \qquad
 (2X-6)^2-4F_c(X)=32.                              \tag{1.6}
\]

The usual resultant is \(16\), but (1.5) is the sharper certificate needed
for excluding a common odd root.

## 2. Exact support congruences

Let \(p\) be an odd prime dividing \(b_n c_n\).  As observed above,
\(p\ne3\).

If \(p\mid b_n\), then

\[
 s_n^2\equiv3\pmod p,
 \qquad
 3r_n^2\equiv2\pmod p.                             \tag{2.1}
\]

The first congruence says \((3/p)=1\).  The second says that
\(2/3\) is a square; because \((3/p)=1\), it follows that \((2/p)=1\).

If \(p\mid c_n\), then

\[
 s_n^2\equiv2\pmod p,
 \qquad
 3r_n^2\equiv1\pmod p.                             \tag{2.2}
\]

Now the two congruences directly give \((2/p)=(3/p)=1\).  The standard
quadratic-reciprocity tables therefore give

\[
 p\equiv1\text{ or }23\pmod {24}.                  \tag{2.3}
\]

Conversely, (2.3) is precisely the simultaneous splitting condition for
\(\mathbf Q(\sqrt2)\) and \(\mathbf Q(\sqrt3)\).  Hence every odd prime in
\(b_nc_n\) splits completely in

\[
 L=\mathbf Q(\sqrt2,\sqrt3).                       \tag{2.4}
\]

This conclusion is stronger than merely knowing that the discriminants in
(1.6) are squares modulo a prime: it identifies all residue degrees and lets
us work in \(L_{\mathfrak p}=\mathbf Q_p\) at every prime above \(p\).

## 3. Hit classes and the first occurrence

Fix an odd prime \(p\mid b_nc_n\), a prime
\(\mathfrak p\mid p\) of \(L\), and write

\[
 t_p=\operatorname {ord}_{\mathbf F_p^\times}(\bar\lambda).
\]

For one of the targets \(\gamma\in\{\gamma_b,\gamma_c\}\), choose the unique
representative \(r\) with

\[
 1\le r<t_p,\qquad \bar\lambda^r=\bar\gamma.
\]

Such a representative exists for a hit, and \(r\ne0\) because the two roots
in (0.1) are distinct modulo \(p\): their differences are \(4\sqrt6\) and
\(4\sqrt2\), respectively.
It follows that all hit indices for this target are exactly

\[
 n\equiv r\quad\hbox{or}\quad n\equiv-r\pmod {t_p}.       \tag{3.1}
\]

If \(\rho_p\) is the first positive index in these two classes, then

\[
 \rho_p=\min(r,t_p-r),
 \qquad
 t_p>2\rho_p,
 \qquad
 p-1\ge t_p>2\rho_p.                              \tag{3.2}
\]

The strict inequality is important.  Equality \(t_p=2\rho_p\) would make
the two roots equal modulo \(p\), contrary to (1.6).

Thus a prime appearing for the first time at index \(n\) has \(p>2n\) if
that appearance is the first hit of the corresponding target.  This is a
real size restriction, but it contributes only \(\log p\gg\log n\), not the
\(\Theta(n)\) logarithmic mass needed for the radical estimate.

## 4. Exact affine Hensel lifting on one hit class

Continue at a fixed split completion \(L_{\mathfrak p}=\mathbf Q_p\), with
\(p\ge5\).  For this local discussion extend the trace sequences \(b,c\)
to every integer index by

\[
 u_{-n}=u_n,
\]

as is immediate from the symmetric toric formula (1.3).  Fix a hit class
\(n=r+t_pk\), with \(k\in\mathbf Z\), and choose
\(\varepsilon\in\{1,-1\}\) so that
\(\lambda^r\equiv\gamma^\varepsilon\pmod{\mathfrak p}\).  Put

\[
 A=\lambda^r\gamma^{-\varepsilon},
 \qquad
 D=\lambda^{t_p}.                                  \tag{4.1}
\]

Both \(A,D\) lie in \(1+p\mathbf Z_p\).  The other toric factor is a unit,
so (0.1) and root simplicity give the exact equality

\[
 v_p(u_{r+t_pk})=v_p(AD^k-1),                      \tag{4.2}
\]

where \(u=b\) or \(c\) is the chosen target sequence.  Since \(p\) is odd,
the \(p\)-adic logarithm is an isometry on \(1+p\mathbf Z_p\); therefore

\[
 v_p(u_{r+t_pk})
 =v_p(\log A+k\log D).                             \tag{4.3}
\]

Set \(a=v_p(\log A)\) and \(h=v_p(\log D)\).  The logarithm \(\log D\)
is nonzero: \(1+p\mathbf Z_p\) is torsion-free and \(\lambda\) is not a
root of unity.  The logarithm \(\log A\) is also nonzero.  Indeed, \(A=1\)
would give \(\lambda^r=\gamma^\varepsilon\).  The relevant distinct
quadratic subfields intersect in \(\mathbf Q\), and a positive rational
element of quadratic norm one is \(1\), contradicting \(r\ge1\) and
\(\lambda>1\).  Since the \(p\)-adic logarithm is injective on
\(1+p\mathbf Z_p\), both \(a\) and \(h\) are finite.  There are two cases.

* If \(a<h\), then

  \[
  v_p(u_{r+t_pk})=a\quad\hbox{for every }k\in\mathbf Z.    \tag{4.4}
  \]

* If \(a\ge h\), define

  \[
  \kappa=-{\log A\over\log D}\in\mathbf Z_p.
  \]

  Then

  \[
  v_p(u_{r+t_pk})=h+v_p(k-\kappa).                 \tag{4.5}
  \]

In the second case, for every integer \(j\ge0\),

\[
 \{k\in\mathbf Z:v_p(u_{r+t_pk})\ge h+j\}
\]

is exactly one residue class modulo \(p^j\).  Formula (4.5) is the precise
version of “one Hensel lift at each level.”

It is not an upper bound at a selected integer \(k\).  The \(p\)-adic number
\(\kappa\) can be extremely close to that integer.  This is exactly the
moving-prime, shifted-Wieferich obstruction left invisible by a simple-root
argument.

The familiar index-lifting formula is the homogeneous special case.  If
\(t_p\mid d\), then

\[
 v_p(\lambda^d-1)
 =v_p(\lambda^{t_p}-1)+v_p(d/t_p).                 \tag{4.6}
\]

Likewise, if the same prime divides two values of the same target, then the
minimum of the two valuations is at most the right side of (4.6) with
\(d=|m-n|\) when the local target roots agree, and with \(d=m+n\) when they
are inverse.

For any fixed finite set \(S\) of primes, (4.3)--(4.6), or standard fixed-
prime bounds for a nonzero affine \(p\)-adic logarithm, imply that the total
\(S\)-part of a term is only \(O_S(\log n)\).  Hence any linear-height
powerful part must migrate through infinitely many primes.  The dependence
on \(S\) is essential and prevents this observation from being summed over
the moving support.

## 5. Same-target gcd carriers

Let \(m\ne n\), and let \(G_b\) be the odd part of
\(\gcd(b_m,b_n)\).  At every prime power in \(G_b\), classify the prime as
“same” or “opposite” according as the two local roots
\(\gamma_b^{\varepsilon_m}\) and \(\gamma_b^{\varepsilon_n}\) agree or are
inverse.  This classification is independent of the chosen prime
\(\mathfrak p\mid p\): Galois conjugation multiplies both signs by the same
quadratic character.

Write \(G_b=G_{b,-}G_{b,+}\) for the corresponding coprime factorization,
where the minus subscript denotes the difference index and the plus
subscript the sum index.  Then

\[
 G_{b,-}^2\mid s_{2|m-n|}-1,
 \qquad
 G_{b,+}^2\mid s_{2(m+n)}-1.                       \tag{5.1}
\]

Indeed, a same-root congruence modulo \(p^e\) gives
\(\lambda^{m-n}\equiv1\pmod {p^e}\).  Therefore

\[
 \lambda^d+\lambda^{-d}-2
 ={(\lambda^d-1)^2\over\lambda^d}
 =2(s_{2d}-1)                                      \tag{5.2}
\]

is divisible by \(p^{2e}\).  The opposite-root case is identical with
\(d=m+n\).  The oddness of \(p\) removes the factor \(2\).  The same proof
gives

\[
 G_{c,-}^2\mid s_{2|m-n|}-1,
 \qquad
 G_{c,+}^2\mid s_{2(m+n)}-1                       \tag{5.3}
\]

for the odd part of \(\gcd(c_m,c_n)\).

These are stronger than a generic resultant bound.  The opposite-root
carrier, however, has logarithmic size
\((m+n)\log\lambda+O(1)\), so (5.1) by itself still permits a gcd on the
natural source scale.

## 6. A cross-target trace carrier

Define the two integer trace sequences

\[
 B_j=\gamma_b^j+\gamma_b^{-j},
 \qquad
 C_j=\gamma_c^j+\gamma_c^{-j}.                    \tag{6.1}
\]

They satisfy

\[
 \begin{aligned}
 B_0&=2,& B_1&=10,& B_{j+2}&=10B_{j+1}-B_j,\\
 C_0&=2,& C_1&=6, & C_{j+2}&=6C_{j+1}-C_j.
 \end{aligned}                                    \tag{6.2}
\]

### Proposition 6.1

For all \(m,n\ge1\),

\[
 \gcd_{\rm odd}(b_m,c_n)\mid |B_n-C_m|.           \tag{6.3}
\]

### Proof

Let \(p^e\) divide both \(b_m\) and \(c_n\), with \(p\) odd.  At a split
prime \(\mathfrak p\mid p\), root simplicity gives signs
\(\varepsilon,\delta\in\{1,-1\}\) such that

\[
 \lambda^m\equiv\gamma_b^\varepsilon,
 \qquad
 \lambda^n\equiv\gamma_c^\delta
 \pmod {\mathfrak p^e}.                            \tag{6.4}
\]

Raising the first congruence to \(n\), and the second to \(m\), eliminates
the common orbit term:

\[
 \gamma_b^{\varepsilon n}
 \equiv\gamma_c^{\delta m}\pmod {\mathfrak p^e}. \tag{6.5}
\]

All quantities are units, so the inverse congruence can be added to (6.5).
The signs disappear and give

\[
 B_n\equiv C_m\pmod {\mathfrak p^e}.               \tag{6.6}
\]

The difference in (6.6) is a rational integer and the completion is
unramified of residue degree one.  Hence \(p^e\mid B_n-C_m\).  Multiplying
over the odd prime powers in the gcd proves (6.3).  \(\square\)

The carrier never vanishes.  If \(B_n=C_m\), positivity and the strict
monotonicity of \(x+x^{-1}\) for \(x>1\) give
\(\gamma_b^n=\gamma_c^m\).  The left side belongs to
\(\mathbf Q(\sqrt6)\), the right side to \(\mathbf Q(\sqrt2)\), and the
intersection of these quadratic fields is \(\mathbf Q\).  A positive rational
unit of norm one is \(1\), whereas both displayed powers are greater than
one.  This is impossible.

More generally, the three units \(\lambda,\gamma_b,\gamma_c\) are
multiplicatively independent.  Applying the three nontrivial involutions of
the biquadratic field to a putative relation reduces it to a nonzero power in
one quadratic subfield being rational; norm one and positivity again force
that power to be \(1\).

The size of (6.3) is explicit:

\[
 \log |B_n-C_m|
 \le \max(n\log\gamma_b,m\log\gamma_c)+O(1).       \tag{6.7}
\]

This is a genuine cross-target restriction.  It is not yet a radical bound:
for a fixed current index, multiplying (6.7) over all possible earlier
indices loses \(\Theta(n^2)\), and no known disjointness principle recovers
that loss.

For reference, the four-conjugate algebra behind (6.3) is

\[
 \begin{aligned}
 &(x-y)(x-y^{-1})(x^{-1}-y)(x^{-1}-y^{-1})\\
 &\hspace{35mm}=\bigl((x+x^{-1})-(y+y^{-1})\bigr)^2.
 \end{aligned}                                    \tag{6.8}
\]

## 7. Why LCM and first-occurrence counting stop

Let \(X_n=b_nc_n\).  Exactly,

\[
 \log\operatorname {rad}(X_n)
 =\log X_n-
   \sum_{p\mid X_n}(v_p(X_n)-1)\log p.             \tag{7.1}
\]

Since \(\log X_n=2n\log\lambda+O(1)\), the required joint estimate is a
uniform upper bound on the weighted powerful excess in (7.1).  Hit-class
counting controls how often a fixed prime can occur as the index varies.  It
does not control the valuation at the first selected integer in its class.

The affine formula (4.5) makes the distinction exact.  For a fixed prime the
level-\(j\) indices have density at most \(p^{-j}\), up to endpoint error.
But at a moving prime the first relevant integer may already satisfy
\(v_p(k-\kappa)\gg1\).  An LCM records the maximum of these depths and a
first-occurrence argument records the prime only once; neither operation
turns the depth into radical weight.

The same issue survives the use of (5.1)--(6.3).  Those formulas sharply
limit repeated common support, while (7.1) can fail because of high powers at
pairwise disjoint, newly appearing primes.  A theorem about gcds cannot see
such a configuration.

Classical lower bounds for nonzero \(p\)-adic linear forms do bound
\(v_p(\lambda^n\gamma^{-1}-1)\) for a fixed prime.  Their constants depend on
the moving prime, and the standard explicit dependence is not summable with
the coefficient needed in (7.1).  Similarly, subspace-theorem gcd estimates
for multiplicatively independent units bound common divisors, while the two
same-index supports here are already disjoint by (1.5).

## 8. A strict finite local no-go model

The following proposition has a deliberately limited conclusion.  It says
that the local and combinatorial facts proved above are not, by themselves,
a proof of a linear radical bound.  It says nothing adverse about the actual
Pell sequence.

### Proposition 8.1

For every sufficiently large integer \(N\), there are two distinct odd
primes \(q_b,q_c\), exponents \(e_b,e_c\ge1\), cyclic local orbits, and two
simple inverse-root targets such that:

1. \(q_b,q_c>2N\), and the orbit order at \(q_i\) is \(q_i-1>2N\);
2. in the interval \(1\le n\le N\), the relevant target is hit only at
   \(n=N\), so the prime is a first-occurrence prime and all repeated-index
   gcd/lifting restrictions are vacuous;
3. the two prime supports are disjoint;
4. the target roots are simple and their \(q_i\)-adic lifts can have depth
   exactly \(e_i\); and
5. for model integers \(U_i=q_i^{e_i}\),

   \[
   \log U_i=N+O(\log N),
   \qquad
   \log\operatorname {rad}(U_bU_c)=O(\log N)=o(N). \tag{8.1}
   \]

### Proof

By Bertrand's postulate choose one prime between \(2N+1\) and \(4N+2\),
and a second prime between \(4N+2\) and \(8N+4\).  Call them \(q_b,q_c\).
For each \(q_i\), choose a generator \(g_i\) of
\(\mathbf F_{q_i}^\times\), take the orbit generator to be \(g_i\), and take
the target to be \(g_i^N\).  Its inverse is hit at
\(q_i-1-N>N\).  Thus only the first target is hit up to \(N\), and the two
roots are distinct because \(2N<q_i-1\).

In \(\mathbf Q_{q_i}\), lift the generator to a unit \(\Lambda_i\) and set
the lifted target to

\[
 \Gamma_i=\Lambda_i^N(1+q_i^{e_i}).                \tag{8.2}
\]

Then \(v_{q_i}(\Lambda_i^N-\Gamma_i)=e_i\), while the reduction and root
simplicity are unchanged.  Finally take

\[
 e_i=\left\lceil{N\over\log q_i}\right\rceil.
\]

Since \(q_i\asymp N\), (8.1) follows.  \(\square\)

This construction is only a family of finite local data.  In particular,
\(\Lambda_i\) and \(\Gamma_i\) depend on \(N\) and on the prime.  It does not
realize the fixed global units \(\lambda,\gamma_b,\gamma_c\), does not produce
the integer recurrence (1.1), and is not an actual counterexample to the Pell
radical estimate.  Its exact logical content is:

> Any successful proof must use a global compatibility property of the fixed
> algebraic units that is stronger than first occurrence, multiplicative
> order, root simplicity, local Hensel uniqueness, and pairwise gcd support.

## 9. The remaining quantitative statement

For every \(0<\eta<1\), the Pell route still needs

\[
 \log\operatorname {rad}(b_n)+
 \log\operatorname {rad}(c_n)
 \ge(1-\eta)n\log\lambda-O_\eta(1).                \tag{9.1}
\]

The analysis above suggests two equivalent forms of genuinely new input:

1. a weighted uniform-integrability theorem for the moving-prime values
   \(v_p(k-\kappa_{p,\gamma})\) in (4.5), including the first selected
   integer in each class; or
2. a global truncated-counting theorem for the four divisors
   \(\lambda^n=\gamma_b^{\pm1},\gamma_c^{\pm1}\) on the fixed torus, with a
   coefficient at least one source-height unit.

Primitive-divisor existence supplies only one new support point.  LCM growth
aggregates different indices.  Fixed-prime \(p\)-adic logarithms have moving
constants.  The explicit gcd carriers (5.1) and (6.3) control repeated support
but not first-hit depth.  None of these statements presently implies (9.1).

Thus this audit gives a positive structural advance and a precise no-go
boundary, but not a proof of abc.

## 10. Formalization boundary

The companion Lean module
`IUTThreeClosures/FreyPellFirstHitLiftingAudit.lean` verifies only the exact
algebraic skeleton used above:

* the two toric polynomials, their difference, the Bézout certificate (1.5),
  and the two discriminant certificates (1.6);
* the inverse-root four-factor trace identity (6.8);
* the trace recurrences in (6.2);
* the first cross carriers \(B_2-C_1=92\) and
  \(B_1-C_3=-188\), matching the observed primes \(23\) and \(47\); and
* a scalar powerful-prime model showing that one support prime can carry
  arbitrarily many copies of its logarithmic weight.

Lean does not formalize splitting of primes, quadratic reciprocity, local
fields, \(p\)-adic logarithms, the ideal-theoretic divisibility in
(5.1)--(6.3), Bertrand's postulate, or the missing radical estimate.  None of
these is inserted as an axiom.

## References

* K. Yu, *Linear forms in p-adic logarithms III*, Compositio Mathematica 91
  (1994), 241--276,
  [primary text](https://www.numdam.org/article/CM_1994__91_3_241_0.pdf).
* E. Rowland and R. Yassawi, *p-adic asymptotic properties of
  constant-recursive sequences*, Indagationes Mathematicae 28 (2017),
  404--432, [preprint](https://arxiv.org/abs/1602.00176).
* Y. Bugeaud, P. Corvaja and U. Zannier, *An upper bound for the G.C.D. of
  \(a^n-1\) and \(b^n-1\)*, Mathematische Zeitschrift 243 (2003), 79--84,
  [journal record](https://doi.org/10.1007/s00209-002-0449-z).
