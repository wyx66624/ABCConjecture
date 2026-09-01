# Actual radical budgets in exceptional-set amplification

Author: ChatGPT. Date: 2026-08-30.

This report continues the global abc investigation without claiming an abc
proof or disproof. It addresses actual prime support, including repeated new
prime factors, rather than imposing the cofactor-size certificates studied in
`research/ANALYTIC_AMPLIFICATION_CONTINUATION_2026_08_30.md`.
The main unconditional counting result below allows arbitrary new primes.
Its combination with the previously proved complete conic-fibre count gives
a necessary height range for a fixed-exponent counting contradiction. It
does not supply the output lower bound still needed in that range.

All mathematical arguments in Sections 2--7 were written before the new
companion Lean module. The published S-unit estimate and the analytic
counting arguments are not introduced into Lean as axioms. No claim of
priority over the literature is made for these corollaries.

## 1. The precise target and the existing boundary

Throughout, a seed consists of positive integers `a,b,c` with `a+b=c` and
`gcd(a,b)=1`. Thus its three coordinates are pairwise coprime. Write

\[
 P=abc,\qquad R=\operatorname{rad}(P),\qquad c\ge2.
 \tag{1.1}
\]

Outputs are ordered positive primitive triples `A+B=C`. For fixed
`0<mu<1`, the available BBLT v2 estimate for strict exceptions is

\[
 \#\{(A,B,C):C\le T,\ \operatorname{rad}(ABC)<C^\mu\}
 \ll_{\mu,\delta}T^{F(\mu)+\delta},\qquad
 F(\mu)=\min\left\{\frac{2\mu}{3},
                      \frac{23\mu+3}{40},\frac35\right\},
 \quad\delta>0.
 \tag{1.2}
\]

This is the combination of Proposition 1.1 and Theorems 1.2--1.3 in
[Bernert--Browning--Lichtman--Teräväinen, arXiv:2410.12234v2](https://arxiv.org/html/2410.12234v2).
At output height `T=c^K`, a contradiction obtained by a uniform power lower
bound needs at least `c^alpha` distinct strict exceptions with
`alpha>K F(mu)`, where `K,mu,alpha` and the positive exponent gap are fixed
before the seed height tends to infinity. An upper bound on a fibre does
not itself produce such a lower bound.

The preceding report already proved, for positive integer solutions of

\[
 ax^2+by^2=cz^2
 \tag{1.3}
\]

whose unscaled output `(ax^2,by^2,cz^2)` is primitive, the complete-fibre
bound

\[
 \#\{(ax^2,by^2,cz^2):cz^2\le T\}
 \le \tau(P)\left(1+4\pi\sqrt{T/P}\right),\qquad T>0.
 \tag{1.4}
\]

It separately excluded the more restrictive radical certificate
`Rxyz<=C^mu`. The new work below uses the actual radical and hence includes
outputs not satisfying that certificate. The old fixed-support S-unit
arguments in `Lean/SUNIT_ANCHORED_DESCENT_BARRIER.md` and
`Lean/GLOBAL_ABC_PELL_TRIPOD_FINITE_ORBIT_AUDIT.md` were also checked: they
do not sum over the arbitrary new supports allowed in Section 2.

## 2. Counting actual radicals while retaining prescribed support

### Theorem 2.1. A bound independent of output height

Let `R>=1` be a squarefree integer and `Y>0` a real number. Let `N(R,Y)`
be the number of all ordered positive primitive integer triples `A+B=C`
such that

\[
 R\mid\operatorname{rad}(ABC),\qquad
 \operatorname{rad}(ABC)\le Y.
 \tag{2.1}
\]

There is no bound on `C` in this definition. If `Y<R`, then `N(R,Y)=0`.
If `Y>=R`, put `X=Y/R>=1`. Then

\[
 \boxed{N(R,Y)\le
 905\,45^{\omega(R)}\,X(1+\log X)^{44}.}
 \tag{2.2}
\]

#### Proof

The empty case follows at once from divisibility of a positive integer.
Otherwise, each output determines the squarefree integer

\[
 D=\operatorname{rad}(ABC)/R\le X,
 \qquad \gcd(D,R)=1.
 \tag{2.3}
\]

Fix this integer `D`. Take the number field `K=Q` and let `S` contain its
archimedean place and all primes dividing `RD`. Then

\[
 s=|S|=1+\omega(R)+\omega(D).
\]

The pair `(A/C,B/C)` consists of `S`-units and solves `u+v=1`.
This association is injective: `A/C` is a reduced positive rational
number, since `gcd(A,C)=1`; its numerator and denominator recover `A,C`,
and then `B=C-A`. In particular we do not count many choices of integer
scaling as distinct solutions of the unit equation.

Theorem 1.1 of Hirata-Kohno, Kawashima, Poels and Washio bounds the number
of solutions of a two-term `S`-unit equation over a degree-`m` number
field by

\[
 (3.1+5(3.4)^m)45^s.
 \tag{2.4}
\]

Its hypotheses allow the coefficients to be `1,1`; its set of places
contains all archimedean places, exactly as chosen here. With `m=1`, the
bound for the fixed `D` is

\[
 20.1\,45^{1+\omega(R)+\omega(D)}
 =904.5\,45^{\omega(R)+\omega(D)}
 <905\,45^{\omega(R)+\omega(D)}.
 \tag{2.5}
\]

The source is the original
[Theorem 1.1, PDF page 1, arXiv:2211.14399v1](https://arxiv.org/pdf/2211.14399v1),
published in *International Journal of Number Theory* 19(10) (2023),
2427--2442, [DOI 10.1142/S1793042123501191](https://doi.org/10.1142/S1793042123501191).
The formula and the place convention were checked in the rendered original.

For an integer `M>=1`, write `d_M(n)` for the number of ordered positive
`M`-tuples with product `n`. Prime factorization gives

\[
 d_M(n)=\prod_{p^e\Vert n}\binom{e+M-1}{M-1}\ge M^{\omega(n)}.
 \tag{2.6}
\]

For any real `X>=1`, fixing the first `M-1` entries and bounding the number
of choices for the last one gives

\[
 \begin{aligned}
 \sum_{n\le X}d_M(n)
 &\le X\sum_{n_1\cdots n_{M-1}\le X}
               \frac1{n_1\cdots n_{M-1}}\\
 &\le X\left(\sum_{1\le n\le X}\frac1n\right)^{M-1}
 \le X(1+\log X)^{M-1}.
 \end{aligned}
 \tag{2.7}
\]

For `M=1` the empty tuple has product one and this proof still applies.
For `X=1` each sum in (2.7) is exactly one, so no boundary exception is
being suppressed. Summing (2.5) over the finitely many admissible `D`,
discarding squarefreeness and coprimality only to enlarge the sum, and using
(2.6)--(2.7) with `M=45` proves (2.2). This also proves that `N(R,Y)` is
finite. QED.

This result charges new prime support by its actual product `D`. It does
not bound exponents of old or new primes and does not require that new
primes lie in a preselected finite set.

### Corollary 2.2. Uniform form for a seed and polynomial output height

Fix `K>0`, `0<mu<1`, and `epsilon>0`. For every seed (1.1), the number of
outputs satisfying

\[
 R\mid\operatorname{rad}(ABC),\quad
 \operatorname{rad}(ABC)\le C^\mu,\quad C\le T\le c^K
 \tag{2.8}
\]

is zero if `T^mu<R`, and otherwise is at most

\[
 C_{\epsilon,K,\mu}\,c^\epsilon\frac{T^\mu}{R}.
 \tag{2.9}
\]

#### Proof

Use Theorem 2.1 with `Y=T^mu`. Here `R<=P<=c^3`. For every fixed
`eta>0`, split the prime divisors of `R` into the finitely many primes
`p<45^(1/eta)` and the remaining primes. The latter satisfy `45<=p^eta`,
so

\[
 45^{\omega(R)}\le C_\eta R^\eta\le C_\eta c^{3\eta}.
\]

Choose `eta=epsilon/6`, independently of the seed. Also
`log(T^mu/R)<=K mu log c`, so its fixed 44th logarithmic power is at most
`C_{epsilon,K,mu} c^(epsilon/2)`. Insert these estimates in (2.2).
All parameters determining the constants were fixed before `c` varied.
QED.

At `T=c^K`, put `sigma=log R/log c`. The exponent in (2.9) is
`K mu-sigma+epsilon`; nonemptiness implies `K mu-sigma>=0`.
An exceptional seed supplies an *upper* bound on `sigma`. Such an upper
bound must not be substituted as a lower bound in (2.9). Very high-quality
seeds, for which `sigma` is small, have more room under this estimate.

## 3. An exact account of the repeated-prime saving

For positive integers `P,n`, define

\[
 D_P(n)=\prod_{\substack{p\mid n\\p\nmid P}}p,
 \qquad E_P(n)=\frac{n}{D_P(n)}\in\mathbb N_{>0}.
 \tag{3.1}
\]

The factor `D_P(n)` is squarefree and coprime to `rad(P)`. Since it divides
`n`, the second quantity is an integer. Its prime factorization is

\[
 E_P(n)=
 \prod_{p\mid P}p^{v_p(n)}
 \prod_{\substack{p\nmid P\\p\mid n}}p^{v_p(n)-1}.
 \tag{3.2}
\]

Thus it counts both reuse of old support and powers of genuinely new
primes. Comparing the prime divisors on both sides gives the exact identity

\[
 \operatorname{rad}(Pn^2)=\operatorname{rad}(Pn)
 =\operatorname{rad}(P)D_P(n).
 \tag{3.3}
\]

### Proposition 3.1. The actual conic budget

For every positive integer completion (1.3), put
`A=ax^2,B=by^2,C=cz^2`, whether or not the output is primitive. Then

\[
 \operatorname{rad}(ABC)E_P(xyz)=Rxyz.
 \tag{3.4}
\]

If `rad(ABC)<=C^mu`, then necessarily

\[
 \boxed{E_P(xyz)\ge \frac{R}{c}C^{1-\mu}.}
 \tag{3.5}
\]

#### Proof

The identity `ABC=P(xyz)^2` and (3.3) prove (3.4). The weighted average
equation `c z^2=a x^2+b y^2` implies `max(x,y)>=z`. Since `x,y>=1`,
we have `xy>=max(x,y)` and hence `xyz>=z^2=C/c`. Therefore

\[
 RC/c\le Rxyz
 =\operatorname{rad}(ABC)E_P(xyz)
 \le C^\mu E_P(xyz).
\]

Division by the positive number `C^mu` proves (3.5). Equivalently, without
division, `RC<=c E_P(xyz) C^mu`. QED.

This is a necessary inequality for the actual radical, not an assumed
certificate. It explains exactly which additional factors can allow an
output to escape the earlier certificate: setting `E_P(xyz)=1` recovers
the old cutoff, but the present analysis never assumes that equality.

## 4. Combining the actual support budget and the complete conic fibre

Put

\[
 \rho=\frac{\log P}{\log c},\qquad
 \sigma=\frac{\log R}{\log c}.
 \tag{4.1}
\]

Both are positive. In particular `P>=c(c-1)` and `P<=c^3/4`, but neither
`rho` nor `sigma` is silently replaced by a limiting constant below.

### Theorem 4.1. A necessary range for power-size amplification

Fix `K>0` and `0<mu<1`, and consider *all* positive integer completions
(1.3) whose unscaled output is primitive and satisfies
`C<=c^K` and `rad(ABC)<=C^mu`. Their number is, for every fixed
`epsilon>0`, at most

\[
 C_{\epsilon,K,\mu}\,
 c^{\min\{\max(0,(K-\rho)/2),\ K\mu-\sigma\}+\epsilon}
 \tag{4.2}
\]

if the fibre is nonempty. Thus, for the exponent permitted by these two
upper bounds to be strictly greater than `K F(mu)`, it is necessary that

\[
 \boxed{
 K>\rho+4\sigma,\qquad
 \frac{3\sigma}{K}<\mu<\frac34\left(1-\frac\rho K\right)<\frac34.
 }
 \tag{4.3}
\]

In particular, along any unbounded sequence of seeds on which
`K<=rho+4sigma`, these integer square completions cannot supply a uniform
lower exponent `alpha>K F(mu)` with a fixed positive gap. This last claim
has fixed `K,mu`; it does not assert uniformity when `K` grows with `c`.

#### Proof

Every such output retains `R`, since `P` divides `ABC`. Hence Corollary
2.2 applies, giving the second exponent in (4.2). Bound (1.4), together
with the standard divisor estimate `tau(P)<=C_eta P^eta` and `P<=c^3`,
gives the first exponent, uniformly in the seed. Taking the smaller of
the two bounds proves (4.2). The divisor estimate can be proved by
splitting primes at a fixed threshold: for large primes, `e+1<=p^(eta e)`;
the supremum of `(e+1)/p^(eta e)` over `e>=0` is finite at each of the
finitely many remaining primes.

If `mu>=3/4`, every term in the minimum defining `F(mu)` is at least
`1/2`. But

\[
 \max(0,(K-\rho)/2)<K/2\le K F(\mu),
\]

because `K,rho>0`. This already rules out that whole target range for the
complete conic fibre, including all actual repeated-prime savings.

If `0<mu<3/4`, then `F(mu)=2mu/3`. For the minimum in (4.2) to exceed
`2Kmu/3`, both of its entries must exceed it. The second one gives

\[
 K\mu-\sigma>2K\mu/3
 \quad\Longrightarrow\quad \mu>3\sigma/K.
\]

The first one must be positive and hence gives

\[
 (K-\rho)/2>2K\mu/3
 \quad\Longrightarrow\quad
 \mu<\frac34(1-\rho/K).
\]

The interval between these two necessary endpoints is nonempty only when
`K>rho+4sigma`. This proves (4.3). If `K<=rho+4sigma`, at least one of
the two exponents is at most `K F(mu)`. Choose `epsilon` smaller than a
proposed fixed positive lower-bound gap in (4.2); that proposed lower
bound is impossible for all sufficiently large seeds in the sequence.
QED.

This is a restriction on the actual-output amplifier, beyond the previous
cofactor-size certification result. It is not a proof that all integer
square-completion amplification is impossible. The remaining interval
(4.3), projective constructions losing seed support, and other maps are
not excluded. In particular, no assertion `sigma>=1` is used.

## 5. Why projective cancellation needs a different support hypothesis

Full seed support retention is automatic for an integer completion with
primitive *unscaled* output. It is false for arbitrary rational multipliers
or for integer outputs subsequently divided by their common factor.

A concrete example is the primitive seed

\[
 (a,b,c)=(49,576,625),\qquad R=210.
\]

The rational point

\[
 (x,y,z)=(3/7,1/6,1/5)
\]

gives the positive primitive output `(9,16,25)`, whose radical is `30`.
The seed prime `7` has disappeared. Equivalently, the primitive integer
point `(90,35,42)` gives an output with common factor `44100`, and dividing
by that common factor produces the same triple. This is a counterexample
only to full support retention under this more permissive construction.

There is a weaker unconditional replacement. If the outputs themselves
have the form `A=ax^2,B=by^2,C=cz^2` for rational `x,y,z` and are positive
integers, every prime having odd valuation in `P` still divides `ABC`.
Indeed it occurs in exactly one of `a,b,c`; the valuation of the
corresponding output is a nonnegative integer congruent to that odd
valuation modulo two, and therefore is positive. Theorem 2.1 can be used
with this smaller odd-exponent squarefree kernel when this precise
squareclass-preserving hypothesis holds. An arbitrary common scaling need
not preserve the three squareclasses, so that hypothesis must be checked
again after normalization.

## 6. A separate positive attempt: three quadratic tripod descendants

Let `a!=b`. Three natural degree-two identities give the following outputs,
each divided by its actual common divisor to make it primitive:

\[
 \begin{array}{ll}
 \mathcal D_0:&((a-b)^2,\ 4ab,\ c^2),\\
 \mathcal D_a:&(a^2,\ 4bc,\ (b+c)^2),\\
 \mathcal D_b:&(b^2,\ 4ac,\ (a+c)^2).
 \end{array}
 \tag{6.1}
\]

The aim was to select a quality-preserving branch and iterate it; that
would be a genuinely different mechanism from asking for many independent
points on one conic. Its elementary universal strengthening is false,
as shown below. This does not rule out adaptive higher-degree operations.

### Proposition 6.1. Exact radicals, including normalization

Write `rad_odd(n)` for the product of the odd primes dividing `n>0`.
The actual primitive-output radicals in (6.1) are respectively

\[
 R\operatorname{rad}_{\rm odd}(|a-b|),\qquad
 R\operatorname{rad}_{\rm odd}(a+2b),\qquad
 R\operatorname{rad}_{\rm odd}(2a+b).
 \tag{6.2}
\]

Every output thus retains the full radical `R`. Its height lies between
`c^2/4` and `4c^2`.

#### Proof

For any two coprime positive integers `u,v`, the three integers
`(u-v)^2,4uv,(u+v)^2` have gcd `1` when `u,v` have opposite parity and
gcd `4` when both are odd. No odd prime can divide two entries, because
such a prime would divide both `u` and `v`. In the both-odd case the
middle entry has exact 2-adic valuation two, and the other entries are
divisible by four, proving the precise gcd. The divided triple is
primitive and satisfies the required sum identity.

For the first row use `(u,v)=(a,b)`; for the second use `(b,c)` and
`c-b=a`; for the third use `(a,c)` and `c-a=b`. Every new odd prime in
the displayed difference or sum is coprime to `P`: for instance, an odd
prime dividing both `a+2b` and any of `a,b,c` would, by `c=a+b`, divide
two seed coordinates. Conversely all odd seed primes are retained in
the corresponding product and cannot be removed by division by `1` or
`4`. The prime `2` occurs in every positive primitive abc triple, both
before and after the operation. This proves (6.2) exactly, without
replacing a radical by the size of its argument. Finally the raw heights
are `c^2,(b+c)^2,(a+c)^2`, lying in `[c^2,4c^2)`, and normalization
divides them by either `1` or `4`. QED.

In particular, every finite composition of these positive descendants
retains the initial full support. Theorem 2.1 therefore applies even if
their additional factors have large repeated-prime savings. It places no
degree bound on such a support-retaining family.

### Proposition 6.2. No universal quality-preserving branch among these three

Let `q(A,B,C)=log C/log rad(ABC)`. The genuine exceptional seed `(1,8,9)`
has three primitive outputs

\[
 (49,32,81),\qquad(1,288,289),\qquad(16,9,25).
 \tag{6.3}
\]

Each output has quality strictly smaller than the seed quality
`q_0=log9/log6>1`.

#### Proof

Their exact radicals are `42,102,30`. For the first output,
`log81/log42<log9/log6` is equivalent to `36<42`.
For the second, it suffices to use the rational separator `38/31`:

\[
 \frac{\log289}{\log102}<\frac{38}{31}
 <\frac{\log9}{\log6}.
 \tag{6.4}
\]

After multiplying positive logarithmic denominators, the right inequality
is equivalent to `3^24>2^38`, and the left one to `17^24<6^38`. These
are exact integer comparisons:

\[
 \begin{aligned}
 3^{24}&=282429536481>274877906944=2^{38},\\
 17^{24}&=339448671314611904643504117121\\
 &<371319292745659279662190166016=6^{38}.
 \end{aligned}
\]

The last output has `log25/log30<1<q_0`. QED.

This disproves only the candidate statement that one of these three
branches always has at least the seed quality. A finite quality loss is
not a counterexample to abc. No unbounded fixed-exponent exceptional
family, or uniform lower count of descendants, has been constructed here.

## 7. What remains mathematically open in this continuation

The actual-support estimate and the conic count leave the range (4.3).
Inside it, the required simultaneous lower bound on large values of
`E_P(xyz)` and distinct conic outputs is not known here. The exact
identity (3.4) is an accounting tool, not a distribution theorem.
For projective outputs losing some seed primes, Theorem 2.1 must use the
support truly retained, not the larger original radical. The three simple
quadratic branches fail universal quality monotonicity, but more elaborate
maps and compositions remain active candidates.

Consequently this report does not give a closed Lean term of the repository's
unconditional `ABCConjecture`, a counterexample sequence, or a solution to
the uniform exceptional-set gap.

## 8. Original-source audit and formalization boundary

The following two original PDFs were saved in the parent-approved source
directory. No shared source manifest or earlier validation snapshot was
modified.

| Original source | Local file under `research/sources/uniform_gate_2026_08_30/` | Bytes | SHA-256 |
| --- | --- | ---: | --- |
| [Hirata-Kohno--Kawashima--Poels--Washio, arXiv:2211.14399v1](https://arxiv.org/pdf/2211.14399v1), Theorem 1.1, PDF p. 1; IJNT 19(10) (2023), 2427--2442 | `HirataKohno_Kawashima_Poels_Washio_2211.14399v1.pdf` | 196132 | `8f7fa1d49637498f5e3ad298981a822f6f6b1911f6570b7781d4d3cab9915cae` |
| [Beukers--Schlickewei, Acta Arith. 78(2) (1996), 189--199](https://matwbn.icm.edu.pl/ksiazki/aa/aa78/aa7826.pdf), Theorem 1.1, PDF p. 1 / journal p. 189; [DOI 10.4064/aa-78-2-189-199](https://doi.org/10.4064/aa-78-2-189-199) | `Beukers_Schlickewei_1996_aa7826.pdf` | 237336 | `f1b115cd8c5f190a0bce8628e229e019191c83b6562a891d8d84f2ed82832a0e` |

The 1996 theorem was checked as a weaker independent alternative: for a
group of rank `r` in `(C*)^2` it gives `2^(8r+8)` solutions, and taking
rank `2 omega(RD)` would give (2.2) with a much larger weight. The actual
bound (2.2) uses the 2023 theorem, including its archimedean place. The
BBLT source is already archived at
`research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`.

The companion module
`Lean/IUTThreeClosures/AnalyticActualRadicalUniformGate20260830.lean`
certifies elementary identities about the actual integer radical and
excess, the resulting necessary conic budget, and the real-algebra
implication (4.3). The published S-unit theorem, its divisor sum, the
complete lattice point count, logarithmic asymptotics, and BBLT remain
paper ingredients, not claims of complete Lean formalization.

The main checked declarations in namespace
`IUTThreeClosures.AnalyticActualRadicalUniformGate20260830` are:

* `radical_mul_eq_newPrimeRadical` and
  `radical_mul_sq_eq_newPrimeRadical`: decomposition of the actual radical;
* `newPrimeRadical_coprime`: disjointness of inherited and new support;
* `square_completion_retains_seed_radical` and
  `square_completion_radical_mul_excess`: full integer support retention
  and the exact excess identity (3.4);
* `square_completion_actual_excess_budget`: the no-division form of (3.5)
  with an actual radical hypothesis, explicitly computed in `Nat` before
  casting to `Real`;
* `actual_conic_exponent_window` and `actual_conic_min_exponent_le`:
  the real-algebra implication (4.3) and its complementary inequality;
* `rational_completion_support_loss_coordinates`: the explicit rational
  completion, primitivity and missing-prime witness in Section 5;
* `quadratic_quality_separator_powers`: the exact integer comparisons
  used in (6.4), not a claim that the full logarithmic quality argument
  has been formalized.

Validation command, run from the repository's `Lean` directory:

```text
lake env lean IUTThreeClosures/AnalyticActualRadicalUniformGate20260830.lean
```

The final run exited with code `0`, with no warnings. The module contains
`#print axioms` for all ten listed main declarations; every printed list
contains only `propext`, `Classical.choice` and `Quot.sound`. No analytic
input, unproved number-theoretic hypothesis, `sorryAx`, or native-evaluation
axiom appears in those dependencies. Only this independent module was
checked; this is not a claim of a new complete repository build.

The root agent separately reviewed Theorems 2.1 and 4.1, the exact excess
accounting, the three tripod radical formulas and their counterexample.
It independently rendered the original S-unit theorem and confirmed its
constant and archimedean-place convention. That review found the stated
mathematical arguments valid with the fixed-parameter and support-retention
qualifications preserved above.
