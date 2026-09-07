# A height budget from the actual boundary-support criterion

Status: ordinary arithmetic proof passed full independent review by
adversarial_audit and critical_bottleneck. The separate complete two-orbit
twist identification has also passed full ordinary review and both exact
full-Sturm replays. TS supplies the stronger root bound p<Q; this note
retains the earlier elementary argument and its explicit hypotheses.

Put F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4. Let a,b be positive
coprime integers and suppose F(a,b)=Q^p with Q>1 and prime p>7.
Write H=max(a,b) and T=log(13)+4 log H. Assume the already stated
boundary-support conclusions for this actual norm: every prime q|Q
splits in Q(sqrt(-3)), neither seven nor thirteen divides Q, and for
q different from p its boundary trace t_q satisfies

    t_q^2<=4q,    p | (q+1)^2-t_q^2.

These are the exact conclusions of BC, allowing all its quadratic
twists unramified outside six. They are enough for the following
universal consequences; no effective Chebotarev estimate is required.

## HB1. A strict elementary prime cutoff

For every prime q|Q one has p<2q. Indeed, q>3 and q is split, so
q>=7. If q=p the inequality is immediate. Otherwise primality of p
and the displayed product divisibility imply that p divides one of
q+1-t_q and q+1+t_q. Both integers are strictly positive and less
than 2q. To see this without approximating square roots, q>=7 gives

    (q-1)^2-4q=q(q-6)+1>0.

The Hasse inequality therefore gives |t_q|<q-1. A positive multiple
of p in (0,2q) forces p<2q. Since Q has a prime divisor q<=Q,
one obtains p<2Q. The split support and the exclusions at seven and
thirteen also imply Q>=19. The latter assertion uses the exact small
split primes, not only the Hasse cutoff.

## HB2. A uniform actual height and exponent bound

Each of the five positive monomials of F is bounded by its coefficient
times H^4, hence

    (p/2)^p < Q^p=F(a,b)<=13H^4.                         (HB2)

Equivalently,

    p log(p/2)<T,    log H>[p log(p/2)-log13]/4.          (HB3)

For T>=exp(2), this also gives the explicit bound

    p < 2T/log T.                                        (HB4)

Proof of the last implication. Suppose p>=2T/log T. The function
x log(x/2) is increasing for x>=2. The proposed lower bound on p
is at least exp(2)>2 when T>=exp(2). With z=log T>=2, the elementary
inequality 2 log z<z holds: z-2 log z is positive at z=2 and has
nonnegative derivative thereafter. Thus

    (2T/log T) log(T/log T)
       =2T[1-log log T/log T]>T,

contradicting HB3. No bound is claimed from this rearrangement when
T<exp(2); HB2 and HB3 remain valid there. Consequently along any
hypothetical family of actual pure prime powers with H tending to
infinity,

    p=O(log H/log log H),

with an effective absolute constant. Conversely, if p tends to infinity,
the actual seed height grows at least at rate
log H >= (1/4+o(1))p log p. These are necessary conditions, not an
upper bound on H or an exclusion of all pure powers.

## Relation to the open ABC gates

BT1--BT4 identify every surviving pure modular orbit as a quadratic
twist of the boundary orbit, so HB1--HB4 apply to every
actual F=Q^p with prime p>7. The new prime-support theorem
gives a substantially smaller exponent budget than the general
effective affine-slice estimate. It does not address arbitrary
moving residual V>1, replace the full signed-tail estimate, or
bound individual rational points uniformly on the moving covers.
The existence of arbitrarily large permitted primes remains compatible
with this necessary height lower bound.
