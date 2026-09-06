# Endpoint-residue checkpoint: scope and verification protocol

Author: ChatGPT  
Date: 2026-09-05  
Baseline main: `6118955d20b4edd32e577e06d1060f3945358dd9`  
Research PR: https://github.com/wyx66624/ABCConjecture/pull/419

## Mathematical result and exact non-result

The ordinary proof is in
`research/ABC_UNBOUNDED_ENDPOINT_RESIDUE_OBSTRUCTION_2026_09_05.md`,
and the companion English manuscript is
`paper/ChatGPT_Endpoint_Residue_Obstructions_2026.tex`.

For every e >= 2, choose 3^(e-1) distinct primes in the CRT progression
q = 2 mod 3^(e+1), q = 3 mod 8. Their squarefree product B gives an
unbounded family (1,B,B+1) with exact valuations v2(c)=2 and v3(c)=e.
The endpoint Boolean cube can exceed its target residue group by an
arbitrarily large multiplicative factor while no proper packet is compatible.
A legitimate saturated donor exists.

Every constructed point also has c < rad(abc) and optimized SCRT/FCRT boundary
zero. Thus this strengthens only the already retired raw-counting NBF child.
It does not prove or disprove ABCConjecture, SCRT-0, or FCRT-1, and does not
retire the parent endpoint, anchored-prefix, IUT, or other research routes.

## Fixed-modulus ordinary proof before the extra Lean module

The specialization fixes the primes 83 and 947 and chooses a prime
p > max(N,947) with p = 83 mod 216, using Dirichlet's theorem. These three
primes are distinct. Put B = 83*947*p = 78601*p. Then B = 35 mod 216,
so 4 divides B+1 but 8 does not, and 9 divides B+1 but 27 does not.
The triple (1,B,B+1) is positive and primitive. Every prime factor is 2 mod 9.
A proper packet of the three factors has size 0, 1, or 2, so its product is
1, 2, or 4 mod 9; adding one cannot be divisible by 9. Dirichlet provides
p above every N, not merely within a computational interval.

`EndpointResidueArithmeticFamily.lean` expresses exactly these arithmetic
claims, including primality of the two fixed factors and arbitrary largeness.
It has no abstract order premise. It does not formalize all e simultaneously,
the radical/FCRT optimization, or the antichain theorem.

## Frozen first-core execution, not a claim about a later revision

The nine-declaration file `EndpointConstantResidueObstruction.lean` at
commit `c09e57fa44cd91d3eb3afb1d49bbebc032a6ee6f` passed the strict command

```sh
lake env lean -DwarningAsError=true IUTThreeClosures/EndpointConstantResidueObstruction.lean
```

in PR run 33956603573, job 101280956135. The actual checked PR merge tree was
`6e17064c0265028dc2de5fa9c81b109f8207983d`. Its nine printed dependency reports
have union `{propext, Classical.choice, Quot.sound}`. The job also reproduced
the exact Python output and passed its SHA256 check. The first audit artifact
ID is 9966588864.

The environment was Lean 4.32.0; pinned Mathlib resolved to
`81a5d257c8e410db227a6665ed08f64fea08e997`. The repository's iut/genl/heights
requirements and existing full-repository workflows were not weakened.

## Current revision: replay and merge requirements

The dedicated workflow now checks both companion Lean files strictly and
requires 13 distinct axiom reports with only the three named standard axioms.
The current revision's result must be taken from its own check suite attached
to PR #419; success of the earlier nine-declaration core does not certify a
later file. Full-repository kernel and all-module audits remain separate checks.
Actual final run identifiers and merge results are recorded in the PR discussion.

From `Lean/`, replay:

```sh
lake update
lake exe cache get
lake env lean -DwarningAsError=true IUTThreeClosures/EndpointConstantResidueObstruction.lean
lake env lean -DwarningAsError=true IUTThreeClosures/EndpointResidueArithmeticFamily.lean
lake build
```

From the repository root, replay the finite computation:

```sh
python research/computation/endpoint_residue_obstruction_2026_09_05.py --max-e 6 --output endpoint-cases.json
```

The output SHA256 must be
`ea56c8bc568e90311204e69e479534c9a7dafa2214db2c3c060831434fee9621`.
The five cases use e=2,...,6, with 3,9,27,81,243 distinct certified primes.
The last c has 1675 decimal digits. Every possible packet cardinality is
checked, which is exhaustive for labels because all generators are equal.
This is not full subset enumeration, a factorization of c, an FCRT optimizer,
or a computational proof of an infinite statement.

Build the manuscript from `paper/` with two runs of

```sh
pdflatex -halt-on-error -interaction=nonstopmode ChatGPT_Endpoint_Residue_Obstructions_2026.tex
```

The PDF is a research manuscript with author ChatGPT, not a journal acceptance
or a claim of external peer review. The full e-uniform family and the
antichain/weighted corollary retain ordinary-proof status. No global gate is
silently introduced as an axiom and neither ABCConjecture nor its negation
has been closed by this checkpoint.
