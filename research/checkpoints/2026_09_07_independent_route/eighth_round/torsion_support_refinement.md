# TS1--TS3. Rational two-torsion removes the exponent prime from the support

Status: complete ordinary proof independently reviewed in full by both
research peers and the root researcher. The local primary sources below
were actually opened by the author and the reviewers. This note
does not modify the frozen BC theorem. It strengthens that theorem
using the rational two-torsion of its fixed boundary curve.

Retain K, F, E_ab and E0 from BC. In particular E0 has good reduction
at every place over a rational prime greater than 3, and `(0,0)` is
a nonzero K-rational point of order two. At every split rational prime
q>3, good reduction preserves this point, so

\[
 t_q(E_0)=q+1-\#E_0(\mathbb F_q)\quad\hbox{is even}.    \tag{TS1}
\]

## Local inputs and conventions

Write `omega` for the mod-p cyclotomic character over Q_p. The
following standard local elliptic-curve facts are the only new
representation inputs.

1. For multiplicative reduction over Q_p, the full mod-p representation
   is an extension with characters `omega*eta` and `eta`, where eta
   is the unramified quadratic splitting character (possibly trivial):
   `0 -> F_p(omega*eta) -> E[p] -> F_p(eta) -> 0`.
2. For good supersingular reduction over Q_p, `E[p]` is irreducible
   as an F_p representation of G_Qp.
3. For good ordinary reduction, the connected--etale filtration gives
   characters `omega*lambda^{-1}` and `lambda`, with lambda
   unramified. With arithmetic Frobenius conventions,
   `lambda(Frob_p)=alpha mod p`, where alpha is the p-adic unit root
   of `T^2-t_p T+p`. Thus `lambda(Frob_p)=t_p mod p`.

The first two are the local descriptions in Darmon--Diamond--Taylor,
Propositions 2.12(b) and 2.11(c), respectively. Their proofs use the
Tate curve and finite-flat/formal-group structure over Z_p; the local
descriptions apply to a curve over Q_p. The ordinary unramified
quotient and its Frobenius unit root are explicitly described in
Boeckle's author lecture notes, Section 1.3.1 and Exercise 1.30.
All these passages were actually opened for this proof. No claim
about a two-dimensional unramified Frobenius trace at p is used.

The supersingular input here only states irreducibility over F_p.
We do not silently strengthen it to absolute irreducibility. Instead,
for an F_p-valued character theta, existence of a theta-submodule
after extending coefficients to Fbar_p implies existence over F_p:
the intertwining maps are the kernel of linear equations over F_p,
and tensoring with Fbar_p preserves that kernel. All the representations
in this argument have finite image, so a finite set of equations
suffices. This observation handles the coefficient extension explicitly.

## TS1. A conditional boundary theorem with no exponent-prime exception

**Theorem.** Let a,b be positive coprime integers and p>7 prime.
Let nu be a quadratic character of G_K unramified outside primes
over 6. Suppose the full module isomorphism

\[
 E_{a,b}[p]\otimes\overline{\mathbb F}_p
 \simeq(E_0[p]\otimes\overline{\mathbb F}_p)\otimes\nu  \tag{TS2}
\]

holds. Then p does not divide F(a,b), and every prime q dividing
F(a,b) satisfies

\[
 q\ge(\sqrt{2p}-1)^2>p.                                \tag{TS3}
\]

At every such q, without an exception for q=p, one also has

\[
 p\mid(q+1)^2-t_q(E_0)^2.                              \tag{TS4}
\]

**Proof of p not dividing F.** Suppose p divides F. The actual FM
local theorem shows that p splits in K, each completion is Q_p,
and the actual curve is multiplicative at each place. Work at one
completion. The character nu is unramified and quadratic there.

The actual Tate representation has an F_p-valued subcharacter
`omega*eta`. Under (TS2), after cancelling nu, this gives a
subcharacter `omega*eta*nu` of E0[p] after coefficient extension.
This character has F_p values, since both eta and nu are quadratic.
The base-change observation above therefore gives a subcharacter
over F_p itself. The good boundary curve cannot be supersingular
by local input 2. It must have ordinary reduction.

For ordinary E0[p], local input 3 gives Jordan--Holder characters
`lambda` and `omega*lambda^{-1}`. After twisting by nu they are
`lambda*nu` and `omega*lambda^{-1}*nu`. The corresponding actual
Tate characters are `eta` and `omega*eta`. Since omega is nontrivial
on inertia and all of lambda, eta, nu are unramified, exactly one
character in each pair is trivial on inertia. The module isomorphism
therefore identifies

\[
 \lambda\nu=\eta,\qquad t_p(E_0)\equiv\pm1\pmod p.     \tag{TS5}
\]

This identification is valid even if either extension splits; it is
the unique inertia-trivial Jordan--Holder character that is compared.
It does not compare a nonexistent unramified trace of the whole Tate
module at p.

On the other hand, (TS1) says that the integer t_p is even. The Hasse
bound and p>7 give `|t_p|<=2sqrt(p)<p-1`. The only integers in this
interval congruent to 1 or -1 modulo p are 1 and -1, both odd.
This contradiction proves that p does not divide F.

**Proof of the cutoff.** Every prime q dividing F is now different
from p. The full BC argument gives
`t_q congruent to +(q+1) or -(q+1) mod p`. Both t_q and q+1 are
even. The corresponding nonzero integer difference is therefore
divisible by 2p. It is nonzero by the strict Hasse inequality
`|t_q|<=2sqrt(q)<q+1`, and its absolute value is at most
`q+1+2sqrt(q)`. Consequently

\[
 2p\le(\sqrt q+1)^2,
\]

which gives the first inequality in (TS3). The second follows from
`p+1>2sqrt(2p)` for p>7; after squaring this is `p^2-6p+1>0`.
Condition (TS4) is precisely the BC trace condition, now applicable
to every divisor because p is excluded. This proves the theorem.

The theorem is conditional only on the displayed boundary module
isomorphism. It does not use the full-Sturm modular identity or any
newform enumeration for its local proof.

## TS2. Unconditional support for the actual pure-power branch

**Corollary.** If a,b are positive coprime integers, p>7 is prime,
and `F(a,b)=Q^p` with integer Q>1, then p does not divide Q and
every q dividing Q satisfies (TS3) and (TS4). Neither 7 nor 13
divides Q. In particular,

\[
 Q\ge(\sqrt{2p}-1)^2>p.                                \tag{TS6}
\]

**Proof.** BT3, using the full-Sturm identity, the independently
identified boundary system, the complete five-space enumeration,
and the CM projective-image exclusion, supplies (TS2) with one of
four quadratic characters unramified outside 6. Apply TS1 and the
already proved BC exclusions at 7 and 13.

For every sufficiently large fixed p, every prime factor now lies
in the BC permitted split rational-prime support, of density
`(2p^2-p-5)/(2(p-1)^2(p+1))`. There is no remaining exponent-prime
exception. Removing a finite initial interval does not alter this
fixed-p density. The density still provides no uniform error term.

## TS3. Height consequence and precise limitation

Set `c=a+b` and `H=max(a,b)`. Since F<=c^4 and F<=13H^4,
the exact root inequality (TS6) gives

\[
 \log c\ge\frac p2\log(\sqrt{2p}-1),\qquad
 \log H\ge\frac p2\log(\sqrt{2p}-1)-\frac{\log13}{4}.  \tag{TS7}
\]

In particular `p^p<F<=13H^4`. These are necessary lower bounds
on the height of any actual pure-power seed. They are compatible
with arbitrarily large seeds and with moving large root primes;
they do not furnish a point-height upper bound, a contradiction to
the Kummer cover coefficient budget, or a proof of ABC.

The finite local residue shadows considered in BS and CB still exist.
They are not global pure powers and do not contradict the global
representation implication used to obtain (TS2).

## Primary sources actually checked

* H. Darmon, F. Diamond and R. Taylor, Fermat's Last Theorem,
  Propositions 2.11(c), 2.12(b), and the adjacent local discussion.
  Author-hosted PDF, PDF page 57:
  https://www.math.mcgill.ca/darmon/pub/Articles/Expository/05.DDT/paper.pdf .
* G. Boeckle, author lecture notes, Section 1.3.1 and Exercise 1.30,
  PDF page 13, the ordinary connected--etale sequence and its
  Frobenius unit root:
  https://math.uni.lu/wiese/galois/Boeckle-Luxemburg-Notes.pdf .

The author actually opened both passages. Both independent peers and
the root researcher subsequently completed full-note ordinary review
with PASS, including the source hypotheses and the final TeX transfer.
None of the local elliptic representation inputs is yet fully
formalized in Lean by this checkpoint.
