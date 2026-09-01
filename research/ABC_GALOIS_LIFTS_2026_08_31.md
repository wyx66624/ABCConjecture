# 完整 Galois 映射、精确局部 hull 与无界初始 theta 数据族

作者：ChatGPT。研究时间：2026-08-30 至 2026-08-31。

**本阶段没有证明或证伪标准无条件 `ABCConjecture`。**
它解决了若干原先悬而未决的局部和初始数据问题，并形成可复验的部分结果。
数学证明先于对应 Lean 实现；尚未形式化的外部理论明确保留在数学证明层。

## 1. 已得到的数学结果

### 实际完整局部 Galois 群上的共同最低层映射

从 Jannsen–Wingberg 的完整相对 profinite 表示出发，显式构造保留全部
relator 的字映射及逆映射。没有把最大 pro-p 商的任意自同构直接提升为
完整 Galois 自同构。在指定 tame 域中，积分基、trace-kernel 和逆向
Kummer 作用逐项核验。

对每个素数 `ell >= 7`、`p = -1 mod 30*ell`，取 `e=15*ell`、
`v_p(b0)=2`、`pi^e=b0`。真正的 uniformizer 是
`beta=pi^((e+1)/2)/p`，不是 `pi`。对全部半区间平方标签
`1 <= j <= (ell-1)/2`，一个实际共同 Galois–Kummer 映射同时达到点输入
与整族输入的最低层。惯性禁用指数总数至多 `9*ell-9 < 15*ell`；其中
至多一个短轨道被单独计入，不能省略。

证明见 `IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md`、
`IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md` 和
`IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md`。

### 预先形成的主理想之精确 hull

令 `A=O_E tensor ... tensor O_E`，`B` 为其 maximal order，
`I` 为 inverse different，`k=floor(v_p(a)+(e-1)/e)`。
采用绝对代数迹，每个分量的 idempotent 给出

```text
B^dual = product I  subset  A^dual = I tensor ... tensor I,
p^(-k)*(a tensor 1 ... 1)*B  subset  B^dual.
```

所以任何保持 `A^dual` 的 Qp 线性映射，在传输已经形成的整个主理想后
再取 B-span，仍落入同一精确上界。结合实际共同点轨道的达到性，得到
`M = P`；整族源的 hull 则为 `S = p^(-1)*P`，严格更大。
此处既不移动非 B 线性映射两边的 B-span，也不乘入虚构的分量数。

这是对先前仅有 `P subset M subset S` 的实质加强。标准 Bloch–Kato
坐标同时改变全部 `m` 个因子和源，hull 乘 `p^m`；不能把 native 坐标的
正 log-volume 直接当成标准坐标不等式的反例。

完整证明及独立复核见 `TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md`
和同名 `CROSS_REVIEW`。六个新的 Lean 定理使用真实的 `Algebra.traceForm`、
dual submodule、积代数迹和传输后的 `Submodule.span` 形式化其中代数核心。

### 真实 Frey 曲线及无界族

具体 `ell=43, p=1289, A=p*(p^16+428)` 给出
`(a,b,c)=(A^2,A^2+1,2*A^2+1)`。逐素数的指数界通过 primorial/gcd 和
大小界证明，不依赖对巨大端点的完全分解。Lean 同时核验实际
Weierstrass 不变量、有限域点数、实对数及 `1224 < Q_D < 1648`。

进一步用 Xylouris 原始 2009 年有效 Linnik 指数 `5.2`，结合明确的 CRT
坏点计数，在所有充分大的 `ell = 43 mod 60` 上构造无界族：
`A,A^2+1,2*A^2+1` 均 ell-power-free，
`3*ell^2/4 < Q_D < ell^2`，相关 Tate orders 与 ell 互素。
一般族不声称 `A^2` 或整个 `abc` 也 ell-power-free。
在原始有限局部域切片意义的固定 bounding domain 中，j 高度趋于无穷，
所以可避开任何预先固定的有限异常集。

见 `FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md`、
`FREY_43_FORMAL_ARITHMETIC_PROOFS_2026_08_30.md` 和
`FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md`。

### 原始 IUT 初始数据全部条件

有限例及上述无界族都满足 IUT I Definition 3.1 的全部原始条件。
构造含 core、dual-isogeny graph cover、固定 decorated quotient vector
所给 distinguished cusp、逐个独立选择的 bad places、局部 theta 模型
及 oriented covers。所用域仍为 `K=Q(i,D[30*ell])`，无需额外添加
ell-squared torsion。各地方可分别使用不同的 Galois 元素；原始定义
没有要求一个共同元素实现所有地方选择。

证明见 `IUT_INITIAL_DATA_BALANCED43_AUDIT_2026_08_30.md`、
`IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md` 及其两路线复核记录。
这一完整几何构造目前是数学证明，**尚未整体形式化**。

## 2. Lean 与论文核验

七个新模块包含 **130 条公开定理及 15 个额外构造**，全部 145 项都有
类型与公理依赖记录。六项无公理依赖，其余仅使用 Lean 的
`propext`、`Classical.choice`、`Quot.sound`。没有 `sorryAx` 或新增数学公理。
旧 89 项和 43 项审计也重新通过。

默认 `lake build` 完成 **9129 jobs**；新模块与审计零警告，265 条旧警告
完整保留。标准目标、受保护的下游接口、工具链和依赖 pins 未变。

作者为 ChatGPT 的英文稿现为 **66 页**，Tectonic 最终日志零警告，
全部页面分四段实际看图检查通过。独立智能体复核属于内部 AI 检查，
不称作外部同行评审或期刊接受。

- 论文：`../output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`
- 主源文件：`../paper/ChatGPT_ABC_Uniformity_2026.tex`
- 完整核验：`../Lean/verification/2026_08_30_galois_lifts/VALIDATION.md`
- 数学和原始文献审计：同目录 `DOC_REVIEW.md` 与 `SOURCE_INDEX.md`

旧 34 页论文、入口及状态文档已有逐字快照；旧 506 项清单通过六处
记录的路径映射完整重放，旧 447 项历史也被保留。原始/用户 PDF 未改动，
没有提交、推送或外发论文。

## 3. 尚未解决的核心

完整初始数据和精确局部 hull 尚不能推出完整全局 pilot 的比较。
下一步需在**同一原始全局构造**中处理地方/标签权重、源集合的身份、
Ind3、arithmetic holomorphic structures 与跨 Frobenius 兼容性，不能
用相同的数值区间或局部容器替代这些结构。

解析路线仍需对实际 radical 得到足够强的统一下界/放大机制，而非仅
异常集计数；算术几何路线仍需跨变化曲线、根支撑和 regulator 的全 epsilon
统一控制。所有广义路线继续保留；只否定已有严格反例的明确中间命题。

最终目标仍是标准无条件 `ABCConjecture` 的 Lean 闭项或严格证伪。
本阶段的成功构建、完整初始数据和英文稿均不等于该最终目标已经完成。
