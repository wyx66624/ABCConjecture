# Independent review of elementary actual-block inputs

Date: 2026-09-07. EA1--EA3 ordinary proof read in full: PASS.
Source: `2026_09_07_critical_bottleneck/tenth_round/elementary_block_inputs.md`.
Reviewed SHA256:
`b6e7897bffa69995e8fbca2014de17b3f3146e88e1d2d6e6a1e78c219c19ef7b`.

For B>=n>=1 and B<=k<2B, the root 3k+zeta has angle
atan(sqrt(3)/(6k+1)). The upper bound 3n*theta<sqrt(3)/2 places it
strictly in the interval where sin u>=2u/pi. The lower arctangent
bound and the cubic boundary identity have the correct constants.
Combining the norm-to-maximum bound with the resulting lower bound
for T_n gives exactly log[4*pi*(12B+1)/(3*sqrt(3)*n)] for the defect.
Its argument is at most 81B/n and hence (3B)^4. This proves the
uniform bound 0<=Delta/t<=4/n, including n=1 and B=1.

The local lifting argument is a direct binomial proof. For a valuation
normalized by v(p)=1, its strict threshold e>1/(p-1) makes the linear
term uniquely minimal when raising to p. The prime-to-p exponent step
only requires e>0. These facts apply at the ramified place above three
with the same normalization.

The norm Q is prime to two and three. The cubic prefactor at three has
valuation 3/2, so lifting eta=(w/bar(w))^3 and subtracting that constant
gives v3(T_n)=v3(T_1)+v3(n). At two the prefactor is a unit. Odd n uses
the weaker prime-to-two step. Even n uses eta^2, whose depth is at least
three: the exact product T_2=a(a-1)(a+1)(a+2)(2a+1) contains four
consecutive integers. The two parity branches and the n/2 exponent
are correct. Their total cost is bounded by 9 log(6B+1)+2 log n,
which yields the displayed 20/n after normalization.

Replacing only the archimedean and two fixed-prime inputs in FM is
legitimate on this stated B>=n domain. The retained first-depth interval
count and Brun--Titchmarsh endpoint give the same all-index mean. Markov
preserves an explicit exceptional proportion. Subtracting actual small
mass from log T_n/t gives EA11; at prime indices, the old rank-one mass
costs at most 3/n and primes beyond Z have no exponent-lifting term.
The resulting EA12 uses actual top first depths. Neither full mass
statement estimates harmful signed cost or proves membership in any
compensation class. No density assertion is substituted for control
of each actual root.

The binomial and angular replacement is self-contained. The previously
reviewed Brun--Titchmarsh theorem remains an explicit external analytic
input. This review does not treat the replacement as a new ABC result,
nor claim that the signed-tail logarithmic-form inputs are all removed.

## Independently executed finite supplement

The replay source was read in full before execution. This reviewer
actually ran the following read-only check, with exit code zero and PASS:

    python research/checkpoints/2026_09_07_critical_bottleneck/tenth_round/replay_elementary_block.py --check

It recomputed 571 actual rows and 1,142 exact valuation equalities for
n=1,...,96, B in {n,n^2,n^4}, and both interval endpoints, removing
duplicate parameter triples. Independent integer multiplication produces
the coordinates, norms, maximum-height bounds, positive sector and
two/three valuations. No full factorization or floating-point angular
inequality is certified by this replay.

Canonical result SHA256:
`05ff5fa1ddb45dfb1c662e5ad0bae06a60adea8956038dd51d49ed778c8ef213`.
Payload SHA256:
`1d657505ffaa849345008e6901daab21c2b3bb07b22ba6c435900c2a10f29566`.
Both agree with the author-provided result. The ordinary infinite proof,
finite supplement, and absence of Lean formalization remain distinct.
