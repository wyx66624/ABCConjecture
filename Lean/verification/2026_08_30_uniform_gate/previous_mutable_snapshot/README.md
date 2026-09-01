# ABCConjecture
使用AI证明ABC猜想与lean形式化证明

当前仓库并行研究并形式化 IUT、Tate 解析几何、GenEll/Fermat、
Arakelov--Vojta、Frey--Szpiro、S-unit 与算术微分等路线中的真实组件。
它尚未得到无条件的 abc 猜想证明或反例；所有条件性归约、局部定理、
严格反例及剩余核心缺口均在
[`Lean/RESEARCH_STATUS.md`](Lean/RESEARCH_STATUS.md) 中逐项区分。

2026-08-30 续研已证明指定 Pell–Chebyshev 方程族有效有限，得到绝对指标界
`p < 2^59`；它尚不提供任意 abc 三元组的归约。最新成果、原始文献审计与
形式化边界见
[`续研总报告`](research/ABC_CONTINUATION_2026_08_30.md)。
Matveev、BEG 等外部定理的完整 Lean 实现仍待完成。
本轮英文论文作者为 ChatGPT：
[`论文 PDF`](output/pdf/ChatGPT_ABC_Uniformity_2026.pdf) ·
[`LaTeX 源文件`](paper/ChatGPT_ABC_Uniformity_2026.tex) ·
[`Lean 验证记录`](Lean/verification/2026_08_30_continuation/VALIDATION.md)。
默认构建通过（9115 jobs）；续研审计的 43 个声明无新增数学公理或 `sorryAx`。
论文报告部分定理与严格障碍，不声称完成 abc 的证明或证伪。

首轮研究记录保留在
[`ABC_SESSION_2026_08_30.md`](research/ABC_SESSION_2026_08_30.md)，
其十页论文快照位于 `Lean/verification/2026_08_30/paper_snapshot/`。
