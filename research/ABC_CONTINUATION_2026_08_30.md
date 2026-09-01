# abc 多路线研究续报：指定 Pell 方程族的有效有限性

作者：ChatGPT。研究日期：2026-08-30（America/Tijuana）。

## 1. 当前结论与标准目标

本轮取得了一个超出固定指标逐项排查的结果：下述 Pell–Chebyshev
方程族在指标和数域同时变化时，仍然有效有限。数学证明使用无条件的
Matveev 与 Bérczes–Evertse–Győry（BEG）定理，并经其他路线独立核查。

**尚未得到标准 `ABCConjecture` 的无条件 Lean 闭项，也未得到其严格反例。**
指定方程族的有限性不等于所有 abc 三元组的有限性归约；目前不存在这里所需的
全局归约。Lean 已证明实际代数表达式、严格逼近与数值吸收，但尚未形式化
Matveev 与 BEG 本身，因此不能把完整有限性定理称为无条件 Lean 定理。

`Lean/IUTThreeClosures/ABCStatement.lean` 中的 `ABCConjecture`、自然数根基，
以及 `NonCircularDownstream.lean` 中的 `ABCPoint` 均未改变。标准目标仍为

\[
\forall\varepsilon>0\;\exists C_\varepsilon\;\forall(a,b,c),\qquad
\log c\le(1+\varepsilon)\log\operatorname{rad}(abc)+C_\varepsilon.
\]

这里 \((a,b,c)\) 遍历所有满足 \(a+b=c\) 的两两互素正整数三元组；
在这个范围内，原 Lean 定义中的 \(\max(a,b,c)\) 等于 \(c\)。

英文论文为 `paper/ChatGPT_ABC_Uniformity_2026.tex` 及
`output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`。作者正文与 PDF 元数据均为 ChatGPT。
它是报告部分定理和适用性审计的研究论文，不冒充 abc 最终证明，也未投稿或发布。

## 2. 主要数学进展：保留 Matveev 的归一化指标

取正整数 \(b,r,s,X\) 和整数 \(p\ge3\)，满足

\[
b+2=3r^2,\qquad b+3=s^2,\qquad
Z=b^2+3b+1=T_p(X),\qquad X>1.
\]

不要求 \(p\) 为素数，也不要求原有端点核 \(A,B\) 的平方自由性或同余条件。
置

\[
\varepsilon=2+\sqrt3,\quad \eta=s+r\sqrt3=\varepsilon^m,
\quad\delta=X+\sqrt{X^2-1},\quad W=Z+\sqrt{Z^2-1}=\delta^p,
\quad H=\log(b+2).
\]

实际 Pell 表达式给出严格不等式

\[
1<\frac{\eta^4}{8W}<1+\frac2b,\qquad W>\eta^2,
\qquad\log W<3H.
\]

因而 \(\Lambda=4m\log\varepsilon-3\log2-p\log\delta\) 满足
\(0<\Lambda<2/b\) 与 \(-\log\Lambda>H/2\)。小范围检验在纸面完成：
\(b<22\) 只可能给 \(b=1\)，与 \(T_p(X)>5\) 冲突。

在次数至多四的实数域中，依次取
\(A_1=2\log\varepsilon,A_2=4\log2,A_3=2\log\delta\)。
Matveev 原文 **Corollary 2.3** 允许

\[
B_* = \max\left(1,\max_i |b_i|A_i/A_3\right)\le2p,
\qquad A_1A_2A_3<96H/p.
\]

这一步不能用最大原始系数替代归一化指标；后者会丢失所需的高度消去。
原文的高度下限 \(0.16\)、数域次数与显式常数均已核对。
不能直接引用另有对数独立性假设的 Theorem 2.1；本证明不需要对数独立性。

比较上下界后得到

\[
p<2^{52}\log(2ep),\qquad \boxed{p<2^{59}}.
\]

再用已核对的 BEG 专门化 \(H\le\exp(4300p^5)\)，可得

\[
\boxed{b+2<\exp\!\bigl(\exp(4300\cdot2^{295})\bigr)}.
\]

所有整数参数因此只有有限多个可能值。这个界不可用于现实中的穷举，
但有限性本身不需要完成穷举。原更窄的 \(p\ge37\) 素数剩余族也随之有效有限。
独立审稿者还能把指数常数收紧；主论文保留较宽的 \(2^{59}\)，未以常数优化冒充进一步突破。

偶指标由 \(Z+1=2Y^2=3(b+1)r^2\) 的 3-adic 估值奇偶矛盾直接排除。
因此，在同一对固定 Pell 条件下，四连续数乘积对应的单位除有效有限集外，
是其**整 Pell 群**的基本正范数一单位。没有把它擅自等同于更大极大整环的单位生成元。
基本单位情形仍不提供所需的根基下界。

完整证明与独立审阅：

- `MATVEEV_PELL_FINITE_PACKET_2026_08_30.md`
- `MATVEEV_PACKET_CROSS_REVIEW_2026_08_30.md`，包括任意整数 \(p\ge3\) 的补充核验。
- 论文 Theorem 6.4、Corollaries 6.5–6.6。

## 3. 实际完成的 Lean 内容

本续报新增六个组件模块及一个集中审计模块，均已进入默认构建。

| 模块 | 真正核验的内容 | 不能由此宣称的内容 |
| --- | --- | --- |
| `MatveevPellFinitePacket20260830` | 实际平方根与 Pell 坐标桥、严格比值和对数逼近、归一化指标代数、显式常数吸收与高度上界的条件推论 | Matveev、BEG、数域全局高度和完整有限性定理尚未形式化 |
| `DVRReachableHaar20260830` | 从实际可达列选择最小非零行列式；张成等于矩阵像；商群基数、闭性、满秩 Haar 和 log-volume 公式 | 在紧整格上证明的是归一化概率测度版本；与环境局部域 Haar 限制的识别、秩亏零测度仍是数学证明 |
| `AnalyticAmplificationContinuation20260830` | CRT 交叉同余、半开带内唯一性与有限计数；实际根基界、二次曲线恒等式和认证高度界 | 椭圆格点方向计数及渐近比较仍是纸面证明 |
| `GeometryUniformityContinuation20260830` | 范数、实际比值、对数吸收、带明确输入的核界，以及实际 Frey 不变量与本原 Mordell 点 | 近期近似定理、调节子估计及小生成元定理未被新设为 Lean 公理 |
| `IUTReachabilityContinuation20260830` | 纯张量单位、独立缩放向量与系数环模包络中的整张量格包含 | 不自动构造真实 IUT 上下界源族的识别 |
| `IUTTargetReset20260830` | 保持重复标签共用映射的全线性同构拼接；目标变换、张成的协变性与相容源重编号 | 未证明 Frobenius 保持所需源类，也未把所有线性同构视为 Galois 所允许映射 |

`ResearchContinuation20260830Audit.lean` 打印原目标及 43 个关键声明的完整类型和公理依赖。
所有外部有效性估计都在相应 Lean 声明中保留为显式参数；没有添加数学公理、
`sorry` 或改名后的替代 abc 定义。

## 4. 解析路线：两个具体放大族的规模

对于固定两两互素正整数模数 \(U,V,W\) 及 \(0<\mu\le1\)，保留
\(U\mid A,V\mid B,W\mid C\) 以及
以余因子**大小**作上界的根基认证。两个输出的交叉行列式一方面被 \(UVW\)
整除，另一方面在同一 dyadic 半开带内绝对值严格小于该模数；本原性遂给唯一性。
高度至多 \(T\ge1\) 时只有 \(1+\lfloor\log_2T\rfloor\) 个输出。
遍历原 seed 的约数模板后，对固定 \(K>0\)、\(T\le c^K\)，在
\(c\to\infty\) 时仍为 \(c^{o(1)}\)；这里不允许 \(K\) 随 seed 增长。

二次完成族 \(ax^2+by^2=cz^2\) 的实际本原输出满足

\[
\#\{(ax^2,by^2,cz^2):cz^2\le T\}
\le\tau(abc)\left(1+4\pi\sqrt{\frac{T}{abc}}\right).
\]

对 \(0<\mu<1\) 和认证 \(\operatorname{rad}(abc)xyz\le(cz^2)^\mu\)
的子族，可进一步界为 \(\tau(abc)(1+4\pi c^{-1/2}T^{\mu/2})\)。
在固定 \(K>0\)、固定 \(0<\mu<1\)、\(T\le c^K\) 且 \(c\to\infty\)
的比较中，它达不到所比较的 BBLT 异常集上界指数。
这是对这两个**指定认证构造**的限制，不排除利用真实小根基的
其他放大方法。例子 \((1,8,9)\mapsto(49,32,81)\) 表明真实异常输出可以逃出
该大小认证；它不是 abc 的反例。

证明见 `ANALYTIC_AMPLIFICATION_CONTINUATION_2026_08_30.md`。
CRT 边界、切线参数、零参数及素数二的 gcd 情形均经过另一条路线复核。

## 5. 算术几何：基本单位方向仍需统一根基估计

结合 Pasten 2026 预印本的一般乘法群近似、小生成元结果和已有 Bennett–Walsh 输入，
在明确的平方自由端点分支证明

\[
H\ll\sqrt A\log^2(2A),\qquad H\ll\sqrt B\log(2B),
\qquad H^4\le K D\log^6(2D),\quad D=3AB.
\]

这些核界只需要固定 Pell 方程，不需要 Chebyshev 分解，因此在非基本单位子族
已有效有限后仍有意义；它们对 \(H\) 的多项式尺度尚不足以推出 abc。
另外得到分裂三次曲线 \(y^2=d(x^3-x)\) 的有效界
\(\log x\ll d^{2/3}\log^3(2d)\)。

实际 Frey 点的本原 Mordell 化为
\(Y^2=Q^3-27m^2\)，其中 \(Q=a^2+ab+b^2\)、\(m=abc/2\)、
\(Y=(a-b)(2a+b)(a+2b)/2\)。已核验互素性、不可再作非平凡权重缩放以及相应
二元三次式仍分裂。这样消除固定不变量因子后，直接代入近期 Mordell 界仍保留高度因子；
不能将该代入描述成 abc 的证明。

证明见 `GEOMETRY_UNIFORMITY_CONTINUATION_2026_08_30.md`。

## 6. IUT：已修复的局部步骤与尚未证明的源族比较

一个真实纯张量单位 \(t\) 一旦位于系数环 \(B\) 的模包络中，就有
\(tA\subset tB\subset H\)，不必先证明独立线性群可达性。
张量整环 \(A\) 与其极大整环 \(B\) 的归一化差为

\[
V_A(U)-V_B(U)=\frac{\log[B:A]}{\dim_{\mathbf Q_p}T}.
\]

该差不能在转用 IUT IV 的 \(B\)-归一化上界时被忽略。
有理 Frey 分支的模域确为 \(\mathbf Q\)，所选位在每个有理素数上只有一个。
一般数域的混合位权重也已从原 IUT IV Remark 1.7.1 核对，而不是另行猜测分布。
保持源配置与源类固定时，整个同构拼接集在合法目标变换下协变；这比仅验证一个点更强。

关键的剩余区别是同一个 native 未乘方根输入、真正 \(j^2\)-乘方的 theta 输入、
principal unit 的 \(p\) 次方以及直到域范数的重标度。这些不是同一操作。
原 IUT IV Step (v) 的容器确有 \(j^2/(2\ell)\) 输入；不能将其直接套到另一个源族。

109-adic Frey 例子仅证明指定 native 张量不在指定乘方容器中。
它的 \(\ell=7\) **不满足** Joshi IV 5.7 的素数窗口；原 Mochizuki IV 1.10
本身又没有这个窗口假设。两者均已在审阅中区别，因此没有声称得到任何已实例化
全局 IUT 定理的反例。

进一步设 \(p>2\)、\(E/\mathbf Q_p\) 为有限 Galois 扩张，分歧指数
\(e\le p-2\)、\(m\ge1\)，且 \(a\ne0\)、\(r=v_p(a)>0\)、\(v_p(p)=1\)。
在**明确允许全部 \(\mathbf Z_p\)-线性自同构的模型**中，证明

\[
H_m=p^{\lfloor r+\kappa\rfloor-m\kappa}B,
\qquad\kappa=1-1/e,\quad r=v_p(a).
\]

对 \(p\nmid30\ell\)、\(\ell\ge7\)、\(3\le e\le p-2\) 的指定分裂乘法约化
Frey 分支，这个精确等式及其整性条件排除了该最大同构模型中
全 procession 整性与素数窗口同时成立。单有温和分歧不足以替代 \(e\le p-2\)。
它不能转用于较窄的 Galois 映射族：
独立审阅给出 \(\mathbf Q_7(\sqrt[3]7)\) 的严格例子，显示两种包络不同。
此末项仍是数学证明；整体局部域/同构群实现的 Lean 形式化待做。

相关文件：

- `IUT_REACHABILITY_CONTINUATION_2026_08_30.md`
- `IUT_MIXED_WEIGHT_CONTINUATION_2026_08_30.md`
- `IUT_LOCAL_DICTIONARY_CROSS_REVIEW_2026_08_30.md`
- `IUT_PRIME_WINDOW_INTEGRAL_HULL_2026_08_30.md`
- `IUT_PRIME_WINDOW_INTEGRAL_HULL_CROSS_REVIEW_2026_08_30.md`

## 7. 验证、原文与历史保留

最终默认 `lake build` 成功，**9115 jobs，exit 0**。
43 个审计声明只依赖 `propext`、`Classical.choice`、`Quot.sound`。
新增模块零警告；完整构建仍有 265 条来自旧模块的样式/检查警告。
首次集成发现的版权头和审计行长警告已经修复，未关闭 linter。

当前记录在 `Lean/verification/2026_08_30_continuation/VALIDATION.md`，
包含原始构建、公理报告、环境、PDF QA 与文件哈希。
Lean 4.32.0、Lake、依赖锁定版本和仓库 HEAD 均未改动。
七份追加原始 PDF 的准确版本和 SHA-256 在
`sources/continuation_2026_08_30/SOURCE_MANIFEST.md`。

首轮报告 `ABC_SESSION_2026_08_30.md` 及
`Lean/verification/2026_08_30/` 描述之前的里程碑；其中 Pell 指标仍未界定、
满秩 Haar 尚未形式化等历史限制已由本续报更新。首轮十页论文保存在
`Lean/verification/2026_08_30/paper_snapshot/`，未覆盖。
本轮未删除研究路线，未改动用户原有两份 PDF，未提交、推送或投稿。

## 8. 继续研究的具体入口

1. 将完整有效有限性逐步形式化：补齐 Pell 单位描述、数域高度、原始对数形式定理
   与有效积分点定理的实现；任何暂缺部分继续保持显式输入，不能新增公理冒充闭项。
2. 全局证明路线仍需耦合带符号质因子估计或等价的、量词正确的 Frey modified-Szpiro
   界。指定 Pell 子族已有限，不能因此忽略基本单位情形或假定全局归约。
3. IUT 路线需从原文导出真正允许的局部 Galois 映射族，比较同一 \(j^2\) 源族的
   下界与上界，并处理统一全局量词、阿基米德项与归一化。
4. 证伪路线仍需固定正指数缺口的高度无界本原 abc 族。有限高质量样本、
   对特定大小认证的计数限制及某个中间命题的反例都不能替代这一目标。

未完成不等于反例。所有主路线继续保留；只有已被严格反驳的具体加强命题被标为不可用。
