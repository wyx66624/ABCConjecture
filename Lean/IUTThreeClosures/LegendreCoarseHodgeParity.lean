/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Coarse degree parity in the Legendre Hodge route

On the coarse Legendre base `P^1`, the logarithmic cotangent line at the three
cusps has degree one.  An ordinary algebraic line bundle has integral degree,
and tensor square doubles that degree.  Hence no ordinary coarse line bundle
can square to the degree-one logarithmic cotangent line.

The half degree used by the maximal-Higgs Legendre variation must therefore be
interpreted on the modular stack, in a parabolic rational Picard group, or in
an equivalent stack-sensitive category.  This module formalizes only the
abstract degree obstruction; it does not construct the modular stack or an
arithmetic specialization theorem.
-/

namespace IUTThreeClosures

/-- An integer cannot be one half: no integral degree doubles to one. -/
theorem no_integral_half_degree :
    ¬ ∃ d : ℤ, d + d = 1 := by
  omega

/-- Abstract tensor-degree version of the coarse square-root obstruction. -/
theorem no_square_root_of_degree_one
    {Pic : Type*}
    (tensor : Pic → Pic → Pic)
    (degree : Pic → ℤ)
    (degree_tensor :
      ∀ L M : Pic, degree (tensor L M) = degree L + degree M)
    (logCotangent hodge : Pic)
    (logCotangent_degree : degree logCotangent = 1)
    (kodairaSpencer : tensor hodge hodge = logCotangent) :
    False := by
  have hdouble : degree hodge + degree hodge = 1 := by
    calc
      degree hodge + degree hodge = degree (tensor hodge hodge) :=
        (degree_tensor hodge hodge).symm
      _ = degree logCotangent := congrArg degree kodairaSpencer
      _ = 1 := logCotangent_degree
  exact no_integral_half_degree ⟨degree hodge, hdouble⟩

/-- Data for a hypothetical ordinary coarse line-bundle square root of a
logarithmic cotangent object of degree one. -/
structure CoarseDegreeOneSquareRootData where
  Pic : Type
  tensor : Pic → Pic → Pic
  degree : Pic → ℤ
  degree_tensor :
    ∀ L M : Pic, degree (tensor L M) = degree L + degree M
  logCotangent : Pic
  hodge : Pic
  logCotangent_degree : degree logCotangent = 1
  kodairaSpencer : tensor hodge hodge = logCotangent

/-- The hypothetical coarse square-root package is uninhabited. -/
theorem coarseDegreeOneSquareRootData_isEmpty :
    IsEmpty CoarseDegreeOneSquareRootData := by
  constructor
  intro D
  exact no_square_root_of_degree_one
    D.tensor D.degree D.degree_tensor
    D.logCotangent D.hodge
    D.logCotangent_degree D.kodairaSpencer

/-- In a rational/parabolic degree group, the unique square-root degree of one
is one half. -/
theorem rational_square_root_degree
    {d : ℚ}
    (h : d + d = 1) :
    d = 1 / 2 := by
  linarith

end IUTThreeClosures
