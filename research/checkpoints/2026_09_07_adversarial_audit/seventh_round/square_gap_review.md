# Independent review of the elementary square gaps

Date: 2026-09-07. Read the complete SG1--SG3 note and the complete
`2026_09_07_critical_bottleneck/seventh_round/replay.py`.
Result: ordinary proof PASS and independent `--check` replay PASS.

The axis identity S^2-64F=72ab^3+57b^4 is exact. Positivity gives
8q<S and hence8q<=S-r for the least positive residue r modulo8;
S-r is nonnegative. Under the contrary assumption2ra>=9b^3,
the derived gap difference is at least51b^4+22rb^2-r^2>0.
The last positivity holds for b>=1 and1<=r<=8. Primitive parity
indeed restricts r to3,4,7,8. Thus2a<3b^3, and symmetry gives
max(a,b)<(3/2)min(a,b)^3. The min-coordinate-one exclusion follows
only after checking the remaining pair(1,1), whose norm13 is nonsquare.

The diagonal identity52F=A^2+3(a-b)^4 with A=26ab+7(a-b)^2 is
also exact. For F=13q^2 and nonzero c=a-b, the positive integer
26q exceeds A by at least one. This gives52ab+14c^2+1<=3c^4.
The separate primitive depth-one theorem at13 correctly implies
13|c and13 not dividing q. The diagonal pair(1,1) is explicitly
treated and is not subjected to the nonzero-gap argument.

For SG3 every actual solution gives the positive divisor pair
d1=26q-A<d2=26q+A, product3c^4. Conversely all divisibility,
parity and square tests in the algorithm produce a,b>0 with
a-b=c, ab=u and the actual F=13q^2 identity. The prescribed h>|c|
ensures both coordinates are positive; h-c even ensures both are
integral. The gcd filter is optional and is not used to justify
completeness without primitivity. Thus the divisor classification
really is finite and exhaustive for each fixed nonzero c.

The replay checks two zero polynomial-coefficient identities and both
Sylvester discriminants at c=1, all48 relevant parity rows,84490
primitive positive seeds and160 complete nonzero difference slices
with |c|<=80. Its brute comparison on each slice is explicitly
restricted to b<=500; the algorithm itself enumerates all divisors.
The known square seed(355,101,192529) is retained. No bounded search
is used as a proof of a general nonexistence assertion.

Independent execution returned exit0 and the exact recorded seals:

* JSON file byte SHA256:
  `98895ac742b8e6daf11c26fb4edbe410e3246c918f919adf1b1c9a19cf63fb54`.
* Internal compact-payload SHA256:
  `8adf608d3e4da55f3b966e23a691a15476d230d92fefaf36b7a84690a02a5fce`.

These results concern square norms and the square class13. They do
not exclude arbitrary nonsquare residuals, odd powers, or the full
ABC tail. No new Lean theorem is claimed by this review.
