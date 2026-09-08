# LP1--LP4. An actual large-prime barrier in balanced two-source radical partitions

Status: complete ordinary argument; root, critical_bottleneck and independent_route full ordinary
reviews PASS. Both peer agents also independently executed the exact integer certificate. This is eighteenth-round work.
It does not modify the sealed sixteenth round or the seventeenth-round DP proof.

The object here is the actual endpoint radical, not an abstract allocation
model. Let e,f >= 2 be integers and put

    c = 2^e 3^f,  M = 2^e,  N = 3^f,
    A = M/2,      B = N/3,  Q = rad(c-1).

Assume the full two-source hypotheses

    max(M,N) < 2 min(M,N)-1,       AB > Q.                 (LP0)

Thus (1,c-1,c) is primitive, its exact two source prime powers are M and N,
and its positive scalar defect is D = log(AB/Q). The already proved FCRT
no-proper-face theorem and exact optimization, recalled with full proof in
`../seventeenth_round/paper/actual_divisor_partition.tex`, give

    B_FCRT = B_SCRT = B_PBT = D + Gamma,
    Gamma = min_{H | Q} dist(log H, [log(Q/B),log A]).      (LP1)

All divisors here are divisors of the complete squarefree integer Q. Selecting
one of its prime factors assigns the full corresponding prime power on the
original endpoint. In particular neither a missed cofactor nor its radical
is discarded from the optimization.

## LP1. Exact optimum on a structural class of actual radicals

**Theorem.** Under (LP0), suppose an actual prime q dividing c-1 satisfies
q > max(A,B). Set R = Q/q. Then

    Gamma = log(q/max(A,B)) > 0,
    D + Gamma = log(min(A,B)/R).                          (LP2)

These formulas hold for every member of this class, without requiring that
R be prime, prescribing the other prime depths, or factoring c-1 as a square.

**Proof.** Since AB > qR and q > max(A,B),

    R < min(A,B),       R < Q/B,       A < q.

Every divisor H of the squarefree Q either omits q, in which case H divides
R and H <= R, or contains q, in which case H >= q. Both extremal choices
H=R and H=q are actual divisors. The central interval is nonempty because
AB>Q, and all its points lie strictly between R and q. Therefore its nearest
divisor below is R and its nearest divisor above is q. The two logarithmic
distances are

    log((Q/B)/R) = log(q/B),       log(q/A).

Their minimum is the first formula. Add log(AB/(qR)) to obtain the second.
This proves the exact optimization using all actual divisors, rather than
a lower bound obtained from one selected allocation. In particular such a
large prime is unique, since two would make Q > max(A,B)^2 >= AB. QED.

## LP2. A completely certified non-DP example

Take

    e = 64, f = 41,
    q = 3981112602195296746201614890054671463.

The following are exact integer identities and inequalities:

    c = 672808029771005150108072916419239477248,
    c-1 = 13^2 q,
    M = 18446744073709551616,
    N = 36472996377170786403,
    A = 9223372036854775808,
    B = 12157665459056928801,
    2 min(M,N)-1-max(M,N) = 420491770248316828 > 0.

Both 13 and q are prime, with a complete recursive Lucas certificate
described below. Hence

    Q = 13q = 51754463828538857700620993570710729019,
    AB/Q = c/(78q) > 1,       q > B > A > 13.

Thus every premise in (LP0) holds and all proper reusable flags are absent.
The complete divisor list of Q is exactly 1,13,q,13q. LP1 proves

    D = log(c/(78q)),
    Gamma = log(q/3^40),
    B_FCRT = log(2^63/13).                               (LP3)

Moreover the exact integer inequality

    q (78q)^52 > 3^40 c^52                               (LP4)

proves Gamma > 52D. To indicate size only, D is approximately 0.77319,
Gamma approximately 40.33013, and their sum approximately 41.10332.
These decimal values are not used as evidence for any strict comparison.
Since c/(78q)=(169q+1)/(78q)<7/3<exp(1), also 0<D<1.

This is not a member of DP's square family: f=41 is odd, so c is not a
square. Its large gap comes from the actual prime q and cannot be inferred
by merely assigning hypothetical prime weights to two budgets.

## LP3. What the counterexample and its conditional continuation say

The natural scalar-control strengthening

    for every actual endpoint satisfying (LP0), Gamma <= D            (LP5)

is false, even after adding 0<D<1. The weaker assertion Gamma=0 for all
such endpoints is false as well. The counterexample has no free omitted
flag, missing large cofactor, or unverified prime in these conclusions.

This is a finite counterexample to the displayed assertions. It does not
disprove a bound Gamma <= epsilon log(rad(c(c-1))) + C_epsilon with an
unspecified constant, the parent FCRT uniform gate, or ABC itself.

There is a useful precise conditional distinction. Fix a prime p>=7.
**If** there are infinitely many balanced endpoints of the form

    2^e 3^f - 1 = p^2 q,  q prime,

then their c tend to infinity and eventually LP0 and the large-prime
condition hold. Indeed D tends to log(p/6)>0, the balance condition makes
each of A,B comparable to sqrt(c), and q=(c-1)/p^2 is much larger than
both. LP1 would give

    D = log(p/6)+o(1),
    B_FCRT = (1/2)log(c)+O_p(1),
    log(rad(c(c-1))) = log(c)+O_p(1).                    (LP6)

Consequently that particular FCRT/SCRT optimal budget would fail its
epsilon-log-radical upper gate for every fixed epsilon<1/2, while the
scalar ABC excess on this family is bounded and in fact satisfies
log(c)-(1+epsilon)log(rad(c(c-1))) -> -infinity for each epsilon>0.

**No infinitude assertion about these prime values is proved or used.**
The single certified endpoint establishes LP2 and the failure of LP5;
the conditional implication LP6 only isolates an arithmetic input that
would separate the certificate gate from scalar ABC. It is not a claim
that the parent route has been disproved. The earlier equivalence of a
different canonical ABC gate must not be transferred to this specific
FCRT optimization without proving its reverse implication.

## LP4. Exact certificate and proof of its primality criterion

The standard-library-only program `replay_large_prime_partition.py`
reads `verification/large_prime_lucas_certificate.json`. It checks 25
recursive prime nodes and 70 modular/gcd witnesses, starting with 2.
For every other node p it checks a complete factorization of p-1 into
already proved smaller primes. For each prime r dividing p-1 it checks
a witness a_r with

    a_r^(p-1) = 1 mod p,
    gcd(a_r^((p-1)/r)-1,p) = 1.                          (LP7)

For completeness, these conditions prove primality. If ell is any prime
divisor of p, the order of a_r modulo ell divides p-1, but does not divide
(p-1)/r. Its r-adic valuation is therefore the entire r-adic valuation of
p-1. This order also divides ell-1. Doing this separately for every r
implies p-1 divides ell-1, so ell>=p. As ell divides p, p=ell is prime.
Different r may use different witnesses; no common primitive root is
assumed. The induction starts with the elementary prime 2.

The top p-minus-one decomposition is

    q-1 = 2 * 61 * 563 * 921889 * 2532974063 * 24821433536218331.

The six corresponding witnesses are respectively 5,2,2,2,2,2. The data
contains the full recursive factorizations and witnesses for every factor,
as well as the node proving 13. Thus generation with a computer algebra
factorizer does not leave its primality tests or factorization claims as
trusted mathematical inputs.

The verifier then checks the complete endpoint factorization, exact balance,
positive defect, all four actual divisors, the rational identity
exp(D) exp(Gamma)=exp(B_FCRT), and LP4 by integer arithmetic. Default mode
writes a canonical result; `--check` recomputes and compares bytes without
modifying the certificate. Both modes have actually returned PASS.

Canonical result SHA256:
`3b4de60c0f5fb1fcba68b7def3b655db4b406047de5ea764f7b29b66f729fb51`.

This finite certificate proves the primality and the specific arithmetic
checks used in LP2. It does not certify prime-value infinitude, asymptotic
ABC failure, or a Lean theorem. The formulas for the entire structural
class and the conditional implication are ordinary proofs above.
