# Z2.1--Z2.4: full independent ordinary and finite review

Reviewed source: `research/checkpoints/2026_09_07_independent_route/nineteenth_round/next_zeta_squared_quotient.md`.

SHA256: `8175504e0746e69219401f123b81b822ba6ba0f7a036afc638425ec797e088d5`.

Verdict: full ordinary proof PASS. I read all four sections and the final scope. I also checked the defining A/B and conic conventions against the actual earlier HG and CB source. This is the distinct squared-unit branch, not an identification with the previously solved unit-zeta quotient.

## Mathematical checks

Multiplication by zeta squared really sends the cubic coordinates to (-A0-B0,A0). Therefore v squared is -B0/A0 and the first quotient is exactly the stated squarefree quintic. The irrational cubic branch sources, all three rational branch points and the projective infinity point are retained. The actual positive lift needs 1<v<2/sqrt(3) and a rational square 4-3v squared; its two signs both give finite t>1 through the original conic inverse. At the branch inputs, the two values t=0,-2 agree directly with the old conic formulas and are outside the positive domain.

The signed lift rho has order three, whereas omitting its y sign would give order six. Its homogeneous transformation negates both A0 and B0; thus v is fixed. The cubic equation bounds the extension degree by three, and the three distinct automorphisms give the reverse bound. The fixed sources s squared+s+1=0 each have two nonzero ordinates. Their four v values are precisely the simple zeros of v fourth-v squared+1, with inertia order three. The v=0 and v=infinity fibers are each unramified with three points. The cubic discriminant agrees with this full projective argument; it is not used to overlook a leading-coefficient exception.

The two branch divisor differences have exact order two and their sum is nonzero. The stated pole basis at infinity, with pole orders two and five, proves the needed dimension statement without an unproved rank or Jacobian algorithm. The full three-adic homogeneous residue S=T gives valuation two and normalized nonsquare -1 mod3; the remaining necessary parity condition retains every branch exception. As the text says, this exclusion was already forced for actual unramified inputs and is not a new global obstruction.

The finite counts give the displayed Frobenius polynomials and orders 12 and 52. At good five, an elliptic factorization over Q would force integral traces with sum three and product -6, which has nonsquare discriminant 33. This proves Q-simplicity, not absolute simplicity. Good-prime torsion injection separately kills the five- and seven-primary parts and bounds every other primary part by both orders. Together with the four constructed two-torsion classes, the exact rational torsion is (Z/2Z)^2.

The norm/pullback identity for the degree-three quotient to P1 gives 1+rho+rho squared=0 on the Jacobian, including ramified multiplicities. Hence the rational Mordell--Weil vector space is a vector space over Q(sqrt(-3)), and its rank is even. This does not decide whether the rank is zero.

Conditional on rank zero, the Abel map embeds rational curve points into the four-element torsion group. The fourth possible class cannot occur: the degree-two divisor P0+Pm is not canonical, so Riemann--Roch gives a unique effective representative, which cannot equal R+Pinf. Thus the stated three-point classification follows under precisely the displayed rank-zero assumption. There is no suppressed upper bound or use of the old bielliptic splitting.

## Actual finite replay

I read the entire `next_replay_zeta_squared_reductions.py` source, recomputed its hash, and independently executed its read-only `--check`. It returned exit zero and:

`PASS: F5/F25/F7/F49 complete fibers; SHA256 66ce937b9a33a5300f08b128f630b3b47ddaeee80b28b7f5a77427ed30c06b6c`.

The program enumerates the full field extensions using verified nonsquare parameters 2 and 3, every abscissa and every square multiplicity, all prime-field ordinates, and the unique point at infinity. The output comparison is exact canonical bytes, not a regenerated result silently overwriting the certificate. I did not implement a second field model or run any rational-point or rank computation.

| Evidence | SHA256 |
| --- | --- |
| Replay source | cf0563d5d31c67ce2c8d90fec0045eb38ca0050194b9c78f4f9c076a5ff9e661 |
| Canonical finite certificate | 66ce937b9a33a5300f08b128f630b3b47ddaeee80b28b7f5a77427ed30c06b6c |

The remaining mathematical target is a certified rank upper bound or another complete rational-point argument for this fixed quotient. Even such a result would not provide the moving-family uniformity, other exponent/residual/ramification domains or the ABC conclusion.
