/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellFixedTwoTransversality20260903

/-!
# Signed trace projectors for the fixed Pell packet

The ordinary proofs precede this file in
`research/ABC_PELL_SIGNED_TRACE_PROJECTOR_2026_09_03.md`.

For `(1 + sqrt 2)^n = A_n + B_n sqrt 2`, the doubled first coordinate at
an odd index satisfies

`A_(2*n) - 1 = 2*A_n^2` and `A_(2*n) + 1 = 4*B_n^2`.

Consequently squared support in either channel is equivalent to fourth-power
support in the corresponding signed trace shift, and exact coordinate depth
two transports to exact trace depth four.  This file turns the old
simultaneous-zero gate into an equivalent all-support fourth-power trace
packet.  It also isolates the exact CRT projector `E = 2*B_n^2`: its
idempotent defect is `2*(A_n*B_n)^2`, so raw precision `U^2` is sharp when
`U ≥ 3`.

No squarefull Pell term, asymptotic assertion, or abc conclusion is assumed
or proved.  The index-seven calculation refutes only the stronger claim that
every depth-two collision automatically gives trace depth five.
-/

namespace IUTThreeClosures
namespace PellSignedTraceProjector20260903

open IUTThreeClosures.PellSquareRootDescent20260831
open IUTThreeClosures.PellPolynomialAllIndexFormalization20260902
open IUTThreeClosures.PellFixedTwoTransversality20260903
open IUTThreeClosures.KFullRadicalCompression

/-! ## Addition and doubling in the square-root orbit -/

/-- Integral multiplication in `Z[sqrt 2]`, expressed on the natural Pell
coordinates. -/
theorem sqrtTwoOrbit_add (m n : ℕ) :
    sqrtTwoOrbit (m + n) =
      ((sqrtTwoOrbit m).1 * (sqrtTwoOrbit n).1 +
          2 * (sqrtTwoOrbit m).2 * (sqrtTwoOrbit n).2,
        (sqrtTwoOrbit m).1 * (sqrtTwoOrbit n).2 +
          (sqrtTwoOrbit m).2 * (sqrtTwoOrbit n).1) := by
  induction n with
  | zero => simp [sqrtTwoOrbit]
  | succ n ih =>
      rw [Nat.add_succ, sqrtTwoOrbit_succ, ih, sqrtTwoOrbit_succ]
      apply Prod.ext <;> dsimp <;> ring

/-- The doubled orbit is the quadratic Veronese image of one orbit point. -/
theorem sqrtTwoOrbit_double (n : ℕ) :
    sqrtTwoOrbit (2 * n) =
      ((sqrtTwoOrbit n).1 ^ 2 + 2 * (sqrtTwoOrbit n).2 ^ 2,
        2 * (sqrtTwoOrbit n).1 * (sqrtTwoOrbit n).2) := by
  rw [show 2 * n = n + n by omega, sqrtTwoOrbit_add]
  apply Prod.ext <;> dsimp <;> ring

/-- First coordinate of the doubled square-root orbit. -/
def pellDoubleTrace (n : ℕ) : ℕ := (sqrtTwoOrbit (2 * n)).1

/-- Second coordinate of the doubled square-root orbit. -/
def pellDoubleSine (n : ℕ) : ℕ := (sqrtTwoOrbit (2 * n)).2

theorem pellDoubleTrace_eq_quadratic (n : ℕ) :
    pellDoubleTrace n =
      (sqrtTwoOrbit n).1 ^ 2 + 2 * (sqrtTwoOrbit n).2 ^ 2 := by
  rw [pellDoubleTrace, sqrtTwoOrbit_double]

theorem pellDoubleSine_eq_two_mul (n : ℕ) :
    pellDoubleSine n =
      2 * (sqrtTwoOrbit n).1 * (sqrtTwoOrbit n).2 := by
  rw [pellDoubleSine, sqrtTwoOrbit_double]

/-! ## Signed trace identities at odd indices -/

theorem odd_pellDoubleTrace_eq_positive
    (ell m : ℕ) (hell : ell = 2 * m + 1) :
    pellDoubleTrace ell = 2 * (sqrtTwoOrbit ell).1 ^ 2 + 1 := by
  subst ell
  rw [pellDoubleTrace_eq_quadratic]
  have hnorm := sqrtTwoOrbit_norm_odd m
  nlinarith

theorem odd_pellDoubleTrace_add_one_eq_negative
    (ell m : ℕ) (hell : ell = 2 * m + 1) :
    pellDoubleTrace ell + 1 = 4 * (sqrtTwoOrbit ell).2 ^ 2 := by
  subst ell
  rw [pellDoubleTrace_eq_quadratic]
  have hnorm := sqrtTwoOrbit_norm_odd m
  nlinarith

theorem odd_pellDoubleTrace_sub_one_eq_positive
    (ell m : ℕ) (hell : ell = 2 * m + 1) :
    pellDoubleTrace ell - 1 = 2 * (sqrtTwoOrbit ell).1 ^ 2 := by
  rw [odd_pellDoubleTrace_eq_positive ell m hell]
  omega

/-! ## Exact fourth-power support dictionary -/

/-- A positive-channel support square is equivalent to fourth-power
divisibility of the positive trace shift. -/
theorem prime_fourth_dvd_positiveTrace_iff_square
    {p A Z : ℕ} (hp : p.Prime) (hpA : p ∣ A) (hoddA : Odd A)
    (hZ : Z - 1 = 2 * A ^ 2) :
    p ^ 4 ∣ Z - 1 ↔ p ^ 2 ∣ A := by
  have hpne : p ≠ 2 := by
    intro h
    subst p
    have hz : A % 2 = 0 := Nat.mod_eq_zero_of_dvd hpA
    have ho : A % 2 = 1 := Nat.odd_iff.mp hoddA
    omega
  have hpc : p.Coprime 2 :=
    (Nat.coprime_primes hp Nat.prime_two).2 hpne
  constructor
  · intro hfour
    have hfour' : p ^ 4 ∣ 2 * A ^ 2 := by simpa [hZ] using hfour
    have hfourA : p ^ 4 ∣ A ^ 2 :=
      (hpc.pow_left 4).dvd_of_dvd_mul_left hfour'
    apply (Nat.pow_dvd_pow_iff (by norm_num : (2 : ℕ) ≠ 0)).mp
    simpa only [show (p ^ 2) ^ 2 = p ^ 4 by ring] using hfourA
  · intro hsquare
    have hpow : p ^ 4 ∣ A ^ 2 := by
      have := pow_dvd_pow_of_dvd hsquare 2
      simpa only [show p ^ 4 = (p ^ 2) ^ 2 by ring] using this
    rw [hZ]
    exact dvd_mul_of_dvd_right hpow 2

/-- A negative-channel support square is equivalent to fourth-power
divisibility of the negative trace shift. -/
theorem prime_fourth_dvd_negativeTrace_iff_square
    {p B Z : ℕ} (hp : p.Prime) (hpB : p ∣ B) (hoddB : Odd B)
    (hZ : Z + 1 = 4 * B ^ 2) :
    p ^ 4 ∣ Z + 1 ↔ p ^ 2 ∣ B := by
  have hpne : p ≠ 2 := by
    intro h
    subst p
    have hz : B % 2 = 0 := Nat.mod_eq_zero_of_dvd hpB
    have ho : B % 2 = 1 := Nat.odd_iff.mp hoddB
    omega
  have hpc : p.Coprime 2 :=
    (Nat.coprime_primes hp Nat.prime_two).2 hpne
  have hpc4 : (p ^ 4).Coprime 4 := by
    simpa [show (4 : ℕ) = 2 ^ 2 by norm_num] using
      (hpc.pow_left 4).pow_right 2
  constructor
  · intro hfour
    have hfour' : p ^ 4 ∣ 4 * B ^ 2 := by simpa [hZ] using hfour
    have hfourB : p ^ 4 ∣ B ^ 2 :=
      hpc4.dvd_of_dvd_mul_left hfour'
    apply (Nat.pow_dvd_pow_iff (by norm_num : (2 : ℕ) ≠ 0)).mp
    simpa only [show (p ^ 2) ^ 2 = p ^ 4 by ring] using hfourB
  · intro hsquare
    have hpow : p ^ 4 ∣ B ^ 2 := by
      have := pow_dvd_pow_of_dvd hsquare 2
      simpa only [show p ^ 4 = (p ^ 2) ^ 2 by ring] using this
    rw [hZ]
    exact dvd_mul_of_dvd_right hpow 4

/-- Exact coordinate depth two gives exact positive-trace depth four. -/
theorem positiveTrace_exact_four_of_coordinate_exact_two
    {p A Z : ℕ} (hp : p.Prime) (hpA : p ∣ A) (hoddA : Odd A)
    (hZ : Z - 1 = 2 * A ^ 2) (h2 : p ^ 2 ∣ A) (h3 : ¬p ^ 3 ∣ A) :
    p ^ 4 ∣ Z - 1 ∧ ¬p ^ 5 ∣ Z - 1 := by
  have hpne : p ≠ 2 := by
    intro h
    subst p
    have hz : A % 2 = 0 := Nat.mod_eq_zero_of_dvd hpA
    have ho : A % 2 = 1 := Nat.odd_iff.mp hoddA
    omega
  have hpc : p.Coprime 2 :=
    (Nat.coprime_primes hp Nat.prime_two).2 hpne
  constructor
  · exact (prime_fourth_dvd_positiveTrace_iff_square
      hp hpA hoddA hZ).mpr h2
  · intro h5
    have h5' : p ^ 5 ∣ 2 * A ^ 2 := by simpa [hZ] using h5
    have h5A : p ^ 5 ∣ A ^ 2 :=
      (hpc.pow_left 5).dvd_of_dvd_mul_left h5'
    have hA0 : A ≠ 0 := by
      intro hzero
      subst A
      exact h3 (dvd_zero _)
    have hfac5 : 5 ≤ (A ^ 2).factorization p :=
      (hp.pow_dvd_iff_le_factorization (pow_ne_zero 2 hA0)).1 h5A
    rw [Nat.factorization_pow] at hfac5
    change 5 ≤ 2 * A.factorization p at hfac5
    have hfac3 : 3 ≤ A.factorization p := by omega
    exact h3 ((hp.pow_dvd_iff_le_factorization hA0).2 hfac3)

/-- Exact coordinate depth two gives exact negative-trace depth four. -/
theorem negativeTrace_exact_four_of_coordinate_exact_two
    {p B Z : ℕ} (hp : p.Prime) (hpB : p ∣ B) (hoddB : Odd B)
    (hZ : Z + 1 = 4 * B ^ 2) (h2 : p ^ 2 ∣ B) (h3 : ¬p ^ 3 ∣ B) :
    p ^ 4 ∣ Z + 1 ∧ ¬p ^ 5 ∣ Z + 1 := by
  have hpne : p ≠ 2 := by
    intro h
    subst p
    have hz : B % 2 = 0 := Nat.mod_eq_zero_of_dvd hpB
    have ho : B % 2 = 1 := Nat.odd_iff.mp hoddB
    omega
  have hpc : p.Coprime 2 :=
    (Nat.coprime_primes hp Nat.prime_two).2 hpne
  have hpc4 : (p ^ 5).Coprime 4 := by
    simpa [show (4 : ℕ) = 2 ^ 2 by norm_num] using
      (hpc.pow_left 5).pow_right 2
  constructor
  · exact (prime_fourth_dvd_negativeTrace_iff_square
      hp hpB hoddB hZ).mpr h2
  · intro h5
    have h5' : p ^ 5 ∣ 4 * B ^ 2 := by simpa [hZ] using h5
    have h5B : p ^ 5 ∣ B ^ 2 := hpc4.dvd_of_dvd_mul_left h5'
    have hB0 : B ≠ 0 := by
      intro hzero
      subst B
      exact h3 (dvd_zero _)
    have hfac5 : 5 ≤ (B ^ 2).factorization p :=
      (hp.pow_dvd_iff_le_factorization (pow_ne_zero 2 hB0)).1 h5B
    rw [Nat.factorization_pow] at hfac5
    change 5 ≤ 2 * B.factorization p at hfac5
    have hfac3 : 3 ≤ B.factorization p := by omega
    exact h3 ((hp.pow_dvd_iff_le_factorization hB0).2 hfac3)

/-- The signed fourth-power trace packet retains every support quantifier. -/
def SignedFourthTracePacket (A B Z : ℕ) : Prop :=
  (∀ p : ℕ, p.Prime → p ∣ A → p ^ 4 ∣ Z - 1) ∧
  (∀ p : ℕ, p.Prime → p ∣ B → p ^ 4 ∣ Z + 1)

theorem signedFourthTracePacket_iff_squarefull_channels
    {A B Z : ℕ} (hoddA : Odd A) (hoddB : Odd B)
    (hZA : Z - 1 = 2 * A ^ 2) (hZB : Z + 1 = 4 * B ^ 2) :
    SignedFourthTracePacket A B Z ↔ NatSquarefull A ∧ NatSquarefull B := by
  constructor
  · rintro ⟨hA, hB⟩
    constructor
    · intro p hp hpA
      exact (prime_fourth_dvd_positiveTrace_iff_square
        hp hpA hoddA hZA).mp (hA p hp hpA)
    · intro p hp hpB
      exact (prime_fourth_dvd_negativeTrace_iff_square
        hp hpB hoddB hZB).mp (hB p hp hpB)
  · rintro ⟨hA, hB⟩
    constructor
    · intro p hp hpA
      exact (prime_fourth_dvd_positiveTrace_iff_square
        hp hpA hoddA hZA).mpr (hA p hp hpA)
    · intro p hp hpB
      exact (prime_fourth_dvd_negativeTrace_iff_square
        hp hpB hoddB hZB).mpr (hB p hp hpB)

/-- The fixed simultaneous-zero gate is exactly an all-support signed
fourth-power packet in the doubled trace. -/
theorem fixed_allZeroDisplacements_iff_signedFourthTracePacket
    (ell m : ℕ) (hprime : ell.Prime) (hell : ell = 2 * m + 1) :
    FixedPrimeIndexAllZeroDisplacements ell ↔
      SignedFourthTracePacket
        (sqrtTwoOrbit ell).1 (sqrtTwoOrbit ell).2 (pellDoubleTrace ell) := by
  have hodd := odd_index_coordinates_odd ell m hell
  have hZA := odd_pellDoubleTrace_sub_one_eq_positive ell m hell
  have hZB := odd_pellDoubleTrace_add_one_eq_negative ell m hell
  calc
    FixedPrimeIndexAllZeroDisplacements ell ↔
        NatSquarefull ((sqrtTwoOrbit ell).1 * (sqrtTwoOrbit ell).2) :=
      (fixed_two_squarefull_iff_all_zero_displacements
        ell m hprime hell).symm
    _ ↔ NatSquarefull (sqrtTwoOrbit ell).1 ∧
        NatSquarefull (sqrtTwoOrbit ell).2 :=
      natSquarefull_mul_iff (sqrtTwoOrbit_coprime ell)
    _ ↔ SignedFourthTracePacket
        (sqrtTwoOrbit ell).1 (sqrtTwoOrbit ell).2 (pellDoubleTrace ell) :=
      (signedFourthTracePacket_iff_squarefull_channels
        hodd.1 hodd.2 hZA hZB).symm

/-! ## Radical fourth-power consequence -/

theorem radical_fourth_dvd_square_of_twoFull
    {N : ℕ} (hN : IsKFull 2 N) : abcRadical N ^ 4 ∣ N ^ 2 := by
  have hsq := pow_dvd_pow_of_dvd hN.radical_pow_dvd 2
  simpa only [show abcRadical N ^ 4 =
      (abcRadical N ^ 2) ^ 2 by ring] using hsq

theorem twoFull_channels_give_radical_fourth_trace
    {A B Z : ℕ} (hA : IsKFull 2 A) (hB : IsKFull 2 B)
    (hZA : Z - 1 = 2 * A ^ 2) (hZB : Z + 1 = 4 * B ^ 2) :
    abcRadical A ^ 4 ∣ Z - 1 ∧ abcRadical B ^ 4 ∣ Z + 1 := by
  constructor
  · rw [hZA]
    exact dvd_mul_of_dvd_right (radical_fourth_dvd_square_of_twoFull hA) 2
  · rw [hZB]
    exact dvd_mul_of_dvd_right (radical_fourth_dvd_square_of_twoFull hB) 4

theorem twoFull_channels_give_product_radical_fourth
    {A B Z : ℕ} (hA : IsKFull 2 A) (hB : IsKFull 2 B)
    (hZA : Z - 1 = 2 * A ^ 2) (hZB : Z + 1 = 4 * B ^ 2) :
    abcRadical A ^ 4 * abcRadical B ^ 4 ∣ (Z - 1) * (Z + 1) := by
  rcases twoFull_channels_give_radical_fourth_trace hA hB hZA hZB with
    ⟨hpos, hneg⟩
  exact Nat.mul_dvd_mul hpos hneg

/-- The adjacent signed trace factors have an exact product, before any
radical estimate is applied. -/
theorem signedTrace_product_eq_eight_product_square
    {A B Z : ℕ} (hZA : Z - 1 = 2 * A ^ 2)
    (hZB : Z + 1 = 4 * B ^ 2) :
    (Z - 1) * (Z + 1) = 8 * (A * B) ^ 2 := by
  rw [hZA, hZB]
  ring

/-! ## The exact channel projector and its sharp raw precision -/

/-- The CRT projector selecting the positive channel modulo the product
square. -/
def pellChannelProjector (B : ℕ) : ℕ := 2 * B ^ 2

theorem pellChannelProjector_eq_positive_add_one
    {A B : ℕ} (hnorm : A ^ 2 + 1 = 2 * B ^ 2) :
    pellChannelProjector B = A ^ 2 + 1 := by
  simpa [pellChannelProjector] using hnorm.symm

theorem pellChannelProjector_defect
    {A B U : ℕ} (hnorm : A ^ 2 + 1 = 2 * B ^ 2)
    (hU : U = A * B) :
    pellChannelProjector B ^ 2 =
      pellChannelProjector B + 2 * U ^ 2 := by
  rw [pellChannelProjector, hU]
  nlinarith

theorem pellChannelProjector_modEq
    {A B U : ℕ} (hnorm : A ^ 2 + 1 = 2 * B ^ 2)
    (hU : U = A * B) :
    pellChannelProjector B ^ 2 ≡ pellChannelProjector B [MOD U ^ 2] := by
  rw [pellChannelProjector_defect hnorm hU]
  simp [Nat.ModEq]

theorem pellChannelProjector_positive_channel
    {A B : ℕ} (hnorm : A ^ 2 + 1 = 2 * B ^ 2) :
    pellChannelProjector B ≡ 1 [MOD A ^ 2] := by
  rw [pellChannelProjector_eq_positive_add_one hnorm]
  simp [Nat.ModEq]

theorem pellChannelProjector_negative_channel (B : ℕ) :
    pellChannelProjector B ≡ 0 [MOD B ^ 2] := by
  simp [pellChannelProjector, Nat.ModEq]

/-- The raw projector has exactly product-square precision: for `U >= 3`
its defect is not divisible by `U^3`. -/
theorem pellChannelProjector_precision_two_sharp
    {A B U : ℕ} (hnorm : A ^ 2 + 1 = 2 * B ^ 2)
    (hU : U = A * B) (hUge : 3 ≤ U) :
    ¬ U ^ 3 ∣ pellChannelProjector B ^ 2 - pellChannelProjector B := by
  have hdef := pellChannelProjector_defect hnorm hU
  have hsub : pellChannelProjector B ^ 2 - pellChannelProjector B =
      2 * U ^ 2 := by omega
  rw [hsub]
  rintro ⟨k, hk⟩
  have hposU2 : 0 < U ^ 2 := pow_pos (by omega) 2
  have hkpos : 0 < k := by
    by_contra hk0
    have : k = 0 := by omega
    subst k
    simp at hk
    omega
  have hlower : 3 * U ^ 2 ≤ U ^ 3 * k := by
    calc
      3 * U ^ 2 ≤ U * U ^ 2 := Nat.mul_le_mul_right (U ^ 2) hUge
      _ = U ^ 3 := by ring
      _ ≤ U ^ 3 * k := by
        exact Nat.le_mul_of_pos_right (U ^ 3) hkpos
  nlinarith

/-! ## Canonical Newton correction: the route survives raw sharpness -/

/-- One Newton correction for the idempotent equation `x^2-x=0`. -/
def newtonIdempotentCorrection (e d : ℤ) : ℤ :=
  e - (2 * e - 1) * d

/-- If `d` is the exact idempotent defect of `e`, one Newton correction
squares the defect, up to the explicit unit polynomial `4*d-3`. -/
theorem newtonIdempotentCorrection_defect
    {e d : ℤ} (hdef : e ^ 2 - e = d) :
    newtonIdempotentCorrection e d ^ 2 -
        newtonIdempotentCorrection e d = d ^ 2 * (4 * d - 3) := by
  rw [newtonIdempotentCorrection]
  nlinarith [sq_nonneg (2 * e - 1)]

/-- The Newton correction preserves the original projector modulo `U^2`. -/
theorem newtonIdempotentCorrection_preserves_square
    (e U : ℤ) :
    newtonIdempotentCorrection e (2 * U ^ 2) ≡ e [ZMOD U ^ 2] := by
  apply Int.modEq_of_dvd
  refine ⟨2 * (2 * e - 1), ?_⟩
  rw [newtonIdempotentCorrection]
  ring

/-- For the Pell projector defect `2*U^2`, the canonical correction is
idempotent modulo `U^4`. -/
theorem pellProjector_newtonCorrection_mod_fourth
    {e U : ℤ} (hdef : e ^ 2 - e = 2 * U ^ 2) :
    U ^ 4 ∣
      newtonIdempotentCorrection e (2 * U ^ 2) ^ 2 -
        newtonIdempotentCorrection e (2 * U ^ 2) := by
  rw [newtonIdempotentCorrection_defect hdef]
  refine ⟨4 * (8 * U ^ 2 - 3), ?_⟩
  ring

/-! ## Exact index-seven boundary counterexample -/

theorem index_seven_doubleTrace : pellDoubleTrace 7 = 114243 := by
  norm_num [pellDoubleTrace, sqrtTwoOrbit]

theorem thirteen_fourth_dvd_index_seven_negative_trace :
    13 ^ 4 ∣ pellDoubleTrace 7 + 1 := by
  rw [index_seven_doubleTrace]
  norm_num

theorem thirteen_fifth_not_dvd_index_seven_negative_trace :
    ¬ 13 ^ 5 ∣ pellDoubleTrace 7 + 1 := by
  rw [index_seven_doubleTrace]
  norm_num

/-- A deliberately stronger lift claim.  The exact index-seven collision
below refutes it. -/
def EveryFibonacciZeroDisplacementLiftsToTraceFifth : Prop :=
  ∀ ell m p : ℕ, ell.Prime → ell = 2 * m + 1 → p.Prime →
    FirstHenselDisplacementZero (pellF ell) 2 p →
      p ^ 5 ∣ pellDoubleTrace ell + 1

theorem not_everyFibonacciZeroDisplacementLiftsToTraceFifth :
    ¬ EveryFibonacciZeroDisplacementLiftsToTraceFifth := by
  intro h
  exact thirteen_fifth_not_dvd_index_seven_negative_trace
    (h 7 3 13 (by norm_num) (by norm_num) (by norm_num)
      index_seven_fibonacci_zero_displacement)

end PellSignedTraceProjector20260903
end IUTThreeClosures
