# SU1--SU3 independent complete review

Status: **full ordinary proof PASS**. The entire verifier source was also
read and its existing canonical certificate independently checked by an
actual `python next_replay_second_unit_disk.py --check`, exit 0. Reviewed
files and certificates were not changed.

Candidate `next_second_unit_disk_certificate.md`, independent eighteenth
round, SHA256 `c92af5f48e1879dc107aeaa96c368eb1fa6a837aa04b3aecbb778602a8f8ac6b`.
Verifier SHA256 `abaa1c39cfb23a0476d2180d0b3a450f34f40b2f099d41cc4bb20c129888afc1`.
Canonical `next_second_unit_disk_exact.json` SHA256
`9c41ff73fad3875408856ff49e32c340cd6e272819eb17db8889dcf037f06dfa`.

The integral implicit square-root series and unit ordinates make all the
division recurrences integral on the unscaled disk. The phi/omega center
units and divisible psi thus establish whole-disk inverse units and formal
ninth-multiple parameters. This uses the same normalized recurrences and
actual multiplication-map identities checked against Sutherland during
the immediately preceding UD review; no second source reopening is claimed.

The first reduction correctly includes the nonzero **actual** center
constant. The unit logarithms give `log Xi=10` and `log 3=20` modulo 25;
the elliptic-log center residues are 4 and 2 after division by five. The
pullback slopes are 2 and 4. With `5alpha=(1,3)` the constant, linear and
quadratic coefficients are respectively 4, 3, 4. Therefore the only
possible residue is s=4, where the reduced derivative is zero. No simple
Hensel argument is used for this double residue root.

At the actual local center z=22, the unique square-root lift is W=32
mod125. Since all denominators are unit series, these input residues
determine the true rational-function values to the same precision. The
unit logarithm series via fourth powers has full omitted-tail valuation
at least three; it gives `log Xi=100` and `log 3=95` mod125. The local
parameters 90 and 10 imply `ell1/5=2` and `ell2/5=3` mod25. The exact
global constants `5alpha=(16,3)` mod25 are requested at well within the
previously proved ZS error budget, and they are independently recomputed
by the invoked rational-series helper.

Crucially, SU5 controls every degree: R0 is even and begins in degree
four; its degree-five term is absent, and all terms from degree six
onward satisfy the stated lower bounds. L-T begins in degree five.
Thus both full compositions have Gauss valuation at least four. Replacing
ell by T/9 changes ell squared in valuation at least five and the height
term in valuation at least four. An error in alpha from knowing 5alpha
mod25 changes alpha times ell squared only in valuation at least three,
which suffices for f mod125. No tail term can change `g(4)=15 mod25`.

The explicit arithmetic check is
`-40/81 - 64 + 27 + 76/3 = 15 mod25`. The plus sign on the last term
is the correct sign of `f=F0-Omega`.

Finally, integral restricted-series Taylor expansion on `4+5Z5` gives
`g(4+5t)=g(4)+5t g'(4) mod25 Z5<t>`. The derivative is divisible by
five, so the **entire** subdisk has value 15 modulo 25 and contains no
zero. The other four residue classes were already excluded at the first
precision. This proves whole-disk exclusion, and DS transfers it to all
four disks above z=+/-2 modulo five.

The finite program reproduces both dual tables, Hensel square-root lifts,
unit-log residues and exact alpha inputs. The independently repeated
canonical check is distinguished from writing an independent arithmetic
implementation, and from proving the analytic tail. The latter is the
complete ordinary argument reviewed here. No rational-point completeness,
intrinsic genus-six QC conclusion, or uniform ABC consequence is asserted.
