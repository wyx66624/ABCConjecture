# A primitive-residue reference measure and its entropy boundary

Author/reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

This note records an independent calculation proposed during discussion of
the critical agent's third-round collision direction. The reference-measure
estimates below are exact; no claim is made that bounded-height integer
residuals follow that reference measure.

## Exact finite local probabilities

Fix an Eisenstein integer H and a prime p not dividing N(H). For a precision
E>=1 let Omega_p be the coordinate pairs modulo p^E which are not both zero
modulo p, with uniform probability. Its cardinality is

    p^(2E-2)(p^2-1).

Multiplication by H is an invertible two-by-two matrix modulo p^E and
permutes Omega_p. For a residue pair v define nu_p to be the largest
e<=E such that p^e divides P(vH). This capped valuation is well-defined
on residues; an uncapped valuation of a chosen integer lift would not be.

For 1<=e<=E, exactly one of the three boundary arms vanishes modulo p
when the product does. The arms are disjoint in the primitive residue set.
Each has phi(p^e) solutions at precision e, followed by p^(2(E-e)) lifts.
Therefore

    Prob(nu_p>=e)=3/[p^(e-1)(p+1)].

No split/inert distinction is needed for this primitive-coordinate measure.
It includes vectors whose Eisenstein norm vanishes modulo p; such vectors
do not contribute to the boundary event. The more restricted norm-unit
measure discussed by the critical agent also works, with p+1 replaced by
p-chi_p. Both measures must be distinguished from an actual height sample.

## Positive-tail expectation and exponential moment

Let K_p=(nu_p-3)_+. Summing its tail probabilities gives

    E K_p <= 3/[p^2(p-1)(p+1)],

uniformly in E. For a finite set S of primes p>Y>=5, the Chinese remainder
theorem gives independent primitive residue coordinates. Thus the reference
mean of F=sum_{p in S} K_p log p is at most the sum of those explicit local
means. It is O(log Y/Y^3), independently of H, the finite set S, and the caps.

For 0<theta<1, the elementary tail-sum identity also gives

    E p^(theta K_p)
      <= 1+3(p^theta-1)/[p^3(p+1)(1-p^(theta-1))].

Indeed expand the expectation using the successive increments of p^(theta k)
and the probabilities K_p>=k, then sum the resulting geometric series.
Independence and log(1+x)<=x bound log E exp(theta F) by the sum of the
displayed local errors. For theta=1/2 that bound is O(Y^(-5/2)), uniformly
in the finite set and caps. Infinite precision can be defined instead on the
p-adic inverse-limit measure; the zero-boundary locus has measure zero, and
monotone convergence gives the same bounds. This does not select an integer
representative or transfer the estimate to a bounded-height integer family.

## An exact entropy transfer, and a barrier to a naive full-state premise

For any probability distribution nu on the finite residue space Omega,
with uniform reference mu, the standard finite entropy inequality reads

    theta E_nu F <= D(nu||mu)+log E_mu exp(theta F).

It follows immediately by applying nonnegativity of relative entropy to
the exponentially tilted reference distribution. At theta=1/2 this gives
E_nu F<=2D(nu||mu)+O(Y^(-5/2)). Thus a sufficiently small relative-entropy
loss would be a valid transfer premise. It has not been established for
the actual residuals of interest.

There is a precise obstruction to obtaining that premise on the entire
residue space from only a small family. Write m=product_{p in S}p^E_p.
Then

    |Omega|=m^2 product_{p in S}(1-p^(-2)).

If nu has support of size at most K, its Shannon entropy is at most log K,
so D(nu||mu)>=log|Omega|-log K. Furthermore
-log(1-p^(-2))<=1/(p^2-1) and |S|<=log m/log Y give

    D(nu||mu)
      >= [2-1/((Y^2-1)log Y)]log m-log K.

Consequently, if log m>=delta*t for fixed delta>0, log K=o(t), and Y tends
to infinity, the full-state entropy loss is at least (2delta-o(1))*t. It
cannot be o(t). This excludes that specific proposed full-residue-space
small-loss shortcut in the indicated range. It does not exclude probability
methods, coarser observables, other reference measures, or an argument that
uses the arithmetic structure of the unique owner packets.

The independent finite replay enumerates five complete primitive residue
spaces, including small primes two and three and precision four at five.
It checks the exact capped-event counts under multiplication by H. These
finite checks supplement the counting proof and do not establish the missing
height-to-measure transfer.

## Full independent review of OM1--OM6

Read `2026_09_07_critical_bottleneck/next_owner_measure.md` in full,
including its norm-unit object and primitive variant. OM1--OM6 pass this
ordinary mathematical review. In addition to the calculations above, the
explicit constants 10 in the mean bound and 4,8 in the exponential moment
and transfer bounds were checked using the displayed decreasing integrands
and floor(Y)>=4Y/5. The theta=1/2 simplification of the local geometric
series is exact. All entropy statements concern the specified finite spaces.

For OM3, fix a primitive integer vector v and draw H uniformly from the
norm-unit residue ring modulo the specified q. If p divides N(v), then Hv
has nonzero coordinates collectively but zero norm modulo p. No nonzero
boundary-arm vector has zero norm, so that prime's arm event is empty.
Otherwise v is a unit and its multiplication permutes the uniform units.
The one-arm probability is therefore 1/[p^(e-1)(p-chi_p)], or zero in the
excluded case. CRT independence and p/(p-chi_p)<=5/4 give the stated local
product bound. Summing over at most 25B possible integer vectors and then
over 3^omega(q) labels proves OM3a and OM3b with their exact constants.

This is an actual first-minimum distribution estimate in the stated
common-factor ensemble. It does not require or prove that a prescribed
orbit H=w^g is uniform in that ensemble. The modulus and optional arm labels
are specified before the event; unrestricted data-dependent selection of
packets would need another budget. OM6 correctly broadens the residual
reference space to every primitive coordinate vector, while retaining the
separate norm-unit common-factor ensemble where OM3 needs it.

## OM7 and final manuscript transcription

Read the full stable `third_round/paper/owner_measure.tex` from the critical
checkpoint. Its OM1--OM7 transcription passes independent review, including
the additional observable-entropy bounds. The final text explicitly caps
all finite-state valuations and distinguishes the reference measure from
any specified small-height integer family or special power orbit.

Under the primitive reference, push forward to K_p=(nu_p-3)_+. For a
positive nonterminal atom k, its probability is

    3(p-1)/[(p+1)p^(k+3)],

while the terminal cap atom is 3p/[(p+1)p^(k+3)]. Both are between
p^(-(k+3)) and 3p^(-(k+3)). The zero atom for a cap at least four is
1-3/[p^3(p+1)], and a lower cap has a certain zero. These exact formulas
give the final upper and lower surprisal bounds without treating the cap
atom as a difference of two infinite-precision tails.

Writing pi for this joint observable law and F=sum K_p log p, the same
finite tilt gives

    (1/2) E F - 4Y^(-5/2) <= D(nu_K || pi)
      <= 4 E F + 10Y^(-3).

The upper bound subtracts the nonnegative Shannon entropy from the expected
surprisal, and uses k+3<=4k only for positive integer k. The zero-coordinate
surprisal is summable uniformly in the number of primes and all caps.
The finite relative-entropy chain rule also gives D_observable<=D_full.
For support of size at most K, the sharper displayed lower bound keeps
the additional sum of 3 log p-log 3 at occupied positive coordinates and
subtracts at most log K. All these directions and constants are correct.

The actual pair (1,1), H=1 has boundary two, hence a zero observable and
bounded observable Dirac entropy, even as one cap grows and its full-state
Dirac entropy diverges. It is correctly labeled a comparison of reference
losses, not a small-lambda family. The two-sided bounds imply that small
observable entropy and small expected positive tail are equivalent up to
constants and vanishing errors at growing height. This is a reformulation
requiring an independent arithmetic input, not a weaker proved premise.

The final passage correctly distinguishes the sum of primewise positive
parts from the positive part of the signed total. The reference target is
stronger, and the signed negative credits are retained in the companion
collision formulas. No global-tail or ABC conclusion has been inferred.
