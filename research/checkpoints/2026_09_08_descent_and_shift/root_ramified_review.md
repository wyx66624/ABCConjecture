# Independent root review of RS1--RS4

PASS: complete ordinary mathematics, not a Lean verification.
Reviewed source: independent nineteenth-round next_ramified_square_cube.md,
SHA256 8c840dd90e2193b974a647b29133b9b8ce04d655b55e7cdbbb70c8088c685341.

The root read the entire source and separately reread the final general-g
connectedness paragraph and corrected Stacks citation. The source theorem
on extension of rational maps was reopened at https://stacks.math.columbia.edu/tag/0BXX:
Lemma 53.2.2 and Theorem 53.2.6 apply to the stated normal projective curves
over the characteristic-zero fields in use.

The three literal unit coordinate pairs follow from zeta^2=zeta-1.
Their projective power maps are conjugate to a cubic map; the three
rational branch targets for the biquadratic construction avoid the two
power-map branch values. Both square classes and their product are
nontrivial by the distinct simple zero sets. The connected degree-four
cover has nine branch points of inertia two, hence genus six. Its three
quotient equations and same-source square-root coordinates agree.

The full conic has no three-adic point at infinity. At every affine
point, opposite valuation parity gives v_3(v)=0 and v_3(w)>=1, and
therefore v_3(r)=-1. Every projective source admits primitive integral
three-adic coordinates. If S and T have different residues, A0,C0 are
units and B0 belongs to 9 Z_3. If S=T+3K with T a unit, direct
expansion gives exact valuation one for all A0,B0,C0. None of the
three unit ratios has valuation -1. The two everywhere-defined
projective images make this an exclusion of the complete normalized
curve, including its branch fibres and points at infinity.

The stronger integer conclusion repeats the full norm-Euclidean UFD
extraction, with primitivity and absence of the ramified norm prime.
A cube norm forces an actual oriented cube up to one of the three
global units. Its source is unramified, so its second coefficient is
either a unit or divisible by nine. A primitive seed's M has valuation
zero or one. Thus the identity unit is impossible and F=Q^3 implies
3 does not divide M. No assumption M/3 is a square is used here.

The numerical propagation only rewrites a total exponent divisible
by three. The geometric propagation uses fixed specified units and
retains geometric connectedness for even g by the same simple-zero
argument; it does not identify all unit classes modulo g-th powers.

The local-versus-global calibration is essential and correct: for
(a,b)=(1,4), M=21 and F=541. Hensel gives a square root of seven
in Q_3. Writing Q=1+3t reduces Q^3=541 to
t+3t^2+3t^3=60, with a simple root modulo three. Thus the bare
numerical equations are locally soluble, while the exact global-unit
common-source covers are locally empty. No stronger local claim
has been inferred from the global integral extraction.

These proofs close an exact ramified branch, not general ABC,
nonunit residual families, or uniform moving-family heights.
