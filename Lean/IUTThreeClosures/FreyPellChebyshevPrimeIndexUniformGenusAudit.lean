import IUTThreeClosures.FreyPellFourConsecutiveProductAudit

/-!
# Uniform prime-index Chebyshev genus audit: scalar kernel

This file checks the elementary coordinate algebra used in
`FREY_PELL_CHEBYSHEV_PRIME_INDEX_UNIFORM_GENUS_AUDIT.md`.

It does not formalize quadratic fields, ideals, genus theory, local fields,
unit groups, the Bennett--Walsh theorem, the Bilu--Hanrot--Voutier theorem,
S-unit equations, modularity, or any external PARI calculation.  In
particular, it does not assert the unresolved uniform exclusion for prime
indices at least eleven.
-/

namespace IUTThreeClosures

/-! ## A transparent executable Chebyshev recurrence

The pair state after n steps is (T_n(x), T_{n+1}(x)).  This definition is
used only for the two exact large-integer diagnostics at the end of the file.
-/

def pellPrimeUniformChebyshev (n : ℕ) (x : ℤ) : ℤ :=
  (Nat.rec (motive := fun _ => ℤ × ℤ) (1, x)
    (fun _ state => (state.2, 2 * x * state.2 - state.1)) n).1

@[simp] theorem pellPrimeUniformChebyshev_zero (x : ℤ) :
    pellPrimeUniformChebyshev 0 x = 1 := rfl

@[simp] theorem pellPrimeUniformChebyshev_one (x : ℤ) :
    pellPrimeUniformChebyshev 1 x = x := rfl

/-! ## The explicit square in the biquadratic square-root field -/

/-- Rational and radical coefficients of
`(v*s*sqrt(B) + u*r*sqrt(3*A))^2 = 1 + 2*epsilon^p`.

The theorem records only the two scalar coefficient identities. -/
theorem pellPrimeUniform_betaSquareCoordinates
    (b A B u v r s : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2)
    (hsquare : b + 3 = s ^ 2) :
    let Z := b ^ 2 + 3 * b + 1
    B * (v * s) ^ 2 + 3 * A * (u * r) ^ 2 = 1 + 2 * Z ∧
      2 * (v * s) * (u * r) = 2 * (u * v * r * s) := by
  dsimp
  constructor
  · calc
      B * (v * s) ^ 2 + 3 * A * (u * r) ^ 2
          = (B * v ^ 2) * s ^ 2 + (A * u ^ 2) * (3 * r ^ 2) := by
              ring
      _ = (b + 1) * (b + 3) + b * (b + 2) := by
            rw [← hB, ← hsquare, ← hA, ← hthree]
      _ = 1 + 2 * (b ^ 2 + 3 * b + 1) := by ring
  · ring

/-- Multiplying the square-root-field square by `B` gives an exact square already
in the third quadratic subfield.  These are the scalar coordinates of

`(B*v*s + u*r*sqrt(3*A*B))^2 = B * (1 + 2*epsilon^p)`.
-/
theorem pellPrimeUniform_gammaSquareCoordinates
    (b A B u v r s : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2)
    (hthree : b + 2 = 3 * r ^ 2)
    (hsquare : b + 3 = s ^ 2) :
    let Z := b ^ 2 + 3 * b + 1
    let D := 3 * A * B
    (B * v * s) ^ 2 + D * (u * r) ^ 2 = B * (1 + 2 * Z) ∧
      2 * (B * v * s) * (u * r) = B * (2 * (u * v * r * s)) := by
  dsimp
  constructor
  · calc
      (B * v * s) ^ 2 + 3 * A * B * (u * r) ^ 2
          = B * (B * (v * s) ^ 2 + 3 * A * (u * r) ^ 2) := by ring
      _ = B * (1 + 2 * (b ^ 2 + 3 * b + 1)) := by
            rw [(pellPrimeUniform_betaSquareCoordinates
              b A B u v r s hA hB hthree hsquare).1]
  · ring

/-! ## Norms to the three quadratic subfields -/

/-- The four relative-norm identities for `beta+1` and `beta-1`.

Here `x` is the scalar shadow of `v*s*sqrt(B)` and `z` that of
`u*r*sqrt(3*A)`. -/
theorem pellPrimeUniform_threeSubfieldNormCoordinates
    (b x z : ℤ)
    (hx : x ^ 2 = (b + 1) * (b + 3))
    (hz : z ^ 2 = b * (b + 2)) :
    (x + z + 1) * (x - z + 1) = 2 * (b + 2 + x) ∧
      (x + z - 1) * (x - z - 1) = 2 * (b + 2 - x) ∧
      (x + z + 1) * (-x + z + 1) = -2 * (b + 1 - z) ∧
      (x + z - 1) * (-x + z - 1) = -2 * (b + 1 + z) := by
  have hdiff : x ^ 2 - z ^ 2 = 2 * b + 3 := by
    nlinarith [hx, hz]
  constructor
  · nlinarith
  constructor
  · nlinarith
  constructor <;> nlinarith

/-- The two displayed quadratic-subfield elements have norm one. -/
theorem pellPrimeUniform_subfieldUnitsNormOne
    (b x z : ℤ)
    (hx : x ^ 2 = (b + 1) * (b + 3))
    (hz : z ^ 2 = b * (b + 2)) :
    (b + 2 + x) * (b + 2 - x) = 1 ∧
      (b + 1 + z) * (b + 1 - z) = 1 := by
  constructor <;> nlinarith

/-- The quotient of the two supported-at-two elements is exactly the
quotient of the two quadratic-subfield units.  Denominators are cleared so
that this is a pure scalar identity. -/
theorem pellPrimeUniform_sUnitQuotient
    (beta t etaA etaB : ℚ)
    (hA : 2 * etaA = (beta - 1) * (t + 1))
    (hB : 2 * etaB = (beta + 1) * (t + 1)) :
    (beta + 1) * etaA = (beta - 1) * etaB := by
  linear_combination ((beta + 1) / 2) * hA - ((beta - 1) / 2) * hB

/-- Eliminating `beta` from
`delta=(beta+1)/(beta-1)` and `beta^2-1=2*epsilonPower` gives the exact
unit equation `(delta-1)^2*epsilonPower=2*delta`. -/
theorem pellPrimeUniform_sUnitExponentEquation
    (beta delta epsilonPower : ℚ)
    (hbeta : beta ^ 2 - 1 = 2 * epsilonPower)
    (hdelta : (beta - 1) * delta = beta + 1) :
    (delta - 1) ^ 2 * epsilonPower = 2 * delta := by
  have hepsilon : epsilonPower = (beta ^ 2 - 1) / 2 := by
    linarith
  have hlinear : beta * (delta - 1) = delta + 1 := by
    nlinarith [hdelta]
  calc
    (delta - 1) ^ 2 * epsilonPower
        = ((beta * (delta - 1)) ^ 2 - (delta - 1) ^ 2) / 2 := by
            rw [hepsilon]
            ring
    _ = ((delta + 1) ^ 2 - (delta - 1) ^ 2) / 2 := by rw [hlinear]
    _ = 2 * delta := by ring

/-- Scalar absolute-norm ledger: if the two conjugate squares differ from
one by `2*e` and `2*eInv`, with `e*eInv=1`, the four conjugates of either
`beta+1` or `beta-1` have product `4`. -/
theorem pellPrimeUniform_sUnitAbsoluteNorm
    (beta t e eInv : ℚ)
    (hbeta : beta ^ 2 - 1 = 2 * e)
    (ht : t ^ 2 - 1 = 2 * eInv)
    (hinv : e * eInv = 1) :
    (1 + beta) * (1 - beta) * (1 + t) * (1 - t) = 4 := by
  have hb : 1 - beta ^ 2 = -2 * e := by linarith
  have htt : 1 - t ^ 2 = -2 * eInv := by linarith
  calc
    (1 + beta) * (1 - beta) * (1 + t) * (1 - t)
        = (1 - beta ^ 2) * (1 - t ^ 2) := by ring
    _ = (-2 * e) * (-2 * eInv) := by rw [hb, htt]
    _ = 4 * (e * eInv) := by ring
    _ = 4 := by rw [hinv]; ring

/-! ## The degree-eight extension gives no new unit -/

/-- The apparent degree-eight relative unit factors into the two visible
quadratic pieces.  The symbols `sqrtThree`, `sqrtA`, and `sqrtB` are formal
scalar placeholders; no square-root theory is used. -/
theorem pellPrimeUniform_degreeEightFactorization
    (s r u v sqrtThree sqrtA sqrtB : ℤ) :
    (s + r * sqrtThree) * (u * sqrtA + v * sqrtB) =
      u * s * sqrtA + v * s * sqrtB +
        u * r * (sqrtThree * sqrtA) +
        v * r * (sqrtThree * sqrtB) := by
  ring

/-- The second factor in the degree-eight decomposition has norm one after
squaring into `Q(sqrt(A*B))`. -/
theorem pellPrimeUniform_adjacentKernelUnitNormOne
    (b A B u v : ℤ)
    (hA : b = A * u ^ 2)
    (hB : b + 1 = B * v ^ 2) :
    (2 * b + 1) ^ 2 - A * B * (2 * u * v) ^ 2 = 1 := by
  calc
    (2 * b + 1) ^ 2 - A * B * (2 * u * v) ^ 2
        = (2 * b + 1) ^ 2 - 4 * (A * u ^ 2) * (B * v ^ 2) := by ring
    _ = (2 * b + 1) ^ 2 - 4 * b * (b + 1) := by rw [← hA, ← hB]
    _ = 1 := by ring

/-! ## Exact scalar part of the BHV-method diagnostic -/

/-- The real quadratic unit in the method diagnostic has norm one.  PARI's
external `quadunit(3585)` computation identifies it as the fundamental unit;
that external assertion is not formalized here. -/
theorem pellPrimeUniform_bhvDiagnostic_normOne :
    (479 : ℤ) ^ 2 - 3585 * 8 ^ 2 = 1 := by
  norm_num

/-- Exact factorization of the seventeenth Chebyshev coordinate in the BHV
diagnostic.  External PARI primality and rank-of-apparition checks are
recorded only in the accompanying note. -/
theorem pellPrimeUniform_bhvDiagnostic_chebyshevFactorization :
    pellPrimeUniformChebyshev 17 (479 : ℤ) =
      479 * 1235420969309 * 407403853151449298643522544267728629 := by
  decide

/-- Both external primitive-prime factors split in `Q(sqrt(5))` and have
the rank-compatible residue `1 mod 68`. -/
theorem pellPrimeUniform_bhvDiagnostic_residues :
    (1235420969309 : ℤ) % 5 = 4 ∧
      (407403853151449298643522544267728629 : ℤ) % 5 = 4 ∧
      (1235420969309 : ℤ) % 68 = 1 ∧
      (407403853151449298643522544267728629 : ℤ) % 68 = 1 := by
  decide

/-- The same diagnostic is not a counterexample to the shifted-square
conjecture: its right side is `3 mod 7`. -/
theorem pellPrimeUniform_bhvDiagnostic_shiftResidue :
    (4 * pellPrimeUniformChebyshev 17 (479 : ℤ) + 5) % 7 = 3 := by
  decide

end IUTThreeClosures

#print axioms IUTThreeClosures.pellPrimeUniform_betaSquareCoordinates
#print axioms IUTThreeClosures.pellPrimeUniformChebyshev_zero
#print axioms IUTThreeClosures.pellPrimeUniformChebyshev_one
#print axioms IUTThreeClosures.pellPrimeUniform_gammaSquareCoordinates
#print axioms IUTThreeClosures.pellPrimeUniform_threeSubfieldNormCoordinates
#print axioms IUTThreeClosures.pellPrimeUniform_subfieldUnitsNormOne
#print axioms IUTThreeClosures.pellPrimeUniform_sUnitQuotient
#print axioms IUTThreeClosures.pellPrimeUniform_sUnitExponentEquation
#print axioms IUTThreeClosures.pellPrimeUniform_sUnitAbsoluteNorm
#print axioms IUTThreeClosures.pellPrimeUniform_degreeEightFactorization
#print axioms IUTThreeClosures.pellPrimeUniform_adjacentKernelUnitNormOne
#print axioms IUTThreeClosures.pellPrimeUniform_bhvDiagnostic_normOne
#print axioms IUTThreeClosures.pellPrimeUniform_bhvDiagnostic_chebyshevFactorization
#print axioms IUTThreeClosures.pellPrimeUniform_bhvDiagnostic_residues
#print axioms IUTThreeClosures.pellPrimeUniform_bhvDiagnostic_shiftResidue
