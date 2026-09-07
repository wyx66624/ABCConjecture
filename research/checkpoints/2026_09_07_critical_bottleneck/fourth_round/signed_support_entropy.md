# Signed support-conditioned depth entropy

Date: 2026-09-07. Fourth-round ordinary proof, independently reviewed.
The third-round manuscript and source files remain frozen.

## 1. The arithmetic target and the reference model

For a nonzero positive integer A and a cutoff Y>=5 put

    S_Y(A)=log W_Y(A)=sum_{p>Y, p|A} (v_p(A)-3) log p,
    R_Y(A)=prod_{p>Y, p|A} p.

This is the signed target. Primes of depth one and two contribute negative
terms; taking the positive part at each prime loses those terms. The
following reference calculations use the already proved primitive-pair
model from OM6. They do not assert that an actual power orbit is uniform.

For a prime p>3, a precision E>=1, and uniform primitive pairs modulo p^E,
let nu be the capped valuation of P(vH), with p not dividing N(H). The
reference law is

    Pr(nu>=e)=3/[p^(e-1)(p+1)]                 (1<=e<=E),
    Pr(nu=0)=(p-2)/(p+1),
    Pr(nu=e)=3(p-1)/[(p+1)p^e]               (1<=e<E),
    Pr(nu=E)=3/[(p+1)p^(E-1)].

The laws at distinct primes are independent by CRT. Throughout, finite
precision valuations are capped. The infinite geometric law below can
equivalently be read as the inverse-limit Haar law, but none of the
height-bounded arithmetic statements needs an infinite state space.

## 2. Exact signed moment calculations

Write j(0)=0 and j(e)=e-3 for e>=1.

**SE1 (unconditioned signed moment).** For 0<theta<1 the infinite-precision
local moment is

    Z_p(theta)=1-3/(p+1)
      +3(p-1)/[(p+1)p^(1+2theta)(1-p^(theta-1))].             (SE1a)

Every finite capped moment is at most this quantity. In particular

    Z_p(1/2)=1-[3/(p+1)](1-1/p-p^(-3/2))
             <=1-2/(p+1)                                  (p>=5). (SE1b)

Consequently for a fixed finite prime set J in the primitive reference
model and S=sum_{p in J}j(nu_p) log p,

    log E exp(S/2)<=-2 sum_{p in J}1/(p+1).                   (SE1c)

Proof. Sum the geometric series over e>=1. Capping a positive valuation
at E can only decrease j on that positive branch, so it decreases its
exponential moment. At theta=1/2 cancel
(1-p^(-1))/(1-p^(-1/2))=1+p^(-1/2). For p>=5,
1-1/p-p^(-3/2)>=2/3 (already true at p=5, and increasing).
Independence and log(1-x)<=-x prove (SE1c).

For any probability law nu on the same finite reference space the
relative-entropy variational inequality therefore gives

    E_nu S <= 2 D(nu||mu)-4 sum_{p in J}1/(p+1).              (SE1d)

The negative term in this unconditioned estimate is a reciprocal-prime
sum. No height-sized negative credit has yet been obtained from it.

**SE2 (condition on support to retain the radical credit).** Conditional
on nu_p>=1, the reference depth law is

    q_p(e)=(1-1/p)p^(-(e-1))                  (e>=1)          (SE2a)

at infinite precision. At finite precision E, use (SE2a) for e<E and
q_p(E)=p^(-(E-1)). Its signed moment satisfies

    E[p^(theta(nu_p-3)) | nu_p>=1]
       <= p^(-2theta)(1-1/p)/(1-p^(theta-1)).                 (SE2b)

At theta=1/2 the right side is exactly p^(-1)(1+p^(-1/2)).
For a fixed supported set J, put R_J=prod_{p in J}p. If D_J is the
relative entropy of any actual depth law on that support against the
conditional product reference, then

    E S <= 2 D_J-2 log R_J
               +2 sum_{p in J}log(1+p^(-1/2)).               (SE2c)

More generally, with theta=1-delta in (0,1),

    E S <= D_J/theta-2 log R_J
      + (1/theta) sum_{p in J}
           [log(1-1/p)-log(1-p^(-delta))].                   (SE2d)

Proof. Divide the local positive-depth probabilities by 3/(p+1), sum the
geometric series, and apply the finite relative-entropy variational
inequality. Capping again only decreases the signed moment.

For primes p>Y, the last sum in (SE2d) is at most

    |J| Y^(-delta)/(1-Y^(-delta)).

Taking delta=1/sqrt(log Y) as Y tends to infinity makes this o(log R_J),
uniformly in the finite support J. Unlike the old positive-excess
observable, the allowance here is of size 2 log R_J. This allowance is
not automatically earned by an arithmetic orbit.

## 3. A height bound controls the remaining depth entropy

This statement is about actual integers, not a uniform reference sample.
Fix t>0, Y>=5, and any probability distribution on finitely many positive
integers A with log A<=3t. The distribution may be concentrated on one
actual value of P(vw^g), or on any finite family of such values. Let

    J=J(A)={p>Y: p|A},     e=(v_p(A))_{p in J},
    L(A)=sum_{p in J}e_p log p,    r(A)=log R_Y(A).

Let H_depth=H(e|J) be the ordinary Shannon conditional entropy, using
natural logarithms. The prime support distribution is kept exactly as
in the actual ensemble; it is not replaced by a reference law.

For each prime in the finite union of actual supports choose a precision
E_p>3t/log p. Conditional on J, let q_J be the product of the finite
geometric laws (SE2a), capped at E_p. Every actual depth is strictly
below its cap. Define

    D_depth = E_J D(Law(e|J)||q_J),
    c_J = sum_{p in J} -log(1-1/p).

**SE3 (height-sensitive signed entropy identity).** One has the exact
identity

    E S_Y(A) = D_depth-2 E r(A)+H_depth-E c_J.                (SE3a)

Moreover

    0<=H_depth<=3(log 2)t/log Y,
    0<=E c_J<=3t/[(Y-1)log Y].                              (SE3b)

In particular

    -3t/[(Y-1)log Y]
      <= E S_Y(A)-(D_depth-2E r(A))
      <=3(log 2)t/log Y.                                    (SE3c)

All bounds are uniform in the actual ensemble, its number of members,
the prime support, the precisions above, and the common factor H.

Proof. On actual depths, which are not at their precision cap,

    -log q_J(e) = sum_{p in J}(e_p-1)log p+c_J=L-r+c_J.

The definition of relative entropy gives
D_depth=E(L-r+c_J)-H_depth. Since S_Y=L-3r, this is (SE3a).

Put M=floor(3t/log Y). For any actual depth vector,
sum e_p<=M, because every p>Y and L<=log A<=3t. Given a support J of
size r0, the number of positive integer vectors with sum at most M is
binomial(M,r0), with the empty support giving one vector. The standard
stars-and-bars count follows by adjoining a nonnegative slack variable.
It is at most 2^M, by summing the binomial coefficients. The entropy of
a law on at most 2^M states is at most M log 2, proving the first bound.
Also |J|<=3t/log Y and -log(1-1/p)<=1/(p-1)<=1/(Y-1), proving the second.
Combining the two nonnegative bounds with (SE3a) proves (SE3c).

For any sequence of these height-bounded ensembles with Y tending to
infinity, a uniform upper bound E S_Y(A)<=o(t) is therefore equivalent
to the support-aware allowance bound

    D_depth <= 2 E log R_Y(A)+o(t).                           (SE3d)

The equivalence concerns a one-sided upper bound, not convergence of the
signed quantity to zero. Negative linear signed credit is compatible
with ABC. For a point-mass ensemble (SE3a) still holds, with H_depth=0;
no distributional assumption has been smuggled into a single seed.

## 4. What this target gains, and what it does not prove

The third-round positive-excess observable had D_obs=o(t) equivalent to
E sum_p(v_p(A)-3)_+ log p=o(t). That target discards all depth-one and
depth-two credit. SE3 instead retains the signed target through the
nonzero allowance 2 E log R. It does not prove (SE3d): an independent
arithmetic estimate for this conditional relative entropy remains needed.
Data processing, a finite reference model, or sparseness of actual seeds
alone does not imply that estimate.

An actual retained-prime example distinguishes the two costs. Take
distinct primes p<q<2p and the primitive pair (a,b)=(p^4,q), with common
factor H=1. At the specified primes {p,q}, the boundary A=ab(a+b) has
depths exactly 4 and 1. Thus its retained positive excess is log p while
its retained signed cost is log p-2 log q<0. The seed height parameter
log(a+b) is asymptotic to 4 log p. This only compares the two targets
on a specified packet of actual primes; it is not a bound for every
other prime of A, and it is not a small-lambda nontrivial power orbit.
Existence of arbitrarily large such prime pairs can be supplied by
Bertrand's postulate, but the exact comparison needs only any such pair.

## 5. Dependency chain and next exact obstruction

The chain is primitive local counting (OM6) -> conditional geometric law
-> signed geometric-series moments (SE1--2) -> exact cross entropy and
finite height counting (SE3). Apart from the already proved local count,
only elementary finite probability, geometric series and stars-and-bars
are used. No analytic number-theory conjecture enters these statements.

For a homogeneous actual orbit w^g the existing exact rank law gives
e_p=s_p+v_p(g) on the supported ranks d_p|g. The total lifting cost is
at most log g. The unresolved part is therefore the joint first-depth
budget s_p with its actual supported primes. A support-conditioned
entropy estimate has to exploit that coupling; merely assigning the
reference geometric distribution to s_p would restate the unproved
input. For shifted residuals v w^g, ranks are shifted residue classes
and may have finite stopping or full towers; the homogeneous divisibility
law cannot be transferred unchanged. Those distinctions remain in force.

Review status: the independent adversarial agent read the complete SE1--SE3
proof and approved the finite-cap calculation, common-height quantifiers,
entropy count and one-sided scope. No claim of Lean formalization or
resolution of ABC.
