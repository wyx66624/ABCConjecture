# Mathematical and computational audit

## Scope

The audit covers only the exact propositions in
`ABC_AFFINE_SIGNED_RAY_CANONICAL_CAPS_2026_09_01.md`.  It does not claim an
abc proof, an exceptional-point lower bound, or control of the remaining
non-arm inverse-period catalogue.

## Proof audit

The central inequality uses all of its premises:

1. residue-class capacity gives `a*T <= H`;
2. geometric span gives `H*L <= N`;
3. the strict large-label premise and exact factorization give
   `N^2 < D = T*capture`;
4. multiplying the first two inequalities by `N` and cancelling positive
   `T` gives `a*N*L < capture`.

The cancellation is valid because every reduced direction period is
positive.  The strict sign cannot be weakened: the recorded tuple
`(card,H,T,capture,D,N,L)=(2,1,1,1,1,1,1)` satisfies the closed version and
violates the conclusion.

For a primitive canonical arm direction, the exact capture identities use
both facts that `C-B=1` and that actual arm divisors are coprime to the seed
coefficients.  The computation tests the three identities separately and
records a counterexample on every arm when either primitivity or the
relevant coprimality is deleted.

The global conversion is termwise:
`n^3 <= 1 + 7*(n-1)^3`.  The polynomial difference is
`3*a*(a-1)*(2*a+1)` for `a=n-1>=1`; occupancy two proves optimality of seven.
The owner-catalogue moment bound is an upper bound: assigning each distinct
label to one catalogue cannot duplicate it, and enlarging each assigned
subset to the complete downward catalogue uses the already proved exact
totient mass identity.  This argument requires the report's explicit
definition of the label set as a union of selected powerful-kernel downward
catalogues.

## Boundary audit

The following exact statements are refuted and only these statements are
retired:

- replacing `N^2 < D` by `N^2 <= D` in the strict capture squeeze;
- replacing `a^3*T^2 < K*N` by `a^3*T^3 < K*N` with the same right side;
- adding a second period factor to the normalized square cap;
- asserting exact arm capture for a scaled, nonprimitive direction;
- deleting the relevant coefficient-coprimality premise on any arm;
- deleting membership in the selected kernel-catalogue union from the owner
  bounds (the `B=1, C=2, M=10` all-divisor weight is `972496`, while its 12
  distinct kernel owners have total mass only `1072`);
- replacing seven by six in the singleton-plus-shifted cubic bridge;
- replacing `(B+1)(C+1)` by a smaller universal non-arm coefficient.

None of these witnesses refutes the signed primitive theorem with its full
premises.  No finite no-hit is used to discard the affine route.

## Replay audit

The final replay on 2 September 2026 completed with the PASS line.  Exact
integer arithmetic checked 4,226,068 abstract ledgers/directions/capture
instances before the actual-box enumeration (the occupancy bridge adds
1,001 further scalar cases).  The four actual boxes checked all 4,307 large
arm-divisor labels locally.  Their selected powerful-kernel subcatalogues
then checked the owner baseline, three owner moments, and (8.5) using exact
rational arithmetic.  A separate `B=4, C=5, M=30` replay contains a repeated
non-arm selected label and exercises the inverse-period term of (8.5).
