import IUTThreeClosures.FreyPellChebyshevIndexTwentyNineStollGammaCertificate

/-!
# Prime thirty-one: kernel-checked algebraic core

The external p31 certificates use three isomorphic hyperelliptic models.  This
file checks the copied Chebyshev polynomial, the integral scaling to the monic
dyadic model, the endpoint scale, and the finite dimension/count ledgers.  It
does not assert the Stoll recursion, Coleman integration, a Selmer theorem, or
a rational-point classification.
-/

namespace IUTThreeClosures

private theorem pellChebyshev_four_indexThirtyOne (x : ℤ) :
    pellChebyshev 4 x = 8 * x ^ 4 - 8 * x ^ 2 + 1 := by
  rw [show 4 = 2 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_three]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp [pellChebyshev_zero, pellChebyshev_one]
  ring

private theorem pellChebyshev_twentyEight_indexThirtyOne (x : ℤ) :
    pellChebyshev 28 x =
      134217728 * x ^ 28 - 939524096 * x ^ 26 +
        2936012800 * x ^ 24 - 5402263552 * x ^ 22 +
          6499598336 * x ^ 20 - 5369233408 * x ^ 18 +
            3111714816 * x ^ 16 - 1270087680 * x ^ 14 +
              361181184 * x ^ 12 - 69701632 * x ^ 10 +
                8712704 * x ^ 8 - 652288 * x ^ 6 +
                  25480 * x ^ 4 - 392 * x ^ 2 + 1 := by
  rw [show 28 = 4 * 7 by norm_num, pellChebyshev_mul]
  rw [pellChebyshev_four_indexThirtyOne, pellChebyshev_seven]
  ring

private theorem pellChebyshev_thirty_indexThirtyOne (x : ℤ) :
    pellChebyshev 30 x =
      536870912 * x ^ 30 - 4026531840 * x ^ 28 +
        13589544960 * x ^ 26 - 27262976000 * x ^ 24 +
          36175872000 * x ^ 22 - 33426505728 * x ^ 20 +
            22052208640 * x ^ 18 - 10478223360 * x ^ 16 +
              3572121600 * x ^ 14 - 859955200 * x ^ 12 +
                141892608 * x ^ 10 - 15275520 * x ^ 8 +
                  990080 * x ^ 6 - 33600 * x ^ 4 + 450 * x ^ 2 - 1 := by
  rw [show 30 = 28 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_twentyNine,
    pellChebyshev_twentyEight_indexThirtyOne]
  ring

/-- The first-kind thirty-first Chebyshev polynomial in the repository's
Pell normalization. -/
theorem pellChebyshev_thirtyOne (x : ℤ) :
    pellChebyshev 31 x =
      1073741824 * x ^ 31 - 8321499136 * x ^ 29 +
        29125246976 * x ^ 27 - 60850962432 * x ^ 25 +
          84515225600 * x ^ 23 - 82239815680 * x ^ 21 +
            57567870976 * x ^ 19 - 29297934336 * x ^ 17 +
              10827497472 * x ^ 15 - 2870927360 * x ^ 13 +
                533172224 * x ^ 11 - 66646528 * x ^ 9 +
                  5261568 * x ^ 7 - 236096 * x ^ 5 +
                    4960 * x ^ 3 - 31 * x := by
  rw [show 31 = 29 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_thirty_indexThirtyOne, pellChebyshev_twentyNine]
  ring

/-- Exact coordinate bridge from the original model to the monic dyadic
model `Y^2 = 2^30 * (4*T_31(X/4)+5)`, evaluated at `X=4*x`. -/
theorem pellChebyshevThirtyOne_stollColemanMonicModelBridge (x : ℤ) :
    let fm :=
      (4 * x) ^ 31 - 124 * (4 * x) ^ 29 +
        6944 * (4 * x) ^ 27 - 232128 * (4 * x) ^ 25 +
          5158400 * (4 * x) ^ 23 - 80312320 * (4 * x) ^ 21 +
            899497984 * (4 * x) ^ 19 - 7324483584 * (4 * x) ^ 17 +
              43309989888 * (4 * x) ^ 15 -
                183739351040 * (4 * x) ^ 13 +
                  545968357376 * (4 * x) ^ 11 -
                    1091936714752 * (4 * x) ^ 9 +
                      1379288481792 * (4 * x) ^ 7 -
                        990258397184 * (4 * x) ^ 5 +
                          332859965440 * (4 * x) ^ 3 -
                            33285996544 * (4 * x) + 5368709120
    fm = 2 ^ 30 * (4 * pellChebyshev 31 x + 5) := by
  dsimp
  rw [pellChebyshev_thirtyOne]
  ring

/-- Under `y_c=y/2^16` and `Y=2^31*y_c`, the two endpoint ordinates on the
monic model are `2^15` and `3*2^15`. -/
theorem pellChebyshevThirtyOne_stollColemanEndpointScaleLedger :
    (2 : ℤ) ^ 31 = 2 ^ 15 * 2 ^ 16 ∧
      3 * (2 : ℤ) ^ 31 = (3 * 2 ^ 15) * 2 ^ 16 := by
  norm_num

/-- Exact finite counts in the frozen p31 BDF principal-factor-base packet. -/
theorem pellChebyshevThirtyOne_classNumberOneScalarLedger :
    4667696 + 600 + 60 = 4668356 ∧ 30 + 31 = 61 := by
  norm_num

/-- Scalar consequences of the frozen norm/3-adic/dyadic p31 certificate. -/
theorem pellChebyshevThirtyOne_globalDyadicDimensionLedger :
    20 - 5 = 15 ∧
      2 ^ 15 = 32768 ∧
      15 - 15 = 0 ∧
      (2 : ℕ) < 15 := by
  norm_num

#print axioms pellChebyshev_thirtyOne
#print axioms pellChebyshevThirtyOne_stollColemanMonicModelBridge
#print axioms pellChebyshevThirtyOne_stollColemanEndpointScaleLedger
#print axioms pellChebyshevThirtyOne_classNumberOneScalarLedger
#print axioms pellChebyshevThirtyOne_globalDyadicDimensionLedger

end IUTThreeClosures
