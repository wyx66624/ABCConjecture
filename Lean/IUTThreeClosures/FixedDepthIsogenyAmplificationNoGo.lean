/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Fixed-depth branching bound for isogeny amplification

A cyclic order-`ell` subgroup is labelled by one of `ell + 1` projective
lines.  A labelled path of exactly `r` cyclic-isogeny choices is therefore
modelled by `Fin r → Fin (ell + 1)`.  This module proves that the number of
labelled paths is `(ell + 1)^r`, and that the image of any endpoint map has at
most this cardinality.

The mathematical research note uses this finite bound to show that fixed depth
and a subpolynomial auxiliary level yield only `X^{o(1)}` outputs, which cannot
close a power-saving exceptional-set estimate.
-/

namespace IUTThreeClosures

/-- The exact number of labelled depth-`r` paths with `ell + 1` choices at each
step. -/
theorem card_fixedDepthProjectiveChoices (ell r : ℕ) :
    Fintype.card (Fin r → Fin (ell + 1)) = (ell + 1) ^ r := by
  simp

/-- Any endpoint construction from labelled paths has at most
`(ell + 1)^r` distinct outputs. -/
theorem card_fixedDepthEndpointImage_le
    {Output : Type*}
    [DecidableEq Output]
    (ell r : ℕ)
    (endpoint : (Fin r → Fin (ell + 1)) → Output) :
    (Finset.univ.image endpoint).card ≤ (ell + 1) ^ r := by
  calc
    (Finset.univ.image endpoint).card ≤ Finset.univ.card :=
      Finset.card_image_le
    _ = Fintype.card (Fin r → Fin (ell + 1)) := Finset.card_univ
    _ = (ell + 1) ^ r := card_fixedDepthProjectiveChoices ell r

/-- Collisions of endpoint curves or triples can only decrease the number of
outputs. -/
theorem card_fixedDepthEndpointRange_le
    {Output : Type*}
    [Fintype Output]
    [DecidableEq Output]
    (ell r : ℕ)
    (endpoint : (Fin r → Fin (ell + 1)) → Output) :
    (Finset.univ.filter fun y => ∃ path, endpoint path = y).card ≤
      (ell + 1) ^ r := by
  let image : Finset Output := Finset.univ.image endpoint
  have hfilter :
      (Finset.univ.filter fun y => ∃ path, endpoint path = y) = image := by
    ext y
    simp [image]
  rw [hfilter]
  exact card_fixedDepthEndpointImage_le ell r endpoint

end IUTThreeClosures
