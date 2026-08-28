# Eventual modified-Szpiro is enough for abc

## 1. Scope

For a positive primitive triple

\[
  a+b=c,
\]

let \(P\) be its Frey point and write

\[
  h(P)=\log c,
  \qquad
  h_{\mathrm{mod}}(P)
    =\log\max\{|c_4(E_P)|^3,|\Delta(E_P)|\},
\]

and

\[
  n_\Delta(P)
    =\log\operatorname{rad}(16(abc)^2).
\]

The repository already proves, uniformly in \(P\),

\[
  6h(P)\le h_{\mathrm{mod}}(P)
    \le 6h(P)+\log 4096.                                     \tag{1.1}
\]

It also proves

\[
  0\le n_\Delta(P)
    \le \log\operatorname{rad}(abc)+\log 2.                  \tag{1.2}
\]

This note records an elementary quantifier gate: a modified-Szpiro estimate
is needed only above a height threshold. No finiteness theorem, enumeration
of small points, or prime-by-prime argument is required to absorb the points
below that threshold.

## 2. The eventual hypothesis

Assume that

\[
 \forall\varepsilon>0\quad
 \exists H_\varepsilon,C_\varepsilon\in\mathbb{R}\quad
 \forall P,\quad
 h(P)\ge H_\varepsilon
 \Longrightarrow
 h_{\mathrm{mod}}(P)
 \le (6+6\varepsilon)n_\Delta(P)+C_\varepsilon .            \tag{2.1}
\]

The order of the quantifiers is essential. The threshold and constant may
depend on \(\varepsilon\), but neither may depend on \(P\), its prime support,
or any auxiliary choice attached to \(P\).

Fix \(\varepsilon>0\), and choose \(H=H_\varepsilon\) and
\(C=C_\varepsilon\) as in (2.1). Define the single enlarged constant

\[
  D_\varepsilon
   =\max\{C,\,6H+\log4096\}.                                 \tag{2.2}
\]

If \(h(P)\ge H\), then (2.1) and \(C\le D_\varepsilon\) give

\[
 h_{\mathrm{mod}}(P)
 \le(6+6\varepsilon)n_\Delta(P)+D_\varepsilon .             \tag{2.3}
\]

If \(h(P)<H\), the unconditional upper half of (1.1) gives

\[
 h_{\mathrm{mod}}(P)
 <6H+\log4096
 \le D_\varepsilon .                                       \tag{2.4}
\]

Since \(6+6\varepsilon>0\) and \(n_\Delta(P)\ge0\), (2.4) also implies
(2.3). Thus the eventual estimate has been upgraded to the fully uniform
statement

\[
 \forall\varepsilon>0\ \exists D_\varepsilon\ \forall P,\quad
 h_{\mathrm{mod}}(P)
 \le(6+6\varepsilon)n_\Delta(P)+D_\varepsilon .             \tag{2.5}
\]

Notice that this argument does not assert that there are finitely many points
of bounded height. It only uses a pointwise height upper bound whose
right-hand side is already uniform.

## 3. Transfer to abc

Combining the lower half of (1.1), (2.5), and (1.2) gives

\[
\begin{aligned}
 h(P)
 &\le \frac16h_{\mathrm{mod}}(P)\\
 &\le (1+\varepsilon)n_\Delta(P)+\frac{D_\varepsilon}{6}\\
 &\le (1+\varepsilon)\log\operatorname{rad}(abc)
      +(1+\varepsilon)\log2+\frac{D_\varepsilon}{6}.
\end{aligned}
\]

The last two summands depend only on \(\varepsilon\). This is the standard
logarithmic abc inequality with the correct quantifier order.

The formal companion first proves the upgrade from (2.1) to (2.5), then
applies the already checked uniform modified-Szpiro-to-abc theorem. The
eventual modified-Szpiro estimate (2.1) remains an explicit hypothesis; this
gate neither proves that estimate nor imports abc, Szpiro, or an equivalent
open statement as an accepted theorem.
