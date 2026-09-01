# Independent review of the normalized Matveev step for the Pell--Chebyshev packet

Reviewer: ChatGPT, analytic route. Date: 2026-08-30.

**Verdict:** the normalized-coefficient argument is valid for the specified
packet, provided the application cites **Corollary 2.3**, rather than invoking
Theorem 2.1 without checking logarithmic independence. A conservative explicit
consequence is `p<2^58`. Combined with the previously proved application of
Bérczes--Evertse--Győry, this gives an effective finite bound for this packet.
It does not establish that all abc triples, or all potential abc exceptions,
are contained in the packet.

This review did not modify the analytic amplification report, its Lean module,
the geometry agent's files, aggregate imports, or the journal manuscript.

## 1. Original theorem checked, including the potential hidden condition

The source is E. M. Matveev, *An explicit lower bound for a homogeneous
rational linear form in the logarithms of algebraic numbers. II*,
Izvestiya: Mathematics **64** (2000), 1217--1269,
DOI [10.1070/IM2000v064n06ABEH000314](https://doi.org/10.1070/IM2000v064n06ABEH000314).
The [original English PDF](https://www.mathnet.ru/php/getFT.phtml?jrnid=im&option_lang=eng&paperid=314&what=fullteng)
was opened independently; printed pages 1218--1219 were also rendered and
visually inspected. Local source:
`research/sources/continuation_2026_08_30/Matveev_2000_explicit_lower_bound.pdf`.

The applicable Corollary 2.3, printed p. 1219, uses

\[
 B=\max\{1,\max_i |b_i|A_i/A_n\},\qquad
 A_i\ge\max\{D_Kh(\alpha_i),|\log\alpha_i|,0.16\},
 \tag{1.1}
\]

and, for the nonzero linear form `Lambda=sum b_i log(alpha_i)`, gives

\[
 \log|\Lambda|>
 -C_1(n,\kappa)D_K^2(A_1\cdots A_n)\log(eD_K)\log(eB).
 \tag{1.2}
\]

Its explicit constant satisfies `C_1(3,1)<=2^38`. The second alternative
inside the minimum in (2.6) is `2^(6n+20)`.

There is no strong-independence hypothesis in this corollary. The introduction
at p. 1218 first discusses earlier independence restrictions, then explicitly
states in item 4 that the normalized parameter (1.3) is retained in the general
case. Theorem 2.1 itself **does** require the logarithms to be linearly
independent over the integers. No such independence is supplied by this packet:
`delta` could belong to `Q(sqrt(3))` and be multiplicatively dependent on
`2+sqrt(3)`. Corollary 2.3 avoids this issue legitimately.

No condition requires `A_n` to be the largest height parameter. No field
discriminant appears in (1.2). The alternative parameter `B*=max |b_i|` may
be substituted as a weaker convenience, but need not be substituted here.

## 2. Precise packet and field inputs

The packet consists of positive integers `b,A,B,u,v,r,s,X`, a prime `p>=37`,
and

\[
 b=Au^2,\quad b+1=Bv^2,\quad b+2=3r^2,\quad b+3=s^2,
\]

\[
 D_0=3AB,\quad D_0+1\le X^2,\quad
 Z=b^2+3b+1=T_p(X),\quad X^p\le Z.
 \tag{2.1}
\]

Here `D_0` is the packet parameter, not the field degree `D_K` in (1.1).
Since `D_0>=3`, positivity gives `X>=2`. Let

\[
 \varepsilon=2+\sqrt3,\quad \eta=s+r\sqrt3,\quad
 \delta=X+\sqrt{X^2-1},\quad H=\log(b+2).
 \tag{2.2}
\]

The two consecutive-square conditions imply `s^2-3r^2=1`, so the usual
positive Pell-unit description gives `eta=epsilon^m` for an integer `m>=1`.

The positive real field

\[
 K=\mathbf Q(\sqrt3,\sqrt{X^2-1})\subset\mathbf R
\]

has degree `D_K<=4`, hence `kappa=1`. For integer `X>=2`, the integer
`X^2-1` lies strictly between `(X-1)^2` and `X^2`. Thus `delta` has
quadratic minimal polynomial `t^2-2Xt+1`, and its conjugate is `delta^(-1)`.
In particular,

\[
 h(\varepsilon)=\tfrac12\log\varepsilon,\qquad
 h(2)=\log2,\qquad h(\delta)=\tfrac12\log\delta.
 \tag{2.3}
\]

These are absolute heights; passing to the compositum does not change them.
The factor `D_K` multiplying them is already accounted for in the choices
of `A_i` below.

Chebyshev's identity at the positive real point gives

\[
 T_p(X)=\frac{\delta^p+\delta^{-p}}2,
 \qquad W:=Z+\sqrt{Z^2-1}=\delta^p.
 \tag{2.4}
\]

There is no root-choice ambiguity: `delta^p>1`, whereas the other root of
`t^2-2Zt+1` is less than one.

## 3. Independent nonvanishing and approximation checks

Define

\[
 \gamma=\frac{\eta^4}{8W},\qquad
 \Lambda=\log\gamma
 =4m\log\varepsilon-3\log2-p\log\delta.
 \tag{3.1}
\]

All logarithms are the nonzero real logarithms of numbers greater than one.
The following elementary bounds verify the intended strict inequality:

\[
 4b+9<\eta^2<4b+10,\qquad 2Z-1<W<2Z.
 \tag{3.2}
\]

Indeed

\[
 \eta^2=2b+5+2\sqrt{(b+2)(b+3)},
\]

and the square root lies between `b+2` and `b+5/2`. The bounds for `W`
follow from `Z>1`.

The lower bounds give

\[
 \eta^4>(4b+9)^2>16Z>8W,
\]

because `(4b+9)^2-16Z=24b+65>0`. The upper bounds give

\[
 \gamma<\frac{(4b+10)^2}{8(2Z-1)}<1+\frac2b,
\]

where the second comparison is exactly

\[
 (b+2)8(2Z-1)-b(4b+10)^2=4b+16>0.
\]

Consequently

\[
 0<\Lambda<\log(1+2/b)<2/b.
 \tag{3.3}
\]

There is also a separate algebraic nonvanishing check. Both `eta` and `delta`
are units of norm one from their quadratic fields, so their norms from `K`
to `Q` are one. Hence `Norm_(K/Q)(gamma)=8^(-D_K)`, which is not one.
Thus `gamma!=1` even without using the approximation estimate. This check
does not assert that the three logarithms are independent.

## 4. All height and normalized-coefficient inequalities

Apply Corollary 2.3 with the fixed order

\[
 (\alpha_1,\alpha_2,\alpha_3)=(\varepsilon,2,\delta),
 \qquad (b_1,b_2,b_3)=(4m,-3,-p),
\]

and choose

\[
 A_1=2\log\varepsilon,\quad A_2=4\log2,\quad
 A_3=2\log\delta.
 \tag{4.1}
\]

Equations (2.3) and `D_K<=4` prove all the required height comparisons.
Because `X>=2`, `delta>=epsilon`, and all three `A_i` exceed `0.16`.
Thus every condition of (1.1)--(1.2) has now been checked.

Crucially the normalized parameter is exactly

\[
 B=\max\left\{1,
  \frac{4m\log\varepsilon}{\log\delta},
  \frac{6\log2}{\log\delta},p\right\}.
 \tag{4.2}
\]

The elementary bounds `log epsilon>1` and `log 2<1`, together with (3.1),
give

\[
 \frac{4m\log\varepsilon}{\log\delta}
 =p+\frac{3\log2+\Lambda}{\log\delta}<p+5\le2p,
\]

since `b>=1` and `p>=37`. The second fraction is less than six. The other
entries are `1` and `p`. Therefore

\[
 \boxed{B\le2p.}
 \tag{4.3}
\]

Neither an uncontrolled `m` nor an extra `log H` remains in this parameter.
The field and the number `delta` may vary with the packet: their entire
dependence in the theorem is already represented by `D_K` and the `A_i`.

Finally, `W<2Z<2(b+2)^2` implies

\[
 p\log\delta<\log2+2H<3H,
 \qquad \boxed{A_3<6H/p.}
 \tag{4.4}
\]

The order of substitution matters. The `A_i` in (4.1) are the actual
parameters used to calculate (4.2); only afterwards is their product
bounded using (4.4). No differently rescaled parameters are silently used
in `B` and in `Omega`.

## 5. One completely explicit index bound

This section deliberately uses loose elementary constants. We have

\[
 C_1(3,1)\le2^{38},\quad D_K^2\le16,\quad
 \log(eD_K)<3,\quad A_1<4,\quad A_2<4,
 \quad A_1A_2A_3<96H/p.
\]

Therefore Matveev gives

\[
 \log\Lambda>
 -4608\cdot2^{38}\,\frac H p\,\log(2ep).
 \tag{5.1}
\]

The packet forces `b>=6`: otherwise `Z<=41`, whereas
`Z>=X^p>=2^p>=2^6=64`. For `b>=6`,

\[
 b^2-4b-8=(b-6)(b+2)+4>0,
\]

so `2/b<(b+2)^(-1/2)`. Combining with (3.3) yields
`log Lambda<-H/2`. Comparison with (5.1), and cancellation of the positive
`H`, now gives

\[
 p<9216\cdot2^{38}\log(2ep)<2^{52}\log(2ep).
 \tag{5.2}
\]

For `t>=2^58`, the function `t-2^52 log(2et)` is increasing, since its
derivative is `1-2^52/t>0`. At `t=2^58`,

\[
 2^{52}\log(2e\,2^{58})
 =2^{52}(1+59\log2)<60\cdot2^{52}<2^{58}.
\]

Thus (5.2) is impossible for `p>=2^58`, proving the explicit bound

\[
 \boxed{p<2^{58}.}
 \tag{5.3}
\]

Primehood of `p` is not needed in the Matveev calculation itself. The
specified packet already assumes it, and its use in earlier reductions
is unchanged.

## 6. Consequence and exact limits of this review

The independently reviewed older BEG application gives

\[
 H\le\exp(4300p^5).
\]

Together with (5.3), it yields, for example,

\[
 H<\exp(4300\cdot2^{290}),\qquad
 b+2<\exp\!\bigl(\exp(4300\cdot2^{290})\bigr).
 \tag{6.1}
\]

Every remaining variable in (2.1) then has only finitely many integer
possibilities: `A|b`, `B|b+1`, their square multipliers are bounded, `r,s`
are determined by their positive squares, `p` is bounded, and `X^p<=Z`
bounds `X`. This is an effective finiteness theorem for the specified
packet, relying on two unconditional published transcendence/Diophantine
theorems. It does not claim that these astronomical bounds have been
enumerated.

The following distinctions must remain explicit in the manuscript:

* Cite Matveev **Corollary 2.3** with its `0.16` condition; do not claim
  logarithmic independence just from `Lambda!=0`.
* The form bounded in Matveev's statement is `Lambda=log gamma`, not
  `gamma-1`. The approximation in (3.3) is for precisely this `Lambda`.
* This effective finiteness result applies only to (2.1). It neither
  supplies a global reduction from abc nor rules out other residual routes.
* A Lean theorem conditional on a stated Matveev/BEG input is not a Lean
  formalization of those external theorems. No unproved analytic axiom may
  be inserted and then described as an unconditional closed proof term.

There is no blocking mathematical defect in the normalized-parameter step
after using the correct corollary and maintaining these boundaries.

## 7. Addendum: the larger family with every integer index at least three

The subsequently written `research/MATVEEV_PELL_FINITE_PACKET_2026_08_30.md`
removes unnecessary packet assumptions. Its hypotheses are only positive
integers `b,r,s,X`, an integer `p>=3`, `X>=2`, and

\[
 b+2=3r^2,\qquad b+3=s^2,\qquad b^2+3b+1=T_p(X).
\]

I independently checked that this extension is valid. For `b<22`, the two
square equations leave only `b=1,r=1,s=2`. This would give `Z=5`, whereas
the positive Chebyshev trace with `X>=2,p>=3` is at least `T_3(2)=26`.
Thus `b>=22`. In this range

\[
 W>2Z-1=2b^2+6b+1>4b+10>\eta^2.
\]

The first normalized coefficient can therefore be bounded without the
earlier `p>=37` step:

\[
 \frac{4mA_1}{A_3}
 =\frac{4p\log\eta}{\log W}<2p.
\]

For the second, `delta^2>8` gives
`6 log 2/log delta<4<=2p`. The remaining entries of `B` are `1` and
`p`; hence `B<=2p` throughout the larger family. All the other field,
height, nonvanishing, approximation, and BEG conditions above remain valid.
In particular the manuscript's deliberately wider common bound

\[
 p<2^{59},\qquad b+2<\exp\bigl(\exp(4300\cdot2^{295})\bigr)
\]

is justified without primality, squarefree endpoint parameters, their
residue conditions, or `D_0+1<=X^2`. The earlier `2^58` statement remains
a valid stronger numerical bound in the narrower scope in which it was
initially stated; there is no conflicting numerical claim.

The new report's exclusion of even indices also checks directly:
`Z+1=2T_(p/2)(X)^2=3(b+1)r^2` would have simultaneously even and odd
3-adic valuation, since `3` does not divide `b+1`. This remains a
statement about the specified Pell conditions and does not supply a
global abc reduction.
