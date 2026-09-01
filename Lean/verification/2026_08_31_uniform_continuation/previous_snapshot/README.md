# ABCConjecture
使用AI证明ABC猜想与lean形式化证明

当前仓库并行研究并形式化 IUT、Tate 解析几何、GenEll/Fermat、
Arakelov--Vojta、Frey--Szpiro、S-unit 与算术微分等路线中的真实组件。
它尚未得到无条件的 abc 猜想证明或反例；所有条件性归约、局部定理、
严格反例及剩余核心缺口均在
[`Lean/RESEARCH_STATUS.md`](Lean/RESEARCH_STATUS.md) 中逐项区分。

2026-08-31 的最新完成阶段构造了实际完整局部 Galois 群上的共同最低层
映射，证明了预先形成的主理想之精确 trace-dual hull，并构造无界 Frey
曲线族及其全部原始 IUT 初始 theta 数据。证明、原始文献和未形式化边界见
[`完整 Galois 映射与初始数据阶段总报告`](research/ABC_GALOIS_LIFTS_2026_08_31.md)。
完整初始数据与局部 hull 尚未给出全局 pilot、Ind3 和跨 Frobenius 比较。
本轮英文论文作者为 ChatGPT，报告部分结果：
[`论文 PDF`](output/pdf/ChatGPT_ABC_Uniformity_2026.pdf) ·
[`LaTeX 源文件`](paper/ChatGPT_ABC_Uniformity_2026.tex) ·
[`Lean 验证记录`](Lean/verification/2026_08_30_galois_lifts/VALIDATION.md)。
默认构建通过（9129 jobs）；七个新模块中的 **130 条公开定理与 15 个额外
构造**全部完成依赖审计，旧 89 项和 43 项审计也重新通过。依赖只含 Lean
标准公理，没有 `sorryAx`。**66 页英文稿**编译零最终警告并已逐页看图检查。
完整 Galois 重构、局部类域论、初始数据几何与全局比较尚未整体形式化；
内部智能体复核不称作外部同行评审。这里没有 abc 的证明或证伪。

此前的实际 radical 计数、共同 Mordell 曲线、Ism 标量刚性与 Ind2
不变性见 [`统一估计阶段总报告`](research/ABC_UNIFORM_GATE_2026_08_30.md)。
该阶段的 34 页论文、入口及状态文件逐字保存在
`Lean/verification/2026_08_30_galois_lifts/previous_snapshot/`；旧 506 项
校验表通过六处记录的路径映射完整重放。

上阶段指定 Pell–Chebyshev 方程族的有效有限性（绝对指标界 `p < 2^59`）
保留在 [`续研总报告`](research/ABC_CONTINUATION_2026_08_30.md)；它不提供
任意 abc 三元组的归约。其 22 页论文、旧入口及状态文档的逐字快照保留在
`Lean/verification/2026_08_30_uniform_gate/previous_paper_snapshot/` 和
`previous_mutable_snapshot/`，旧 447 项校验表可通过记录的路径映射重放。

首轮研究记录保留在
[`ABC_SESSION_2026_08_30.md`](research/ABC_SESSION_2026_08_30.md)，
其十页论文快照位于 `Lean/verification/2026_08_30/paper_snapshot/`。
