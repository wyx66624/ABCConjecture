# Proof dependency and approach register

Author: ChatGPT. Updated September 5, 2026.

## Established in this continuation

| Node | Mathematical content | Dependencies | Status |
|---|---|---|---|
| L1 | Exact local content `G_n=(n/rad(n))*k_n*rho_n`; `h_n=k_n/gcd(k_n,rad(n)/rho_n)` | Unique factorization, Bezout | COMPLETE ordinary proof |
| L2 | Bounded correction using a shortest path modulo the smallest step | Finite residue group, gcd one | COMPLETE ordinary proof |
| L3 | Every allowable derivative value lifts within `Omega(n)/k_n` of constant real weights | L1, CRT, L2 | COMPLETE ordinary proof |
| G1 | Wronskian image from the minors of a primitive integer row | Bezout, pairwise coprime supports | COMPLETE ordinary proof; two concrete images FORMALLY VERIFIED |
| G2 | Aggregate fibre is a coset of `lcm(h_a,h_b,h_c)*Z` | G1, coprimality | COMPLETE ordinary proof |
| G3 | Exact real minimum by three pairwise-overlapping intervals | Elementary inequalities | COMPLETE ordinary proof |
| G4 | Additive error at most `(log_2 c)^2/2+log_2 c` at every nonzero level | L3, G2, G3 | COMPLETE ordinary proof |
| G5 | A finite range of levels contains every minimizer; `h0>E` forces primitive level | G4 | COMPLETE ordinary proof |
| B1 | `H_perp=1644/23` and every vector of norm at most 10 is tangent on the large benchmark | Exact integer equations | FORMALLY VERIFIED |
| B2 | `H_perp=1/5`, `H_1=2/5`, all minimizers level 3 on `5+7=12` | Actual coefficients including `v_2(12)=2` | FORMALLY VERIFIED |
| Q1 | Uniform `H_perp <= C_tau J R^tau` is equivalent to ABC | G4 and elementary log absorption | COMPLETE equivalence proof; neither side proved unconditionally |

## Refuted children, not refuted parent routes

`SHORTEST-IS-TRANSVERSE` is REFUTED by B1. `PRIMITIVE-CLASS-IS-OPTIMAL` is REFUTED by B2. Neither example refutes ABC or the derivative method. An initial small-example calculation omitted the factor `v_2(12)=2`; the working statement and progress message were corrected before the small-example source was committed. The correct image is `4*Z`, not `2*Z`.

## Remaining and preserved routes

The derivative route is **BLOCKED at theorem-strength scalar uniformity**, not at unspecified local integral lifting. Its exact remaining assertion is Q1's uniform inequality, whose constants may depend only on `tau`. The equivalence prevents presenting this node as an almost-completed ABC proof.

FCRT/signed endpoints and the multi-output successor remain ACTIVE under their actual compatibility conditions. Their global uniform estimate is not supplied by G4. The first-apparition valuation problem on power-neighbour/Pell/Mersenne routes is retained as ACTIVE; the current continuation does not add a first-apparition theorem. The IUT all-place comparison and geometric contact-multiplicity gates remain BLOCKED at their previously recorded unresolved inputs. No equivalence to ABC is treated as an established height estimate.

A next constructive refinement within this derivative route is to compute the exact level spectrum rather than assume primitive optimality. G5 makes that refinement finite for a fixed factored triple. However, G4 and Q1 show that improving this auxiliary optimization alone cannot be advertised as a new independent bound for the original scalar defect.

## Final root and audit

```text
L1 + L2 + CRT -> L3
G1 + coprimality -> G2
interval overlap -> G3
L3 + G2 + G3 -> G4 -> G5
G4 + ABC -> uniform small transverse derivatives
uniform small transverse derivatives -> ABC
```

The root `ABCConjecture` is UNRESOLVED. There is no Lean axiom, placeholder, or conditional import representing a completed ABC proof. The general ordinary proofs have not been fully encoded in Lean. Two different exact numerical implementations and actual Lean executions were used; independent autonomous subagents and external peer review were not performed or claimed.
