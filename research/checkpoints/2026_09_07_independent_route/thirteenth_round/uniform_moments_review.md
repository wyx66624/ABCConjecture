# Independent full ordinary review of UM1--UM4

Reviewer: independent_route. Date: 2026-09-07.
Status: PASS. This review belongs to the thirteenth round; the published
twelfth-round files are not modified.

Reviewed the complete source
`research/checkpoints/2026_09_07_critical_bottleneck/twelfth_round/next_uniform_moments.md`,
and reread the previously established PN tuple bounds and the explicit
prime-index specialization of FM1 at the new cutoff 8B.
Reviewed source SHA256:
35491e4c01733542da45118fdb720af120d79705b4828b3c1824ff182f4eea91.

1. The uniform determinant comparison is valid for every finite positive
   tuple length. Its ratio to the modulus is strictly smaller than
   (8/(7B))*nu*(49/64)^nu. The finite geometric-sum bound gives
   512/(105B)<1 for B>=5. No constant depending on nu is hidden.
2. Actual boundary divisibility supplies units and membership in the
   norm-one 3n-torsion group; q>8B>n prevents residual-characteristic
   torsion in the lifting kernel. Equal multiset images give exact ratio
   equality by UM1, and PN's private prime ideals make all multiplicities
   equal. Thus the stars-and-bars bound is an actual injection, with the
   empty-set case stated separately.
3. The two-root bound and r=ceil(sqrt(n)) bound are correct. Four deep
   roots would give binom(r+3,3)>n^(3/2)/6>3n when n>324. The lower
   layers cost less than 10n log(q); all layers at least 2r together
   cost at most 9n log(6B+1). Every positive-excess layer is included.
4. The normalized cost at one prime is at most 38/B on the stated
   domain Z<=B^2. Rank one cannot support these depths, and the two
   rank-n progressions together have the stated Brun--Titchmarsh bound.
   The exact numerical conversion is 76*n/(n-1)<80 for n>324.
5. With B=n^4 and fixed delta>0, the floor in Z_n is harmless and
   log(Z_n/(3n))~4 log(n). FM1 at Z=8B gives O(1/log(n)) for prime n:
   its endpoint term uses sigma(n)=n+1, rather than a uniform-in-index
   bound that would lose this saving. The elementary exceptional-prime
   contribution is retained through the cited EA result.
6. Both Markov exclusions are measured relative to the whole block B,
   so their intersection with PN's actual half-density class has the
   displayed size. The signed decomposition and the identity relating
   log(T), the signed cost, and log(rad(T)) give UM7--UM8 with the stated
   constants and positive part of the far tail.

No mathematical correction is required. This is a complete ordinary
proof review with explicit reliance on the already reviewed PN, MC,
FM/EA and Brun--Titchmarsh inputs. It is not an additional Lean build or
a new independent software replay. The far tail, norm-smooth complement,
and remaining exceptional roots stay open; the result does not prove
a global ABC estimate.

## Final TeX and the fifteen arithmetic declarations

Full mathematical transcription review of the entire
`thirteenth_round/paper/uniform_moments.tex`: PASS.
Reviewed SHA256:
d87e28d3df6aa21dd825bfaf789998c98b19e653ce4d302dd3c508f9d8bd121c.
The all-length rigidity, complete layers, growing threshold, all-block
normalization, constants, and remaining tail scope agree with the
ordinary proof. The final paragraph accurately separates the fifteen
formal declarations from the finite-ring and analytic inputs.

Read every signature and proof in `UniformMomentArithmetic.lean`,
SHA256 646308163a102479ea842b33b2f06eb8b1adf342e459f13cf8b4a51c597d1568:
source and scope PASS. The binomial identity and monotonicity arguments
handle the truncated natural subtraction; floor(sqrt(n))+1 has the
stated numeric bounds. The finite-list count is genuinely identified
with a filter length, and the complete excess inequality is proved
term by term for every listed depth. The weighted statements retain
their explicit depth-cap, low-count, multiset-count and height
hypotheses. The real divisions use positive denominators. I did not
perform a second Lean build and do not represent this source review
as an independent compilation.
