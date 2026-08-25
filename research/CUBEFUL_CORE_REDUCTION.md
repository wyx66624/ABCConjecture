# Large cube-core reduction

For `n=prod p^e_p`, define

\[
 U_3(n)=\prod_pp^{\lfloor e_p/3\rfloor}.
\]

Primewise, `3 floor(e/3)>=e-2`, so

\[
 U_3(n)^3\geq n/\operatorname{rad}(n)^2.
\]

Let `a+b=c` be primitive and put `R=rad(abc)`. If

\[
 c>R^{1+\epsilon},
\]

then `ab>=c-1` and hence

\[
 U_3(abc)^3
 \geq abc/R^2
 >c^{2\epsilon/(1+\epsilon)}(1-1/c).
\]

Writing

\[
 a=A x^3,\quad b=B y^3,\quad c=C z^3
\]

with cube-free `A,B,C`, one has `xyz=U_3(abc)`. Therefore one of `x,y,z`
is at least

\[
 c^{2\epsilon/(9(1+\epsilon))}(1-1/c)^{1/9}.
\]

Every prospective counterexample thus yields a primitive point on the varying
diagonal cubic

\[
 A x^3+B y^3=C z^3
\]

with a polynomially large cubic coordinate. This supplies a genus-one/elliptic
descent route complementary to the square-core diagonal-conic reduction.
