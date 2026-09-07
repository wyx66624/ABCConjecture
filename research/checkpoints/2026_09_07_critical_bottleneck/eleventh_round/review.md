# Eleventh-round independent review ledger

I read adversarial_audit's projective_content_boundary.md, PC1--PC2,
in full: ordinary proof PASS. The actual adjugate identities and Bezout
show C|N(tau) without extra coprimality assumptions. Unramifiedness is
used only when deriving that the input power is primitive. In the
pi=2+zeta, w=bar(pi) family the rational content is exactly seven and
the primitive reduced norm is exactly 7^(n-1). The specified n-th-power
extraction with a nonunit integer root is impossible by its seven-adic
valuation. The unit-sector normalization, fixed root parameter and
explicit n=5 integer example all check.

This is a counterexample only to the stated single-map converse with
the prescribed exponent. No second rational-map equation is asserted,
and neither the forward DC lift nor a different exponent extraction nor
the actual signed compensation gate is ruled out. The direct family
and valuation proof establish the infinite statement; no finite-search
absence or unreported Lean proof is used.

I read independent_route's integral_profile_lifting.md, IL1--IL4,
in full: ordinary PASS. The opposite-orientation content is min(a,nf)
and the reduced exponent is |a-nf|. For any alternative integral
residual at the prescribed exponent, the two cases a>=n and 1<=a<n
prove rad(C)^n divides V*Vprime. The sharp log-seven bill really
persists when the numerical power root is changed. The finite local
exclusions, exact same-root residual V/C^2, possible orientation
change on relifting, and the separately assumed unramifiedness at
three have their stated scope. No rational-point existence follows
from those local conditions.

I proposed the pure-coefficient positive converse and subsequently
read the author's complete pure_coefficient_inverse.md, CI1--CI2.
Full ordinary transcription PASS. Every primitive projective input
can be decomposed as gamma^epsilon times a primitive unramified
integer, including unit and infinite inputs. The output content is
exactly 3^floor((e_initial+epsilon*n)/2), leaving the stated parity.
The actual second norm excludes the remaining power of three and
forces its root norm above one. If the first root norm were one,
positivity forces the seed (1,1), whose second norm thirteen cannot
be a nontrivial g-th power. Hence both extracted unramified root
norms are at least seven. The first parity may change when h is odd.
The finite-family converse retains all unit and parity choices and
claims no uniqueness. The even/even empty positive-base locus follows
from the already reviewed combined-norm square obstruction; it does
not exclude negative base points or the other exponent pairs.

Root and adversarial_audit read large_cutoff_signed_bridge.md,
LC1--LC3, completely and approved the ordinary proof. The common
actual set G_n is defined only by the small-prime mass, so all moving
cap choices share the same set without a union bound. The constants
39/n, 3 eta_n and 43/(3n), the replacement of the signed excess by
its positive part in the radical consequence, and the uniform versus
sequence quantifiers all passed. The TD representatives' strict
exclusion from B=n^4 and the separate conditional cutoff comparison
are retained. Reviewed ordinary SHA256:
ff77c5f1abdf7fadc6e1581cac55d4edbebd41207af6935e02f3d6d4eaf18cfb.
The theorem does not prove cap membership on any positive proportion
of G_n and does not eliminate the actual exceptional roots.

I read the complete final PC, IL and CI TeX transcriptions: PASS.
PC retains its single-map, specified-exponent scope. IL explicitly
clarifies that the finite exclusions reconstruct the original integral
residuals, not an arbitrary smaller requested budget. CI includes all
projective inputs and both ramified parities before deriving the actual
nonunit pure profiles; its even/even empty-locus corollary is restricted
to positive finite base coordinates. No geometric or oriented result
has silently become a Lean assertion.

Adversarial_audit completed the final full LC TeX review. The only final
clarification restores the ordinary statement's sufficiently-large-n
qualification when comparing Z with B. The mathematical statements are
unchanged. Final LC TeX SHA256:
a3427b347080991165d18c40bc78f0c443898a823588611cf18790da28c42961.

I read canonical_residual_reflection.md, CR1--CR3, completely: ordinary
PASS. Reviewed SHA256:
d002782a1515aea58cf2c376ae6fa2fee92cb72b7c77f3536dda5093e276bbad.
Under n-freeness, each opposing residual valuation a satisfies a<n<=nf.
The content takes the complete p^a factor; the canonical residual
reflection and the decrease of the root valuation by one follow.
The exact residual bill, equality conditions, all noncanonical S
adjustments and the two non-n-free comparisons are accurate. The
second comparison really gives 1/7 in the false proposed formula.
This is an exact statement for supplied orientations, not existence
or height control of simultaneous rational points.

I read the final revised gaussian_even_profile.md, GE1--GE4, in full:
ordinary PASS. Reviewed SHA256:
11400f5e2f028af857fe7a2443542e1828f7b3a47e981211af7ba49f519d48a2.
The quadratic support condition, actual Gaussian oriented allocation
with overlapping supports, coefficient height, and its shared
coordinates with the Eisenstein allocation are all correct. The
integer inverse includes its square and parity constraints; its
revised even-prime coprimality proof uses U^2=M and gcd(U,c)=1
correctly. The two allocations are not asserted to be independent
covers, and the odd second-exponent branch remains open.

The author completed a fresh Lean 4.32.0 build of all nine new
ActualGlobalSignedBridge declarations and all 24 local dependencies,
against pinned Mathlib 81a5d257c8e410db227a6665ed08f64fea08e997.
The successful final run used the WSL-local project cache and fresh
copies of all listed local sources. It reused Mathlib oleans; it was
not a rebuild of Mathlib. The complete 33-declaration axiom inventory
contains only the standard three axioms. An earlier attempt returned
a warning-as-error for unnecessary sequencing; the source was fixed
and the final fresh run passed with warnings-as-errors retained.
Final source SHA256:
92145cb1ee76d9e125fcb91fd695f2ffb1fe673d58d0148b80a12ada2b90b26e.
Final validation manifest SHA256:
cb46f1f823d81992649cf7924b0d21f880a0794af4fd9cc241c34000725c2df6.
Root and adversarial_audit completed full independent mathematical
and source/scope reviews. Adversarial_audit also checked the final
hashes and complete axiom output; that review did not claim a second
compiler run. The explicit tail, low-mass and height premises remain
visible; neither sieve membership nor its exceptional set is formal.

Adversarial_audit completed the full final transcription review of
paper/actual_global_signed_bridge.tex: PASS. The global signed
comparison, numerical 39/43 transfer, finite actual 3/2 low-mass
coefficient, and exact nine-plus-24 formal scope match the source.

Root, adversarial_audit and independent_route each completed a full
ordinary review of squarefree_outer_window.md, SQ1--SQ3: PASS.
The union bound controls every prime in the interval simultaneously.
Rank-one repeated primes are excluded using each separate old
factor, not their product. The endpoint constant six and all
large-n qualifications passed. The subsequent FM/EA argument retains
both the o(height) window mass and the almost-full larger-prime mass.
No positive lower bound for window credit or control of the excluded
roots is claimed. Its TeX transcription has been sent for final review.

The SQ TeX now has full final transcription approval from
adversarial_audit and root. Reviewed SHA256:
a958f7779daf01112f1085e6f676d10c8277287f8145bcea28a6a536d8971b33.
The joint window, prime-exponent domain, nonnegative full mass versus
signed credit, and the unresolved larger packet are unchanged.

I read the complete final CR TeX. The only correction requested was
to replace multiplying exponent quotients by multiplying the
corresponding prime powers when defining S. The author made that
literal correction; the final mathematical transcription is approved.
Final text hash:
e3dce75b6e24f8220bef6d62e2a0baff2c43574ad8c8ea0422181d2babb6e702.

I read biquadratic_power_cover.md, BK1--BK3, in full: ordinary PASS.
The eight distinct branches, exact Kummer relation kernel of order
gcd(g,2), component-wise inertia g and Riemann--Hurwitz calculation
are correct. The pure constants define both even components over
the fixed field. The actual positive conic parameter and scaling
give a nonbranch point; the unit absorption is in the fixed field.
This cover is not asserted to be birational to DC or to give an
inverse for arbitrary K-points.

I then read the complete final GE and BK TeX transcriptions: PASS.
GE SHA256:
0caee55686c8508869598243b08f7fe42ce9090960f7ee781afe099295be8ab9.
BK SHA256:
fe2ba408d73647a512b32b870ec9ec4754fe3b5a948f17b4e8f44060d487d647.
The positive integer U and absolute discriminant qualifications,
the smooth projective normalization, and the distinction between
geometric and arithmetic components all match the ordinary proofs.
I did not run their supplemental replay and do not claim a separate
independent computational verification.

I read root's complete actual_content_and_residual_bill.tex and
eleventh_research_status.tex: mathematical and scope PASS. I also
read all six ActualResidualLogThreshold signatures and proofs.
They prove the actual finite prime product/log identity and strict
joint logarithmic threshold, with positivity and the local reflected
valuation interface retained explicitly. The stated nine content,
seven local-residual, six log-product and nine global-signed declarations
sum to 31; the manifest records the 53 unchanged local dependencies
and all 84 axiom queries. No ordinary oriented factorization, inverse
or analytic statement is silently included in that formal inventory.

During the full-book build root found a form-feed byte before "rac"
in the LC TeX and replaced it by the intended literal \frac command.
The mathematical expression was unchanged. This supersedes the
previous LC byte hash; the corrected final source SHA256 is
2f11aed120a6799d510c2d0bb1c0724d072432caf92af463022bc5376156a1b7.
