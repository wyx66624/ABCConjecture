# Independent review of the full-lattice hull and prime-window theorem

**Author:** ChatGPT  
**Date:** 2026-08-30  
**Reviewed report:** `research/IUT_PRIME_WINDOW_INTEGRAL_HULL_2026_08_30.md`.  
**Disposition:** the exact hull, rounding threshold, and stated conditional prime-window obstruction pass independent mathematical review. Full integral-lattice automorphism reachability is indispensable and is not established here for a narrower Galois-induced source family.

No existing report or source file was modified in this review. This is a mathematical cross-review, not a Lean formalization of local field theory or IUT.

## 1. Sources and the precise scope of the check

I reread the archived original text of [Joshi III, v4](https://arxiv.org/pdf/2401.13508v4), pp. 112–113, Proposition 9.7.5.1, together with [Joshi II-half, v12](https://arxiv.org/pdf/2305.10398v12), pp. 48–49, Propositions 7.4.1 and 7.5.1. The former describes collation using topological group isomorphisms supplied by the latter. The latter proves an amphoricity/isomorphism assertion through Galois groups. These passages must not be replaced, without further argument, by a theorem that every integral logarithmic-lattice automorphism is induced by an allowed Galois-group isomorphism.

The other source formulas were checked in the preceding independent review: [IUT IV, April 2020](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf), Propositions 1.2 and 1.4, pp. 10–14; the three-slot/procession convention, pp. 26–27; [Joshi III](https://arxiv.org/pdf/2401.13508v4), normalized logarithmic coefficient, p. 110, background unit norm, p. 117, and integral-hull convention, section 9.10.7; [Joshi IV, v2](https://arxiv.org/pdf/2403.10430v2), normalized Tate quantity, pp. 51–52, and Theorem 5.7.1's prime window, p. 53.

Accordingly, the theorem under review has an explicit local model: all integral `Z_p`-linear automorphisms of one native logarithmic lattice are allowed, after coherent field markings. A repeated source label uses the same map in each occurrence. The theorem is valid for that model. Whether that model is the correct source construction is a separate question.

## 2. The minimum-layer lemma lifts correctly

Let `E/Q_p` be finite Galois, with ramification index `e<=p-2`, and let `v(p)=1`. Set

\[
 \kappa=1-1/e,\qquad
 I=p^{-1}\log(\mathcal O_E^\times)=\pi^{1-e}\mathcal O_E.
\]

The lattice identity is valid: `1/e>1/(p-1)` puts all of the maximal ideal in the convergence range where logarithm and exponential are inverse. The prime-to-`p` Teichmuller units have logarithm zero. Thus the least valuation in `I` is `-kappa`, and the least valuation in `pI` is `1-kappa=1/e`.

For

\[
 u=\log(1+p)/p,\quad \tau=\log(1+pa)/p,
 \quad r=v(a)>0,\quad k=\lfloor r+\kappa\rfloor,
\]

the first-term logarithm estimate gives `v(u)=0` and `v(tau)=r`. Therefore

\[
 u\in I\setminus pI,\qquad
 \tau\in p^kI\setminus p^{k+1}I.
\]

Here `k>=0`, so `y=tau/p^k` belongs to `I` and is primitive as a vector of its free `Z_p`-module. There is no assumption that `y` is a unit of `O_E`.

For any two primitive `x,y in I`, write `V=I/pI`, a vector space of dimension `d=[E:Q_p]`. Both reductions are nonzero. Each of the two annihilator hyperplanes in `V^*` has `p^(d-1)` elements. Since `p>2`, their union has fewer than `p^d` elements, so there is a functional `l` nonzero on both vectors.

The quotient `V -> I/pi I` is well-defined and surjective because `pI subset pi I`. Fix any nonzero `F_p`-linear coordinate on `I/pi I` and denote its composition with this quotient by `l_0`. Both `l_0` and `l` are nonzero. Extending a basis of each kernel by a vector of value one gives an invertible map `A:V->V` satisfying `l_0 A=l`.

Choose a `Z_p` basis of `I`. Any lift of the entries of the matrix of `A` has determinant a `p`-adic unit and is therefore in `GL_d(Z_p)`. The resulting automorphism `F` of `I` satisfies

\[
 F(x),F(y)\notin\pi I,\qquad
 v(F(x))=v(F(y))=-\kappa.
\]

This proves the asserted lift. It is important to use a coordinate of `I/pi I`, rather than just an arbitrary target coordinate in `I/pI`: nonzero reduction modulo `pI` alone would prove primitivity, not attainment of the least native valuation.

Taking `x=u` and `y=tau/p^k` produces a single `F` with

\[
 v(F(u))=-\kappa,\qquad v(F(\tau))=k-\kappa.
\]

The second equality uses `Z_p`-linearity and `k>=0`. No independent transformation of repeated labels is required.

## 3. The exact fractional hull follows in both directions

Let `m>=1`, let `T_m` be the tensor product over `Q_p` of `m` copies of `E`, and let `B_m` be its maximal order. In the Galois decomposition, each field component is a copy of `E` and a pure tensor maps to a product of Galois conjugates of its entries.

For every allowed map, each background lies in `I`, while the theta coordinate lies in `p^k I`. The product of these lattices is closed and nonarchimedean convex. Hence taking the specified convex closure does not lose these individual bounds. Every field component of every subsequent tensor-image point has valuation at least

\[
 \beta=(k-\kappa)+(m-1)(-\kappa)=k-m\kappa.
\]

The fractional `B_m`-ideal `p^beta B_m` therefore contains the entire image and its module hull.

For the common `F` constructed above, the actual permitted tuple gives

\[
 t_F=F(u)\otimes\cdots\otimes F(u)\otimes F(\tau).
\]

Every component has valuation exactly `beta`. The reason is that the field embeddings in the tensor decomposition preserve the unique native extension of `v_p`. This does **not** assume that `F` itself preserves native valuations; indeed it generally does not. Every component is nonzero, and therefore

\[
 t_FB_m=p^\beta B_m.
\]

Since a `B_m`-module hull containing `t_F` contains this ideal, the reverse inclusion holds. Thus

\[
 H_m^{\mathrm{frac}}=p^{\lfloor r+\kappa\rfloor-m\kappa}B_m.
\]

This also proves existence of the compact fractional hull. If an alternative definition only permits integral ideal generators, its hull exists for this set exactly when `beta>=0`; when `beta<0`, the exhibited image point is already outside `B_m` and cannot lie in any such integral product ideal.

The argument remains valid if the collation also allows separate maps for some nonrepeated labels, provided they preserve the same lattice contents: the upper bound remains unchanged, and the common-`F` configuration is still allowed. It does not require such additional freedom.

## 4. Rounding and the prime-window implication have the correct direction

The exact integrality condition is

\[
 \lfloor r+\kappa\rfloor\ge m\kappa
 \quad\Longleftrightarrow\quad
 r\ge\lceil m\kappa\rceil-\kappa.
\]

Indeed, the integer on the left is at least the real number `m*kappa` exactly when it is at least its ceiling. An inequality `floor(x)>=N` for an integer `N` is equivalent to `x>=N`. The alternative displayed threshold also checks:

\[
 \lceil m(1-1/e)\rceil-\kappa
 =m-1-\lfloor m/e\rfloor+1/e.
\]

In particular, integrality **necessarily** implies
`r>=(m-1)*kappa`. This is the direction needed in the application. A sufficient integrality criterion has not been promoted to a necessary one.

Now let `ell>=7`, take the largest procession block `m=(ell+1)/2`, and suppose

\[
 a^{2\ell}=q,\quad n=v_p(q)>0,\quad
 r=n/(2\ell),\quad Q\ge n\log p,\quad \ell^2\ge Q.
\]

If that largest hull is integral, its necessary threshold gives

\[
 n\ge\ell(\ell-1)\kappa.
\]

Combining the two global inequalities, and dividing only by positive quantities, gives

\[
 \kappa\log p\le\frac{\ell}{\ell-1}.
\]

When `p>=7` and `e>=3`, the left side is at least `(2/3)log7`, whereas the right side is at most `7/6`. The former is strictly larger. An exact check avoiding numerical approximations is
`exp(1)<3` and `3^7=2187<2401=7^4`; hence `log7>7/4` and `(2/3)log7>7/6`.

Thus the largest hull itself is not integral under these hypotheses. A fortiori the whole procession cannot have all its local hulls integral.

The condition `Q>=n log p` is justified for a rational split multiplicative place and the normalized Tate quantity used in Joshi IV: after passing to a number field `L`, its contribution is

\[
 \frac1{[L:\mathbb Q]}
 \sum_{w\mid p} n e_w f_w\log p=n\log p.
\]

All other Tate contributions are nonnegative. The inequality `ell^2>=Q` is precisely the lower endpoint of the prime window. No assertion about a pointwise quantity has been inferred from an unrelated average.

## 5. The indicated rational Frey specialization passes

At an odd multiplicative prime of a primitive Frey equation,

\[
 n=v_p(\Delta_{\min})=2v_p(a_{\rm Frey}b_{\rm Frey}c_{\rm Frey})
\]

is even: pairwise coprimality makes `c4` a unit, and the displayed Frey discriminant is minimal at that prime.

For split multiplicative reduction at `p` prime to `30ell`, the full division field has ramification index

\[
 e=\frac{30\ell}{\gcd(30\ell,n)}.
\]

The Tate parametrization and unramified extraction of prime-to-`p` unit roots justify this equality, not just a denominator divisibility. Adjoining `i` is unramified at odd `p`. Since `30ell` has exactly one factor of 2 and `n` is even, this `e` is odd. If ramified, it is at least 3. Also `p>=7`, since `p` is prime to `30ell`.

The specialization separately retains `e<=p-2`. It cannot deduce that inequality from tameness alone. Conversely, the standing level condition excludes `ell=5`: the field containing all 30-torsion has trivial mod-5 representation, which cannot contain `SL_2(F_5)`. With the usual prime condition `ell>=5`, this leaves `ell>=7`.

These facts supply exactly the hypotheses used in section 4. The conclusion concerns this ramified, small-ramification, full-lattice-automorphism native model. Neither wild primes nor `p|30ell` nor larger ramification indices are covered.

## 6. A concrete check that the arrow restriction matters

The following local example shows why the exact hull formula cannot be transferred to an unspecified smaller group of maps.

Take `p=7` and `E=Q_7(pi)` with `pi^3=7`. The field `Q_7` contains the cube roots of unity, so `E/Q_7` is Galois of degree 3. Here `e=3<=5`, `kappa=2/3`. Put `a=pi`, so `r=1/3`, `k=1`, and take `m=2`.

For all `Aut_{Z_7}(I)`, the proved formula gives

\[
 H_2^{\mathrm{frac}}=7^{-1/3}B_2,
\]

which is not integral. Restrict instead to the actual field-marking maps
`Gamma=Gal(E/Q_7)`, using the same map on both slots. They fix
`u=log(8)/7` and preserve the valuation `1/3` of `tau`. Every tensor
component of every orbit point has valuation `1/3`. Convex closure
cannot lower it, and any one such point generates the full product
ideal of that valuation. The corresponding hull is therefore

\[
 H_{2,\Gamma}^{\mathrm{frac}}=7^{1/3}B_2,
\]

which is integral and differs from the full-automorphism hull.

This example does not identify all possible Galois-induced arrows with
field automorphisms. It demonstrates the precise logical issue: the
result for the maximal integral linear automorphism group supplies no
necessity result for an arbitrary smaller allowed group. The common
minimum-layer automorphism must be proved admissible in that group.

The reviewed report maintains this distinction. With it retained, there
is no mathematical correction required in the exact hull or prime-window
argument. The result restricts one concrete local interpretation and
does not disprove IUT, establish the failure of a source's actual global
hull, or resolve ABC.
