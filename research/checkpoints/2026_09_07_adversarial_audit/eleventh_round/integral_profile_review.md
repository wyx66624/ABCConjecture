# Independent review of the integral profile inverse

Date: 2026-09-07. IL1--IL4 read in full: ordinary proof PASS.
Source: `2026_09_07_independent_route/eleventh_round/integral_profile_lifting.md`.
Initially reviewed SHA256:
`790699aeec463170824ec4b8b852e94a6d29469e886d4e2f4c3d87f29c24f7cb`.
The review below distinguishes the actual stated hypotheses from stronger
claims that would be false. No Lean verification is asserted.

## Exact orientation and ramification accounting

The primitive multiplier tau=u*gamma^e*v has e in {0,1}, while v
and the input root are primitive and unramified. Thus tau is primitive
as well. At a split rational prime each input has at most one
orientation. At an opposite-orientation overlap the product has the
two valuations a and n*f. Its rational content therefore has valuation
min(a,n*f), and the reduced norm has valuation |a-n*f|. Equal
orientations produce no content. No inert prime can occur. At the
ramified prime the total gamma-depth is exactly e<=1, so the content
is prime to three. This proves the support assertions and C|V without
assuming V is n-free or that the two oriented supports are disjoint.

## The residual bill and its precise divisibility

For every p|C, if a>=n then V already contains p^n. If 0<a<n,
the opposite root depth f>=1 implies v_p(Mred)=n*f-a, so any integral
residual Vprime in a representation at the same exponent n has depth
at least n-a. This remains true when the numerical root Rprime is
changed, including Rprime=1. Consequently rad(C)^n divides V*Vprime.
All p|C are split and different from three, hence at least seven.
The logarithmic threshold follows exactly, and the PC norm-seven
family realizes equality. The fixed first ramified factor 3^e causes
no missing prime: the reduced norm has precisely that three-depth.

The word radical is essential. The stronger assertion C^n|V*Vprime
would fail even under all current primitive/unramified hypotheses.
Take pi=2+zeta, w=bar(pi), tau=pi^(n+1), and n>=3. Then

    tau*w^n=7^n*pi,
    C=7^n, V=7^(n+1), Mred=7, Vprime=7, Rprime=1.

Thus C^n has seven-depth n^2, greater than the n+2 depth of V*Vprime.
This is a counterexample only to that stronger replacement. The
published candidate uses rad(C), and its asserted result survives.

Two other hypotheses are material. If multiplier primitivity is
dropped, tau=7, w=pi, n>=3 gives C=7, V=N(tau)=49 and a reduced
norm 7^n with Vprime=1; the radical bill would fail. If input
unramifiedness is dropped, tau=1, w=gamma, n=3 gives content three
and reduced norm three. With e=0, V=1, Vprime=3 and Rprime=1,
rad(C)^3=27 does not divide V*Vprime=3. The note excludes both cases.

## Both actual norms and positive primitive seeds

For a rational point satisfying the complete RD equation, the extra
condition x=L0(t0)>0 and finite yields the unique reduced expression
x=a/b with a,b>0. Primitive homogeneous root coordinates are used;
the separately assumed nonunit and unramified conditions are not
inferred merely from rationality. A zero second input coordinate
would be a unit and is therefore explicitly excluded.

The primitive reduction of the first output is exactly (a,b), up to
a common sign. Taking its norm gives M=3^e V0 R^h/C0^2. Since
gcd(ab,M)=1, the second positive rational ratio ab/M already has
coprime numerator and denominator. Its primitive output is exactly
(ab,M), again up to a common sign. This proves
F(a,b)=V1 Q^g/C1^2, with no missing scalar. Both denominators are
nonzero. Common sign changes only modify the units, not the norms,
specified exponents, or the first ramified exponent e.

For unchanged numerical root norms R,Q the residuals are uniquely
V0/C0^2 and V1/C1^2, after retaining the first 3^e factor. They are
positive integers precisely when C0^2|V0 and C1^2|V1. Their upper
bounds by the original residuals are then automatic. These numerical
profiles have actual oriented lifts: the primitive reduced outputs
admit the reviewed oriented factorization, with first gamma-depth e
and second gamma-depth zero. The orientations of the roots may change;
the note correctly avoids claiming that the originally chosen w_i
survive the primitive division. Failure of this fixed-root criterion
does not by itself exclude another numerical root norm.

## Finite local inverse domain

At every p|V, multiplier primitivity fixes exactly one split factor.
Avoiding divisibility of w by the opposite factor is equivalent to
content one there. This is one forbidden point of P1(F_p). Its
primitive norm-zero residue cannot have second coordinate zero, so
the affine description r/s=-theta omits no forbidden infinity point.
There are no other split-prime conditions; input unramifiedness at
three and the positive real output domain are still separate premises.

The exclusions suffice to reconstruct the original residuals and
numerical root norms. When any representation at the prescribed
exponent also satisfies (log V+log Vprime)/n<log seven, the exclusions
are necessary even if that representation changes the root norm.
For precision, this is not a claim that content one automatically
meets an arbitrarily smaller independently prescribed output-residual
target: the guaranteed output residual is the original V. A brief
explicit clarification of this distinction was suggested to the author;
the present necessary-condition proof itself is correct.

The result identifies an arithmetic domain of rational points, not
their existence, a uniform point-height bound, or an ABC solution.
The full two-map equation and the local exclusions remain simultaneous
conditions. Neither the single-map PC counterfamily nor a density
statement is substituted for that actual membership problem.

The author subsequently added the suggested distinction about a smaller
separately specified output-residual target. That paragraph was directly
read and verified. Final reviewed source SHA256:
`efd6529cd6d5a3b986ea480f1b7501af795d08560ead843a90f606b24cd7e5ce`.
The mathematical conclusions are unchanged; final ordinary review PASS.
