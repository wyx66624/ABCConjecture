# Independent review of signed support-conditioned depth entropy

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read the critical-agent `fourth_round/signed_support_entropy.md` in full,
SE1--SE3. The ordinary proofs pass independent mathematical review.

The primitive reference hit probability is 3/(p+1), with geometric
conditional positive depth. Summing the signed moment j(0)=0,
j(e)=e-3 for e>=1 yields the stated SE1 formula. At theta=1/2 the
conditional factor is p^(-1)(1+p^(-1/2)); for p>=5 it is at most 1/3.
Consequently the unconditioned moment is at most 1-2/(p+1).
Capping a positive depth decreases j on that branch even for caps one
or two; its discontinuity between depth zero and one is irrelevant
because capping never changes whether a depth is positive. Thus the
finite-cap inequalities have the correct direction.

SE2 conditions on the actual supported set, retaining the radical
credit rather than paying for a rare support event. Its theta moment
and entropy variational bound are exact. For theta=1-delta, dropping
the nonpositive log(1-1/p) terms and bounding the remaining logarithms
gives the claimed uniform error. Delta=1/sqrt(log Y) makes that error
o(log R_J) as Y grows. This does not grant the arithmetic entropy
allowance and is not used to replace the support by a uniform law.

SE3 explicitly assumes one common t with log A<=3t throughout each
finite ensemble. Its choice E_p>3t/log p places every actual depth
strictly below the terminal cap. Hence the reference distribution
remains normalized with its terminal atom, while every actual cross-
entropy term reads the nonterminal geometric formula exactly. There
is no omitted terminal-tail correction in the displayed identity.

For each actual support J, the negative log reference probability is
L-r+c_J. Subtracting ordinary conditional Shannon entropy gives
D_depth=E(L-r+c_J)-H_depth, and rearranging yields exactly

    E signed_cost=D_depth-2 E log R+H_depth-E c_J.

The entropy bound counts positive integer depth vectors whose coordinate
sum is at most M=floor(3t/log Y). Their number is binomial(M,|J|),
including one vector for empty J, and this is at most 2^M. The separate
c_J bound uses at most 3t/log Y supported primes and
-log(1-1/p)<=1/(Y-1). Both errors are uniform o(t) as Y grows.

The resulting equivalence is one-sided: an upper signed-tail bound
corresponds to D_depth<=2 E log R+o(t). It is not a two-sided claim
that the signed value tends to zero, and it is not a proved independent
estimate for D_depth. The point-mass case has zero conditional entropy
and is explicitly included without a distribution assumption.

The actual pair (p^4,q), with distinct p<q<2p, has exact depths four
and one at the specified primes, so the retained positive excess is
log p while the retained signed cost is log p-2 log q<0. The note
does not infer a bound for other primes of that boundary or a small-
lambda profile. Its homogeneous rank-law discussion also keeps the
first-depth input separate from the at-most-log(g) lifting contribution;
the residual-shifted law is not silently replaced by rank divisibility.

No new Lean theorem or ABC conclusion is claimed by this review.

Read the complete final `fourth_round/paper/signed_support_entropy.tex`.
The transcription also passes. It explicitly states the common ensemble
height bound, its application to actual abc boundaries, and the strict
precision caps whose terminal atoms do not enter actual cross entropy.
The one-sided signed interpretation and the unproved arithmetic allowance
remain explicit. The fourth-round TeX is ready to freeze.
