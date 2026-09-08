# CG1–CG6: independent ordinary and exact replay review

Status: **PASS after the correction at 3**, 2026-09-07. Full CG1–CG6 and the entire verifier were actually read; the final replacement CG6 was reread after identifying the original missing premise.

Final ordinary source: `../../2026_09_07_critical_bottleneck/eighteenth_round/next_coefficient_packet_lattice.md` (repository checkpoint path), SHA256 `216e6695ea1cf0bf43dd6441fb8746841c604b670c5bb7cf362c7238ca08eb64`.
Verifier SHA256: `312f1729e8d3c0d9203f1f4a6476c83139ff427d0d95376a7e1be03cab692cbb`.
An independent actual `python .../next_replay_coefficient_packets.py --check` returned PASS, canonical SHA256 `646285f84df9e53c2f547d5f4b208178525ef9c314ab267e834aee0afb0cbaa0`. It checks three indices and six actual powers; it does not certify the asymptotic assertions or factor the entire owner value.

## Full ordinary checks

The setup retains prime n>324, B=n^4, and the complete actual root block. The positivity, integer primitivity and boundary-prime norm units follow from the actual powers. The characteristic-p reduced-algebra argument for p different from 3 and the norm-unit argument at 3 are separate and valid.

CG1 has P_n'(0)=n in both n modulo 6 classes. Consequently T_n has linear coefficient 3n, its content divides 3n, and the nonzero Frobenius polynomial modulo n excludes n from the content. Content is exactly 3; degree 3n−1 and the coefficient one-norm bound are correct. CG2's owner B has exact depths 1 at 3 and 5 at n, and no hit at 5. The CRT owner k_1 has exact depth 4 at 5, no hit at n, and lies in the actual block; n^3>3125 is sufficient for its size bound. These selected primes are not claimed to satisfy the far-prime cutoff.

CG3's full owner-value packet omits 3, and adding 5^4 at the other owner preserves disjoint labels. The evaluation map is onto by constant-polynomial CRT, so the lattice index is exactly its full modulus product. The primitive vector F_n lies in the lattice and does not vanish at B. The signed adjustment J(T_B)+2 log 3+log 5 is correct. CG4 disproves a bound C_0 H^C with fixed constants as n varies; it does not disprove a dimension-dependent, basis-height, evaluation-height or coprime-certificate bound.

CG5 uses the integer Sylvester adjugate identity, which needs neither a monic polynomial nor invertible leading coefficients at packet primes. Evaluation proves divisibility by each entire assigned prime power, and distinct prime labels permit their product. The resultant is nonzero under the explicit rational coprimality premise. Hadamard's bound has exponents deg G and deg F in the stated order.

## Original defect and exact resolution

The old CG6 called every full T-packet a packet for F_n=T_n/3. The one-label packet (3, B, 1) disproves that claim: F_n(B) is a 3-adic unit, hence Res(F_n,X−B) is not divisible by 3. This was reported before approval.

Final CG6 first restricts the unadjusted assertion to primes different from 3. For a general owner k_3, the linear term gives e_3=1+v_3(k_3), with every higher term of valuation at least 2+2v_3(k_3). Reducing that depth by one (and omitting a zero depth) gives M_T=3M_F. Thus the complete resultant budget has the explicit extra log 3. This handles owners divisible by 3 as well as B.

The signed identities are also exact: if e_3=1, J_T=J_F−2 log 3 because the radical loses 3; if e_3≥2, J_T=J_F+log 3 because the support is unchanged. CG15–CG16 retain −3 log rad(M), including all negative depth-one/two contributions. The automatic product of owner factors remains coprime to F_n and has resultant product F_n(k), so it merely recovers the owner-height budget. It supplies no shorter coprime polynomial or global tail compensation.

No actual all-root membership, small far-label count, infinite-tail saving, dependent-root complement, or complete ABC claim is approved here. No Lean compilation was performed or asserted by this review.
