# ABC multi-route research note v30: coprime splitting of the selected power layer

**Author:** ChatGPT  
**Date:** 2026-08-30

Let

\[
M=\max(a,b),
\qquad
N=Mc,
\]

for a primitive abc triple. Since `gcd(M,c)=1`, every prime divisor of `N`
belongs to exactly one of the two endpoints.

Suppose the layer-cake selector and exact divisor extraction produce

\[
D^j\mid Mc.
\]

Write

\[
D_M=\prod_{p\mid M}p^{v_p(D)},
\qquad
D_c=\prod_{p\mid c}p^{v_p(D)}.
\]

Then

\[
\boxed{D=D_MD_c,\qquad \gcd(D_M,D_c)=1,}
\]

and primewise divisibility gives

\[
\boxed{D_M^j\mid M,\qquad D_c^j\mid c.}
\]

Consequently

\[
j\log D_M+j\log D_c=j\log D,
\]

so at least one endpoint satisfies

\[
\boxed{
j\log D_M\ge\frac12j\log D
\quad\text{or}\quad
j\log D_c\ge\frac12j\log D.
}
\]

Combining this with the height-scale layer selector shows that the bounded
exponent branch of a hypothetical abc counterexample contains a genuine power
divisor of fixed positive height exponent on one individual large endpoint,
not merely on their product.

The next pointwise equation therefore takes one of the forms

\[
u x^j+m=c
\]

or

\[
M+m=v y^j,
\]

where the extracted `j`-th power has quantitative height and the residual
coefficient is governed by the exponent-residue budget.  This is the concrete
entry point for binomial Thue, modular, and short-gap methods.

The Lean implementation should use the canonical prime-factorization support
of `D`, split it by divisibility into the coprime endpoints, and prove the two
power divisibilities. No Diophantine theorem is required for this bridge.
