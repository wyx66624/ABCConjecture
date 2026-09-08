# Full ordinary review of CG1--CG6

2026-09-07. I actually read the entire critical-bottleneck candidate
`eighteenth_round/next_coefficient_packet_lattice.md`. **PASS**.

Reviewed source SHA256: `e0cf109cc085e0f6708cc7b9cec0992e3d12b631df892334e8ab78a2d0cb5ddd`.

The content proof uses the actual linear coefficient 3n and the two
nonzero Frobenius polynomial branches modulo n, so division by three
really yields a primitive nonzero polynomial of degree 3n-1. The
coefficient norm bound, positive original block arms, and primitivity
over both the reduced algebra at p!=3 and the norm-unit ramified case
are correct. The full depths n^5 and 5^4 belong to different actual
owners, with the other owner's label absent. All claimed CRT and
valuation inequalities hold for n>324.

The lattice evaluation map is surjective already on constants by CRT,
giving its exact index 625 F_n(B). The lower evaluation-height bound
and coefficient-height upper bound refute only a dimension-independent
fixed-power implication from one primitive short vector. Every original
depth-one and depth-two cost is retained in the displayed ledger; its
sign is not inferred from the construction.

For CG5, the adjugate of the integral Sylvester map really gives an
integer Bezout identity with the resultant, without monicity or a
prime-to-leading-coefficient assumption. Evaluation at each assigned
owner preserves its full prime-power depth, and distinct primes combine
by divisibility. Hadamard gives the stated norm inequality. Finally the
automatic owner polynomial is coprime since every actual value F_n(k)
is strictly positive, and its exact resultant just pays the old product
of those values. The claimed limitation does not overrule a different
short coprime certificate or a signed argument.

This is a full ordinary review only. I did not execute the separate
finite CG replay, and no such execution is claimed here.
# Final CG6 correction: the removed factor at three

The corrected full CG6 was actually reread against CG1--CG2 and the
packet definition. Reviewed source SHA256:
`216e6695ea1cf0bf43dd6441fb8746841c604b670c5bb7cf362c7238ca08eb64`.
The earlier CG1--CG5 review is unchanged. Final CG6 ordinary review: PASS.

For the raw T-packet the automatic polynomial for F=T/3 needs either
three excluded or its depth adjusted. Since n>324 is prime, 3 does not
divide n. From P_n(a)=na+a^2R_n(a), at a=3k the unique lowest term has
valuation 1+v_3(k); the remaining terms have valuation at least
2+2v_3(k). Thus e_3=1+v_3(k_3) and h_3=e_3-1 are exact for every owner,
including owners divisible by three. The identities M_T=3M_F and the
two radical cases give J_T=J_F-2log(3) when e_3=1, and
J_T=J_F+log(3) when e_3>=2. CG15--CG16 consequently retain the whole
negative-credit term. If the adjusted packet is empty, its modulus is
one and the same resultant certificate remains valid. No finite
replay was rerun for this bounded correction, and the corrected result
is not described as a proof of the parent global signed inequality.
