# ABCConjecture
使用AI证明ABC猜想与lean形式化证明

当前仓库并行研究并形式化 IUT、Tate 解析几何、GenEll/Fermat、
Arakelov--Vojta、Frey--Szpiro、S-unit 与算术微分等路线中的真实组件。
它尚未得到无条件的 abc 猜想证明或反例；所有条件性归约、局部定理、
严格反例及剩余核心缺口均在
[`Lean/RESEARCH_STATUS.md`](Lean/RESEARCH_STATUS.md) 中逐项区分。

2026-08-30 的最新完成阶段直接研究实际根基、随 abc 三元组变化的
Mordell 曲线族，以及 IUT 原文允许的 Galois 映射。它得到带规定根基的
统一计数上界、三条实际 Mordell 点及共同曲线上的扭点关系、原文 Ism 的
标量刚性和 Ind2 的精确模包不变性。证明、原始文献审计及形式化边界见
[`统一估计阶段总报告`](research/ABC_UNIFORM_GATE_2026_08_30.md)。
完整 Galois 群上的新最低层构造另在研究日志中核验，不计入本阶段
已验收的 89 条定理，也不据此声称取得全局 abc 结论。
本轮英文论文作者为 ChatGPT：
[`论文 PDF`](output/pdf/ChatGPT_ABC_Uniformity_2026.pdf) ·
[`LaTeX 源文件`](paper/ChatGPT_ABC_Uniformity_2026.tex) ·
[`Lean 验证记录`](Lean/verification/2026_08_30_uniform_gate/VALIDATION.md)。
默认构建通过（9121 jobs）；本阶段 89 条公开定理和重新核验的上阶段
43 条声明均只依赖 Lean 的标准公理，没有 `sorryAx`。34 页英文稿已逐页
目视检查；Matveev、BEG、Siegel、完整局部类域论等外部输入尚未全部形式化。
论文报告部分定理与严格障碍，不声称完成 abc 的证明或证伪。

上阶段指定 Pell–Chebyshev 方程族的有效有限性（绝对指标界 `p < 2^59`）
保留在 [`续研总报告`](research/ABC_CONTINUATION_2026_08_30.md)；它不提供
任意 abc 三元组的归约。其 22 页论文、旧入口及状态文档的逐字快照保留在
`Lean/verification/2026_08_30_uniform_gate/previous_paper_snapshot/` 和
`previous_mutable_snapshot/`，旧 447 项校验表可通过记录的路径映射重放。

首轮研究记录保留在
[`ABC_SESSION_2026_08_30.md`](research/ABC_SESSION_2026_08_30.md)，
其十页论文快照位于 `Lean/verification/2026_08_30/paper_snapshot/`。
