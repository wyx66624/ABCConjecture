# The Mersenne Route at the Arithmetic Endpoint: Exact-Order Coupling at \(\sigma=1\)

**Author:** ChatGPT  
**Date:** 2 September 2026  
**Status:** research checkpoint; one unconditional paper-level estimate, one conditional endpoint reduction, and one exact reformulation of the surviving obstruction. This document does **not** prove the abc conjecture.

## 1. Purpose and logical boundary

Let the canonical exact-order repeated block and its logarithmic mass be
\[
  E_d:=\prod_{\substack{p\text{ prime}\\ \operatorname{ord}_p(2)=d}}
       p^{\,v_p(2^d-1)-1},
  \qquad
  a_d:=\log E_d
      =\sum_{\substack{p\text{ prime}\\ \operatorname{ord}_p(2)=d}}
        (v_p(2^d-1)-1)\log p.
\]
This is the exact-order block, not in general the full radical loss of
\(2^d-1\).  For example, at \(d=6\), primes of orders two and three occur in
\(2^6-1\), so the two quantities differ.
All logarithms are natural.
The fixed-window Mersenne route studies
\[
  \sum_{\substack{d\mid m\\ m/d<Q_m}}a_d,
  \qquad
  A_m:=\log(3m),\quad L_m:=\log A_m,\quad Q_m:=A_m^k,
\]
for a fixed \(k>0\). The earlier slow-slack checkpoint proved a two-arm reduction for every fixed \(\sigma>1\), with
\[
  F_{m,\sigma}:=A_mL_m^\sigma,
  \qquad
  H_{m,\sigma}:=\left\lfloor\sqrt{A_m/L_m^\sigma}\right\rfloor.
\]
The endpoint \(\sigma=1\) is not a harmless change of notation: the independently summed multiplier estimate loses its little-oh precisely there.

This note makes four advances at that endpoint.

1. The low one-copy arm is proved to be \(o(m)\) at \(\sigma=1\) by a direct weighted Brun--Titchmarsh argument. This is unconditional in the usual mathematical sense: its proof invokes established external theorems, not new conjectural hypotheses.
2. The low-multiplier deep arm is reduced to an exact-order Farey energy. This preserves the correlation between divisor index and multiplier and gives a sharp sufficient condition \(E_k(m)=o(\log m)\). That condition is not proved here.
3. The two surviving arms are identified exactly as a weighted packet of prime-power layers on which the order of \(2\) is stable under lifting. This is an equivalent localization, not a proof that the packet has small mass.
4. Although a finite all-\(m\) inclusion is false, the near-square arm is proved to lie inside the high-multiplier support uniformly in every fixed polylogarithmic window once \(m\) is sufficiently large. Thus both surviving arms share one asymptotic multiplier support.

The Lean companion formalizes only finite algebraic kernels and exact identities. It does not formalize weighted Brun--Titchmarsh, the totient estimate, Yamada's theorem, or any asymptotic assertion.

## 2. Exact-order rows and the endpoint partition

For a prime \(p\mid 2^d-1\), write
\[
  d_p:=\operatorname{ord}_p(2),\qquad
  w_p:=v_p(2^{d_p}-1),\qquad
  r_p:=\frac{p-1}{d_p}.
\]
Thus \(p=1+d_pr_p\). In the window \(d\mid m\), put \(q=m/d\). At \(\sigma=1\), set
\[
  F_m:=A_mL_m,
  \qquad
  H_m:=\left\lfloor\sqrt{A_m/L_m}\right\rfloor.
\]
For each \(d\), partition the repeated-prime mass into
\[
\begin{aligned}
U_d(m)&:=\sum_{\substack{d_p=d,\ w_p\ge2\\p\le d^2/F_m}}\log p,\\
B_d(m)&:=\sum_{\substack{d_p=d,\ w_p\ge2\\p>d^2/F_m}}\log p,\\
V_d(m)&:=\sum_{\substack{d_p=d,\ w_p\ge3\\r_p<H_m}}(w_p-2)\log p,\\
G_d(m)&:=\sum_{\substack{d_p=d,\ w_p\ge3\\r_p\ge H_m}}(w_p-2)\log p.
\end{aligned}
\]
The identity
\[
  a_d=U_d(m)+B_d(m)+V_d(m)+G_d(m)
\]
is exact. The labels have the following meanings:

- \(U\): the first repeated copy at small prime size;
- \(B\): the first repeated copy at near-square or larger size;
- \(V\): all copies beyond the first at low multiplier;
- \(G\): all copies beyond the first at high multiplier.

All quantifiers below concern integers \(m\to\infty\) with fixed \(k\).

## 3. An unconditional endpoint estimate for the low one-copy arm

### Theorem 3.1 (weighted Brun--Titchmarsh closes \(U\) at \(\sigma=1\))

For every fixed \(k>0\),
\[
  \sum_{\substack{d\mid m\\m/d<Q_m}}U_d(m)=o(m).
\]

#### Proof

Fix a divisor \(d\mid m\) in the window and put \(X=d^2/F_m\). Every prime counted by \(U_d(m)\) satisfies \(p\equiv1\pmod d\), so
\[
  U_d(m)\le \vartheta(X;d,1)
  :=\sum_{\substack{p\le X\\p\equiv1\pmod d}}\log p.
\]
Since \(m/d<Q_m\), we have \(d>m/Q_m\). Consequently, uniformly in the window,
\[
  \frac{d}{F_m}\longrightarrow\infty,
  \qquad
  F_m^2<d
\]
for all sufficiently large \(m\). The second inequality implies \(d<X^{2/3}\). The weighted Brun--Titchmarsh estimate of Murty and S\'eguin, applied with the fixed exponent \(\theta=2/3<1\), therefore gives
\[
  \vartheta(X;d,1)
  \le
  \frac{2X\log X}{\varphi(d)\log(X/d)}
\]
uniformly for all sufficiently large \(m\). Also,
\[
  \log X\le2\log d,
  \qquad
  \log(X/d)=\log(d/F_m)\ge\frac12\log d
\]
uniformly in the same window. Hence
\[
  U_d(m)\ll \frac{d^2}{F_m\varphi(d)}.
\]
The classical uniform totient bound
\[
  \frac d{\varphi(d)}\ll\log\log(3d)\le L_m+O(1)
\]
now yields
\[
  U_d(m)\ll \frac d{A_m}.
\]
Writing \(d=m/q\), summing over the window, and then enlarging to all integers \(q<Q_m\),
\[
\begin{aligned}
  \sum_{\substack{d\mid m\\m/d<Q_m}}U_d(m)
  &\ll \frac m{A_m}
       \sum_{\substack{q\mid m\\q<Q_m}}\frac1q\\
  &\le \frac m{A_m}\bigl(1+\log Q_m\bigr)\\
  &=O_k\!\left(m\frac{L_m}{A_m}\right)
   =o(m).
\end{aligned}
\]
This proves the assertion. \(\square\)

### Remark 3.2 (what changed at the endpoint)

The earlier injection \(p=1+dr\) alone gives approximately \(H_m^2\log Q_m\), which is of order \(A_m\) at \(\sigma=1\). Theorem 3.1 instead sums primes in progressions with their logarithmic weights. The saving comes from the factor \(d/\varphi(d)\), controlled before the divisor harmonic sum is taken. Thus the theorem is a new endpoint argument and not a relabeling of the \(\sigma>1\) result.

## 4. The low-multiplier deep arm as an exact-order Farey energy

Define the actual endpoint support
\[
\mathcal S_k(m):=
\left\{(q,r,p):
\begin{array}{l}
q\mid m,\quad q<Q_m,\quad d=m/q,\\
p\text{ prime},\quad \operatorname{ord}_p(2)=d,\\
w_p\ge3,\quad p=1+dr,\quad 1\le r<H_m
\end{array}
\right\}.
\]
Its Farey energy and cardinality are
\[
  E_k(m):=\sum_{(q,r,p)\in\mathcal S_k(m)}\frac rq,
  \qquad
  N_k(m):=|\mathcal S_k(m)|.
\]

### Proposition 4.1 (cross-fibre slope injectivity)

For a fixed \(m\), distinct rows of \(\mathcal S_k(m)\) have distinct rational slopes \(r/q\).

#### Proof

If \(r_1/q_1=r_2/q_2\), then
\[
  d_1r_1=\frac m{q_1}r_1
         =\frac m{q_2}r_2=d_2r_2.
\]
Thus \(p_1=1+d_1r_1=1+d_2r_2=p_2\). A prime has only one exact order for the base \(2\), so \(d_1=d_2\). Since \(d_iq_i=m\) and \(d_i>0\), it follows that \(q_1=q_2\), and then \(r_1=r_2\). \(\square\)

The previous multiplier count used injectivity only inside one fibre \(d\). Proposition 4.1 shows that exact order couples all fibres through one Farey diagram.

### Proposition 4.2 (energy is a localized prime first moment)

For every positive \(m\),
\[
  E_k(m)=\frac1m
    \sum_{(q,r,p)\in\mathcal S_k(m)}(p-1).
\tag{4.1}
\]
Consequently (4.5) is equivalent to the localized estimate
\[
  \sum_{(q,r,p)\in\mathcal S_k(m)}(p-1)=o(m\log m).
\]

#### Proof

Every row has \(d=m/q\) and \(p-1=dr\). Hence
\[
  \frac rq=\frac{dr}{dq}=\frac{p-1}{m}.
\]
Summation gives (4.1), and multiplication by \(m\) gives the equivalence.
\(\square\)

This form shows the precise missing arithmetic input: one needs a first
moment estimate for super-Wieferich primes whose exact orders are
near-diagonal divisors of the same \(m\). A global count of primes or an
unweighted order theorem does not by itself control this localized moment.

### Theorem 4.3 (correlation-preserving Yamada transfer)

Assume the published Yamada-type pointwise estimate in the form
\[
  (w_p-2)\log p
  \le C_Y\frac{d_pr_p}{\log p}+2\log p
  \tag{4.2}
\]
for every row with \(w_p\ge3\), where \(C_Y\) is an absolute constant. Then, for every fixed \(k>0\) and all sufficiently large \(m\),
\[
\sum_{\substack{d\mid m\\m/d<Q_m}}V_d(m)
\le
\frac{C_Ym}{\log(m/Q_m)}E_k(m)
+2N_k(m)\log(1+mH_m).
\tag{4.3}
\]
Moreover,
\[
  N_k(m)\le H_mQ_m,
  \qquad
  2N_k(m)\log(1+mH_m)=o(m).
\tag{4.4}
\]

#### Proof

For a row of \(\mathcal S_k(m)\),
\[
  d_pr_p=\frac m q r=m\frac rq,
  \qquad
  \log p\ge\log d_p\ge\log(m/Q_m).
\]
Also \(p=1+d_pr_p\le1+mH_m\). Substitution in (4.2) and summation over the actual support gives (4.3).

There are fewer than \(Q_m\) possible positive integers \(q\) and fewer than \(H_m\) possible positive integers \(r\), while Proposition 4.1 prevents duplicate rows at a fixed pair. This gives the first part of (4.4). Finally,
\[
  H_mQ_m\log(1+mH_m)
  =O_k\!\left(A_m^{k+3/2}L_m^{-1/2}\right)
  =o(m),
\]
which proves the second part. \(\square\)

### Corollary 4.4 (the exact endpoint condition for this method)

If
\[
  E_k(m)=o(\log m),
  \tag{4.5}
\]
then
\[
  \sum_{\substack{d\mid m\\m/d<Q_m}}V_d(m)=o(m).
\]

Indeed, \(\log(m/Q_m)\sim\log m\), so the first term of (4.3) is \(o(m)\), and the second is \(o(m)\) by (4.4).

Condition (4.5) is a genuine unresolved arithmetic estimate. It asks for cancellation or sparsity in the joint distribution of the divisor index \(q=m/d_p\) and exact-order multiplier \(r_p=(p-1)/d_p\). It cannot be replaced by independent bounds for \(q\) and \(r\).

### Proposition 4.5 (slope separation alone cannot supply the saving)

Let
\[
  \mathcal F_N:=\{(q,r):1\le q,r\le N,\ \gcd(q,r)=1\}.
\]
The slopes \(r/q\) are pairwise distinct, because every pair is reduced, yet
\[
  \sum_{(q,r)\in\mathcal F_N}\frac rq
  \sim \frac3{\pi^2}N^2\log N.
\tag{4.6}
\]

#### Proof

For fixed \(q\), Möbius inversion gives
\[
  \sum_{\substack{1\le r\le N\\(r,q)=1}}r
  =\frac{N^2}{2}\frac{\varphi(q)}q+O(N\tau(q)).
\]
After division by \(q\) and summation, the main term follows from
\[
  \sum_{q\le N}\frac{\varphi(q)}{q^2}
  =\frac6{\pi^2}\log N+O(1),
\]
and the total error is \(O(N^2)\). \(\square\)

This is a counterexample only to the proposed inference “distinct slopes imply a little-oh Farey energy.” It is **not** a counterexample to the Mersenne route: \(\mathcal F_N\) does not impose \(q\mid m\), primality of \(1+(m/q)r\), exact order, or depth at least three. Those are precisely the correlations that (4.5) must exploit.

## 5. Stable lifting packages the two surviving arms

For an odd prime \(p\), let \(\operatorname{ord}_{p^j}(2)\) denote the multiplicative order of \(2\) modulo \(p^j\).

### Proposition 5.1 (exact stable-lift criterion)

Let \(d=\operatorname{ord}_p(2)\) and \(w=v_p(2^d-1)\). For every integer \(j\ge1\),
\[
  j\le w
  \quad\Longleftrightarrow\quad
  \operatorname{ord}_{p^j}(2)=d.
\tag{5.1}
\]

#### Proof

If \(j\le w\), then \(2^d\equiv1\pmod{p^j}\), so \(e:=\operatorname{ord}_{p^j}(2)\) divides \(d\). Reduction modulo \(p\) shows that \(d=\operatorname{ord}_p(2)\) divides \(e\). Hence \(e=d\). Conversely, if \(\operatorname{ord}_{p^j}(2)=d\), then \(p^j\mid2^d-1\), so \(j\le w\). \(\square\)

It follows exactly that
\[
  a_d
  =\sum_{\substack{p\text{ prime}\\d_p=d}}
     \sum_{j=2}^{w_p}\log p.
\tag{5.2}
\]
Thus the repeated-prime mass in the canonical exact-order block is a
weighted count of stable exact-order prime-power layers.

Define the critical stable-layer packet \(\mathcal C_k(m)\) to consist of quadruples \((d,p,j,q)\) satisfying
\[
\begin{gathered}
  d\mid m,\quad q=m/d<Q_m,\quad d_p=d,\quad 2\le j\le w_p,\\
  \bigl(j=2\ \text{and}\ p>d^2/F_m\bigr)
  \quad\text{or}\quad
  \bigl(j\ge3\ \text{and}\ r_p\ge H_m\bigr).
\end{gathered}
\]

### Theorem 5.2 (exact two-arm layer identity)

The weighted mass of \(\mathcal C_k(m)\) is exactly
\[
  \sum_{(d,p,j,q)\in\mathcal C_k(m)}\log p
  =
  \sum_{\substack{d\mid m\\m/d<Q_m}}
    \bigl(B_d(m)+G_d(m)\bigr).
\tag{5.3}
\]

#### Proof

For every prime with \(w_p\ge2\), the layer \(j=2\) contributes exactly one copy of \(\log p\); selecting it by \(p>d^2/F_m\) gives \(B_d(m)\). The layers \(3\le j\le w_p\) contribute exactly \((w_p-2)\log p\); selecting them by \(r_p\ge H_m\) gives \(G_d(m)\). The two layer ranges are disjoint, so their union has precisely the sum in (5.3). \(\square\)

The two alternatives have complementary small-order geometry. If a selected layer belongs to \(B\), then with \(n=p^2\),
\[
  d<\sqrt{pF_m}=n^{1/4}\sqrt{F_m}.
\tag{5.4}
\]
If it belongs to \(G\), then for \(n=p^j\), \(j\ge3\),
\[
  d=\frac{p-1}{r_p}<\frac p{H_m}
   =\frac{n^{1/j}}{H_m}
  \le\frac{n^{1/3}}{H_m}.
\tag{5.5}
\]

### Proposition 5.3 (finite cutoff coupling)

Let \(d,p,r,H\) be positive integers, let \(F>0\), and suppose
\[
  p=1+dr,
  \qquad
  dH\le\frac{d^2}{F}.
\tag{5.6}
\]
If \(p>d^2/F\), then \(r\ge H\).

#### Proof

If \(r<H\), integrality gives \(r\le H-1\), and therefore
\[
  p=1+dr\le1+d(H-1)\le dH\le d^2/F,
\]
contradicting the strict size inequality. \(\square\)

### Corollary 5.4 (eventual common high-multiplier support)

Fix \(k>0\). For all sufficiently large \(m\), uniformly for every
\(d\mid m\) with \(m/d<Q_m\), every prime counted by \(B_d(m)\) satisfies
\[
  r_p\ge H_m.
\tag{5.7}
\]

#### Proof

The window gives \(d>m/A_m^k\), while
\[
  F_mH_m
  \le A_mL_m\sqrt{A_m/L_m}
  =A_m^{3/2}\sqrt{L_m}.
\]
Since
\[
  \frac{m}{A_m^{k+3/2}\sqrt{L_m}}\longrightarrow\infty,
\]
we have \(F_mH_m<d\), and hence \(dH_m<d^2/F_m\), uniformly in the
window for all sufficiently large \(m\). Proposition 5.3 applies. \(\square\)

Define the complete high-multiplier repeated-layer mass
\[
  R_k^{\mathrm{hi}}(m):=
  \sum_{\substack{d\mid m\\m/d<Q_m}}
  \sum_{\substack{d_p=d,\ w_p\ge2\\r_p\ge H_m}}
       (w_p-1)\log p.
\tag{5.8}
\]
Corollary 5.4 and the layer identity give, eventually,
\[
  \sum_{\substack{d\mid m\\m/d<Q_m}}(B_d(m)+G_d(m))
  \le R_k^{\mathrm{hi}}(m).
\tag{5.9}
\]
Thus \(R_k^{\mathrm{hi}}(m)=o(m)\) is a single sufficient estimate for both
surviving arms. It is not proved here. Every layer in this enlarged packet
has stable order through its exponent and
\[
  d_p=\frac{p-1}{r_p}<\frac p{H_m},
  \qquad H_m\longrightarrow\infty.
\tag{5.10}
\]
This is a genuine common localization of the two arms. It does not follow
from present unweighted order-distribution results, because those results do
not control the repeated-prime intersection with this fixed divisor window.

Therefore the remaining Mersenne obstruction is a family of prime powers for which the order of \(2\) is stable through the selected layer and is unusually small relative to that layer.

## 6. The endpoint two-arm consequence

### Theorem 6.1 (conditional \(\sigma=1\) reduction)

Fix \(k>0\) and assume (4.5). Suppose that for some \(\varepsilon>0\) there is an infinite sequence \(m\to\infty\) such that
\[
  \sum_{\substack{d\mid m\\m/d<Q_m}}a_d\ge\varepsilon m.
\tag{6.1}
\]
Then for every \(0<\gamma<1/2\), after passage to an infinite subsequence, at least one of the following holds throughout that subsequence:
\[
  \sum_{\substack{d\mid m\\m/d<Q_m}}B_d(m)\ge\gamma\varepsilon m,
  \tag{6.2}
\]
or
\[
  \sum_{\substack{d\mid m\\m/d<Q_m}}G_d(m)\ge\gamma\varepsilon m.
  \tag{6.3}
\]
Equivalently, the stable-layer packet (5.3) has linear weighted mass, and one of its two disjoint geometries has asymptotically at least half of that mass. By Corollary 5.4, the enlarged common high-multiplier packet (5.8) also has linear mass on that subsequence.

#### Proof

By Theorem 3.1 and Corollary 4.4, the sums of \(U_d(m)\) and \(V_d(m)\) over the window are \(o(m)\). The exact four-way identity therefore gives
\[
  \sum(B_d+G_d)\ge(\varepsilon-o(1))m.
\]
For fixed \(\gamma<1/2\), both \(B\) and \(G\) cannot remain below \(\gamma\varepsilon m\) once the error is smaller than \((1-2\gamma)\varepsilon m\). One alternative occurs infinitely often. The last assertion follows from Theorem 5.2. \(\square\)

## 7. Exact finite counterexample boundary

The reproducible evidence bundle is
`research/computation/2026_09_02_mersenne_sigma_one/`. Its C++ program
sieves every prime through \(10^9\), and its standard-library Python verifier
checks the exact arithmetic of every hit used below. The logarithmic window
comparisons are certified by exact rational Taylor lower bounds and
geometric-tail upper bounds; they do not rely on Decimal rounding.

### Proposition 7.1 (a full-fibre \(B>0\), \(G=0\) witness)

Take
\[
  p=1093,\qquad d=364,\qquad q=10^{12},\qquad
  m=dq,\qquad k=8.
\]
Then \(q<Q_m\), \(p>d^2/F_m\), \(H_m=3=r_p\), and
\[
  \Phi_{364}(2)
  =1093^2\cdot4733\cdot8861085190774909
     \cdot556338525912325157.
\tag{7.1}
\]
All four displayed factors are prime and have exact base-two order \(364\).
The last three have depth one, while \(1093\) has depth exactly two.
Consequently the complete exact-order fibre satisfies
\[
  U_{364}(m)=V_{364}(m)=G_{364}(m)=0,
  \qquad
  B_{364}(m)=a_{364}=\log1093>0.
\tag{7.2}
\]

#### Proof

The exact-order and depth assertions follow from the complete factorization
(7.1), Lucas \(p-1\) primality certificates for all four factors, the
nontrivial residues \(2^{364/\ell}\pmod p\) for every prime \(\ell\mid364\),
and the residues modulo \(p^2,p^3\) archived in the verifier output.

For the real inequalities, exact rational exponential enclosures give
\[
  34.5<A_m<35,
  \qquad
  3.54<L_m<3.56.
\tag{7.3}
\]
Direct rational arithmetic gives
\[
  10^{12}<34.5^8<A_m^8,
  \qquad
  1093\cdot34.5\cdot3.54>364^2.
\tag{7.4}
\]
Thus the window and strict \(B\)-inequality hold. Moreover
\[
  9<\frac{34.5}{3.56}<\frac{A_m}{L_m}
  <\frac{35}{3.54}<16,
\]
so \(H_m=3\). Equation (7.2) now follows from the complete fibre and its
depths. \(\square\)

For every fixed finite \(C\ge0\), Proposition 7.1 is a full-premise
counterexample to the universal pointwise estimate \(B_d(m)\le C G_d(m)\).
It also refutes the claims that \(B\) is always empty or that a repeated row
with \(r_p\ge H_m\) must have depth at least three. It does not refute
\(\sum B_d(m)=o(m)\), because one fixed prime cannot remain in a fixed
\(k\)-window as \(q\to\infty\).

### Proposition 7.2 (a \(B\)-carrier below the multiplier cutoff)

Take
\[
  p=3511,\qquad d=1755,\qquad q=10^{71},\qquad
  m=dq,\qquad k=32.
\]
Then \(p\) is prime, \(d_p=1755\), \(w_p=2\), \(q<Q_m\),
\(p>d^2/F_m\), and
\[
  r_p=2<H_m=5.
\tag{7.5}
\]

#### Proof

Primality, exact order, and exact depth are certified by the archived Lucas,
order, and prime-power residues. Exact rational exponential enclosures give
\[
  172<A_m<172.1,
  \qquad
  5.14<L_m<5.15.
\]
The exact comparisons
\[
  10^{71}<172^{32},
  \qquad
  3511\cdot172\cdot5.14>1755^2
\]
prove the window and \(B\) conditions. Finally,
\[
  25<\frac{172}{5.15}<\frac{A_m}{L_m}
  <\frac{172.1}{5.14}<36,
\]
so \(H_m=5\), whereas \((3511-1)/1755=2\). \(\square\)

Proposition 7.2 is a full-premise counterexample to the proposed pointwise
inclusion “for every \(m\), every \(B\)-carrier has \(r_p\ge H_m\).” It does
not refute Corollary 5.4, whose fixed-window quantifier is “for all
sufficiently large \(m\).” The finite witness shows why that quantifier must
remain explicit.

### Finite search boundary

The exhaustive scan contains all \(50{,}847{,}534\) primes \(p\le10^9\).
Exact-order LTE and \(p\nmid(p-1)/d_p\) make the tested congruence
\(2^{p-1}\equiv1\pmod{p^2}\) equivalent to \(w_p\ge2\).
Its only base-two repeated hits are
\[
  (p,d_p,r_p,w_p)=(1093,364,3,2),
  \quad(3511,1755,2,2).
\tag{7.6}
\]
Thus no depth-three carrier occurs in this bounded range. This finite
no-hit is not an asymptotic theorem and does not eliminate the \(G\) route.

For a fixed repeated row \((p,d)\), put \(A=\log(3dq)\). The two relevant
conditions are
\[
  A\log A>d^2/p,
  \qquad
  h_d(A):=\frac{A-\log(3d)}{\log A}<k.
\tag{7.7}
\]
The function \(h_d\) is strictly increasing for \(A>e\) and tends to
infinity. Hence, for fixed \((p,d,k)\), the window permits only bounded
\(q\). In particular, neither Proposition 7.1 nor Proposition 7.2 can be
repeated with the same prime to manufacture an asymptotic counterexample.

The logically valid retirements are now precise:

- retire \(B=0\), pointwise \(B\le C G\), the all-\(m\) form of
  \(B\Rightarrow r\ge H\), and “high-multiplier repeated implies deep”;
- retain and use the eventual fixed-window implication in Corollary 5.4;
- retain both actual asymptotic targets \(\sum B=o(m)\) and \(\sum G=o(m)\);
- treat slope/Farey saturation only as a counterexample to an abstract
  inference from positivity and injectivity, not to the arithmetic packet.

## 8. What remains to be proved

The endpoint analysis now has two exact unresolved estimates.

### 8.1 Low-multiplier exact-order energy

Prove, for every fixed \(k>0\),
\[
  E_k(m)=o(\log m).
\tag{8.1}
\]
A useful strengthening would be a uniform bound \(E_k(m)\ll (\log m)^{1-\delta}\) for some \(\delta>0\). Proposition 4.5 shows that order uniqueness and slope injectivity by themselves are insufficient. Any proof must use at least one of primality, exact order, depth \(w_p\ge3\), or the common divisibility constraint \(q\mid m\) in a quantitative way.

### 8.2 Stable small-order prime-power mass

Prove
\[
  \sum_{(d,p,j,q)\in\mathcal C_k(m)}\log p=o(m).
\tag{8.2}
\]
By (5.3), this is exactly the simultaneous estimate \(\sum(B_d+G_d)=o(m)\). It combines the near-square one-copy Wieferich mass and the high-multiplier deep exact-order mass in one lift-stable object. Neither existing unconditional order-distribution theorems nor known fixed-base Wieferich results currently imply (8.2).

The stronger one-line target
\[
  R_k^{\mathrm{hi}}(m)=o(m)
\]
would also suffice by (5.9). Its advantage is a common support and the
uniform relative-order bound (5.10); its disadvantage is that it includes
additional high-multiplier layers not present in \(B+G\). The exact target
(8.2) should therefore remain active even if this stronger enlargement
cannot be proved.

No finite computation can prove either (8.1) or (8.2), and a finite search with no violations cannot eliminate either route. A genuine counterexample to the endpoint Mersenne conclusion must satisfy the full simultaneous premises: a common \(m\), the divisor window, primality, exact order \(d_p=m/q\), and the required depth. Abstract Farey saturation such as Proposition 4.5 does not meet those premises.

## 9. Formalization and evidence ledger

The companion Lean module proves only the following finite statements:

1. cross-fibre injectivity from the common-index equations and uniqueness of exact order;
2. the finite size-to-multiplier cutoff implication in Proposition 5.3;
3. the exact equality between Farey energy and the localized prime first moment;
4. a finite weighted-energy transfer inequality from a supplied pointwise bound;
5. the actual prime-power stable-order criterion (5.1), via mutual divisibility of the two orders;
6. exact finite layer-count identities separating layer \(2\) from layers \(3,\ldots,w\);
7. the finite two-arm ledger used after supplied low-arm budgets.

Lean does not certify the external analytic inputs or any limit:

- weighted Brun--Titchmarsh;
- the uniform bound for \(d/\varphi(d)\);
- the Yamada-type pointwise estimate (4.2);
- the Möbius-inversion asymptotic (4.6);
- hypotheses (8.1) or (8.2).

The exact integer and rational certificates in Section 7 prove only their
two finite witness statements. The exhaustive scan result is evidence about
the bounded range \(p\le10^9\); it is not used to prove an asymptotic claim.

## References and source boundary

1. M. Ram Murty and François S\'eguin, *Prime divisors of sparse values of cyclotomic polynomials and Wieferich primes*, Journal of Number Theory 201 (2019), 1--22, [DOI](https://doi.org/10.1016/j.jnt.2019.02.016).  The weighted Brun--Titchmarsh estimate used above is their Theorem 2.4 and remains an external paper-level input.
2. Tomohiro Yamada, *A note on the paper by Bugeaud and Laurent “Minoration effective de la distance p-adique entre puissances de nombres algébriques”*, Journal of Number Theory 130 (2010), 1889--1897, [DOI](https://doi.org/10.1016/j.jnt.2010.02.018), [primary manuscript](https://arxiv.org/abs/math/0607072). The pointwise valuation inequality is an external paper-level input.
3. `research/ABC_MERSENNE_CRITICAL_SLOW_SLACK_GATE_2026_09_01.md`.
4. `research/ABC_MERSENNE_BALANCED_MULTIPLIER_DEPTH_LOCALIZATION_2026_09_01.md`.
5. `research/ABC_MERSENNE_TOTIENT_DIVISOR_CONCENTRATION_2026_09_01.md`.
6. `research/ABC_MERSENNE_MULTIPLIER_INDEX_TWO_ARM_2026_09_01.md`.
7. `research/ABC_MERSENNE_SUPER_WIEFERICH_DEPTH_2026_09_01.md`.
8. `research/computation/2026_09_02_mersenne_sigma_one/README.md` and its frozen exact outputs.
