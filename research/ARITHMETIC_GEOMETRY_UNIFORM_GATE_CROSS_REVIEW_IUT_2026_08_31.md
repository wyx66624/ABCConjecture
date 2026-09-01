# Independent mathematical review of the full rational isogeny-class argument

Author: ChatGPT, IUT-route reviewer. Date: 2026-08-31.

**Verdict:** Sections 3--7 of
`research/ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md` pass this
independent mathematical review. No correction required for those sections
was found. The result concerns the entire **rational** isogeny class and the
ordinary complex absolute value of its rational \(j\)-invariants. It does not
establish abc, a global Weil-height bound, or an assertion about an entire
\(\overline{\mathbb Q}\)-isogeny class.

The reviewed report had full-file SHA-256
`c97923a5652b8a80ff89d7ffab9ce8f64f8c40dd7361c3d0276b4cd9dc961775`
at the first hash check, and
`d0534a1a7b6a2824511a17d7a536b84548274bb9cf923a9262418d54749ad1c6`
at the final rereading. To pin the actual review scope independently of
other sections, the UTF-8, LF-normalized text starting at the heading
`## 3.` and ending immediately before `## 8.` has SHA-256
`51e6718e8edbee270138cbdfd8a6e7b8fffcbd9659c47378326368ae63c3f407`.
The reviewer did not edit the reviewed report, any Lean file, the frozen
manuscript, or the frozen validation stage.

## 1. Source and scope of the review

The complete cyclic-isogeny classification used in the report was read
directly in Balakrishnan and Mazur, *Ogg's torsion conjecture: Fifty years
later* (2025), Theorem 2.2, printed p.239 / PDF p.5, together with the
surrounding discussion on PDF pp.4--6:

* Original URL: <https://celebratio.org/media/essaypdf/636_Orig.pdf>.
* Archived file:
  `research/sources/arithmetic_geometry_gate_2026_08_31/Balakrishnan_Mazur_2025_Ogg.pdf`.
* SHA-256:
  `2c6acd3452ced7f031c446e6f54a94f09681d0e9d8ee28d199e308ad46847d6d`.
* Size: 732,299 bytes.
* The theorem page was also visually inspected in the locally rendered
  image
  `E:/AImath/abc猜想/tmp/iut_global_gate_2026_08_31/BalakrishnanMazur2025-p5.png`.

The theorem states the full cyclic-degree list

\[
 \{1,2,\ldots,19,21,25,27,37,43,67,163\}.
\]

It concerns rational cyclic isogenies of curves over \(\mathbb Q\), not
just rational torsion points or prime-degree isogenies. There is no non-CM
restriction in this statement. The preceding paragraph attributes the
extension from prime degrees to all degrees to Kenku. This review uses
that stated unconditional classification; it does not claim to have
reproved its original modular-curve arguments.

The other inputs are the usual characteristic-zero quotient and dual
isogeny theorems, the Frobenius characteristic polynomial at a prime of
good reduction, and minimality of an integral model with unit \(c_4\).
The new argument using those inputs was checked independently below.
No database enumeration, torsion conjecture, anabelian claim, or IUT
comparison is needed.

## 2. Section 3: why the composite really has cyclic \(4\ell\)-kernel

Let \(E/\mathbb Q\) have full rational two-torsion and a rational
\(\ell\)-isogeny \(\psi:E\to E'\), where \(\ell\) is odd. Choose distinct
nonzero \(T_0,T_1\in E[2](\mathbb Q)\), and use the two rational quotient
maps

\[
 \phi_0:E\longrightarrow E_0=E/\langle T_0\rangle,
 \qquad
 \phi_1:E'\longrightarrow E_1=E'/\langle\psi(T_1)\rangle .
\]

The reviewer checked each of the following necessary points.

1. Odd degree makes \(\psi|_{E[2]}\) an isomorphism. In particular
   \(\psi(T_1)\) is a rational nonzero two-torsion point and the second
   quotient is defined over \(\mathbb Q\).
2. The restriction of \(\widehat{\phi_0}\) to \(E_0[2]\) has kernel of
   order two. Since
   \(\phi_0\widehat{\phi_0}=[2]_{E_0}\), its image lies in
   \(\ker\phi_0=\langle T_0\rangle\). Cardinalities force its image to
   be exactly that group.
3. The images of the two distinct order-two subgroups under \(\psi\)
   are distinct. Thus \(\phi_1\psi\) is injective on
   \(\langle T_0\rangle\).

Consequently, for
\(\Phi=\phi_1\psi\widehat{\phi_0}\), one obtains

\[
 \ker\Phi\cap E_0[2]=\ker\widehat{\phi_0}.
\]

All isogenies are separable in characteristic zero, so
\(\#\ker\Phi=\deg\Phi=4\ell\). Its two-primary part has order four and
exactly two elements annihilated by 2. It is therefore cyclic of order
four, rather than \(C_2\times C_2\). The \(\ell\)-primary part has order
\(\ell\), hence is cyclic. These two orders are coprime, and the kernel
is an abelian group, so the full kernel is cyclic of order \(4\ell\).
This is precisely the extra property needed before invoking the
classification.

If \(\ell\ge5\), then \(4\ell\ge20\) is even, whereas every member of
the classification above 19 is odd. The remaining odd prime is
\(\ell=3\), with \(4\ell=12\) allowed. Proposition 3.1 follows. This
does not replace a stable kernel by a rational generator of that kernel.

## 3. Section 4: cyclic least degree and rational graph connectivity

### 3.1 The least-degree argument descends over \(\mathbb Q\)

For fixed rationally isogenous endpoints \(E,F\), the positive degrees
of rational isogenies \(E\to F\) form a nonempty set of positive integers,
using a dual if the given arrow is oriented oppositely. Choose a map of
least degree.

For a finite abelian geometric kernel \(H\), noncyclicity implies that
for some prime \(\ell\), its \(\ell\)-torsion has dimension at least
two over \(\mathbb F_\ell\). Since \(H[\ell]\subseteq E[\ell]\) and the
latter has dimension exactly two, it follows that

\[
                         E[\ell]\subseteq H.
\]

The quotient property of \([\ell]:E\to E\) then factors the chosen map
as \(\theta=\theta_1[\ell]\). This factor is defined over \(\mathbb Q\):
each Galois conjugate of \(\theta_1\) has the same composite with the
surjective map \([\ell]\), and uniqueness of the factor makes them
equal. Its degree is \(\deg\theta/\ell^2\), strictly smaller. This
contradicts minimality.

Thus a cyclic rational isogeny with the same endpoints exists. A cyclic
finite group has a unique subgroup of each divisor order. Since the
kernel is Galois-stable, these characteristic subgroups are Galois-stable.
A chain of such subgroups gives rational quotients with prime-degree
successive arrows, and the final quotient is rationally isomorphic to
\(F\). This proves the claimed graph connectivity.

The report correctly avoids saying that the initially given isogeny
always has such a factorization. In particular, multiplication by
\(\ell\) may have no rational prime-degree factor if \(E[\ell]\) is
irreducible. Replacing it by a map of least degree with the same
endpoints is essential and is present in the proof.

### 3.2 Absence of an odd exit is preserved by two-power isogeny

If \(\alpha:F\to E\) has two-power degree and \(\ell\) is odd, then
\(\alpha:F[\ell]\to E[\ell]\) is a Galois-equivariant isomorphism.
An invariant line in the first space would give one in the second.
The corresponding order-\(\ell\) subgroup yields a rational
\(\ell\)-isogeny by the quotient theorem. This proves Lemma 4.2
without assuming that \(F\) retains full rational two-torsion.

That final qualification matters: the three neighbors in Section 6
have only one nonzero rational two-torsion point. The proof transfers
the odd-degree exclusion through the representation isomorphism;
it does not incorrectly apply Proposition 3.1 directly to those
neighbors.

## 4. Section 5: the actual Frey family and Frobenius obstruction

The sequence \(c_n=1792n+2\), \(n\ge1\), is strictly increasing, satisfies
\(c_n\equiv2\pmod8\), \(c_n\equiv2\pmod7\), and has \(c_n\ge1794\).
The triples \((1,c_n-1,c_n)\) are positive and primitive. All three
two-torsion points of

\[
                 E_c:y^2=x(x-1)(x+c-1)
\]

are rational, and its displayed discriminant is
\(16(c-1)^2c^2\).

Modulo 7, this discriminant is nonzero and the curve reduces to
\(y^2=x^3-x\). The reviewer independently recomputed

\[
 (x^3-x)_{x=0}^6=(0,0,6,3,4,1,0)\pmod7
\]

and the affine-point multiplicities
\((1,1,0,0,2,2,1)\). There are seven affine points and one at infinity.
Thus \(a_7=0\). For the mod-3 representation, good reduction at
\(7\ne3\) gives the characteristic polynomial

\[
                        T^2+7=T^2+1\quad\text{in }\mathbb F_3[T].
\]

Neither 0 nor either of the two nonzero elements of \(\mathbb F_3\)
is a root. A rational three-isogeny would give a stable
one-dimensional subspace and hence an eigenvalue in \(\mathbb F_3\)
for this Frobenius. This contradiction proves Lemma 5.1. It does
not require any assertion about reduction at 3 itself.

Combining this result with Proposition 3.1 excludes all odd-prime
rational isogenies from the central curve, exactly as stated.

## 5. Section 6: the whole rational class, including all possible exits

For a model \(y^2=u^3+Au^2+Bu\), quotient by \((0,0)\) gives the model

\[
               Y^2=X^3-2AX^2+(A^2-4B)X .
\]

Its remaining quadratic factor has discriminant \(16B\).
The three translations of \(E_c\), putting the chosen two-torsion
point at the origin, give

\[
 (A,B)=
   (c-2,1-c),\quad
   (c+1,c),\quad
   (1-2c,c(c-1)).
\]

The first \(B\) is negative and the last two are 2 modulo 8. None is
a rational square: an integer square in \(\mathbb Q\) is an integer
square, and integer squares have residues \(0,1,4\) modulo 8.
Each quotient therefore has exactly one nonzero rational point of
order two. Its unique rational two-isogeny is the dual edge back to
the central vertex.

As a separate algebra check, the formulas

\[
 c_4=16(A^2-3B),\qquad
 \Delta=16B^2(A^2-4B)
\]

on each resulting quotient reproduce all four entries of the report:

| Curve | \(c_4/16\) | Displayed discriminant |
| --- | --- | --- |
| \(E_c\) | \(c^2-c+1\) | \(16(c-1)^2c^2\) |
| \(E_0\) | \(c^2-16c+16\) | \(-256(c-1)c^4\) |
| \(E_a\) | \(c^2+14c+1\) | \(256c(c-1)^4\) |
| \(E_b\) | \(16c^2-16c+1\) | \(256c(c-1)\) |

In particular the sign of \(\Delta(E_0)\) and the first power of
\(c-1\) in it are correct. Every curve in this table is connected
to \(E_c\) by a rational two-isogeny and has no odd-prime exit by
Lemma 4.2.

The least-degree argument now genuinely covers arbitrary rational
isogeny degrees. Any rationally isogenous endpoint has a prime-degree
path from \(E_c\). A string of two-edges cannot leave the displayed
graph. The first odd edge, if one occurred, would start at a displayed
vertex and would contradict the odd-prime exclusion there. Hence no
additional vertex exists.

This proves Theorem 6.1 for the entire rational class. It does not use
an eight-vertex upper bound as a substitute for graph completeness,
and it is unaffected by any accidental isomorphisms among displayed
vertices.

## 6. Section 7: both optimizations have the stated uniform constants

### 6.1 Minimal discriminants

Every absolute displayed discriminant in the table is at most
\(256c^5\). For an integral model, passage to a minimal model cannot
increase a prime valuation of its discriminant. Thus the absolute
minimal discriminant of every displayed curve is at most
\(256c^5\). The completed rational-class argument is what permits
using this as an upper bound on \(D_{\max}(c)\).

For the lower bound, at an odd \(q\mid c\),
\(c_4(E_0)\equiv256\pmod q\); at an odd \(q\mid c-1\),
\(c_4(E_0)\equiv16\pmod q\). Both are units. These are all possible
odd prime divisors of its displayed discriminant, so the model is
minimal at all of them.

Since \(v_2(c)=1\) and \(c-1\) is odd, the odd part of
\(|\Delta_{\mathrm{disp}}(E_0)|\) is exactly
\((c-1)(c/2)^4\). Whatever minimalization at 2 does, it cannot remove
that odd part. Therefore

\[
 D_{\max}(c)\ge|\Delta_{\min}(E_0)|
      \ge(c-1)(c/2)^4
      \ge c^5/32 .
\]

No missing 2-adic minimal-model case enters this lower bound.
Together these give
\(c^5/32\le D_{\max}(c)\le256c^5\).

### 6.2 A single complex absolute-value convention

For \(c\ge1794>32\), every polynomial in the \(c_4/16\) column is at
least \(c^2/2\). For the potentially smaller one,

\[
 c^2-16c+16-\frac{c^2}{2}
        =c(c/2-16)+16\ge0.
\]

Consequently every listed curve has \(|c_4|\ge8c^2\), and the same
ordinary complex absolute-value convention gives

\[
 |j|=\frac{|c_4|^3}{|\Delta_{\mathrm{disp}}|}
       \ge\frac{512c^6}{256c^5}=2c .
\]

This ratio is invariant under rational changes of integral model.
It is thus a bound on the \(j\)-invariant of every rational isomorphism
class, not only on the particular displayed equations.

For the opposite bound one may choose \(E_0\), since
\(0<c^2-16c+16\le c^2\):

\[
 |j(E_0)|=
   \frac{16(c^2-16c+16)^3}{(c-1)c^4}
       \le\frac{16c^2}{c-1}\le32c .
\]

It follows that \(2c\le J_{\min,\infty}(c)\le32c\). The lower bound
is uniform over the **entire** rational class; the upper bound
requires only one representative. The two extremizing representatives
for \(D_{\max}\) and \(J_{\min,\infty}\) need not coincide, and the
proof never assumes that they do.

All the \(j\)-invariants here are rational numbers. The notation
\(|j|\) consistently denotes their ordinary complex modulus, and
not the global height \(h(j)\). For \(c\ge1794\), all these absolute
values exceed 1, so
\(\min_F\log^+|j(F)|=\log J_{\min,\infty}(c)\). Squeezing between
the bounds just proved gives both limits (7.4), with values 5 and 1.

### 6.3 Quantifiers of the disproved replacement

For every fixed \(\theta>5\) and \(C>0\), choose \(n\) so large that
\(c_n^{\theta-5}>256C\). Then for **every** rationally isogenous
curve \(F\),

\[
                C|\Delta_{\min}(F)|
                   \le256C c_n^5<c_n^\theta .
\]

Thus allowing the isogenous representative to depend on the triple
does not rescue the proposed uniform lower bound. This verifies
Corollary 7.2 and its stated consequence for \(6-\delta\), \(0<\delta<1\).
It also excludes an exponent \(6-o(1)\) interpreted uniformly as
height tends to infinity: eventually that exponent exceeds any fixed
number strictly between 5 and 6.

The argument supplies no small-radical estimate for these triples.
It therefore does not refute abc, either form of Szpiro, or an
estimate combining archimedean and nonarchimedean information.
The report preserves these distinctions.

## 7. Review conclusion and boundary

No mathematical change to Sections 3--7 is required by this review.
The composite-kernel argument, minimal-degree descent, Frobenius
obstruction, completeness of the rational graph, and both numerical
bounds are valid with the hypotheses written there.

The review does not certify the report's separate modular-degree
discussion in Section 8.1, reprove the full historical rational-isogeny
classification, or assert that the new statements have been formalized.
No Lean file or frozen artifact was edited. The only new artifact
from this review is the present file.
