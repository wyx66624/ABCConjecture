# Frey 模次数—Petersson—伴随 \(L\) 路线的指数审计

## 0. 结论先行

对正本原三元组 \(a+b=c\) 的 Frey 曲线

\[
E_{a,b,c}:y^2=x(x-a)(x+b),
\]

这条路线中，Manin 常数、伴随 \(L\) 值下界、坏素数局部因子、
\(X_0(N)\)-optimal 商到显示曲线的同源缝，以及 relative/stable
Faltings 高度的方向，都不会损失一个随 \(N\) 变化的幂指数。精确审计
后只剩一个量化缺口：对每个 \(\eta>0\)，需要独立证明

\[
\frac{\delta_{1,N}}{c_f^2}\ll_\eta N^{2+\eta}.
\tag{MD\(_\eta\)}
\]

这里 \(\delta_{1,N}\) 是 \(X_0(N)\)-optimal 模参数化的模次数，
\(c_f\) 是相应 Manin 常数。由于 \(c_f\ge1\)，更强的普通模次数界
\(\delta_{1,N}\ll_\eta N^{2+\eta}\) 足以用于正向推导；而 Pasten 对
Frey 族给出的 \(c_f=O(1)\) 又说明普通版与归一化版在这个族上只差
绝对常数。

目前无条件结果只是

\[
\log\delta_{1,N}=O(N\log N),
\]

在 Rankin--Selberg GRH 下也只是

\[
\log\delta_{1,N}=O(N\log\log N).
\]

它们分别对应 \(\delta_{1,N}\le\exp(O(N\log N))\) 和
\(\exp(O(N\log\log N))\)，都不是 \(N\) 的固定次幂，距
\((\mathrm{MD}_\eta)\) 所需的
\(\log\delta_{1,N}\le(2+\eta)\log N+O_\eta(1)\)，无条件时在
log-scale 上恰多一个 \(N\) 因子；即使假设 GRH，尺度比仍为
\(N\log\log N/\log N\to\infty\)。因此本说明不是 abc 的证明；
它精确定位了唯一仍会改变主指数的未证命题。

## 1. 归一化与 Frey 的局部输入

记 \(N=N_E\)。Pasten 在第 3 节记录了显示 Frey 曲线的精确局部形状

\[
|\Delta_E|=2^s(abc)^2,\qquad
N=2^t\operatorname{rad}(abc),\qquad
-8\le s\le4,\quad -1\le t\le7.
\tag{1.1}
\]

这里第二式中的负 \(t\) 与 radical 自带的因子 2 合并后仍给出整数
导子。尤其所有奇坏素数都是乘法约化且 \(v_p(N)=1\)，重复导子素数
只可能是 2。[Pasten, §3, p.15](https://people.math.harvard.edu/~hpasten/preprints/ShABC.pdf)

令 \(f\in S_2(N)\) 为 Fourier 首项归一化的新形式，令

\[
q_{1,N}:J_0(N)\twoheadrightarrow A_{1,N}
\]

为连通核的 optimal 商，并令
\(\phi=q_{1,N}\circ j_N:X_0(N)\to A_{1,N}\)。取 \(A_{1,N}\) 的
全局 Néron 微分 \(\omega_A\)，规定

\[
\phi^*\omega_A=2\pi i\,c_f f(z)\,dz,
\]

并使用未除以模曲线体积的 Petersson 范数

\[
\lVert f\rVert_2^2=
\int_{\Gamma_0(N)\backslash\mathfrak h}
|f(z)|^2y^2\frac{dx\,dy}{y^2}.
\]

体积归一化范数会额外引入约为 \(N\) 的因子，不能与下文公式混用。

## 2. 面积公式及 optimal seam

Pasten 的公式 (5) 是

\[
\log\delta_{1,N}
=2\log(2\pi c_f)+2\log\lVert f\rVert_2
+2h_{\mathrm{rel}}(A_{1,N}),
\tag{2.1}
\]

其中 \(h_{\mathrm{rel}}\) 是定义在 \(\mathbb Q\) 上、未先作半稳定
基变换的 relative Faltings 高度。等价地，若

\[
P_f=(2\pi)^2\lVert f\rVert_2^2,
\]

则

\[
h_{\mathrm{rel}}(A_{1,N})
=\frac12\left(
\log\frac{\delta_{1,N}}{c_f^2}-\log P_f
\right).
\tag{2.2}
\]

这同时核对了所有平方与方向：模次数在正号，Manin 常数和 Petersson
共体积在负号。[Pasten, equation (5), p.16](https://people.math.harvard.edu/~hpasten/preprints/ShABC.pdf)

### 2.1 optimal 曲线不是显示 Frey 曲线

公式 (2.1) 首先属于 \(A_{1,N}\)，不能仅以“同属一个同源类”就替换成
显示模型 \(E_{a,b,c}\)。所需缝合由 Pasten 同页明确完成：Mazur 与
Kenku 的有理同源分类给出 \(A_{1,N}\) 与任意同源
\(E/\mathbb Q\) 之间次数至多 163 的最小 \(\mathbb Q\)-同源；
Faltings [Lemma 5] 的同源高度不等式于是给出

\[
\left|h_{\mathrm{rel}}(A_{1,N})-h_{\mathrm{rel}}(E)\right|
\le\frac12\log 163<3.
\tag{2.3}
\]

这是绝对常数，不依赖 \(S=\{2\}\)。原文的引用链为 Mazur [70]、
Kenku [59]、Faltings [32, Lemma 5]。
[Pasten, §3, p.16](https://people.math.harvard.edu/~hpasten/preprints/ShABC.pdf)

Pasten 在这里定义
\(h_{\mathrm{rel}}(E)=-\frac12\log\Omega_E\)。因此 (2.3) 还精确给出

\[
\frac1{163}\le\frac{\Omega_E}{\Omega_{A_{1,N}}}\le163.
\tag{2.4}
\]

所以 Néron period-area seam 也以绝对常数闭合。

不应把它改写为“同源曲线的最小判别式只差常数”。后者是假的：
取奇素数 \(p\) 和

\[
a=1,\qquad b=p^k-1,\qquad c=p^k.
\]

原 Frey 曲线在 \(p\) 处有
\(v_p(\Delta_{\min})=2k\)，而 \(x=0\) 的显示 2-商在 \(p\) 处有
\(v_p(\Delta_{\min})=4k\)。两边的 \(c_4\) 都是 \(p\)-单位，故这些
显示式在 \(p\) 处确为最小，差 \(2k\) 无界。这里转移的是 Faltings
高度/周期面积，而不是 \(\Delta\)。

### 2.2 relative 到 stable 的方向

设 \(h_F(E)\) 为 stable Faltings 高度。所需且无条件成立的方向是

\[
h_F(E)\le h_{\mathrm{rel}}(E).
\tag{2.5}
\]

所以 (2.2)--(2.3) 的上界自动也是 stable 高度的上界；不需要另猜一个
“Frey 族基变换修正一致有界”的命题。这个方向及 relative 高度的定义
可见 [von Känel, §2.1, equation (2.1)](https://londmathsoc.onlinelibrary.wiley.com/doi/full/10.1112/tlms/tlu003)：
基变换使 relative 高度不增，而 stable 高度是在半稳定扩张上取得的值。

## 3. Petersson 范数与伴随 \(L\) 值

Watkins 采用中心在 \(s=1/2\) 的 motivic symmetric-square 归一化，
并在引言给出下式。为与第 2 节的 \(\phi,c_f,\omega_A\) 严格匹配，
公式 (3.1)--(3.3) 中暂取 \(E=A_{1,N}\)，把其 Néron 面积写成
\(\Omega_A\)；symmetric-square \(L\)-函数只依赖该 \(\mathbb Q\)-同源
类，稍后可重新记成显示 Frey 曲线的 \(L\)-函数。

\[
\frac{L(\operatorname{Sym}^2A_{1,N},1)}{2\pi\Omega_A}
=\frac{\deg\phi}{Nc_f^2}
\prod_{p^2\mid N}U_p(1).
\tag{3.1}
\]

其中 \(\Omega_A\) 是 \(\omega_A\) 的复基本平行四边形面积。另一方面，
直接拉回面积形式给出

\[
\deg(\phi)\,\Omega_A
=4\pi^2c_f^2\lVert f\rVert_2^2.
\tag{3.2}
\]

消去 \(\deg\phi,c_f,\Omega_A\) 后得到与上述归一化严格相容的公式

\[
\boxed{
\lVert f\rVert_2^2=
\frac{N}{8\pi^3}L(\operatorname{Sym}^2A_{1,N},1)
\prod_{p^2\mid N}U_p(1)^{-1}}.
\tag{3.3}
\]

在 unitary 记号中，这就是相应的 \(L(1,\operatorname{Ad}f)\) 公式；
引用时应保留 (3.1) 所声明的归一化，以免把 \(s=1\) 与 \(s=2\) 的
惯例混淆。[Watkins, Introduction](https://arxiv.org/pdf/math/0408126)

### 3.1 全有理 2-挠 Frey 族上的全局下界

Watkins 的 Lemma 3.4 对 symmetric-square 导子 \(N^{(2)}\ge142\)
给出

\[
L(\operatorname{Sym}^2A_{1,N},1)
\ge\frac{0.033}{\log N^{(2)}},
\qquad N^{(2)}\le N^2.
\tag{3.4}
\]

因此 \(L(\operatorname{Sym}^2A_{1,N},1)\gg1/\log N\)。由于它与
显示 Frey 曲线有相同的新形式，也可无歧义地写成该 Frey 同源类的
symmetric-square 值。在当前
semistable-away-\(2\) 的 Frey 族中，小 symmetric-square 导子迫使
\(N\) 有界：每个奇乘法坏素数的局部 Weil--Deligne 表示为 Steinberg，
在 Watkins 的平方导子惯例下贡献
\(v_p(N^{(2)})=2\)，而 Frey 导子满足 \(v_2(N)\le8\)。因此
\(N^{(2)}<142\) 迫使 odd level、进而 \(N\) 有界，余下有限个小导子
只改变最后常数；这句话不应无条件推广到一般二次扭族。

在 Frey 族中，奇素数满足 \(v_p(N)=1\)，所以 (3.3) 的乘积中没有任何
变化的奇素数；只剩固定素数 \(p=2\)。Watkins 第 4 节逐类处理
twist-minimal 与非 twist-minimal 情形：minimal 局部因子为
\(U_2(1)^{-1}=1-\varepsilon_2/2\)，而非 minimal 情形的显式估计以及
可能的 \(2^8\mid N\) 扭转比较只造成绝对常数损失。文中在
\(256\nmid N\) 的非 minimal 子情形明确写出
\(U_2(1)^{-1}\ge5/8\)；这个 \(5/8\) 不能冒充全族逐点结论。统一且
安全的结论是

\[
\prod_{p^2\mid N}U_p(1)^{-1}\gg1,
\tag{3.5}
\]

常数只来自 2；也可直接引用 Watkins 第 4 节至 Theorem 5.2 的完整
twisting 比较。结合 (3.3)--(3.5)，有

\[
\lVert f\rVert_2^2\gg\frac{N}{\log N},
\qquad
P_f=(2\pi)^2\lVert f\rVert_2^2\gg\frac{N}{\log N}.
\tag{3.6}
\]

例如在可直接采用局部下界 \(1/2\) 的子情形，(3.4) 给出显式的

\[
\lVert f\rVert_2^2
\ge\frac{0.033}{32\pi^3}\frac{N}{\log N}.
\]

对指数审计，统一结论是

\[
\log P_f\ge\log N-\log\log N+O(1).
\tag{3.7}
\]

故伴随 \(L\) 值与局部因子已经提供恰好一个正的 \(N\)-幂。即使将
\(1/\log N\) 改善成绝对常数，也只会删掉 \(O(\log\log N)\)，不能
修复模次数上界中缺失的主指数。

## 4. Manin 常数的方向性审计

Edixhoven 证明 optimal 商的 \(c_f\) 是非零整数，故按正号选择后
\(c_f\ge1\)。在 (2.2) 的高度上界方向，

\[
-\log c_f\le0,
\]

所以仅凭整数性，普通模次数上界就已足够；Manin 常数不会造成正向
指数损失。

反向从高度估计恢复普通 \(\delta\) 上界时则需要控制 \(c_f\) 的上界。
Pasten 的 Theorem 1.3 / Corollary 10.2 证明：若导子在固定有限集合
\(S\) 外平方自由，则 \(c_f\le M_S\)。Frey 曲线在 \(S=\{2\}\) 外
半稳定，故

\[
1\le c_f\le M_{\{2\}}.
\tag{4.1}
\]

这正是 Pasten Remark 3.3 所说对旧文献“普通模次数猜想与高度猜想
等价”缺口的修补。Frey 原始且方向不变的量其实是
\(\delta_{1,N}/c_f^2\)。
[Pasten, Theorem 1.3, Corollary 10.2, Remark 3.3](https://people.math.harvard.edu/~hpasten/preprints/ShABC.pdf)

## 5. 从模次数指数到 \(6+\varepsilon\) 的严格系数

写

\[
n=\log N,\quad
d=\log\delta_{1,N},\quad
m=\log c_f,\quad
p=\log P_f.
\]

假设目标模次数输入为

\[
d-2m\le(2+\eta)n+E_d,
\tag{5.1}
\]

而 (3.7) 写成

\[
p\ge n-E_p,\qquad E_p=O(\log n).
\tag{5.2}
\]

由 (2.2)、(2.3)、(2.5) 与 optimal seam 的常数 3，

\[
h_F(E)
\le\frac{1+\eta}{2}n+\frac{E_d+E_p}{2}+3.
\tag{5.3}
\]

Pazuki 的显式 Silverman 比较 (50) 为

\[
1.18\le\frac1{12}h(j(E))-h_F(E)
\le2.08+\frac12\log(1+h(j(E))).
\tag{5.4}
\]

特别地，若 \(J=h(j(E))\)，则

\[
J\le12h_F(E)+24.96+6\log(1+J).
\tag{5.5}
\]

这里最后一项不是 \(O(1)\)，不能删除。它是次线性的：对任意固定
\(\rho>0\)，由 \(\log x\le x-1\) 应用于
\(x=(\rho/6)(1+J)\)，可得完全显式的

\[
6\log(1+J)
\le\rho J+\rho-6-6\log(\rho/6).
\tag{5.6}
\]

取 \(0<\rho<1\) 后把 \(\rho J\) 移到左边；同时
\(E_p=O(\log n)\) 也可用同一不等式吸收到任意小的 \(n\)-系数。
更具体地，给定 \(\varepsilon>0\)，先选 \(\eta,\rho>0\) 使

\[
\frac{6+6\eta}{1-\rho}<6+\frac{\varepsilon}{2},
\]

再选 \(\kappa>0\) 把除以 \(1-\rho\) 后的
\(6E_p=O(\log n)\) 吸收到 \(\kappa n+O_\kappa(1)\)，且令总斜率仍
不超过 \(6+\varepsilon\)。数值 \(24.96\) 本身是绝对常数，但
\(6\log(1+J)\) 不是；只有经过 (5.6) 和除以 \(1-\rho\) 后才能进入
常数项。于是由 (5.3)--(5.6) 得到：对每个 \(\varepsilon>0\)，

\[
h(j(E))\le(6+\varepsilon)\log N+O_\varepsilon(1).
\tag{5.7}
\]

主系数没有隐藏抵消：一般地，若模次数系数为 \(\alpha\)、Petersson
下界系数为 \(\beta\)，则 \(j\)-高度系数严格为

\[
12\cdot\frac{\alpha-\beta}{2}=6(\alpha-\beta).
\tag{5.8}
\]

代入 \(\alpha=2+\eta,\beta=1\)，就是 \(6+6\eta\)。若
\(n>0,\eta>0\)，取所有不等式都恰好取等，便得到严格大于 \(6n\)
的反模型；Manin 项或 \(L\)-值的对数误差不可能形式上消掉这
\(6\eta n\)。

最后使用仓库已独立形式化的真实 Frey \(j\)-高度走廊

\[
\log c\le\frac16h(j(E))+\frac16\log8
\]

以及 (1.1) 给出的
\(\log N=\log\operatorname{rad}(abc)+O(1)\)，参数重命名后 (5.7)
正好给出 abc 的 \(1+\varepsilon\) 斜率。这里绝不能把 \(h(j)\)
误解为单个复嵌入的 \(\log|j|\)；它是有理数 \(j\) 的绝对对数
Weil 高度，分子、分母同时计入。

[Pazuki, equation (50)](https://arxiv.org/pdf/1611.01094)

## 6. 现有模次数上界离目标多远

称 \(N=DM\) admissible，是指 \(\gcd(D,M)=1\)，且 \(D\) 是偶数个
互异素数的乘积（允许 \(D=1\)）；以下 \(d(r)\) 表示 \(r\) 的正因子
个数。Pasten Theorem 7.2 对每条 \(\mathbb Q\) 上导子 \(N\) 的
椭圆曲线和每个 admissible 分解 \(N=DM\) 给出

\[
\log\delta_{D,M}(E)\le
\left(\frac1{12}\varphi(D)M+\frac7{12}d(DM^2)\right)
\left(\log N+\frac{4\log N}{\log\log N}\right).
\tag{6.1}
\]

并且，对每个 \(\epsilon>0\)，当 \(N\gg_\epsilon1\)（阈值有效）时，

\[
\log\delta_{D,M}<
\left(\frac1{24}+\epsilon\right)\varphi(D)M\log N.
\tag{6.2}
\]

取经典情形 \(D=1,M=N\)，得到

\[
\log\delta_{1,N}\le
\left(\frac N{12}+\frac7{12}d(N^2)\right)
\left(\log N+\frac{4\log N}{\log\log N}\right),
\]

以及充分大 \(N\) 时的

\[
\log\delta_{1,N}<
\left(\frac1{24}+\epsilon\right)N\log N.
\tag{6.3}
\]

在 modular-form Rankin--Selberg \(L\)-函数统一满足 GRH 的假设下，
Theorem 7.4 对每个 \(\epsilon>0\)、有效的
\(N\gg_\epsilon1\) 给出下式；它对所有 \(E/\mathbb Q\) 及所有
admissible 分解统一成立：

\[
\log\delta_{D,M}\le
\left(\frac1{12}+\epsilon\right)
\varphi(D)M\log\log N.
\tag{6.4}
\]

故经典情形仍是 \(O(N\log\log N)\)。

Theorem 7.5 把经典模次数界转成高度，完整量词为：所有
\(E/\mathbb Q\) 都有显式

\[
h_{\mathrm{rel}}(E)\le
\frac1{24}(N+7d(N^2))
\left(\log N+\frac{4\log N}{\log\log N}\right)+9;
\]

对每个 \(\epsilon>0\) 与有效充分大的 \(N\)，无条件

\[
h_{\mathrm{rel}}(E)<(1/48+\epsilon)N\log N,
\]

而 GRH 下

\[
h_{\mathrm{rel}}(E)<(1/24+\epsilon)N\log\log N.
\]

同一 Theorem 7.5 还给出所有 \(E/\mathbb Q\) 的显式判别式界

\[
\log|\Delta_E|\le
\frac12(N+7d(N^2))
\left(\log N+\frac{4\log N}{\log\log N}\right)+124,
\]

以及对每个 \(\epsilon>0\) 和有效充分大的 \(N\)，无条件

\[
\log|\Delta_E|<(1/4+\epsilon)N\log N,
\]

在 GRH 下

\[
\log|\Delta_E|<(1/2+\epsilon)N\log\log N.
\]

这些是“模次数的对数为 \(N\) 量级”的指数型界，绝不是模次数的
polynomial upper bound。
[Pasten, Theorems 7.2, 7.4, 7.5](https://people.math.harvard.edu/~hpasten/preprints/ShABC.pdf)

全有理 2-挠只使局部表示和 Manin 常数在 \(S=\{2\}\) 处特别整洁；
现有证明模次数上界所计数的是整个 level-\(N\) 新形式/Hecke 特征值
空间，其维数仍为 \(N\) 量级。Pasten 的上述定理没有因“Frey +
全有理 2-挠”把这个维数项降成 \(O(1)\)。若真能把 (6.3) 在该族上
改善成

\[
(2+\eta)\log N+O_\eta(1),
\]

经第 5 节就会证明 abc；这正解释了为何不能把任何现有指数型界口头
称为“已经接近”。

## 7. 缺口清单

| 环节 | 无条件状态 | 对 \(N\) 主指数的影响 |
|---|---|---:|
| Frey 奇素数导子/局部因子 | 半稳定，重复导子仅可能在 2 | 0 |
| \(L(1,\operatorname{Ad}f)\) 下界 | Watkins Lemma 3.4，损失 \(\log N\) | Petersson 提供 \(+1\) |
| Manin 正向符号 | \(c_f\in\mathbb Z_{>0}\) | 0，且有利 |
| Frey 族 Manin 上界 | Pasten Cor. 10.2，\(S=\{2\}\) | 0 |
| optimal \(A_{1,N}\) 到显示 \(E\) | \(\mathbb Q\)-同源次数 \(\le163\)，高度差 \(<3\) | 0 |
| relative 到 stable | \(h_F\le h_{\mathrm{rel}}\) | 0 |
| stable Faltings 到 \(h(j)\) | Pazuki (50)，有可吸收的 \(\log(1+h(j))\) | 乘 12 |
| **归一化模次数 upper** | **只知 \(\log\delta=O(N\log N)\)** | **缺少目标指数 2** |

因此唯一真正需要新数学的主指数命题是
\((\mathrm{MD}_\eta)\)。它不是由模性、Manin 常数、伴随 \(L\) 值
非零、GRH 或全有理 2-挠自动推出的。

## 8. Lean 边界

配套文件
[FreyModularDegreeExponentAudit.lean](IUTThreeClosures/FreyModularDegreeExponentAudit.lean)
只形式化：

1. 面积恒等式的实数重排；
2. 一般系数公式 \(6(\alpha-\beta)\)；
3. \(2+\eta\) 与 Petersson 系数 1 推出 \(6+6\eta\)；
4. 显式保留的 \(j\)-误差、Pazuki 对数项的次线性估计及线性吸收；
5. 正 \(\eta\) 严格破坏 slope 6 的等号见证；
6. 粗上包络不能形式推出 exponent 2 的实数反模型。

Lean 文件没有定义“模次数上界对象”，没有把
\((\mathrm{MD}_\eta)\) 填入结构字段，也没有声称形式化模性、optimal
商、Faltings 高度、伴随 \(L\) 值、导子或 abc。
