import EisensteinDescent
import Mathlib.Data.Int.GCD
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! Actual coordinate gcd and exact primitive reduction for Eisenstein multiplication.
The ordinary PC proof and its bounded arithmetic core were independently reviewed first.
The coprime input is expressed by Int.gcd, not supplied Bezout coefficients. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
namespace ABCActualProjectiveContent20260907
open ABCEisenstein20260905

def content (z : Pair) : Nat := Int.gcd z.1 z.2
def reduced (z : Pair) : Pair := (z.1 / (content z : Int), z.2 / (content z : Int))

theorem norm_positive (z : Pair) (hz : z ≠ (0, 0)) : 0 < norm z := by
  rcases z with ⟨x, y⟩
  by_cases hy : y = 0
  · have hx : x ≠ 0 := by
      intro hx
      exact hz (Prod.ext hx hy)
    simpa [norm, hy] using (mul_self_pos.mpr hx)
  · have hy2 : 0 < y * y := mul_self_pos.mpr hy
    dsimp [norm]
    nlinarith [sq_nonneg (2 * x + y)]

theorem content_mul_divides_norm (τ W : Pair) (hW : content W = 1) :
    (content (mul τ W) : Int) ∣ norm τ := by
  rcases τ with ⟨r, s⟩
  rcases W with ⟨u, v⟩
  let A := r * u - s * v
  let B := s * u + (r + s) * v
  have heq : mul (r, s) (u, v) = (A, B) := by
    apply Prod.ext
    · rfl
    · dsimp [mul, B]
      ring
  rw [heq]
  change (Int.gcd A B : Int) ∣ norm (r, s)
  change Int.gcd u v = 1 at hW
  obtain ⟨a, ha⟩ := Int.gcd_dvd_left A B
  obtain ⟨b, hb⟩ := Int.gcd_dvd_right A B
  have hbez : u * Int.gcdA u v + v * Int.gcdB u v = 1 := by
    simpa [hW] using (Int.gcd_eq_gcd_ab u v).symm
  have hadj := inverse_numerators r s u v
  change (r + s) * A + s * B = norm (r, s) * u ∧
    -s * A + r * B = norm (r, s) * v at hadj
  have hu : norm (r, s) * u = (Int.gcd A B : Int) * ((r + s) * a + s * b) := by
    calc
      norm (r, s) * u = (r + s) * A + s * B := hadj.1.symm
      _ = (r + s) * ((Int.gcd A B : Int) * a) + s * ((Int.gcd A B : Int) * b) :=
        congrArg₂ (· + ·) (congrArg ((r + s) * ·) ha) (congrArg (s * ·) hb)
      _ = (Int.gcd A B : Int) * ((r + s) * a + s * b) := by ring
  have hv : norm (r, s) * v = (Int.gcd A B : Int) * (-s * a + r * b) := by
    calc
      norm (r, s) * v = -s * A + r * B := hadj.2.symm
      _ = -s * ((Int.gcd A B : Int) * a) + r * ((Int.gcd A B : Int) * b) :=
        congrArg₂ (· + ·) (congrArg (-s * ·) ha) (congrArg (r * ·) hb)
      _ = (Int.gcd A B : Int) * (-s * a + r * b) := by ring
  refine ⟨((r + s) * a + s * b) * Int.gcdA u v +
    (-s * a + r * b) * Int.gcdB u v, ?_⟩
  calc
    norm (r, s) = norm (r, s) * (u * Int.gcdA u v + v * Int.gcdB u v) := by
      rw [hbez]
      ring
    _ = norm (r, s) * u * Int.gcdA u v + norm (r, s) * v * Int.gcdB u v := by ring
    _ = (Int.gcd A B : Int) * (((r + s) * a + s * b) * Int.gcdA u v +
        (-s * a + r * b) * Int.gcdB u v) := by
      rw [hu, hv]
      ring

theorem content_positive (z : Pair) (hz : z ≠ (0, 0)) : 0 < content z := by
  apply Int.gcd_pos_iff.mpr
  by_cases h₁ : z.1 = 0
  · right
    intro h₂
    exact hz (Prod.ext h₁ h₂)
  · exact Or.inl h₁

theorem content_product_positive (τ W : Pair) (hτ : τ ≠ (0, 0))
    (hW : content W = 1) : 0 < content (mul τ W) := by
  have hw0 : W ≠ (0, 0) := by
    intro hw
    simp [hw, content] at hW
  apply content_positive
  intro hp
  have hpos := mul_pos (norm_positive τ hτ) (norm_positive W hw0)
  have hnzero : norm (mul τ W) = 0 := by rw [hp]; rfl
  rw [norm_mul] at hnzero
  exact (ne_of_gt hpos) hnzero

theorem reduced_reconstruction (z : Pair) :
    (content z : Int) * (reduced z).1 = z.1 ∧
    (content z : Int) * (reduced z).2 = z.2 := by
  constructor
  · exact Int.mul_ediv_cancel' (Int.gcd_dvd_left z.1 z.2)
  · exact Int.mul_ediv_cancel' (Int.gcd_dvd_right z.1 z.2)

theorem reduced_primitive (z : Pair) (hz : z ≠ (0, 0)) : content (reduced z) = 1 := by
  exact Int.gcd_ediv_gcd_ediv_gcd (content_positive z hz)

theorem reduced_norm_identity (z : Pair) :
    (content z : Int) ^ 2 * norm (reduced z) = norm z := by
  have h := reduced_reconstruction z
  calc
    (content z : Int) ^ 2 * norm (reduced z) =
        norm ((content z : Int) * (reduced z).1, (content z : Int) * (reduced z).2) := by
      dsimp [norm]
      ring
    _ = norm z := by rw [h.1, h.2]

theorem reduced_product_norm_identity (τ W : Pair) :
    (content (mul τ W) : Int) ^ 2 * norm (reduced (mul τ W)) = norm τ * norm W := by
  rw [reduced_norm_identity, norm_mul]

theorem concrete_norm_seven_cancellation :
    mul (-3, 2) (62, -149) = (112, 273) ∧ content (62, -149) = 1 ∧
    content (112, 273) = 7 ∧ reduced (112, 273) = (16, 39) ∧
    content (16, 39) = 1 ∧ norm (-3, 2) = 7 ∧ norm (62, -149) = 7 ^ 5 ∧
    norm (16, 39) = 7 ^ 4 := by
  decide

#print axioms norm_positive
#print axioms content_mul_divides_norm
#print axioms content_positive
#print axioms content_product_positive
#print axioms reduced_reconstruction
#print axioms reduced_primitive
#print axioms reduced_norm_identity
#print axioms reduced_product_norm_identity
#print axioms concrete_norm_seven_cancellation
end ABCActualProjectiveContent20260907
