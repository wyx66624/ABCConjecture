# Fixed-unit Kummer, cyclotomic, and sieve structure at Pell first hits

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad b_n=s_n^2-3,
 \qquad c_n=s_n^2-2,
 \qquad X_n=b_nc_n,
\]

and put

\[
 \lambda=97+56\sqrt3,
 \quad \gamma_b=5+2\sqrt6,
 \quad \gamma_c=3+2\sqrt2,
 \quad H_n=n\log\lambda.
\]

This note audits the still-uncontrolled part of the super-square sum at
actual first hits

\[
 F_n^{\rm fh}=
 \sum_{\substack{p\mid X_n\\p>Y_n,\ t_p>2n}}
       (v_p(X_n)-2)_+\log p,                       \tag{0.1}
\]

where \(t_p=\operatorname{ord}_p(\bar\lambda)\).  It makes three
unconditional structural advances.

First, the fixed units have more power structure than the four-target
factorization alone displays.  In
\(L=\mathbf Q(\sqrt2,\sqrt3)\),

\[
 q={\sqrt6+\sqrt2\over2},\qquad
 \lambda=q^8,
 \qquad
 \gamma_b=(\sqrt3+\sqrt2)^2,
 \qquad
 \gamma_c=(1+\sqrt2)^2.                            \tag{0.2}
\]

Consequently a first-hit prime satisfies

\[
 p-1>16n\quad(p\equiv1\pmod {24}),
 \qquad
 p-1>4n\quad(p\equiv23\pmod {24}).                \tag{0.3}
\]

This is a genuine strengthening of \(p>2n\), but it remains only linear and
does not control (0.1).

Second, let \(e=v_p(X_n)\), select the oriented target
\(\gamma\in\{\gamma_b^{\pm1},\gamma_c^{\pm1}\}\), and put

\[
 d=(n,t_p),\qquad n=da,\qquad t_p=dT.
\]

Then

\[
 (a,T)=1,\qquad T>2a,
 \qquad \operatorname{ord}_p(\bar\gamma)=T.       \tag{0.4}
\]

Thus the target carrier can be normalized from
\(\gamma^{t_p}-1\), of height \(O(t_p)\), to the exact cyclotomic value
\(\Phi_T(\gamma)\), of height \(O(T)\).  In particular \(p>Y_n\) forces
\(T\gg\log n\).  This can save a factor \(d\) when \(d\) is large.  It does
not close the sum because the set of occurring \(T\)'s is moving and
unbounded, and the extra shifted depth need not occur in this carrier.

Third, the missing depth has an exact fixed-unit description.  With

\[
 h_\lambda=v_{\mathfrak p}(\lambda^{t_p}-1),
 \qquad
 h_\gamma=v_{\mathfrak p}(\gamma^T-1),             \tag{0.5}
\]

order lifting at a first hit gives

\[
 \boxed{\min(e,h_\lambda)=\min(e,h_\gamma).}       \tag{0.6}
\]

If this common truncated depth is \(q_p\), then exactly

\[
 (e-2)_+=(q_p-2)_+
          +\bigl(e-\max\{q_p,2\}\bigr)_+.         \tag{0.7}
\]

The first term is simultaneous fixed-base cyclotomic Wieferich mass.  The
second is cancellation between two equal-depth principal units.  For every
level \(J\le e\), the hit indices form one class modulo

\[
 Q_{p,J}=t_p p^{(J-h_\lambda)_+}.                  \tag{0.8}
\]

At a first hit the least positive representative of that class is \(n\),
although \(Q_{p,J}>2n\).  When \(h_\lambda=1,J=3\),

\[
 Q_{p,3}=t_p p^2,\qquad
 {n\over Q_{p,3}}<{1\over2p^2}.                   \tag{0.9}
\]

Hence the heuristic Hensel density \(p^{-2}\) is exact only after varying
the class or the index through a complete interval.  On the interval
\([1,n]\), every relevant class is sampled exactly once, at the common
endpoint \(n\).  The endpoint errors in a sieve sum retain the unknown mass
itself.

Tame Kummer theory of the near-one ratio is depth-blind; the depth-sensitive
\(p\)-primary tower is ramified at the prime being counted.  Ordinary
Chebotarev and large-sieve averages therefore do not prove a pointwise bound
for (0.1).  The exact surviving input is a fixed-unit, moving-prime theorem
excluding anomalously small least representatives in (0.8), together with
control of the synchronized cyclotomic Wieferich part in (0.7).  No such
theorem is proved here, and no proof of equation (8.1) in the preceding
cubeful-tail audit, or of abc, is claimed.

## 1. The first-hit part of the remaining ledger

The preceding cubeful-tail audit reduces the Pell route to the balance

\[
 \sum_{\substack{p\mid X_n\\p>Y_n,\ t_p>T_n}}
       (v_p(X_n)-2)_+\log p
 \le
 \sum_{\substack{p\mid X_n\\v_p(X_n)=1}}\log p
       +2\eta H_n+O_\eta(1).                      \tag{1.1}
\]

The range \(t_p>2n\) in (0.1) is the part in which \(n\) is the first
positive hit of the selected inverse target pair.  A theorem

\[
 F_n^{\rm fh}=o(n)                                \tag{1.2}
\]

would remove this entire part of the left side of (1.1).  It is a convenient
standalone sufficient statement, but it is stronger than logically
necessary: (1.1) permits exponent-one mass at the same index to compensate
super-square mass.  Nothing below silently replaces the balance (1.1) by
the stronger assertion (1.2).

Every odd support prime splits completely in \(L\).  At a chosen
\(\mathfrak p\mid p\), exactly one oriented target satisfies

\[
 e=v_p(X_n)
  =v_{\mathfrak p}(\lambda^n\gamma^{-1}-1).        \tag{1.3}
\]

One such choice is fixed once for each rational prime.  This prevents any
prime-ideal or target multiplicity from entering the rational weighted sum.

## 2. Eighth-power source and square targets

Put

\[
 q={\sqrt6+\sqrt2\over2},
 \qquad \alpha=7+4\sqrt3,
 \qquad \beta_b=\sqrt3+\sqrt2,
 \qquad \beta_c=1+\sqrt2.
\]

Direct squaring gives

\[
 q^2=2+\sqrt3,\qquad q^4=\alpha,\qquad q^8=\lambda,
 \qquad \beta_b^2=\gamma_b,\qquad
 \beta_c^2=\gamma_c.                              \tag{2.1}
\]

Let \(r_p=\operatorname{ord}_p(\bar q)\).  Since \(q\in L\) and \(p\)
splits completely,

\[
 t_p=\operatorname{ord}_p(\bar q^8)
 ={r_p\over(r_p,8)}
 \mid {p-1\over(p-1,8)}.                          \tag{2.2}
\]

For \(p\equiv1\pmod {24}\), the denominator in (2.2) is \(8\); for
\(p\equiv23\pmod {24}\), it is \(2\).  Combining (2.2) with \(t_p>2n\)
proves (0.3).

The square targets preserve the full local depth.  If
\(\gamma=\beta^2\), then

\[
 \lambda^n-\gamma=(\alpha^n-\beta)(\alpha^n+\beta). \tag{2.3}
\]

At an odd support prime the two factors on the right cannot both vanish,
because their difference is \(2\beta\), a unit.  Thus the entire exponent
\(e\), not just one radical copy, transfers to exactly one of the eight
forms

\[
 \alpha^n-\eta,\qquad
 \eta\in
 \{\pm\beta_b^{\pm1},\ \pm\beta_c^{\pm1}\}.       \tag{2.4}
\]

This is useful normalization data.  It does not make a simple shifted root
squarefree, and the linear lower bounds (0.3) are far below the exponential
height \(H_n\).  For example, one prime \(p\asymp n\) can still occur to
exponent \(\asymp n/\log n\) without violating the component height.

There is also a tame power-residue restriction.  In the class
\(p\equiv1\pmod {24}\), an actual target \(\gamma\) must be an eighth power
modulo \(p\), because it equals \(q^{8n}\).  This places the support inside a
fixed Kummer/Chebotarev ambient set.  Section 6 explains why that ambient
restriction does not distinguish depth one from depth three.

## 3. The normalized target order and cyclotomic carrier

Fix a first-hit prime and its oriented target.  Write

\[
 t=t_p,\qquad d=(n,t),\qquad n=da,\qquad t=dT.   \tag{3.1}
\]

Then \((a,T)=1\), and the reduction of the hit equation gives

\[
 \operatorname{ord}_p(\bar\gamma)
 =\operatorname{ord}_p(\bar\lambda^n)
 ={t\over(t,n)}=T.                                \tag{3.2}
\]

Moreover \(t>2n\) is exactly

\[
 T>2a.                                             \tag{3.3}
\]

Since \(p\nmid tT\), exact-order cyclotomic factorization gives

\[
 \begin{aligned}
 h_\lambda
  &:=v_{\mathfrak p}(\lambda^t-1)
    =v_{\mathfrak p}(\Phi_t(\lambda)),\\
 h_\gamma
  &:=v_{\mathfrak p}(\gamma^T-1)
    =v_{\mathfrak p}(\Phi_T(\gamma)).             \tag{3.4}
 \end{aligned}
\]

In particular the rational prime \(p\) divides the two nonzero integers

\[
 N_{L/\mathbf Q}(\Phi_t(\lambda)),
 \qquad
 N_{L/\mathbf Q}(\Phi_T(\gamma)).                 \tag{3.5}
\]

The second is the promised normalized carrier.  For the fixed target units,
standard archimedean estimates give an effective constant \(C>0\) such that

\[
 \log\left|N_{L/\mathbf Q}(\Phi_T(\gamma))\right|
 \le CT.                                          \tag{3.6}
\]

Thus

\[
 \log p\le CT,
 \qquad p>Y_n\Longrightarrow T\gg\log n.          \tag{3.7}
\]

This improves the earlier \(O(t)=O(dT)\) target norm when \(d\) is large.
It is not merely a change of notation.

### 3.1 Exact resultant identity

The normalization also follows from an exact polynomial resultant.  For
\(t>2\), \(d=(n,t)\), \(T=t/d\), and

\[
 m={\varphi(t)\over\varphi(T)},
\]

one has in \(\mathbf Z[Y]\)

\[
 \boxed{
 \operatorname {Res}_X(\Phi_t(X),X^n-Y)
   =\Phi_T(Y)^m.}                                  \tag{3.8}
\]

Indeed, \(\zeta\mapsto\zeta^n\) maps the primitive \(t\)-th roots
surjectively onto the primitive \(T\)-th roots.  Every fiber has size \(m\).
Taking the product of \(\zeta^n-Y\) over the primitive \(t\)-th roots gives
\((-1)^{\varphi(t)}\Phi_T(Y)^m\); the sign is \(+1\) because
\(t>2\) makes \(\varphi(t)\) even.  If one uses the opposite convention for
the resultant, (3.8) is unchanged up to a sign, which is irrelevant
ideal-theoretically.

At \(Y=\gamma\), (3.8) records \(m h_\gamma\) locally.  It does not record
the shifted depth \(e\) unless that depth has already transferred to
\(\Phi_T(\gamma)\).  Section 4 makes the precise difference visible.

### 3.2 Why the \(O(T)\) gain does not yet sum

Every exact target order \(T\) has a nonredundant fixed cyclotomic block,
and (3.6) bounds the sum of the logarithms of its distinct prime divisors by
\(O(T)\).  The first-hit relation adds \(n=da\) and \(T>2a\), with \(a\mid n\).
Nevertheless:

1. the occurring \(T\)'s have no polynomial upper bound in \(n\); only
   \(T\le p-1\) is automatic;
2. summing \(O(T)\) over all possible target orders is therefore worse than
   the source-height budget;
3. even within one block, (3.6) controls total height, not the powerful part
   of \(\Phi_T(\gamma)\); and
4. the cancellation term in (0.7) can exceed \(h_\gamma\) and is absent
   from the carrier altogether.

Thus (3.4)--(3.8) are a positive reduction, especially for large \(d\), but
not a proof of a weighted tail estimate.  Controlling their powerful parts
uniformly in \(T\) is a fixed-base cyclotomic Wieferich problem analogous to
the unresolved powerful parts of \(\Phi_T(2)\).

## 4. Exact synchronization of homogeneous and shifted depth

Let

\[
 e=v_{\mathfrak p}(\lambda^n\gamma^{-1}-1),
 \qquad
 v=v_p(a),
\]

with the notation (3.1).  The standard order-lifting formula gives

\[
 \begin{aligned}
 \operatorname{ord}_{\mathfrak p^e}(\lambda)
   &=t p^{(e-h_\lambda)_+},\\
 \operatorname{ord}_{\mathfrak p^e}(\gamma)
   &=T p^{(e-h_\gamma)_+}.                        \tag{4.1}
 \end{aligned}
\]

Since \(\gamma\equiv\lambda^n\pmod {\mathfrak p^e}\), the order of the
right side is

\[
 T p^{(e-h_\lambda-v)_+}.                         \tag{4.2}
\]

Comparison with (4.1) gives the general truncated identity

\[
 \boxed{
 \min(e,h_\gamma)=\min(e,h_\lambda+v_p(a)).}       \tag{4.3}
\]

In the first-hit range, (0.3) implies \(p>n\), so \(v_p(a)=0\), and (4.3)
becomes (0.6).  This is the point at which the first-hit size condition is
used in the synchronization statement.

Put

\[
 q_p=\min(e,h_\lambda)=\min(e,h_\gamma).           \tag{4.4}
\]

Since \(q_p\le e\), elementary truncation proves the exact identity (0.7).
If the second term there is positive, then \(e>q_p\).  Equation (0.6) then
forces

\[
 h_\lambda=h_\gamma=q_p.                          \tag{4.5}
\]

Thus the extra term is not depth carried by just one of the two
cyclotomic values.  It is cancellation between two principal units of the
same depth.

This cancellation is seen directly by putting

\[
 u=\lambda^n\gamma^{-1},\qquad
 D=\lambda^t,\qquad G=\gamma^T.
\]

Because \(n=da\) and \(t=dT\),

\[
 u^T=D^aG^{-1}.                                    \tag{4.6}
\]

As \(p\nmid T\), the left side has valuation \(e\).  Hence

\[
 e=v_{\mathfrak p}(D^aG^{-1}-1)
  =v_{\mathfrak p}(a\log D-\log G).               \tag{4.7}
\]

When \(e>q_p\), (4.7) is cancellation between two logarithms whose separate
valuations both equal \(q_p\).  The obvious full-depth algebraic carrier
\(D^a-G=\lambda^{nT}-\gamma^T\) has height \(O(nT)\), not \(O(T)\), and is
therefore quantitatively unusable.  Taylor subtraction can recover finitely
many cancellation layers in carriers of height \(O(kT)\), but recovering all
\(e-q_p\) layers makes the degree \(k\) move and returns the same unsummed
budget.

## 5. Affine interpolation and the anomalously small representative

Fix \(1\le r<t\) with
\(\lambda^r\equiv\gamma\pmod {\mathfrak p}\), and suppose the actual hit
\(n\equiv r\pmod t\) has depth \(e\).  Write

\[
 A=\lambda^n\gamma^{-1},\qquad D=\lambda^t,
 \qquad h=v_{\mathfrak p}(D-1).
\]

For \(m=n+tk\), the odd-\(p\) logarithm is an isometry on principal units and
gives

\[
 v_{\mathfrak p}(\lambda^m\gamma^{-1}-1)
 =v_p(\log A+k\log D).                             \tag{5.1}
\]

Because \(k=0\) has depth \(e\), (5.1) proves, for every \(1\le J\le e\),
the exact class formula

\[
 \boxed{
 \{m\in\mathbf Z:
   v_{\mathfrak p}(\lambda^m\gamma^{-1}-1)\ge J\}
  =n+Q_{p,J}\mathbf Z,
 \quad Q_{p,J}=t p^{(J-h)_+}.}                    \tag{5.2}
\]

For completeness, if \(e<h\), every integer \(k\) has valuation \(e\) in
(5.1) through level \(J\le e\), so \(Q_{p,J}=t\).  If \(e\ge h\), put

\[
 \kappa=-{\log A\over\log D}\in\mathbf Z_p.
\]

Then the valuation is \(h+v_p(k-\kappa)\).  Since \(k=0\) reaches level
\(J\), one has
\(\kappa\equiv0\pmod {p^{(J-h)_+}}\), which proves (5.2).

Let \(\rho_{p,\gamma,J}\) be the least positive representative of the
oriented class in (5.2).  At a first hit \(n<t/2\), and \(Q_{p,J}\ge t\),
so

\[
 \rho_{p,\gamma,J}=n.                             \tag{5.3}
\]

If \(J>h\), equations (5.2)--(5.3) sharpen this to

\[
 {n\over Q_{p,J}}
 <{1\over2p^{J-h}}.                               \tag{5.4}
\]

The cube-level instance \(h=1,J=3\) is (0.9).

### 5.1 Exact layer formulation

For one prime,

\[
 (e-2)_+=\sum_{J=3}^{e}1.                         \tag{5.5}
\]

Consequently, after choosing one oriented local target for every rational
prime, the first-hit mass is exactly a weighted sum of pairs \((p,J)\) for
which the least lifted representative in (5.3) equals the common index
\(n\).  This identifies a clean, nonredundant sufficient target.

For each oriented fixed target \(\gamma\), let

\[
 \mathcal W_\gamma(N)=
 \sum_{\substack{p,J\ge3\\
       p>Y_{\rho_{p,\gamma,J}},
       \rho_{p,\gamma,J}\le N\\
       2\rho_{p,\gamma,J}<t_p}}
       \log p,                                    \tag{5.6}
\]

where only nonempty lifted classes are included.  A fixed-unit theorem

\[
 \sum_{\gamma}\mathcal W_\gamma(N)=o(N)           \tag{5.7}
\]

would imply \(F_n^{\rm fh}=o(n)\) pointwise, by nonnegativity and
(5.3)--(5.5).  Formula (5.7) is not asserted here.  It is a precise
first-occurrence, small-representative uniform-integrability theorem, rather
than a density statement about arbitrary primes or bases.

The synchronized part \((q_p-2)_+\) in (0.7) may instead be separated into
powerful parts of the two fixed cyclotomic blocks in (3.4).  A successful
proof may combine a weaker version of (5.7) for the collision layers with a
fixed-base Wieferich-mass estimate for those blocks.  Neither input is known
unconditionally with the required pointwise coefficient.

### 5.2 Why the usual endpoint estimate is circular

For a single residue class modulo \(Q\), elementary counting gives

\[
 \#([1,n]\cap(a+Q\mathbf Z))={n\over Q}+O(1).      \tag{5.8}
\]

For every pair \((p,J)\) contributing to (0.1), (5.2) and \(Q_{p,J}>2n\)
give the exact count

\[
 \#([1,n]\cap(n+Q_{p,J}\mathbf Z))=1.             \tag{5.9}
\]

The main term in (5.8) is below \(1/2\), so its endpoint remainder is above
\(1/2\).  Multiplying by \(\log p\) and summing over the layers leaves an
endpoint error at least \(F_n^{\rm fh}/2\).  Thus summing the individual
\(O(1)\)'s loses a fixed fraction of exactly the mass one is trying to bound.

This does not disprove every possible large-sieve argument.  It proves that
the standard class-density input, with separate endpoint errors, is
quantitatively circular in the pointwise first-hit range.  A successful
sieve would have to exploit correlations of the fixed four targets strong
enough to cancel or globally control these coherent endpoint atoms.

### 5.3 Relation with the medium-order lifting core

The same coordinate also appears beyond the first-hit range.  If \(\rho\)
is the first residue and

\[
 n=kt\pm\rho,\qquad t>T_n,\qquad p>Y_n,
\]

then

\[
 k<{n\over t}+1<{n\over T_n}+1
   =n^{2/3}\log n+1<p^2                           \tag{5.10}
\]

for all sufficiently large \(n\).  Hence every layer with
\(J-h\ge2\) again asks for an exceptionally small representative of the
center modulo at least \(p^2\).  The single layer \(J=h+1\), whose modulus is
only \(p\), is a separate transition layer and must not be silently included
in (5.10).  Thus the first-hit problem studied here and the deep part of the
medium-order problem share the same fixed-unit least-representative core;
the first-hit case is the extreme endpoint \(k=0\).

## 6. Kummer and Chebotarev audit

### 6.1 Tame Kummer theory of the near-one ratio is depth-blind

At the selected place put

\[
 u=\lambda^n\gamma^{-1}\in U_1,
 \qquad U_j=1+p^j\mathbf Z_p.
\]

For odd \(p\), the logarithm identifies \(U_1\) with \(p\mathbf Z_p\).
Therefore

\[
 U_1^M=U_1\quad((M,p)=1),
 \qquad U_3=(U_1)^{p^2}.                            \tag{6.1}
\]

Every prime-to-\(p\) Kummer class of \(u\) is already trivial as soon as
\(u\equiv1\pmod p\).  It is identical for depth one and depth at least
three.  Fixed extensions obtained by adjoining prime-to-\(p\) roots of
\(\lambda,\gamma_b,\gamma_c\) can refine the residual orders and the power
residue restriction from Section 2, but cannot read the filtration
\(U_1/U_3\).

Detecting that quotient requires \(p\)-primary Kummer or ray data.  A Galois
closure which realizes \(p^2\)-th Kummer classes contains
\(\mu_{p^2}\), and a ray-class realization has \(p\) in its conductor.  In
either description the prime \(p\) is ramified, so there is no ordinary
unramified Frobenius element at the same prime to which Chebotarev can be
applied.

### 6.2 Kummer theory of the difference records ramification, not the tail

One must distinguish the ratio \(u\) from the difference
\(\delta=u-1\).  For a fixed \(M\) prime to \(p\), after a harmless
unramified local base change the tame Kummer extension

\[
 z^M=\delta
\]

has ramification index

\[
 {M\over(M,v_p(\delta))}.                          \tag{6.2}
\]

Thus it can see the depth modulo \(M\).  This still does not bound
\((e-2)\log p\).  If \(M\nmid e\), the prime is ramified and excluded from
ordinary Chebotarev.  If \(M\mid e\), arbitrarily large depths divisible by
\(M\) are invisible to (6.2).  Any finite collection of exponents misses
all depths divisible by their least common multiple.  A tower large enough
to reconstruct \(e\) puts the unknown multiplicity directly into its
ramification or conductor and merely repackages the truncated-counting
problem.

### 6.3 The quantifiers of exact hits

For fixed \(n\) and \(\gamma\), every hit prime divides the one nonzero
integer

\[
 N_{L/\mathbf Q}(\lambda^n-\gamma),                \tag{6.3}
\]

so the hit set is finite.  A nonempty unramified Frobenius class in a fixed
finite Galois extension contains infinitely many primes.  Therefore the
exact hit condition cannot itself be a fixed Chebotarev class.  Chebotarev
can count an ambient power-residue set, but supplies no distribution theorem
for the prime divisors of the single principal value (6.3) inside that set.

There is also a scale obstruction.  A super-square prime belongs to one
factor of height \(H_n+O(1)\), so

\[
 4n<p\le\exp(H_n/3+O(1)),
 \qquad
 \#\{p:e_p\ge3\}=O(n/\log n).                     \tag{6.4}
\]

At the exponential upper cutoff in (6.4), a power-saving exceptional set of
ambient primes is still exponentially larger than the selected Pell
support.  More sharply, (1.2) would eventually exclude even one contributing
prime with \(\log p\ge\epsilon n\), for every fixed \(\epsilon>0\).
An almost-all-primes theorem permits such a sparse exceptional sequence
unless it adds a correlation with the principal divisors (6.3).

Accordingly, this section retires only the audited tame/unramified Kummer
and marginal Chebotarev uses.  It does not rule out a new fixed-unit theorem
that controls the cross-prime correlations of the least representatives in
(5.6).

## 7. Derivatives, resultants, and a fixed-Pell diagnostic

At a first hit, \(p\nmid n tT\).  Therefore

\[
 {d\over dX}(X^n-\gamma)=nX^{n-1}
\]

is a unit at the selected root.  The primitive roots of
\(\Phi_t\) and \(\Phi_T\) are also simple modulo \(p\).  Polynomial
discriminants and derivative gcds consequently see reduced horizontal
divisors at precisely the primes where the specialization may have depth
three or more.  Hensel uniqueness selects one lift; it does not keep the
fixed orbit point away from that lift.

Formula (3.8) is the complete natural resultant between the exact source
order and the shifted target polynomial.  Its specialization records the
target depth \(h_\gamma\), while (4.7) shows that \(e-h_\gamma\) can be
equal-depth logarithmic cancellation.  Adding the source cyclotomic value
records \(h_\lambda\); equation (0.6) then synchronizes the two truncated
depths but still does not bound their common powerful part or their
cancellation.

There is a useful finite diagnostic inside the actual fixed Pell sequence.
The trace recurrence

\[
 s_0=1,\qquad s_1=7,\qquad s_{j+2}=14s_{j+1}-s_j
\]

satisfies

\[
 \begin{aligned}
 s_{1552}&\equiv6654\pmod {23^3},\\
 s_{1552}&\equiv140491\pmod {23^4},\\
 s_{1552}^2-3&\equiv0\pmod {23^3},\\
 s_{1552}^2-3&\equiv21\cdot23^3\pmod {23^4}.
                                                               \tag{7.1}
 \end{aligned}
\]

Thus \(v_{23}(b_{1552})=3\).  At the split embedding
\(\sqrt3\equiv7\pmod {23}\), one has
\(\lambda\equiv6\pmod {23}\), whose order is \(11\), and
\(1552\equiv1\pmod {11}\).  This is **not** a first hit:

\[
 11\le2\cdot1552.                                  \tag{7.2}
\]

It is included only as a strict fixed-unit warning.  Deep shifted
cancellation really occurs in this Pell sequence despite simple roots and
fixed global units.  It does not prove that a first-hit cube exists, let
alone infinitely many, and it is not used as a counterexample to a theorem
that makes essential use of \(t_p>2n\).

## 8. Subspace theorem and truncated SMT after the square-root pullback

The factorization (2.3) replaces the four target points for the
\(\lambda\)-orbit by the eight fixed points

\[
 D'=
 \sum_{\eta\in
 \{\pm\beta_b^{\pm1},\pm\beta_c^{\pm1}\}}[\eta]
\]

for the \(\alpha\)-orbit.  Outside a fixed finite set of bad places, its
truncated count is the same rational radical count as before.  Since
\(\alpha^2=\lambda\),

\[
 h(\alpha^n)={H_n\over4}.                          \tag{8.1}
\]

The Pell radical target would follow from the special-orbit inequality

\[
 N^{(1)}(D',\alpha^n)
 \ge(4-\epsilon)h(\alpha^n)-O_\epsilon(1).         \tag{8.2}
\]

The conjectural truncated Second Main Theorem coefficient for eight points
is \(8-2=6\).  Thus the square-root pullback creates real coefficient slack:
only coefficient \(4\), rather than the optimal \(6\), is needed.  This is a
useful reformulation of the target.

No audited unconditional theorem supplies even (8.2).  Ordinary Subspace
Theorem estimates are untruncated or fix a finite support set.  Here the
support moves with \(n\), and at each good prime exactly one of the eight
linear factors vanishes.  A gcd theorem requiring two simultaneous
independent vanishings therefore sees the opposite geometry.  Pulling back
to more target points does not create a second vanishing at the selected
prime.

Pasten's unconditional truncated approximation theorem remains on the
iterated-logarithmic scale when specialized to this orbit; its
Lang--Waldschmidt-strength version is conjectural.  Hence (8.2), even with
its two units of coefficient slack below the expected value, is still a new
one-orbit truncated-counting theorem.  It must not be labeled as an
application of the ordinary Subspace Theorem.

## 9. Exact surviving statements

The fixed-unit first-hit problem has now separated into two nonnegative
parts.

1. **Synchronized cyclotomic mass.**  Control the weighted powerful parts of
   the exact source and normalized target blocks
   \(\Phi_t(\lambda)\), \(\Phi_T(\gamma)\), subject to
   \(n=da,t=dT,T>2a\).  The carrier height is \(O(T)\), and
   \(T\gg\log n\) above the large-prime cutoff, but no available theorem
   sums these moving blocks with a sublinear pointwise bound.

2. **Small-representative collision mass.**  Control the fixed-unit centers
   whose level-\(J\) least representatives satisfy (5.3)--(5.4).  The clean
   cumulative sufficient form is (5.7).  Root density modulo \(p^j\), a
   base average, a prime-density theorem, or a separate \(O(1)\) endpoint
   estimate does not prove it.

Either an estimate for both parts, or a direct cross-target balance which
charges them to exponent-one support, would advance (1.1).  A full proof of
\(F_n^{\rm fh}=o(n)\) is sufficient but stronger than required.  The
possibility that the consecutive relation \(c_n-b_n=1\) enforces the weaker
balance remains open.

## 10. Formalization boundary

The companion module
`IUTThreeClosures/FreyPellFirstHitKummerSieveAudit.lean` proves only:

* the algebraic power identities in (0.2);
* the scalar order squeezes in (0.3);
* the natural-number form of the truncated-depth synchronization;
* the exact super-square decomposition (0.7);
* the small-representative inequality behind (0.9);
* a finite weighted endpoint-remainder inequality; and
* the exact finite recurrence computations in (7.1), together with the
  explicit warning (7.2).

Lean does not formalize or assume local order lifting, \(p\)-adic logarithms,
prime splitting, the cyclotomic resultant (3.8), norm heights, Kummer or ray
extensions, Chebotarev, a large sieve, the Subspace Theorem, Pasten's
theorem, (5.7), (8.2), or the desired Pell tail bound.  No missing analytic
or Diophantine statement is introduced as an axiom.

For the structural scalar lemmas, `#print axioms` reports only `propext`,
`Classical.choice`, and `Quot.sound` (or a subset).  The two explicit trace
residues and the order-\(11\) computation use `native_decide`; those
certificates and their finite
corollaries therefore expose Lean's generated native-evaluator trust axiom.
No analytic or Diophantine statement depends on that evaluator boundary.

## References

* K. Yu, *p-adic logarithmic forms and a problem of Erdos*, Acta Math. 211
  (2013), 315--382,
  [author PDF](https://archive.ymsc.tsinghua.edu.cn/pacm_download/117/6782-11511_2013_Article_106.pdf).
* Y. Bilu, H. Hong and S. Gun, *Uniform explicit Stewart's theorem on prime
  factors of linear recurrences*, Acta Arith. 206 (2022), 223--243,
  [author manuscript](https://arxiv.org/abs/2108.09857).
* Y. Bugeaud, P. Corvaja and U. Zannier, *An upper bound for the G.C.D. of
  \(a^n-1\) and \(b^n-1\)*, Math. Z. 243 (2003), 79--84,
  [journal record](https://doi.org/10.1007/s00209-002-0449-z).
* H. Pasten, *On the arithmetic case of Vojta's conjecture with truncated
  counting functions*, Math. Res. Lett. 32 (2025), 1249--1268,
  [author preprint](https://arxiv.org/abs/2205.07841).
* P. Vojta, *A more general abc conjecture* (1998),
  [primary text](https://arxiv.org/abs/math/9806171).
