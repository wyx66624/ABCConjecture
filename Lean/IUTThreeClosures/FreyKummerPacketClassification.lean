import IUTThreeClosures.FreyDivisionHeightConservation

/-!
# Kummer packet classification for a full-two-torsion Frey curve

For the paper companion, identify the rational two-torsion group with
'Bool × Bool' by

* 'O  = (false, false)',
* 'T₀ = (true,  false)',
* 'Tₐ = (false, true)',
* 'T_b = (true,  true)'.

At collision primes dividing 'a', 'b', and 'c', respectively, the local
identity-torsion lines are the kernels of 'u xor v', 'u', and 'v'.

This module checks the finite packet classification and the polynomial
identities in the explicit counterfamily.  The arithmetic identification
of these Boolean kernels with Néron component kernels, and their
interpretation through rational 2-isogeny descent, are paper-only.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The four two-torsion labels and three collision quotients -/

/-- A finite coordinate model of the rational two-torsion group. -/
abbrev FreyTwoTorsionLabel := Bool × Bool

def freyTorsionO : FreyTwoTorsionLabel := (false, false)
def freyTorsionTzero : FreyTwoTorsionLabel := (true, false)
def freyTorsionTa : FreyTwoTorsionLabel := (false, true)
def freyTorsionTb : FreyTwoTorsionLabel := (true, true)

/-- Component quotient at a prime dividing 'a'; its kernel is
'{O, T_b}'. -/
def freyPacketA (T : FreyTwoTorsionLabel) : Bool :=
  xor T.1 T.2

/-- Component quotient at a prime dividing 'b'; its kernel is
'{O, Tₐ}'. -/
def freyPacketB (T : FreyTwoTorsionLabel) : Bool :=
  T.1

/-- Component quotient at a prime dividing 'c'; its kernel is
'{O, T₀}'. -/
def freyPacketC (T : FreyTwoTorsionLabel) : Bool :=
  T.2

def freyLineA (T : FreyTwoTorsionLabel) : Prop :=
  freyPacketA T = false

def freyLineB (T : FreyTwoTorsionLabel) : Prop :=
  freyPacketB T = false

def freyLineC (T : FreyTwoTorsionLabel) : Prop :=
  freyPacketC T = false

theorem freyLineA_iff (T : FreyTwoTorsionLabel) :
    freyLineA T ↔ T = freyTorsionO ∨ T = freyTorsionTb := by
  rcases T with ⟨u, v⟩
  cases u <;> cases v <;>
    simp [freyLineA, freyPacketA, freyTorsionO, freyTorsionTb]

theorem freyLineB_iff (T : FreyTwoTorsionLabel) :
    freyLineB T ↔ T = freyTorsionO ∨ T = freyTorsionTa := by
  rcases T with ⟨u, v⟩
  cases u <;> cases v <;>
    simp [freyLineB, freyPacketB, freyTorsionO, freyTorsionTa]

theorem freyLineC_iff (T : FreyTwoTorsionLabel) :
    freyLineC T ↔ T = freyTorsionO ∨ T = freyTorsionTzero := by
  rcases T with ⟨u, v⟩
  cases u <;> cases v <;>
    simp [freyLineC, freyPacketC, freyTorsionO, freyTorsionTzero]

/-! ## Actual finite image size of a conjugate orbit -/

/-- The number of distinct component packets hit by a finite orbit. -/
def freyLocalPacketCount
    (packet : FreyTwoTorsionLabel → Bool)
    (H : Finset FreyTwoTorsionLabel) : ℕ :=
  (H.image packet).card

/-- If the orbit contains the zero difference and the quotient sends it to
zero, then a one-packet orbit is exactly an orbit contained in the quotient
kernel. -/
theorem freyLocalPacketCount_eq_one_iff
    (packet : FreyTwoTorsionLabel → Bool)
    (H : Finset FreyTwoTorsionLabel)
    (hO : freyTorsionO ∈ H)
    (hpacketO : packet freyTorsionO = false) :
    freyLocalPacketCount packet H = 1 ↔
      ∀ T ∈ H, packet T = false := by
  constructor
  · intro hcard T hT
    have hfalse : false ∈ H.image packet := by
      exact Finset.mem_image.mpr ⟨freyTorsionO, hO, hpacketO⟩
    have hTmem : packet T ∈ H.image packet := by
      exact Finset.mem_image.mpr ⟨T, hT, rfl⟩
    obtain ⟨z, hz⟩ := Finset.card_eq_one.mp hcard
    rw [hz] at hfalse hTmem
    have hTz : packet T = z := by simpa using hTmem
    have hfz : false = z := by simpa using hfalse
    exact hTz.trans hfz.symm
  · intro hkernel
    have himage : H.image packet = {false} := by
      ext z
      constructor
      · intro hz
        obtain ⟨T, hT, rfl⟩ := Finset.mem_image.mp hz
        simp [hkernel T hT]
      · intro hz
        have hzfalse : z = false := by simpa using hz
        subst z
        exact Finset.mem_image.mpr ⟨freyTorsionO, hO, hpacketO⟩
    simp [freyLocalPacketCount, himage]

/-- With the zero packet present, the only alternative to one packet is
the full two-element Boolean image. -/
theorem freyLocalPacketCount_eq_two_iff
    (packet : FreyTwoTorsionLabel → Bool)
    (H : Finset FreyTwoTorsionLabel)
    (hO : freyTorsionO ∈ H)
    (hpacketO : packet freyTorsionO = false) :
    freyLocalPacketCount packet H = 2 ↔
      ∃ T ∈ H, packet T = true := by
  constructor
  · intro htwo
    by_contra hnot
    have hkernel : ∀ T ∈ H, packet T = false := by
      intro T hT
      cases hvalue : packet T with
      | false => rfl
      | true =>
          exact False.elim (hnot ⟨T, hT, hvalue⟩)
    have hone : freyLocalPacketCount packet H = 1 :=
      (freyLocalPacketCount_eq_one_iff packet H hO hpacketO).2 hkernel
    omega
  · rintro ⟨T, hT, htrue⟩
    have himage : H.image packet = {false, true} := by
      ext z
      cases z
      · have hfalse : false ∈ H.image packet :=
          Finset.mem_image.mpr ⟨freyTorsionO, hO, hpacketO⟩
        simp [hfalse]
      · have htrueMem : true ∈ H.image packet :=
          Finset.mem_image.mpr ⟨T, hT, htrue⟩
        simp [htrueMem]
    simp [freyLocalPacketCount, himage]

theorem freyPacketA_count_one_iff
    (H : Finset FreyTwoTorsionLabel) (hO : freyTorsionO ∈ H) :
    freyLocalPacketCount freyPacketA H = 1 ↔
      ∀ T ∈ H, freyLineA T := by
  simpa [freyLineA] using
    freyLocalPacketCount_eq_one_iff freyPacketA H hO (by decide)

theorem freyPacketB_count_one_iff
    (H : Finset FreyTwoTorsionLabel) (hO : freyTorsionO ∈ H) :
    freyLocalPacketCount freyPacketB H = 1 ↔
      ∀ T ∈ H, freyLineB T := by
  simpa [freyLineB] using
    freyLocalPacketCount_eq_one_iff freyPacketB H hO (by decide)

theorem freyPacketC_count_one_iff
    (H : Finset FreyTwoTorsionLabel) (hO : freyTorsionO ∈ H) :
    freyLocalPacketCount freyPacketC H = 1 ↔
      ∀ T ∈ H, freyLineC T := by
  simpa [freyLineC] using
    freyLocalPacketCount_eq_one_iff freyPacketC H hO (by decide)

/-! ## Pairwise line intersections and two-type rigidity -/

theorem freyLineA_inter_lineB
    {T : FreyTwoTorsionLabel} (hA : freyLineA T) (hB : freyLineB T) :
    T = freyTorsionO := by
  rcases T with ⟨u, v⟩
  cases u <;> cases v <;>
    simp [freyLineA, freyLineB, freyPacketA, freyPacketB,
      freyTorsionO] at hA hB ⊢

theorem freyLineA_inter_lineC
    {T : FreyTwoTorsionLabel} (hA : freyLineA T) (hC : freyLineC T) :
    T = freyTorsionO := by
  rcases T with ⟨u, v⟩
  cases u <;> cases v <;>
    simp [freyLineA, freyLineC, freyPacketA, freyPacketC,
      freyTorsionO] at hA hC ⊢

theorem freyLineB_inter_lineC
    {T : FreyTwoTorsionLabel} (hB : freyLineB T) (hC : freyLineC T) :
    T = freyTorsionO := by
  rcases T with ⟨u, v⟩
  cases u <;> cases v <;>
    simp [freyLineB, freyLineC, freyPacketB, freyPacketC,
      freyTorsionO] at hB hC ⊢

/-- One packet at collision types 'a' and 'b' forces the whole finite
difference orbit to be trivial. -/
theorem twoCollisionTypesAB_forceTrivial
    (H : Finset FreyTwoTorsionLabel) (hO : freyTorsionO ∈ H)
    (hA : freyLocalPacketCount freyPacketA H = 1)
    (hB : freyLocalPacketCount freyPacketB H = 1) :
    H = {freyTorsionO} := by
  have hkA := (freyPacketA_count_one_iff H hO).mp hA
  have hkB := (freyPacketB_count_one_iff H hO).mp hB
  ext T
  constructor
  · intro hT
    have hzero : T = freyTorsionO :=
      freyLineA_inter_lineB (hkA T hT) (hkB T hT)
    simp [hzero]
  · intro hT
    have hzero : T = freyTorsionO := by simpa using hT
    subst T
    exact hO

theorem twoCollisionTypesAC_forceTrivial
    (H : Finset FreyTwoTorsionLabel) (hO : freyTorsionO ∈ H)
    (hA : freyLocalPacketCount freyPacketA H = 1)
    (hC : freyLocalPacketCount freyPacketC H = 1) :
    H = {freyTorsionO} := by
  have hkA := (freyPacketA_count_one_iff H hO).mp hA
  have hkC := (freyPacketC_count_one_iff H hO).mp hC
  ext T
  constructor
  · intro hT
    have hzero : T = freyTorsionO :=
      freyLineA_inter_lineC (hkA T hT) (hkC T hT)
    simp [hzero]
  · intro hT
    have hzero : T = freyTorsionO := by simpa using hT
    subst T
    exact hO

theorem twoCollisionTypesBC_forceTrivial
    (H : Finset FreyTwoTorsionLabel) (hO : freyTorsionO ∈ H)
    (hB : freyLocalPacketCount freyPacketB H = 1)
    (hC : freyLocalPacketCount freyPacketC H = 1) :
    H = {freyTorsionO} := by
  have hkB := (freyPacketB_count_one_iff H hO).mp hB
  have hkC := (freyPacketC_count_one_iff H hO).mp hC
  ext T
  constructor
  · intro hT
    have hzero : T = freyTorsionO :=
      freyLineB_inter_lineC (hkB T hT) (hkC T hT)
    simp [hzero]
  · intro hT
    have hzero : T = freyTorsionO := by simpa using hT
    subst T
    exact hO

/-! ## The complete five-row packet table -/

def freyOrbitTrivial : Finset FreyTwoTorsionLabel :=
  {freyTorsionO}

def freyOrbitTzero : Finset FreyTwoTorsionLabel :=
  {freyTorsionO, freyTorsionTzero}

def freyOrbitTa : Finset FreyTwoTorsionLabel :=
  {freyTorsionO, freyTorsionTa}

def freyOrbitTb : Finset FreyTwoTorsionLabel :=
  {freyTorsionO, freyTorsionTb}

def freyOrbitFull : Finset FreyTwoTorsionLabel :=
  {freyTorsionO, freyTorsionTzero, freyTorsionTa, freyTorsionTb}

theorem freyPacketTable_trivial :
    (freyLocalPacketCount freyPacketA freyOrbitTrivial,
      freyLocalPacketCount freyPacketB freyOrbitTrivial,
      freyLocalPacketCount freyPacketC freyOrbitTrivial) = (1, 1, 1) := by
  decide

theorem freyPacketTable_Tzero :
    (freyLocalPacketCount freyPacketA freyOrbitTzero,
      freyLocalPacketCount freyPacketB freyOrbitTzero,
      freyLocalPacketCount freyPacketC freyOrbitTzero) = (2, 2, 1) := by
  decide

theorem freyPacketTable_Ta :
    (freyLocalPacketCount freyPacketA freyOrbitTa,
      freyLocalPacketCount freyPacketB freyOrbitTa,
      freyLocalPacketCount freyPacketC freyOrbitTa) = (2, 1, 2) := by
  decide

theorem freyPacketTable_Tb :
    (freyLocalPacketCount freyPacketA freyOrbitTb,
      freyLocalPacketCount freyPacketB freyOrbitTb,
      freyLocalPacketCount freyPacketC freyOrbitTb) = (1, 2, 2) := by
  decide

theorem freyPacketTable_full :
    (freyLocalPacketCount freyPacketA freyOrbitFull,
      freyLocalPacketCount freyPacketB freyOrbitFull,
      freyLocalPacketCount freyPacketC freyOrbitFull) = (2, 2, 2) := by
  decide

/-! ## Polynomial identities behind the rational two-isogeny quotients -/

/-- Quotienting the model with kernel '(0,0)' produces a last coefficient
'(a+b)^2'. -/
theorem freyTzeroQuotient_lastCoefficient (a b : ℤ) :
    (b - a) ^ 2 - 4 * (-a * b) = (a + b) ^ 2 := by
  ring

/-- After translating '(a,0)' to the origin, the quotient has last
coefficient 'b^2'. -/
theorem freyTaQuotient_lastCoefficient (a b : ℤ) :
    (2 * a + b) ^ 2 - 4 * (a * (a + b)) = b ^ 2 := by
  ring

/-- After translating '(-b,0)' to the origin, the quotient has last
coefficient 'a^2'. -/
theorem freyTbQuotient_lastCoefficient (a b : ℤ) :
    (a + 2 * b) ^ 2 - 4 * (b * (a + b)) = a ^ 2 := by
  ring

/-! ## The explicit prescribed-point counterfamily -/

theorem kummerCounterfamily_abc (s : ℤ) :
    6 + (s ^ 2 - 8) = s ^ 2 - 2 := by
  ring

theorem kummerCounterfamily_point (s : ℤ) :
    (4 * s) ^ 2 =
      8 * (8 - 6) * (8 + (s ^ 2 - 8)) := by
  ring

/-- The first Kummer coordinate has squareclass represented by '2'. -/
theorem kummerCounterfamily_firstCoordinate :
    (8 : ℤ) = 2 * 2 ^ 2 := by
  norm_num

/-- The second Kummer coordinate has the same squareclass represented by
'2'. -/
theorem kummerCounterfamily_secondCoordinate :
    (8 : ℤ) - 6 = 2 := by
  norm_num

/-- The third Kummer coordinate is a rational square. -/
theorem kummerCounterfamily_thirdCoordinate (s : ℤ) :
    (8 : ℤ) + (s ^ 2 - 8) = s ^ 2 := by
  ring

/-- The duplication abscissa identity used in the paper's local
non-torsion proof. -/
theorem kummerCounterfamily_doubleAbscissa (s : ℤ) :
    ((8 : ℤ) ^ 2 + 6 * (s ^ 2 - 8)) ^ 2 * (16 * s ^ 2) =
      (3 * s ^ 2 + 8) ^ 2 *
        (4 * 8 * (8 - 6) * (8 + (s ^ 2 - 8))) := by
  ring

/-- The numerator in the reduced duplication abscissa is a unit modulo
every odd prime dividing 's'; this integer Bézout identity is the
denominator-coprimality core. -/
theorem kummerCounterfamily_numerator_gcdCore (s : ℤ) :
    (3 * s ^ 2 + 8) - 3 * s * s = 8 := by
  ring

end

end IUTThreeClosures
