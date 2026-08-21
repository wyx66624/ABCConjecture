import Iut.Cor312.LogVolume

/-!
# Prime-power fractional-ideal regions and calibrated local log-volumes

The image/preimage cancellation used below is valid only when the rational
prime has nonzero image in the summand field.  The public packet interface
carries only a `Field` instance, so this fact is made an explicit hypothesis
rather than silently assuming characteristic zero.
-/

namespace Iut

open scoped BigOperators

universe u₁ u₂ v

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

namespace PrimePowerQPilotRegion

def primeImage
    {F : Type*} [Field F] (p : Nat.Primes) (U : Set F) : Set F :=
  (fun x : F => ((p : ℕ) : F) * x) '' U

theorem preimage_primeImage
    {F : Type*} [Field F] (p : Nat.Primes)
    (hp : (((p : ℕ) : F)) ≠ 0) (U : Set F) :
    (fun x : F => ((p : ℕ) : F) * x) ⁻¹' primeImage p U = U := by
  ext x
  constructor
  · intro hx
    rcases hx with ⟨y, hy, hxy⟩
    have hyx : y = x := by
      apply mul_left_cancel₀ hp
      exact hxy
    simpa [hyx] using hy
  · intro hx
    exact ⟨x, hx, rfl⟩

def primePowerImage
    {F : Type*} [Field F] (p : Nat.Primes) : ℕ → Set F → Set F
  | 0, U => U
  | n + 1, U => primeImage p (primePowerImage p n U)

variable (vol : LogVolumeData D)

theorem componentVol_primeImage
    (i : Fin D.proc.length) (p : Nat.Primes)
    (c : D.Components i (.finite p))
    (hp : (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0)
    (U : Set ((D.packet i (.finite p)).Summand c)) :
    vol.componentVol i (.finite p) c (primeImage p U) =
      vol.componentVol i (.finite p) c U - Real.log p := by
  have h := vol.componentVol_prime_preimage i p c (primeImage p U)
  rw [preimage_primeImage p hp U] at h
  linarith

theorem componentVol_primePowerImage
    (i : Fin D.proc.length) (p : Nat.Primes)
    (c : D.Components i (.finite p))
    (hp : (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0)
    (U : Set ((D.packet i (.finite p)).Summand c))
    (n : ℕ) :
    vol.componentVol i (.finite p) c (primePowerImage p n U) =
      vol.componentVol i (.finite p) c U - (n : ℝ) * Real.log p := by
  induction n with
  | zero => simp [primePowerImage]
  | succ n ih =>
      rw [primePowerImage, componentVol_primeImage vol i p c hp, ih]
      push_cast
      ring

theorem componentVol_primePowerIntegral
    (i : Fin D.proc.length) (p : Nat.Primes)
    (c : D.Components i (.finite p))
    (hp : (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0)
    (n : ℕ) :
    vol.componentVol i (.finite p) c
        (primePowerImage p n ((D.packet i (.finite p)).integral c)) =
      - (n : ℝ) * Real.log p := by
  rw [componentVol_primePowerImage vol i p c hp]
  rw [vol.componentVol_integral_nonarch]
  ring

def packetPrimePowerRegion
    (i : Fin D.proc.length) (p : Nat.Primes)
    (order : D.Components i (.finite p) → ℕ) :
    Set (D.packet i (.finite p)).Total :=
  (D.packet i (.finite p)).productRegion fun c =>
    primePowerImage p (order c) ((D.packet i (.finite p)).integral c)

theorem packetVol_packetPrimePowerRegion
    (i : Fin D.proc.length) (p : Nat.Primes)
    (order : D.Components i (.finite p) → ℕ)
    (hp : ∀ c : D.Components i (.finite p),
      (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0) :
    vol.packetVol i (.finite p) (packetPrimePowerRegion i p order) =
      ∑ c, vol.packetWeight i (.finite p) c *
        (- (order c : ℝ) * Real.log p) := by
  rw [packetPrimePowerRegion, vol.packetVol_product']
  apply Finset.sum_congr rfl
  intro c hc
  rw [componentVol_primePowerIntegral vol i p c (hp c)]

end PrimePowerQPilotRegion
end Iut

/-! Compatibility lemma for the zero-valued packet used by the generated-hull
construction.  Its argument order matches the historical proof term. -/
namespace Function

theorem update_noteq
    {α β : Type*} [DecidableEq α] [Zero β]
    {a b : α} {v : β}
    (h : b ≠ a) :
    Function.update (fun _ : α => (0 : β)) a v b = 0 := by
  simp [Function.update, h]

end Function
