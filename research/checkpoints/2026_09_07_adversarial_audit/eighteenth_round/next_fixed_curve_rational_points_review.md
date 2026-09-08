# SM1--SM3: final independent full ordinary review

Status: **full ordinary proof PASS**. I actually read the complete combined
root proof and its complete finite verifier, after independently proving
the index/logarithm bridge and writing a separate finite implementation.
No reviewed source was changed.

Root source `next_fixed_curve_rational_points.md` SHA256:
`d74cdd8f7da9261b17e40cb8e76e13e38645a2b370216d74e49fc32fd09b3fab`.
Root verifier `next_replay_thirteen_sieve.py` SHA256:
`cc0f644d939278c588e701a17ebc6014c595097a388ae2f2ebf56efd0b0f8282`.
Root canonical `next_verification/thirteen_sieve.json` SHA256:
`46adefa954c349500510973f452e551ab82125bfc3d5ade6a6ab0efba65515da`.

SM1 matches the independently established FS1 bridge in
`next_five_primary_sieve_review.md`. QL's actual whole rational-group index
d is finite and prime to five, so dQ=aP and the logarithmic coefficient
is a/d. Only after tripling the reduction does the argument invert d,
on a group killed by five. This works even if d is divisible by thirteen
or three. There is no direct operation of reducing a Q5 value modulo
thirteen and no global-generator or unproved extra saturation premise.

SM2's entire sixteen-row table, all zero/infinity image conventions, and
both sign targets agree with my independent enumeration and normalized
division-polynomial tripling. Root's verifier instead uses chord/tangent
addition and checks the group exponent. The displayed polynomial Bezout
identity was checked coefficient by coefficient: all positive-degree
coefficients vanish and the constant is one modulo thirteen. Hence it
establishes geometric squarefreeness, not merely a test on rational roots.
The elliptic discriminants and all point lists are correct. The explicit
valuation cases ensure that every rational point and its two quotient
images reduce to the complete projective table, including denominators.

The complete root verifier was actually run with `--check`, exit 0,
matching the canonical hash above. I also performed an exact JSON-level
comparison of all sixteen points, both quotient images and both triples
against the output of my separate implementation; all rows agree. My
independent output remains
`next_verification/f13_independent.json`, SHA256
`c806cba4c93ce98628556464990a3be735d98fd45abcfb68c1c81ca48f6486f0`.
These two executions are distinguished from the ordinary number-theoretic
bridge and the complete analytic disk arguments.

SM3 uses the previously fully reviewed UD, SU, ZD and IF ordinary proofs,
each of whose latest finite inputs I independently checked. The extra UD
root has s=4 and logarithmic coefficient pair (0,1) modulo five; the actual
DS signs produce only (0,+/-1) on its orbit. If any such point were rational,
SM1 would force precisely the two forbidden finite targets. The other local
disks have already been exhaustively excluded or contain just the known
infinity points. The original height necessity is applied only on its valid
finite nonzero chart; z=0 has no Q point and infinity is treated directly.

Thus the six-point classification of this fixed smooth genus-two C is a
completed ordinary conclusion, with existence as well as exclusion proved.
It is not a completed Lean proof of the height argument, a classification of
the original double-cover positive source, or a uniform varying-curve ABC
estimate. The root manuscript keeps each of these scopes separate.
