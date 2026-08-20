import Mathlib

/-!
# Ramification-corrected local q-pilot response

The public packet normalization is expressed using the rational residue
characteristic `p`: multiplication by `p` subtracts `log p`.  For a local
uniformizer `π` with `p = u * π^e`, where `u` is a unit and `e` is the
ramification index, the correct normalized response is therefore
`-(1/e) * log p`.  A Tate parameter `q = u_q * π^n` has response
`-(n/e) * log p`.

This corrects the tempting but generally false identification of `q O` with
`p^n O` in ramified fields.
-/

namespace IUTThreeClosures

structure MultiplicativeLogResponse (G : Type*) [CommGroup G] where
  response : G → ℝ
  response_one : response 1 = 0
  response_mul : ∀ x y, response (x * y) = response x + response y

namespace MultiplicativeLogResponse

variable {G : Type*} [CommGroup G]

theorem response_pow
    (D : MultiplicativeLogResponse G) (x : G) (n : ℕ) :
    D.response (x ^ n) = (n : ℝ) * D.response x := by
  induction n with
  | zero => simp [D.response_one]
  | succ n ih =>
      rw [pow_succ, D.response_mul, ih]
      push_cast
      ring

theorem uniformizer_response
    (D : MultiplicativeLogResponse G)
    {p u π : G} {e : ℕ} {logp : ℝ}
    (he : 0 < e)
    (hp : p = u * π ^ e)
    (hu : D.response u = 0)
    (hpvol : D.response p = -logp) :
    D.response π = -(logp / (e : ℝ)) := by
  have h :
      -logp = (e : ℝ) * D.response π := by
    calc
      -logp = D.response p := hpvol.symm
      _ = D.response (u * π ^ e) := congrArg D.response hp
      _ = D.response u + D.response (π ^ e) := D.response_mul _ _
      _ = (e : ℝ) * D.response π := by
        rw [hu, D.response_pow]
        ring
  have he0 : (e : ℝ) ≠ 0 := by
    exact_mod_cast he.ne'
  field_simp [he0]
  nlinarith

theorem tate_parameter_response
    (D : MultiplicativeLogResponse G)
    {p u π uq q : G} {e n : ℕ} {logp : ℝ}
    (he : 0 < e)
    (hp : p = u * π ^ e)
    (hu : D.response u = 0)
    (hpvol : D.response p = -logp)
    (hq : q = uq * π ^ n)
    (huq : D.response uq = 0) :
    D.response q = -((n : ℝ) / (e : ℝ)) * logp := by
  have hπ := D.uniformizer_response he hp hu hpvol
  calc
    D.response q = D.response (uq * π ^ n) := congrArg D.response hq
    _ = D.response uq + D.response (π ^ n) := D.response_mul _ _
    _ = (n : ℝ) * D.response π := by
      rw [huq, D.response_pow]
      ring
    _ = -((n : ℝ) / (e : ℝ)) * logp := by
      rw [hπ]
      ring

end MultiplicativeLogResponse

/-- Multiplying the ramification-corrected local response by the normalized
local-degree weight cancels the ramification index. -/
theorem normalized_local_degree_contribution
    {e f d n logp : ℝ}
    (he : e ≠ 0) (hd : d ≠ 0) :
    ((e * f) / d) * (-(n / e) * logp) =
      -((n * f) / d) * logp := by
  field_simp [he, hd]
  ring

end IUTThreeClosures
