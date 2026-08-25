# Frey node quotients by full two-torsion: exact conservation after inertia

## 1. Result and verdict

Let `p` be odd and let a Frey curve have multiplicative reduction of type
`I_(2e)` at `p`.  The full rational two-torsion does **not** give a larger
free dihedral action on the `2e` nodes.  One nonzero two-torsion translation
fixes every node and acts nontrivially on its two tangent directions.  The
other two nonzero translations induce the same half-polygon permutation.
Together with inversion, the effective permutation group is only a Klein
four group.

If one forgets tangent inertia and takes only the coarse node-orbit set, its
degree is

```text
ceil(e/2),
```

and its functions modulo constants have rank

```text
r_e = ceil(e/2)-1.                                  (1.1)
```

Thus the coarse rank is indeed smaller than the inversion-only rank `e-1`.
This is not a new compression of discriminant contact.  There are three
exact ways to see the missing mass:

1. The discarded sign-character piece has rank `floor(e/2)`, and

   ```text
   e-1 = (ceil(e/2)-1) + floor(e/2).                (1.2)
   ```

2. The node-fixing translation has local quotient

   ```text
   R[[x,y]]/(xy-pi)  -->  R[[X,Y]]/(XY-pi^2),
   ```

   so desingularization doubles every ordinary coarse quotient node.  The
   direct coarse quotient `X/G` has, before optional contractions of its
   genus-zero special fiber,

   ```text
   2 floor(e/2) = e - (e mod 2)                    (1.3)
   ```

   resolved nodes.  In the odd case the one missing orbit is precisely a
   branch-swapping fixed node whose quotient is smooth; its information is
   ramification, not a quotient node.

3. On the generic elliptic curve, quotient by all translations is `[2]`:

   ```text
   E/E[2] isomorphic to E.
   ```

   Its minimal multiplicative discriminant exponent is therefore still
   `2e`.  After also quotienting by inversion, the generic quotient is
   genus zero and the same exponent occurs in the collision discriminant of
   the four branch points.

Consequently the V4/"dihedral" shortcut produces no asymptotic decrease of
the node-excess coefficient once quotient singularities, regularization,
ramification, or the complementary character are retained.  This is a
local conservation theorem, not an abc proof.

The companion Lean file formalizes an abstract finite action model, both
parity identities, cardinality and arithmetic-degree conservation for
modules defined with the paper-predicted ranks, the resolved node-count
scalar, and the average contact identity for the three cyclic two-isogenies.
It does not construct the actual quotient or its character submodules.  All
model-theoretic statements below remain paper mathematics.

## 2. Which model contains the nodes

The Neron model is smooth.  Its special fiber has a component group, but it
does not contain the crossing points of the polygon.  The `2e` nodes belong
to the special fiber of the **proper minimal regular model** `X`.  Thus
"Neron polygon nodes" is harmless shorthand only if this distinction is
kept explicit.

A rational translation extends canonically on the Neron model.  Its action
on the proper regular model can be read on the Tate polygon.  Quotienting a
smooth Neron model, quotienting the proper model, normalizing a coarse
quotient, resolving its singularities, and passing to a relatively minimal
model are different operations.  They need not commute.  The apparent
extra factor two is lost precisely when these operations are conflated.

## 3. Split Tate calculation

Work first over a complete strictly henselian DVR `R` of residue
characteristic not two.  Let `q` be a Tate parameter with

```text
v(q)=n=2e.
```

Full two-torsion permits a choice `delta^2=q`.  In multiplicative notation,

```text
E_q[2] = {1, P_mu=[-1], P_+=[delta], P_-=[-delta]}.
```

Write

```text
a     = translation by P_mu,
h     = translation by P_+,
ah    = translation by P_-,
sigma = group inversion [-1].
```

Here `a` and `sigma` are different automorphisms: `a([u])=[-u]`, whereas
`sigma([u])=[u^(-1)]`.

Over the algebraic residue field, normalize the `I_(2e)` fiber as copies
`C_i` of `P^1`, indexed by `i` modulo `2e`.  Let `s_i` be the node joining
`C_i` to `C_(i+1)`.  The actions are

```text
sigma(C_i)=C_(-i),          sigma(s_i)=s_(-i-1),
a(C_i)=C_i,                 a(s_i)=s_i,
h(C_i)=C_(i+e),             h(s_i)=s_(i+e).        (3.1)
```

The translation `ah` has the same component and node permutation as `h`.
The first line follows because inversion exchanges zero and infinity on
each normalized component.  The second and third follow from the valuation
classes `0` and `e` of `-1` and `delta`.

All two-torsion points equal their negatives, so inversion centralizes their
translations.  Hence the abstract affine group is

```text
G = E[2] x <sigma> isomorphic to C_2^3,             (3.2)
```

not a nonabelian dihedral group.  Its permutation image on the polygon is

```text
H = <h,sigma> isomorphic to V4 = D_2.              (3.3)
```

The kernel contains `a`.  In particular, rational two-torsion supplies only
a half-turn, not a component-one rotation generating the full dihedral
group of the `2e`-gon.

For comparison with the Lean encoding, there is an explicit conjugacy from
`Fin e x Bool` to the geometric nodes:

```text
phi(j,false)=j,             phi(j,true)=2e-1-j.    (3.4)
```

Under `phi`, inversion toggles the Boolean coordinate and the half-turn is
`(j,b) |-> (e-1-j,!b)`.  The companion Lean file proves identities inside
this paired model, but does not formalize `phi` or its conjugacy with the
actual Tate polygon.

## 4. Burnside count and the exceptional odd orbit

The `H`-orbit of a node label `i` is

```text
{i, i+e, -i-1, e-i-1}.                             (4.1)
```

The half-turn `h` has no fixed node.  Inversion `sigma` has no fixed node,
because `2i=-1 mod 2e` is impossible.  The other reflection `h sigma` is
fixed at a node precisely when

```text
2i = e-1 mod 2e.                                   (4.2)
```

If `e` is even, (4.2) has no solution.  Every orbit has four elements and
there are `e/2` orbits.  If `e` is odd, (4.2) has two solutions differing by
`e`; together they form one two-element `H`-orbit.  The other orbits have
four elements, so the total is `(e+1)/2`.  Thus

```text
#(nodes/H) = ceil(e/2).                             (4.3)
```

The stabilizer inside the full group `G` is `<a>` at every ordinary node.
For odd `e`, the two exceptional nodes have stabilizer
`<a,h sigma>`.  At either exceptional node, `h sigma` exchanges the two
branches.  Therefore the orbit counted in (4.3) is not a node of the
regularized surface quotient; Section 6 computes its regular local quotient.

Small cases are useful checks:

```text
e                 1   2   3   4
# coarse H-orbits  1   1   2   2
# ordinary orbits  0   1   1   2
# exceptional      1   0   1   0.
```

For `e=1`, the `I_2` graph has two vertices and two parallel edges; this
prevents the usual simple-cycle drawing from hiding the exceptional orbit.

## 5. Exact character conservation

First quotient only the finite node scheme by inversion.  It has degree
`e`.  The half-turn descends to an involution `rho` of these `e` points.  It
has one fixed point when `e` is odd and none when `e` is even.  Hence the
permutation algebra has invariant dimension `ceil(e/2)`.

Let `k` have odd characteristic and put

```text
M = k^(nodes/<sigma>) / k.
```

The idempotents `(1+rho)/2` and `(1-rho)/2` give

```text
M = M^+ direct_sum M^-,
dim M^+ = ceil(e/2)-1,
dim M^- = floor(e/2).                               (5.1)
```

Therefore

```text
dim M = e-1
      = dim M^+ + dim M^-.                         (5.2)
```

The parity form requested by the coarse quotient calculation is

```text
e-1 = 2(ceil(e/2)-1) + indicator(e even).           (5.3)
```

Over `F_p`, (5.2) becomes the exact cardinality and arithmetic-degree
identities

```text
#M = #M^+ #M^-,
(e-1)log p
  = (ceil(e/2)-1)log p + floor(e/2)log p.           (5.4)
```

Thus retaining only `M^+` literally discards a character piece of linear
size.  At a fixed prime it is unbounded as `e` grows, so reduced support,
Tamagawa data, or a constant-depth congruence cannot bound it.

For a global Frey profile, define

```text
E_plus  = sum_p (ceil(e_p/2)-1) log p,
R_even  = sum_(p : e_p even) log p,
E       = sum_p (e_p-1) log p.
```

Also write `R_bad=sum_p log p` for the odd reduced bad-prime weight.  Then

Then (5.3) gives the exact identity

```text
E = 2 E_plus + R_even.                              (5.5)
```

So a radical-scale upper bound for `E_plus` would be a legitimate formal
interface, but not a free consequence of taking invariants.  For example,
the slope-six target

```text
E <= (2+eps/2) R_bad + C
```

is exactly equivalent to

```text
E_plus <= (1+eps/4)R_bad - R_even/2 + C/2.         (5.6)
```

No estimate of the form (5.6) is supplied by the quotient construction.
It still requires a cross-prime global theorem of Szpiro strength.

## 6. Tangent inertia and desingularization

At an ordinary node, the completed strict henselian local ring is

```text
A = R[[x,y]]/(xy-pi).
```

The identity-component translation is invisible on the dual graph but acts
on the two branches by

```text
a(x,y)=(-x,-y).                                    (6.1)
```

Because two is invertible, its invariant ring is

```text
A^<a> = R[[X,Y]]/(XY-pi^2),
X=x^2, Y=y^2.                                      (6.2)
```

This is the thickness-two `A_1` surface singularity.  Its minimal
desingularization inserts one exceptional component and replaces the thick
intersection by two ordinary nodes.  Therefore every ordinary `G`-orbit in
Section 4 contributes two resolved nodes, not one coarse node.

At the exceptional odd orbit a reflection exchanges the branches.  After a
unit rescaling it has the form

```text
r(x,y)=(lambda y, lambda^(-1)x).                   (6.3)
```

Writing `t=x+lambda y`, one obtains

```text
A^<r> = R[[t]],                                    (6.4)
```

which is regular.  Quotienting simultaneously by `a` is still regular; one
may use the invariant `x^2+lambda^2 y^2`.

Here is the complete local-algebra check.  Put `z=lambda y`.  Then
`xz=lambda pi`, and `x,z` are the two roots of

```text
U^2-tU+lambda pi.
```

Thus `A` is free of rank two over `R[[t]]`, with basis `1,x`, and the
reflection sends `x` to `t-x`.  Since `2` is a unit and `A` is a domain, a
fixed element `b_0+b_1 x` has `b_1=0`.  This proves (6.4), rather than merely
counting tangent eigenvalues.  On `R[[t]]`, the residual action of `a` is
`t |-> -t`, so the simultaneous invariant ring is `R[[t^2]]`, again
regular.  Equivalently, `t^2` differs from
`x^2+lambda^2 y^2` by the base element `2 lambda pi`.  Hence the exceptional
coarse node orbit is folded to a smooth ramification point.

There are no omitted quotient singularities on the smooth locus.  At a
smooth fixed point a nontrivial tame reflection has completed transverse
coordinate action `t |-> -t`; its invariant ring is `R[[t^2]]`.  Free
orbits are etale-locally regular.  Therefore the node stabilizers listed in
Section 4 account for all singularities relevant to the displayed quotient
fiber.

It follows that the minimal **local desingularization of the coarse
quotient**, before any later contraction of vertical components, has

```text
2 floor(e/2)
```

nodes.  Equivalently,

```text
2 floor(e/2) + (e mod 2) = e.                      (6.5)
```

The odd parity term is the branch-swapping orbit.  Thus tangent inertia
restores all of the apparent factor-two saving, up to one radical-weighted
unit which ramification records exactly.

After inversion the generic quotient has genus zero, so further vertical
contractions can change the raw number of nodes.  Consequently quotient
node count by itself is not an invariant of the generic quotient.  The
intrinsic replacement is the marked double cover and its discriminant line.
A numerical polynomial discriminant still depends on an integral
coordinate/trivialization; Section 8 fixes the primitive Frey coordinate
before taking its valuation.

## 7. Translation quotients and the three local isogenies

Assume in this section that the curve is split over the local field and that
`delta` belongs to that field, so the full two-torsion displayed in Section
3 is rational.  The Tate parameter then gives an independent check of the
local calculation:

```text
E_q/<P_mu>  isomorphic to E_(q^2),
  [u] |--> [u^2],                 type I_(4e);

E_q/<P_+>   isomorphic to E_delta,
  [u]_q |--> [u]_delta,           type I_e;

E_q/<P_->   isomorphic to E_(-delta),
                                      type I_e.     (7.1)
```

The first quotient doubles contact because its kernel lies in the identity
component.  The latter two halve contact because their kernels meet the
order-two component.  Their three minimal discriminant exponents satisfy

```text
4e + e + e = 3(2e).                                (7.2)
```

Thus even the average over all three cyclic quotients preserves the original
contact exactly.

Quotienting by the whole translation group gives

```text
E_q/E_q[2] isomorphic to E_q                       (7.3)
```

via the quotient map `E_q -> E_q/E_q[2]` followed by the canonical target
identification under which that map is `[2]`.  On the coarse graph, the
half-turn first seems
to replace `I_(2e)` by `I_e`, but each of those `e` nodes has `<a>` inertia.
Resolving (6.2) replaces it by two nodes, returning exactly `I_(2e)`.

This also separates the generic quotient from its models.  Under the stated
split/rationality hypotheses, the generic identity (7.3) says that the
minimal regular elliptic target has the original Kodaira type.  Without a
ground-field square root of `q`, (7.1) is only a geometric calculation until
the two component kernels and their quotient parameters are descended.  A
naive coarse quotient of the source polygon is not the minimal regular
model of the generic target.

## 8. Adding inversion: genus zero and the branch discriminant

After the translation quotient, inversion descends to inversion on the
target elliptic curve.  Hence

```text
E/(E[2] x <sigma>) isomorphic to E/<sigma>,         (8.1)
```

which is a genus-zero curve.  For the Frey model

```text
E : y^2=x(x-a)(x+b),       a+b=c,
```

the quotient map is the `x`-map and its branch divisor on `P^1` is

```text
{infinity, 0, a, -b}.
```

Represent it by the binary quartic

```text
F(X,Z)=Z X (X-aZ)(X+bZ).
```

The product of the six pairwise determinants of its four linear factors,
squared, is

```text
Disc(F)=a^2 b^2 c^2.                               (8.2)
```

At an odd prime dividing exactly one of `a,b,c`, with exponent `e`, this has
valuation `2e`, exactly the old `I_(2e)` contact.  The elliptic discriminant
is `16 Disc(F)`, so its odd valuation is the same.

The generic `G`-quotient map can be written `x o [2]`.  Multiplication by
two is etale on the characteristic-zero generic fiber, and the branch values
remain the four images of the target `E[2]`.  Thus (8.2) is unchanged.  A
node smoothed by (6.4) has not vanished arithmetically; it has moved into the
collision/ramification divisor of the marked genus-zero quotient.

## 9. Split versus nonsplit multiplicative reduction

For nonsplit multiplicative reduction, pass to the unramified quadratic
extension over which the torus splits.  The geometric fiber is still the
same `I_(2e)` polygon, and the descent involution reverses it.  Because the
Frey two-torsion points and all the quotient maps above are defined over the
ground field, their geometric actions commute with descent.

Unramified base change preserves the normalized multiplicative
discriminant exponent.  Since `p` is odd, the group order is invertible and
the Reynolds projector shows that finite-group invariants commute with this
unramified flat base change.  The geometric minimal resolutions of the tame
quotient singularities are unique, hence Galois-equivariant.  Therefore:

1. the formulas (3.1), orbit sizes, and stabilizer sizes hold geometrically;
2. the local invariant rings (6.2)--(6.4) descend, possibly as nonsplit
   forms, with the same geometric resolution and degree counts;
3. the quotient map `E -> E/E[2]`, after the canonical identification of
   its target with `E`, is still `[2]`, so its minimal type and exponent
   remain those of `E`;
4. the Frey branch divisor is rational and (8.2) is unchanged.

Individual components or nodes need not be residue-field rational.  This
affects their fields of definition and rational Tamagawa number, but not the
geometric degree or the `p`-weighted arithmetic degree of the descended
finite scheme.  No claim is made that each node or exceptional component is
itself rational over the residue field.  Residue characteristic two is
excluded: the idempotent character splitting and the tame quotient-ring
calculation both fail there.

## 10. Why choosing a lowering leaf globally does not contract uniformly

At every odd bad prime, exactly one of the three rational order-two kernels
is the identity-component kernel and doubles the local exponent; the other
two halve it.  For the Frey roots one has

```text
p divides a : identity kernel (-b,0),
p divides b : identity kernel (a,0),
p divides c : identity kernel (0,0).               (10.1)
```

This agrees with the three quotient discriminants

```text
256 a b c^4,       256 a c b^4,       256 b c a^4.
```

At odd primes their logarithmic discriminants sum to three copies of the
original odd discriminant, prime by prime.  At every such multiplicative
prime, the corresponding displayed `c_4` is a unit, so these displayed
models are already minimal there.  A globally fixed kernel cannot
choose one of the two lowering directions independently at every prime.

There is not even a uniform contraction after choosing the best of the three
global leaves.  For

```text
(a,b,c)=(4k+1, 4k+2, 8k+3),
```

the triple is primitive and the odd logarithmic sizes of `a`, `b`, and `c`
are all asymptotic to `log k` (the odd part of `b` is `2k+1`).  If these
three weights are `A,B,C`, the quotient logs are

```text
A+B+4C,   A+C+4B,   B+C+4A,
```

while the original is `2(A+B+C)`.  The ratio of the best quotient log to
the original tends to one.  Hence no fixed positive contraction factor can
come merely from choosing among the three rational two-isogenies.  Moreover
`v_2(b)=1` in this family, so the omitted binary/minimal-model correction is
uniformly bounded and cannot alter that limiting ratio.

The only surviving positive interface is therefore a genuinely global
upper bound such as (5.6), or equivalently an Arakelov/branch/intersection
bound that controls the complementary character and ramification terms.
The quotient algebra supplies their exact lower degrees but no such upper
bound.  Any proof of it must be audited for hidden Szpiro, abc, Vojta, or
truncated-counting input.

## 11. Lean boundary

`IUTThreeClosures/NeronNodeDihedralConservation.lean` proves:

1. an explicit paired-node model for the commuting inversion and half-turn;
2. fixed-point freeness of each generator and the odd middle fixed pair of
   their product;
3. arithmetic of the scalar `(e+1)/2` which the paper Burnside calculation
   identifies with the coarse orbit count;
4. the exact conservation and parity identities for the two ranks prescribed
   by (5.1), and abstract finite function modules having those ranks;
5. cardinality and arithmetic-degree conservation for those abstract modules
   over `ZMod p`;
6. the resolved-node scalar identity (6.5);
7. the three-isogeny contact average (7.2).

In particular, the completed invariant-ring and normalization arguments of
Section 6 are entirely paper-only; Lean contains only their resulting
finite rank and parity ledger.

Lean also does not formalize the conjugacy from `PairedNode e` to the actual
`2e` polygon nodes, a quotient type, Burnside's lemma in this action, the
idempotents `(1+rho)/2` and `(1-rho)/2`, or an identification of the abstract
modules with genuine invariant/anti-invariant subspaces.

The file does not formalize Tate uniformization, rationality of local two-torsion,
Kodaira classification, proper regular models, extension of translations,
completed invariant rings, quotient existence, singularity resolution,
Neron models, nonsplit descent, isogenies, binary-quartic discriminants,
Szpiro, or abc.  None of these paper statements is hidden in a structure
field or axiom.
