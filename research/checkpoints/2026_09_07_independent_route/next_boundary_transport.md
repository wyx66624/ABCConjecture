# A paid-divisor bridge from shared norm exponents to mixed-map quality

Author: ChatGPT. Date: 2026-09-07.

**Status.** This is the next ordinary-mathematics checkpoint, beyond the
already integrated product-tripod rigidity section. It proves exact transport
identities and sufficient counterexample criteria. It does **not** prove that
the criteria have infinitely many solutions, and does not prove or disprove
abc. No new Lean or manuscript-integration claim is made in this note.

## 1. Inputs and notation

Let `a,b` be coprime positive integers, `c=a+b`, and

\[
T=abc,\quad R=\operatorname{rad}(T),\quad t=\log c,
\quad r=\log R,\quad q=t/r.
\]

Work in the Eisenstein ring with `zeta^2-zeta+1=0`. Put

\[
z=a+b\zeta,\qquad M=N(z)=a^2+ab+b^2.
\]

Suppose there is an actual oriented quotient-remainder representation

\[
z=u(1+\zeta)^{e_0}v w^g,
\quad e_0\in\{0,1\},\quad g\ge1,
\quad V=N(v)\ge1,\quad Q=N(w)\ge7,
\tag{1}
\]

as in the shared-generator checkpoint. In particular `u` is a unit, `v,w`
are actual algebraic integers, and all factors are explicitly constructed.
Let

\[
h_v=\max(1,\log V),\qquad
\lambda=\frac{h_v}{g},\qquad
\rho=\lambda\log(4+g),\qquad
s=\log\operatorname{rad}(M).
\tag{2}
\]

The symbol `lambda` in this note denotes the positive real compression ratio
in (2), not the complex quotient denoted by the same letter in the
logarithmic-form source. The basic norm identities give

\[
M=3^{e_0}VQ^g,\qquad M\le c^2,\qquad
t\ge\frac12 g\log7.
\tag{3}
\]

Only these elementary norm facts are needed for the radical comparison. The
new comparison uses no logarithmic-form theorem, no tail estimate, and no abc
assumption.

## 2. Complete norm radical from the compressed representation

**Theorem NT1.** For every representation (1),

\[
\begin{aligned}
\operatorname{rad}(M)&\le 3^{e_0}VQ,\\
s&\le\frac{\log M}{g}
 +\left(1-\frac1g\right)(\log V+e_0\log3)\\
 &\le\frac{2t}{g}+\log V+\log3.
\end{aligned}
\tag{4}
\]

Consequently, with the explicit absolute constant

\[
K=2+\frac{2(1+\log3)}{\log7},
\tag{5}
\]

one has

\[
0<\frac{s}{t}\le K\lambda
=\frac{K\rho}{\log(4+g)}.
\tag{6}
\]

When `e_0=0`, one can replace `K` by `K_0=2+2/log 7`.

**Proof.** Radicals are unaffected by positive powers, and the radical of a
product is at most the product of its factors. Thus

\[
\operatorname{rad}(3^{e_0}VQ^g)
\le3^{e_0}\operatorname{rad}(V)\operatorname{rad}(Q)
\le3^{e_0}VQ.
\]

No coprimality between `V` and `Q` is needed; repeated support only reduces
the left side. Set `x=log V+e_0 log3`. Since `log M=x+g log Q`, the bound
`s<=x+log Q` is exactly the first logarithmic bound in (4). Now use `g>=1`,
`e_0<=1`, and `log M<=2t`.

Finally `log V<=h_v`, `h_v>=1`, and (3) yield

\[
\frac{s}{t}
\le \frac2g+\frac{2(h_v+\log3)}{g\log7}
\le\left(2+\frac{2(1+\log3)}{\log7}\right)\frac{h_v}{g}.
\]

For `e_0=0`, omit `log3` throughout. Since `M>=7`, its radical is greater
than one, which gives the strict positivity in (6).

**Important distinction.** Equation (6) controls the radical of the norm
`M`. It gives no direct upper bound for the boundary radical `R=rad(abc)`.
The established balance conclusion `min(a,b)>c^(1-eta)` also supplies no
such upper bound. In particular neither assertion implies `q>1/2`.

## 3. Exact one-step quality transfer

Define the primitive mixed-map transform

\[
\mathcal T(a,b,c)=(ab,M,c^2).
\tag{7}
\]

The arithmetic ledger in the preceding checkpoint proves

\[
\gcd(M,abc)=1,\qquad R'=R\operatorname{rad}(M),\qquad t'=2t.
\tag{8}
\]

Thus the new norm divisor is charged exactly once and has no overlap with
the old prime support.

**Theorem NT2.** The exact identities are

\[
q'=\frac{2q}{1+q(s/t)},\qquad
\frac1{q'}=\frac1{2q}+\frac{s}{2t}.
\tag{9}
\]

Under (1),

\[
\frac1{2q}\le\frac1{q'}
\le\frac1{2q}+\frac K2\lambda.
\tag{10}
\]

For a fixed `epsilon>0`, the excess satisfies

\[
E'_\varepsilon
=[2-(1+\varepsilon)/q-(1+\varepsilon)s/t]t.
\tag{11}
\]

**Proof.** Substitute `r'=r+s` and `t'=2t`. All statements follow by
division by the positive quantities `t,r,r+s` and then by (6).

For a family with `rho->0`, (10) gives the uniform statement

\[
\frac1{q'}-\frac1{2q}\longrightarrow0.
\tag{12}
\]

This inverse-quality statement is safer than asserting `q'/q->2` without
an upper bound on `q`: the latter additionally requires `q s/t->0`. If the
input qualities remain bounded above, the usual ratio formulation does hold.

## 4. A rigorous half-quality sufficient criterion for disproof

**Theorem NT3 (conditional counterexample production).** Suppose a sequence
of actual primitive triples has representations (1) for which `rho_n->0`.
Suppose further that some fixed real `q_0>1/2` satisfies `q_n>=q_0` for all
sufficiently large `n`. Then the transformed sequence (7) disproves standard
abc: there is one fixed `epsilon>0` for which

\[
\frac{c_n^2}{(R_n\operatorname{rad}(M_n))^{1+\varepsilon}}
\longrightarrow\infty.
\tag{13}
\]

**Proof, including all quantifiers.** Choose once and for all
`0<epsilon<2q_0-1`, and set

\[
d=2-\frac{1+\varepsilon}{q_0}>0.
\]

Since `rho_n->0`, equation (6) gives `s_n/t_n->0`. Eventually
`(1+epsilon)s_n/t_n<=d/2`. For those `n`, (11) gives
`E'_{epsilon,n}>=d t_n/2`.

It remains to justify that heights tend to infinity. By (2),
`rho_n>=1/g_n`, since `h_{v,n}>=1` and `log(4+g_n)>1`. Therefore
`g_n->infinity`. Equation (3) gives `t_n>=g_n log7/2->infinity`.
Consequently `E'_{epsilon,n}->infinity`; exponentiating proves (13).
Every proposed uniform constant is defeated, and the output triples are
primitive by (8).

The same conclusion holds if only `limsup q_n>1/2`: take a subsequence
with a fixed `q_0>1/2`, along which `rho_n` still tends to zero.
Equivalently, **if abc is true**, every small-rho sequence must satisfy
`limsup q_n<=1/2`. This last sentence is a conditional consequence of abc,
not a new unconditional bound.

**Unresolved premise.** No such sequence with `limsup q_n>1/2` has been
constructed or proved to exist here. The actual content-one families from
the shared-generator theorem are proved to be balanced and to have small
rho. They are not proved to have quality above one half. The trivial
`R<=abc<=c^3/4` gives only an asymptotic lower bound one third, which is
insufficient for NT3.

## 5. A many-step ledger with fresh, disjoint divisors

Starting from any primitive positive seed, define

\[
(a_{j+1},b_{j+1},c_{j+1})
=(a_jb_j,M_j,c_j^2),\qquad
M_j=a_j^2+a_jb_j+b_j^2.
\tag{14}
\]

Let `t_j=log c_j`, `r_j=log rad(a_jb_jc_j)`, and
`s_j=log rad(M_j)`. Iterating (8) proves, with no extra hypothesis,

\[
\begin{aligned}
c_n&=c_0^{2^n},&t_n&=2^n t_0,\\
R_n&=R_0\prod_{j=0}^{n-1}\operatorname{rad}(M_j),&
r_n&=r_0+\sum_{j=0}^{n-1}s_j.
\end{aligned}
\tag{15}
\]

All the `M_j` are pairwise coprime and coprime to `a_0b_0c_0`: at step
`j`, (8) makes `M_j` coprime to the complete support already accumulated.

Put `d_j=r_j/t_j` and `theta_j=s_j/t_j`. The exact recurrences are

\[
d_{j+1}=\frac{d_j+\theta_j}{2},\qquad
d_n=2^{-n}d_0+\sum_{j=0}^{n-1}2^{j-n}\theta_j.
\tag{16}
\]

These are genuine arithmetic identities. The value `theta_j` is the cost of
the actual new divisor; it is never discarded, duplicated, or replaced by an
unproved scalar bound. NT1 provides an independently proved upper bound
`theta_j<=K lambda_j` whenever that iterate has representation (1).

## 6. A two-step sufficient criterion without an input quality assumption

In particular two transforms produce

\[
\begin{aligned}
M_0&=a^2+ab+b^2,\\
M_1&=(ab)^2+abM_0+M_0^2
    =c^4-ab c^2+(ab)^2,\\
\mathcal T^2(a,b,c)&=(abM_0,M_1,c^4).
\end{aligned}
\tag{17}
\]

The two new factors are coprime to each other and to `abc`.

**Theorem NT4 (two compressed norms suffice for counterexample production).**
Suppose a primitive seed and its first transform both admit representations
(1), with compression ratios `lambda_0,lambda_1`. Then

\[
\frac{r_2}{t_2}
\le\frac34+\frac K4(\lambda_0+2\lambda_1).
\tag{18}
\]

Hence if

\[
\lambda_0+2\lambda_1\le\frac1{5K},
\tag{19}
\]

the second transform has quality at least `5/4`. If there are seeds of
unbounded height satisfying (19), standard abc is false.

**Proof.** The elementary bound `R_0<=a_0b_0c_0<=c_0^3` gives `r_0<=3t_0`.
Using (15) and NT1 at both steps,

\[
r_2=r_0+s_0+s_1
\le3t_0+K\lambda_0t_0+2K\lambda_1t_0.
\]

Divide by `t_2=4t_0` to obtain (18). Under (19), its right side is at most
`3/4+1/20=4/5`, so `q_2>=5/4`.

For the final assertion choose the fixed `epsilon=1/8`. For every seed
satisfying (19),

\[
E_{2,1/8}=4t_0-\frac98r_2
\ge4t_0-\frac98\frac{16}{5}t_0
=\frac25t_0.
\tag{20}
\]

Unbounded seed heights give a subsequence along which (20) tends to infinity,
so the outputs defeat every constant at that same fixed epsilon.

For example, the stronger pair of conditions
`lambda_0<=1/(15K)` and `lambda_1<=1/(15K)` implies (19). A sequence with
both `rho_0->0` and `rho_1->0` would eventually satisfy (19), and its initial
heights automatically tend to infinity by (3).

**Exact open problem.** Construct unbounded actual primitive seeds for which
the two explicitly displayed Eisenstein norms in (17) simultaneously have
the required oriented compressed representations, or prove a specific
incompatibility theorem for those representations. No existence claim is
made here. This is a sufficient structured search gate, not an equivalence
assertion for arbitrary abc triples.

## 7. What the existing small-prime theorem says about fixed-seed iteration

The shared-generator theorem also proves

\[
v_p(a_jb_jc_j)\le p^2 B_j,
\qquad B_j\le A\rho_j t_j
\tag{21}
\]

for an absolute effective `A`. Fix a seed and a prime `p|c_0`. Every fresh
divisor is coprime to `c_0`, so (14) gives

\[
v_p(a_jb_jc_j)=2^jv_p(c_0).
\]

Combining this with (21) and `t_j=2^jt_0` yields the effective floor

\[
\rho_j\ge\frac{v_p(c_0)}{A p^2\log c_0}>0
\tag{22}
\]

for every iterate having a representation to which (21) applies.
Thus the particular strategy of repeatedly transforming one fixed seed
cannot obtain `rho_j->0` along its iterates. This is a proved boundary on
that fixed-seed strategy. It does not rule out NT3 or NT4, which vary the
seeds; the lower bound in (22) is not uniform when their denominator primes
and heights vary.

## 8. Review and dependency summary

The independent `adversarial_audit` agent reviewed NT1--NT3, including the
overlap-safe radical bound, the explicit K, and the fixed-epsilon
unbounded-height argument, and found the proof correct. A second review of
the completed note confirmed NT4, the exact `2t_0/5` excess, all fresh-divisor
coprimality inductions, the corrected inverse-quality statement, and the
fixed-seed floor. This is independent research-agent review, not journal peer
review or Lean verification. The existence premises of NT3 and NT4 remain
unproved after that review.

The new unconditional mathematical content is

```
actual shared representation -> small norm radical
  -> exact one-step and multi-step paid-divisor quality identities.
```

Two distinct sufficient disproof programs are now concrete:

```
small-rho actual sequence + limsup input quality > 1/2 -> disproof;
unbounded seeds with two consecutive sufficiently compressed norms -> disproof.
```

Their arithmetic existence premises are open. The currently proved balance
and small-prime estimates do not supply either premise. No ABC claim has
been installed as an assumption, and no Lean axiom is introduced.
