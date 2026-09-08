# DP1--DP4. Scalar-optimal actual radical partitions without reusable flags

Status: complete ordinary proof; critical_bottleneck and root full independent
ordinary reviews PASS. This is a
new seventeenth-round arithmetic subclass. It does not modify FCRT-1, bound
the scalar ABC defect from above, or construct an ABC counterexample.

The inherited FCRT source is the primitive endpoint (1,c-1,c), where
c=2^e 3^f and e,f>=2. Write

    M=2^e, N=3^f, A=M/2, B=N/3, Q=rad(c-1).

Assume max(M,N)<2 min(M,N)-1 and AB>Q. The previously proved no-proper-face
theorem and exact optimization then give

    B_FCRT = B_SCRT = B_PBT
           = D + min_{H|Q} dist(log H, [log(Q/B),log A]),
    D = log(AB/Q) = log(c/rad(c(c-1))) > 0.            (DP1)

Here every divisor in the minimum is an actual divisor of the squarefree
integer Q; the prime factors of a packet are taken with their full powers
on the original endpoint. This note constructs infinite actual inputs for
which the minimum distance is zero despite the absence of every proper flag.

## DP1. A two-factor sufficient condition with all radical factors retained

Let u,v>=1 be integers, x=2^u 3^v, e=2u and f=2v. Suppose x>6 and

    3/4 <= rho := 2^u/3^v <= 4/3,
    7^k | x-1,  5^k | x+1,   k>=2.                 (DP2)

Then all inherited hypotheses of (DP1) hold, every proper flag is absent,
and the actual divisor

    H=rad(x-1),   J=rad(x+1),   Q=HJ

satisfies H<=A and J<=B. Consequently

    B_FCRT = D,
    D > (k-1) log 35 - log 6.                        (DP3)

Proof. The numbers x-1,x+1 are odd with gcd one, so radical
multiplicativity gives exactly Q=HJ, not merely divisibility. If p^k|m,
then rad(m)<=m/p^(k-1), irrespective of additional prime powers. Therefore

    H <= (x-1)/7^(k-1) < x/7,
    J <= (x+1)/5^(k-1) <= (x+1)/5 <= x/4.

The last inequality uses x>=4. On the other hand

    A=x rho/2 >=3x/8,   B=x/(3 rho)>=x/4.

Thus H<=A and J<=B, so Q/B<=H<=A. Since these are radicals of two
coprime complete integer factors, their prime sets are disjoint and cover
every sink. Taking all primes of x-1 for the first residual source and all
primes of x+1 for the second is a legitimate whole-prime-power owner
partition. It uses no putative proper subface and no duplicated credit.

For the no-flag condition, M=x rho and N=x/rho. Their ratio is at most
16/9, and min(M,N)>=3x/4. Hence

    2 min(M,N)-max(M,N) >= (2/9)min(M,N) >= x/6 >1.

Both M and N are their exact full prime powers in c, so the inherited
no-proper-face theorem applies to both sources. Also

    Q <= (x^2-1)/35^(k-1) < x^2/6 = AB.

This proves the positive-defect hypothesis. The exhibited H makes the
distance in (DP1) zero. Finally

    AB/Q >= 35^(k-1) x^2 / (6(x^2-1)) > 35^(k-1)/6,

which proves the strict lower bound for D. Nothing in this proof requires
factorization of the unknown remaining parts of x-1 or x+1. QED.

## DP2. Simultaneous residue construction for every k

For each integer k>=2 put L=12*35^(k-1). For arbitrary integers r>=0,s>=1 set

    u=L r+L/2=6*35^(k-1)(2r+1),   v=L s.           (DP4)

Then x=2^u3^v satisfies both congruences in (DP2).

Proof. The elementary binomial induction

    z=1 mod p  ==>  z^(p^(k-1))=1 mod p^k

gives 2^(3*7^(k-1))=1 mod 7^k, since 2^3=1 mod 7.
Since -4=1 mod 5 and 5^(k-1) is odd, the same induction gives
2^(2*5^(k-1))=-1 mod 5^k. The exponent u is a multiple of
3*7^(k-1), while

    u/(2*5^(k-1))=3*7^(k-1)(2r+1)

is odd. Thus 2^u is 1 at 7^k and -1 at 5^k.
Applying the induction to 3^6=1 mod 7 and 3^4=1 mod 5, and using
6*7^(k-1)|v and 4*5^(k-1)|v, shows 3^v=1 at both moduli.
Multiplication proves the assertions. QED.

## DP3. Infinitely many balanced actual inputs; unbounded absolute defect

For every fixed k>=2 there are infinitely many positive pairs r,s in
(DP4) for which rho tends to one and x tends to infinity. They therefore
satisfy (DP2) eventually. Across these families, D is unbounded while the
actual radical partition penalty is identically zero.

Proof. Let alpha=log 3/log 2, irrational by unique factorization.
Elementary pigeonhole approximation supplies positive integers q_j and
integers a_j such that beta_j=|q_j alpha-a_j| tends to zero and beta_j>0.
Choose a positive integer h_j nearest to 1/(2 beta_j). Then
h_j beta_j tends to 1/2. For s_j=h_j q_j, the fractional part of
s_j alpha tends to 1/2, whether q_j alpha-a_j is positive or negative.
Also s_j tends to infinity. With r_j=floor(s_j alpha), eventually positive,

    r_j+1/2-alpha s_j ->0,
    log rho_j=L log 2 (r_j+1/2-alpha s_j) ->0.

This proves balance and unbounded x for each fixed L. After discarding
finitely many terms, DP1 applies. For any requested bound T, choose k with
(k-1)log35-log6>T and then select arbitrarily large members of that fixed-k
family. Their D exceeds T and their partition penalty is zero. A diagonal
choice makes both c and D increase without bound. QED.

This refutes the precise additional claim that sufficiently large absolute
defect and absence of proper flags force a positive radical partition gap.
It does not refute the inherited FCRT-1 gate. In particular, no bound below
for D/log(rad(c(c-1))) by a fixed positive constant is proved, and no upper
bound for that ratio or for D itself is supplied. The infinitely many
scalar-optimal endpoints are an arithmetic subclass, not all endpoints.

## DP4. What has changed in the surviving partition problem

The earlier exact dense-divisor bound uses the maximum gap anywhere in the
entire divisor set of Q. DP1 instead supplies one actual divisor in the
required central interval by using the arithmetic factorization of c-1.
It needs no upper bound for that global maximum gap. The credit comes from
separate repeated prime factors of x-1 and x+1, and all unprescribed prime
factors remain in their correct packets.

The older 25-digit example showed one balanced no-flag endpoint attaining
the scalar optimum. DP1--DP3 prove an infinite family and allow arbitrarily
large absolute scalar defect. They do not improve the universal FCRT gate
outside this factored, congruence-controlled subclass. The remaining global
question still includes actual central divisor gaps when no suitable
factorization/valuation witness is available, together with the scalar
defect bound itself.

Inherited ordinary input: the no-face theorem and exact optimization in
`research/checkpoints/2026_09_05_chatgpt/research/ABC_FCRT_UNIT_GAP_OBSTRUCTION_2026_09_05.md`,
Sections 4--6. Those ordinary results are used with their full hypotheses;
their original partial Lean draft is not relabelled as a compiled theorem.

## Exact finite supplement

`replay_divisor_partition.py` was actually run in generation and read-only
`--check` modes. Its canonical certificate SHA256 is
`6b7a363b91b7fad5c570696ed8b5fcd50be50d73607a7d0c0d829bc1b75c551d`.
It checks three actual balanced inputs with k=2, including exact integer
balance, both prescribed prime-power divisibilities, coprimality of the
two full factors, strict no-face balance, and the two sufficient radical
upper bounds against A and B. It also checks 66 residue-only instances
across k=2,...,12; those are not claimed to satisfy balance.

The verification uses integers and modular exponentiation only. It does
not factor x-1 or x+1, compute their radicals or any logarithms, or prove
the infinite-family statement. The inequalities certified are precisely
the sufficient witnesses used in the ordinary proof above, leaving all
unprescribed prime factors inside the complete packets.
