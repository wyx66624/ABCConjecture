import P2M.Sol.S_ModularForm_S2_Gamma0_2_eq_zero

/-- An actual import of the pinned official subproof with Mathlib's types. -/
theorem abc_s2_gamma0_two_zero
    (f : CuspForm (CongruenceSubgroup.Gamma0 2) 2) : f = 0 :=
  P2MW.S_ModularForm_S2_Gamma0_2_eq_zero.solution f

#print axioms P2MW.S_ModularForm_S2_Gamma0_2_eq_zero.solution
#print axioms abc_s2_gamma0_two_zero
#check abc_s2_gamma0_two_zero
