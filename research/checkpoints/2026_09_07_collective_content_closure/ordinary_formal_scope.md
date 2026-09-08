# Seventeenth continuation: ordinary proof before formalization

The global ABC conjecture is still unproved and undisproved. The source
arguments below were completed and independently reviewed before the new
Lean files in this checkpoint were started. This file describes the intended
formal statements, not a claim that unfinished code has passed.

## Actual complement cancellation

Source: critical_bottleneck/seventeenth_round/
complement_determinant_cancellation.md, SHA-256
`2cd1583877c359c110c2c4baec3fd62f421ac97b552789cf70840197e397b54e`.

Use the existing integer-pair Eisenstein multiplication, norm and rotation.
Define the content as the positive integer gcd of both coordinates and
the primitive reduction by integer division by that gcd. For a nonzero
pair, content is positive, division is exact, and the reduced pair is
primitive. Norm is positive away from zero, so a product of two nonzero
pairs is nonzero by the already proved multiplicativity of norm.

Let W=(a,b) have gcd(a,b)=1 and let V be nonzero. Put c=cont(VW),
d=cont(V), U=prim(VW), V0=prim(V). Multiplication has determinant N(V).
Its determinant on W and the three units 1,zeta,zeta^2 gives the exact
cleared equations

    cd*x=-b*N(V), cd*D=a*N(V), cd*y=(a+b)*N(V).

Bézout supplies integers u,v with ua+vb=1. Consequently
N(V)=cd*(u*D-v*x), so cd divides N(V). Its quotient r is a positive
integer. Cancelling cd gives (x,D,y)=r*(-b,a,a+b). The exact gcd of
these three integers is r, because gcd(a,b,a+b)=1. Division by r
therefore gives the original primitive boundary, up to its displayed
sign and permutation. Its absolute product is exactly |ab(a+b)|.
Any function of that natural-number product, including its radical or
signed valuation sum, is unchanged by substitution. This is the complete
integer map, not a theorem that assumes its own cleared equalities.

## Squarefree residue in every power extraction

Source: critical_bottleneck/seventeenth_round/collective_primitive_profile.md,
SHA-256 `6a98c73bf65c0b2097b2a55fbe6791c460b2e92aeae76aaccb40f85dc6edacac`.

For positive natural numbers R,D,V,Q and g>=2, assume R is squarefree,
gcd(R,D)=1 and R*D=V*Q^g. A prime of R cannot divide Q: its square
would divide R*D, whereas its depth in that product is exactly one.
Thus gcd(R,Q)=1, R divides V and Q^g divides D. These are actual
natural-number divisibilities; no coprimality of V and Q is required.
If Q>1, a prime p dividing Q gives g<=v_p(D). Any explicit depth ceiling
for D bounds g, and monotonicity of the logarithm bounds log(V)/g
from below using log(R). The actual aggregate's prime profile, the
interval residue counts, the asymptotic prime estimates and its large-B
uniform quantifiers remain separate ordinary theorems unless explicitly
implemented and verified here.

## Other ordinary results retained separately

The collective-content asymptotics, the infinite actual divisor-partition
family, and the explicit p-adic Jacobian closure have their own ordinary
proofs and reviews. Exact finite replay is evidence about its finite inputs.
It is not a Lean proof of asymptotics, density, local logarithms, Jacobians,
quadratic Chabauty, or a complete rational-point classification.

The input-norm cancellation must not be identified with a gain in the
original boundary radical. The cross-prime signed tail, exceptional roots,
independent-domain complement and coverage of arbitrary ABC triples are
still open. No result in this checkpoint may be presented as solving ABC.
