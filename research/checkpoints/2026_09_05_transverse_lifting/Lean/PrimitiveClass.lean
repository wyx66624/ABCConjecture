import Std

/-!
Author: ChatGPT. A complete exact counterexample on 5 + 7 = 12:
the minimum transverse radius is 1/5, but the minimum radius in the
primitive Wronskian classes W = +/-4 is 2/5. No ABC theorem is assumed.
-/
set_option autoImplicit false
namespace ABCPrimitiveClass20260905

structure Weights where
  at2 : Int
  at3 : Int
  at5 : Int
  at7 : Int
  deriving DecidableEq

def additive (v : Weights) : Prop :=
  v.at5 + v.at7 = 12*v.at2 + 4*v.at3

def W (v : Weights) : Int := 5*v.at7 - 7*v.at5

def Within (n d : Int) (v : Weights) : Prop :=
  -2*n <= d*v.at2 /\ d*v.at2 <= 2*n /\
  -3*n <= d*v.at3 /\ d*v.at3 <= 3*n /\
  -5*n <= d*v.at5 /\ d*v.at5 <= 5*n /\
  -7*n <= d*v.at7 /\ d*v.at7 <= 7*n

def Below (n d : Int) (v : Weights) : Prop :=
  -2*n < d*v.at2 /\ d*v.at2 < 2*n /\
  -3*n < d*v.at3 /\ d*v.at3 < 3*n /\
  -5*n < d*v.at5 /\ d*v.at5 < 5*n /\
  -7*n < d*v.at7 /\ d*v.at7 < 7*n

def minimum : Weights := { at2 := 0, at3 := 0, at5 := -1, at7 := 1 }
def primitive : Weights := { at2 := 0, at3 := -1, at5 := -2, at7 := -2 }

theorem arithmetic_data :
    (5 : Nat)+7=12 /\ Nat.gcd 5 7=1 /\
    (5 : Nat)*7*12 = 210*2 /\
    (12 : Nat)/2*2 = 12 /\ (12 : Nat)/3 = 4 := by decide

theorem image_divisibility (v : Weights) (h : additive v) :
    W v = 4*(15*v.at2 + 5*v.at3 - 3*v.at5) := by
  unfold additive at h
  unfold W
  omega

theorem image_attainment (m : Int) :
    exists v : Weights, additive v /\ W v = 4*m := by
  refine ⟨{ at2 := 0, at3 := -m, at5 := -2*m, at7 := -2*m }, ?_, ?_⟩
  · dsimp [additive]
    omega
  · dsimp [W]
    omega

theorem exact_image (k : Int) :
    (exists v : Weights, additive v /\ W v = k) <-> exists m : Int, k=4*m := by
  constructor
  · intro h
    obtain ⟨v,hv,hk⟩ := h
    exact ⟨15*v.at2+5*v.at3-3*v.at5, hk.symm.trans (image_divisibility v hv)⟩
  · intro h
    obtain ⟨m,hm⟩ := h
    obtain ⟨v,hv,hw⟩ := image_attainment m
    exact ⟨v,hv,hw.trans hm.symm⟩

theorem minimum_witness :
    additive minimum /\ W minimum = 12 /\ Within 1 5 minimum := by
  unfold additive W Within minimum
  decide

theorem no_smaller_transverse (v : Weights)
    (h : additive v) (hb : Below 1 5 v) : W v = 0 := by
  unfold additive at h
  unfold Below at hb
  unfold W
  omega

theorem exact_transverse_minimum :
    additive minimum /\ W minimum ≠ 0 /\ Within 1 5 minimum /\
    (forall v : Weights, additive v -> W v ≠ 0 -> Not (Below 1 5 v)) := by
  refine ⟨minimum_witness.1, ?_, minimum_witness.2.2, ?_⟩
  · rw [minimum_witness.2.1]
    decide
  · intro v hv hn hb
    exact hn (no_smaller_transverse v hv hb)

theorem primitive_witness :
    additive primitive /\ W primitive = 4 /\ Within 2 5 primitive := by
  unfold additive W Within primitive
  decide

theorem no_smaller_primitive (v : Weights) (h : additive v)
    (hw : W v = 4 \/ W v = -4) : Not (Below 2 5 v) := by
  intro hb
  unfold additive at h
  unfold Below at hb
  unfold W at hw
  have hz : v.at2=0 := by omega
  omega

theorem all_minimizers_have_level_three (v : Weights)
    (h : additive v) (hn : W v ≠ 0) (hb : Within 1 5 v) :
    W v = 12 \/ W v = -12 := by
  unfold additive at h
  unfold Within at hb
  unfold W at hn ⊢
  omega

#print axioms arithmetic_data
#print axioms image_divisibility
#print axioms image_attainment
#print axioms exact_image
#print axioms minimum_witness
#print axioms no_smaller_transverse
#print axioms exact_transverse_minimum
#print axioms primitive_witness
#print axioms no_smaller_primitive
#print axioms all_minimizers_have_level_three
end ABCPrimitiveClass20260905
