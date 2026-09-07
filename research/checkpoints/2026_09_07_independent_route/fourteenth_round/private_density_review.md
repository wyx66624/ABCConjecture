# Full independent ordinary review of DG1--DG4

Reviewer: independent_route. Date: 2026-09-07. Status: PASS.
Reviewed complete source:
critical_bottleneck/thirteenth_round/next_private_density_gain.md.
SHA256: 384a3251b1d9c51059f379584071576dc06f782dc0f7048b8e944324e8dba247.
This new review does not change a frozen thirteenth-round source.

The cofactor polynomial has exactly discriminant -27. At a prime
dividing m its leading coefficient vanishes and its linear coefficient
is the nonzero derivative of Q at the chosen root, so it has one root.
At a prime not dividing m the invertible affine substitution gives
the original zero or two roots. In particular the asserted no-fixed-
prime-divisor condition and the interval endpoint bound are valid
uniformly in the cofactor and its chosen root, including m=1.

I actually opened the author-hosted primary PDF
https://ford126.web.illinois.edu/sieve2023.pdf and read Theorem 4.1
on printed page 45, together with the preceding weight bound and
equation (4.5). The substitution D=z^2 gives precisely the denominator
and full pairwise remainder used here. The local densities are in
[0,1), and the sequence can be treated with multiplicities, so no
injectivity of polynomial values is required.

The fixed-modulus prime estimates imply both partial-summation
relations in DG5. The finite product weighted mean uses exactly
h0(p)/(1+h0(p))=2/p. At y=z^(1/4) its mean is below half log z
for sufficiently large z, and weighted Markov gives the claimed
J0 lower bound; a smaller constant covers bounded z. Decomposing
squarefree divisors into their m-supported and coprime parts proves
J0<=A(m)Jm without a moving singular-series asymptotic.

The full sieve remainder is at most z^4. The unrestricted cofactor
Euler product contains every prime power and has factors
1+2p/((p-2)(p-1)), giving O(log(3X)) from the fixed reciprocal-prime
sum. With X=49B^epsilon and z=B^(1/10), the complete endpoint is
O(B^(2epsilon+2/5))=O(B^(3/5)). Both that exponent and all constants
are uniform for 0<epsilon<=1/10; the fixed 49 factor is absorbed
into an absolute constant, not a quantity depending on epsilon.

The final mass comparison uses the established full-block PN mass
once. A norm prime above 12B has depth one and is unique to that root;
there is at most one such prime per root. The exceptional extreme-
prime roots pay epsilon times their number in the mass upper bound.
Consequently the limiting fraction is at least
(1-C0 epsilon^2)/(2-epsilon), and choosing C0 epsilon<=1/4 gives
the stated strict positive improvement over one half, with half the
limiting margin available for a uniform sufficiently-large-B bound.

The result is an ordinary proof using the cited finite sieve and the
previously reviewed fixed-modulus and full-block inputs. I have not
claimed a new Lean formalization or an independent finite numerical
experiment. The complement and the unbounded signed boundary-prime
tail remain unbounded by this result.
