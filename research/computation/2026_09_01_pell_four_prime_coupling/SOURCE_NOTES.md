# Source and quantifier notes

Checked on 2026-09-01.  This continuation uses no new imported theorem.
The literature inputs are the exact source copies and audits already frozen
in the repository:

* Carlo Sanna, *The p-adic valuation of Lucas sequences*, Fibonacci
  Quarterly 54(2) (2016), 118--124.  Theorem 1.5 and Corollary 1.6 are used
  only through the inherited equality
  `v_q(u_n)=e(q)+v_q(n/z(q))` when `z(q)|n`.
* J. H. E. Cohn, *The Diophantine equation x^n=Dy^2+1*, Acta Arithmetica
  106 (2003), 73--83.  Its Section 6 perfect-power classification is the
  inherited reason that a nontrivial `A_ell` is not a perfect power.  The
  official IMPAN PDF is frozen at
  `research/sources/pell_packet_global_attack_2026_09_01/Cohn_2003_Diophantine_xn_Dy2_plus_1.pdf`,
  bytes `140958`, SHA-256
  `2c1f60eef15e6b7efef8b1358cc8abb4535042bb97135393a71a04ca88fb51f7`.
* J. H. E. Cohn, *Perfect Pell Powers*, Glasgow Mathematical Journal 38
  (1996), 19--20, together with Ljunggren's square theorem.  These are the
  inherited reason that `B_ell` is not a perfect power except at the already
  explicit value `B_7=169`.
* Nic Fellini and M. Ram Murty, *Wieferich primes in number fields and the
  conjectures of Ankeny--Artin--Chowla and Mordell*, Journal of Number Theory
  285 (2026), 209--229.  The repaired prime-order consequence in
  `research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md` is audited here but
  is not strengthened to a pointwise statement.

Authoritative local source locations and hashes are recorded in
`research/computation/2026_09_01_pell_packet_global_attack/SOURCE_NOTES.md`.
In particular, the Fellini--Murty source PDF has SHA-256
`104e9e6f3992e751a08f8af564857d9820e944ade1e178c3ba5ce07827faab4c`.

The finite scan proves only the stated endpoint theorem.  A lack of a hit up
to `10^9` is not extrapolated to finiteness or nonexistence of depth-three
balancing-Wieferich primes.
