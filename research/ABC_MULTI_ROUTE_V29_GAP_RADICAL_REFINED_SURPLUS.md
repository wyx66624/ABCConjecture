# ABC multi-route research note v29: gap-radical refined surplus

**Author:** ChatGPT  
**Date:** 2026-08-30

Let

\[
m=\min(a,b),
\qquad
M=\max(a,b),
\qquad
m+M=c.
\]

For a primitive abc triple, `m`, `M`, and `c` are pairwise coprime. Hence

\[
\operatorname{rad}(abc)
=
\operatorname{rad}(m)
\operatorname{rad}(Mc).
\]

Write

\[
r_m=\log\operatorname{rad}(m),
\qquad
r_P=\log\operatorname{rad}(Mc),
\qquad
R=r_m+r_P,
\]

and

\[
D_2=\log(Mc)-2r_P.
\]

The exact lower corridor

\[
2h-\log2\le\log(Mc)
\]

is equivalent to

\[
2h\le\log2+2r_P+D_2.
\]

Therefore a violation

\[
h>(1+\epsilon)R+C
\]

forces the sharper inequality

\[
\boxed{
D_2>
2\epsilon r_P+
2(1+\epsilon)r_m+
2C-\log2.
}
\]

The earlier conductor-only lower bound retained only
`2epsilon*(r_P+r_m)`. The refined formula shows that the radical of the small
additive gap is charged with the larger coefficient `2(1+epsilon)`.

Consequently an endpoint-degenerate family is not enough: a counterexample
family must simultaneously have

1. height-scale positive multiplicity surplus on the two large endpoints;
2. exceptionally small radical on the additive gap.

This reconnects the aggregate-surplus route with the smooth/low-radical
neighbour route in a quantitatively exact way. A successful final theorem may
trade a partial bound on `D_2` against a partial lower bound for
`rad(min(a,b))`; neither component must be controlled alone at full abc
strength.
