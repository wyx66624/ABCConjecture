# ABCConjecture
使用AI证明ABC猜想与lean形式化证明

当前仓库并行研究并形式化 IUT、Tate 解析几何、GenEll/Fermat、
Arakelov--Vojta、Frey--Szpiro、S-unit 与算术微分等路线中的真实组件。
它尚未得到无条件的 abc 猜想证明或反例；所有条件性归约、局部定理、
严格反例及剩余核心缺口均在
[`Lean/RESEARCH_STATUS.md`](Lean/RESEARCH_STATUS.md) 中逐项区分。

## 2026-09-02 最新四路线检查点：actual Haar、sigma-one、catalogue novelty 与 endpoint curvature

标准、无条件的 `ABCConjecture` 仍未被证明或证伪。本检查点继续并行推进
正向证明与完整前提反例搜索；路线困难和有限无命中不构成淘汰理由，反例只
关闭它严格满足全部假设的具体命题。四条母路线均保持 active。统一数学账本见
[`四路线综合报告`](research/ABC_MULTI_ROUTE_ACTUAL_HAAR_SIGMA_ONE_CATALOGUE_CURVATURE_2026_09_02.md)，
两次独立对抗审计分别见
[`总检查点审计`](research/ABC_CHECKPOINT_ADVERSARIAL_AUDIT_2026_09_02.md)和
[`仿射/Pell 审计`](research/ABC_AFFINE_PELL_ADVERSARIAL_AUDIT_2026_09_02.md)。

- **IUT actual-Haar 路线。** 已在真实非阿基米德加法 Haar 测度上证明
  finite-positive 区域对所有非零标量逆像封闭，并构造 compact-open
  uniformizer 的无限、单射、无有限正测度公共包络轨道。对有理素数的原始
  位移是 `ef log p`；除以局部次数 `ef` 后才成为 `log p`。非分歧二次分量
  完整否定“只令权重和为一便足够”的原始版本，但不否定修正后的分量归一化。
  尚需实际 tensor/place 统一实现、Ind1--Ind3/theta 运输与 same-pilot 比较。
- **Mersenne sigma-one 路线。** 加权 Brun--Titchmarsh 在论文层无条件关闭
  endpoint 的低 one-copy 臂；另一低臂精确归约为 exact-order Farey energy
  `E_k(m)=o(log m)`，两个剩余臂又由 stable prime-power layers 合并为一个
  明确的公共质量目标。穷尽全部 50,847,534 个 `p≤10^9` 的素数只得到
  `1093,3511` 两个 depth-two 命中；它们严格否定若干 pointwise 加强，不能
  外推否定仍开放的渐近目标。
- **Affine catalogue-novelty 路线。** 已证最优 incidence 常数 6、3、8，
  singleton baseline 精确消去；建立 `J=A1+Ω`、pair-kernel Euler product、
  三项 hybrid tail bound、powerful-excess filter 与 support skeleton。
  一个满足 `R<C` 的实际双-singleton period-one packet 达到
  `w/S=23392/23701`，否定只由 `R<C`、singleton 或 `T≥1` 推出严格节省。
  剩余门是带 ownership 聚合 divisibility-maximal powerful-intersection tops。
- **Pell--Lucas curvature 路线。** 伴随 jets 与三阶 ledger 的精确差公式显示
  反向恢复会损失因子 8；端点 determinant 满足
  `Delta_top=2v*32^(ell-1)*U^2` 且商与 `U` 互素，因此 `U^2` 严格最优。
  系数反例、局部 `(ell,q,r)=(3,7,797)` 反例和实际 `ell=7` 反例只分别关闭
  reverse-jet、local-inconsistency 与 `U^3` 加强。57 个奇素数指标至 271
  有一次素因子证书，这只是有限非-squarefull 定理；全局 negative-Pell
  realization 与完整 character packet 的耦合仍开放。

四个新 Lean 模块含 102 个 theorem、18 个 definition、2 个 structure 与
1 个 abbreviation，共 123 个声明。102 次一一对应的 `#print axioms` 依赖
并集仅为 `Classical.choice`、`Quot.sound`、`propext`；全部直接
`warningAsError` 编译通过，聚合目标完成 9,239 jobs。它们没有构造无条件
`ABCConjecture` 或否定项。

作者为 ChatGPT 的 202 页英文期刊稿已重新编译为
[`output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`](output/pdf/ChatGPT_ABC_Uniformity_2026.pdf)，
SHA-256 为
`cbe3693431fd9f969531fa8c7a0669e3afe1c8cd29aa36a2c1af497f1024451f`；
完整编译、结构、文字与逐页视觉检查记录位于
[`本轮 PDF QA 目录`](output/pdf/ChatGPT_ABC_ActualHaar_SigmaOne_Catalogue_Curvature_2026_09_02_QA/)。

## 2026-09-02 最新四路线检查点：signed-ray、critical slow-slack、correlated Lucas 与 admissible index

标准、无条件的 `ABCConjecture` 仍未被证明或证伪。本检查点继续把正向证明
与反例搜索置于同等地位：困难、形式化尚未完成或有限搜索无命中均不关闭
路线；只有满足一个精确命题全部前提的反例才淘汰该命题。四条母路线全部
保持 active。统一账本见
[`四路线综合报告`](research/ABC_MULTI_ROUTE_SIGNED_SLOW_CORRELATED_ADMISSIBLE_2026_09_02.md)。

- **IUT admissible/index 路线。** 对 2026-09-02 观察到的 LANA `iut`
  提交 `c65b28c` 做了逐文件来源封存与补丁重放。空集完整否定“对所有集合
  都有非零逆像体积平移”，全集又完整否定只加非空条件的版本；修正后的
  admissible-domain 接口已在上游快照的 `Iut` 与 `Iut4Sec1` 全目标中完成
  8,767-job 构建。Lean 还证明差映射核对应的整阶商群指数恰为 `n`，即使
  两个坐标投影都满射。它没有把 LANA 仓库或 IUT 说成已验证；实际局部
  Haar 体积、各 place 的 tensor-order index、horizontal/Ind3 covariance 与
  pointed q-pilot 识别仍是开放门。
- **Mersenne critical slow-slack 路线。** 以任意缓慢发散的
  `sigma(m)` 取代固定正 `log log` 幂后，已控制两条低臂，并把失败集中到
  高 multiplier 深提升或近平方根 one-copy 臂；Euler 判别给出精确的
  multiplier 模 8 过滤。实际素数 `1093` 具有
  `ord_1093(2)=364`、深度 2、奇 multiplier 3，完整否定“所有重复
  exact-order multiplier 都为偶数”，但不触及 `sigma=1` 的算术端点。
- **Pell--Lucas correlated all-order 路线。** 第二条 staircase 的系数从
  原始奇因子乘积独立推导，并证明与第一条 staircase 的逐系数微分相关；
  每阶 splitter、cross-order determinant 与顶点互反符号保持相容。57 个
  素指标至 `271` 均有一次素因子，这是严格有限排除；527,352 次候选扫描
  只见 `13^2 || B_7` 且无 depth-three 命中，不被外推为无界定理。
  `ell=11` 的混合符号行只淘汰“负行每条边都负”的加强命题。
- **Affine signed-ray/catalogue 路线。** 对任意 primitive signed ray 已证
  `aNL<C_lambda`、非臂 `a^3 T^2<(B+1)(C+1)N`，以及三条 canonical arm
  的精确线性 cap；`n^3<=1+7(n-1)^3` 中常数 7 最优。owner 全局能量界
  只对 selected powerful-kernel catalogue union 成立；实际
  `972496>1072` 完整否定删除该 membership 的推广。剩余门是控制
  `S_non` 并与 singleton/class multiplicity 下界比较。

四个新 Lean 模块共含 90 个 theorem 与 16 个 definition，直接
`warningAsError` 编译全部通过，聚合目标完成 9,233 jobs；公理并集仅为
`Classical.choice`、`Quot.sound` 与 `propext`。它们证明的是上述局部闭合与
精确淘汰边界，不构造无条件 `ABCConjecture` 或其否定项。

## 2026-09-01 最新四路线检查点：全局 omega、prime/unit/label、双臂 CRT 与 Mersenne order block

标准、无条件的 `ABCConjecture` 仍未被证明或证伪。本检查点同时推进正向
证明和反例搜索；只有满足一个命题全部假设的反例才关闭该精确命题，路线
困难或有限扫描无命中都不构成淘汰理由。四条广义路线均继续保留。统一账本见
[`四路线综合报告`](research/ABC_MULTI_ROUTE_PRIME_UNIT_TWO_ARM_LAYER_2026_09_01.md)。

- **Carella 全局 omega / 素数幂邻点路线。** primorial multiples 给出满足
  `w(x)≤2 log log x` 时
  `#{n≤x: omega(n)>w(x)}=x^(1-o(1))`，从而完整否定 Carella v2 所印的
  全局 `o(x^(3/5))` 假设及其无条件调用；它不否定稀疏的低 radical 邻点。
  正向门已放宽为：对某个固定 `k`，构造无界的
  `p^k<c≤p^k+(p^k)^(3/5)`、`p∤c` 且
  `rad(c)≤(p^k)^(sigma+o(1))` 的子序列，其中
  `sigma<2/5-1/k`。见
  [`全局 omega 报告`](research/ABC_CARELLA_GLOBAL_OMEGA_HYPOTHESIS_2026_09_01.md)与
  [`CarellaGlobalOmegaHypothesis20260901`](Lean/IUTThreeClosures/CarellaGlobalOmegaHypothesis20260901.lean)。
- **IUT prime/unit/label 路线。** 完整的素数指数、unit 部分与固定 label
  可以重构有理数、实际 `Q_p` 点、带标签 packet 及其区域包含关系。三个
  全前提反例分别关闭 exponent-only、只保留第一 residue、以及丢弃标签后
  用 aggregate holonomy 重构的弱接口；它们不否定实际 IUT 构造或显式返回
  permutation 的接口。最小开放门是在真实 theta link、log-Kummer 修正、
  determinant normalization 与 Ind1--Ind3 分支上证明 all-place/all-label
  signature preservation 或 image containment。见
  [`prime-unit-label 报告`](research/ABC_IUT_PRIME_UNIT_LABEL_VECTOR_BRIDGE_2026_09_01.md)与
  [`IUTPrimeUnitLabelVectorBridge20260901`](Lean/IUTThreeClosures/IUTPrimeUnitLabelVectorBridge20260901.lean)。
- **最小仿射 shear 双臂 CRT 路线。** 对 seed `(1,242,243)` 构造了
  `318322715` 个同时满足两条 long-arm 必要门的精确 CRT 参数；其中首点
  满足全部 seed、box、互素、cap 与双臂假设，却有
  `rad(ABC)^4>C^3`。这个完整反例只关闭“两条 marginal long-arm 门足以
  推出三分之四异常”的命题。正向路线仍需以至少
  `kappa R^(-2/3)c^(4+eta)` 的匹配密度强迫完整三臂 excess 乘积不等式。见
  [`双臂 CRT 报告`](research/ABC_AFFINE_TWO_ARM_CRT_PACKET_2026_09_01.md)与
  [`AffineTwoArmCRTPacket20260901`](Lean/IUTThreeClosures/AffineTwoArmCRTPacket20260901.lean)。
- **Mersenne prime-layer / order-block 路线。** 对 composite odd-prime
  layer 已证平方级 radical 下界，并由最大素因子结果渐近得到
  `E_ell/Phi_ell(2) << 1/(ell^2 log ell)`；这还远弱于所需的
  `log E_d=o(phi(d))`。正确总账
  `W_m=L_m*prod_(d|m) E_d` 且 `L_m|m`。`m=6` 完整否定省略 lifting
  factor 的恒等式；`ell=37` 和 `ell=11` 分别只否定统一三因子加强与统一
  立方 radical 加强。prime index 到 `61` 未发现重复因子只是有限 no-hit。
  已完成的
  [`MersennePrimeLayerRadical20260901`](Lean/IUTThreeClosures/MersennePrimeLayerRadical20260901.lean)
  核验 prime-layer、有限 base-mass 与显式前提下的抽象 bridge；
  [`MersenneOrderBlockDecomposition20260901`](Lean/IUTThreeClosures/MersenneOrderBlockDecomposition20260901.lean)
  进一步核验 exact-order 局部 LTE、`L_m|m`、逐素数 base exponent 及
  `W_m=L_m*prod_(d|m)E_d` 的显式有限乘积；
  [`MersenneOrderBlockAsymptotic20260901`](Lean/IUTThreeClosures/MersenneOrderBlockAsymptotic20260901.lean)
  核验 canonical `E_d` 与 relative block 的一致性、对数 divisor-sum 恒等式，
  以及以开放前提 `log E_d=o(phi(d))` 推出 `log W_m=o(m)`。尚未证明的是该
  前提本身与外部 Erdős--Shorey 输入，而不是分解或条件渐近 passage。
  [`MersenneCanonicalBlockWitness20260901`](Lean/IUTThreeClosures/MersenneCanonicalBlockWitness20260901.lean)
  又核验 `ord_1093(2)=364`、该处 valuation 恰为 2 及 `1093|E_364`，从而只
  关闭“所有 canonical block 都等于 1”的加强命题。最新 cyclotomic 文献
  审计进一步给出 `E_d=Phi_d(2)/rad(Phi_d(2))`，而 Brun--Titchmarsh 无条件
  控制 `q≤phi(d)^2/log log(3d)` 的 repeated-prime 小臂。若开放 little-oh
  失败，质量必须落入 super-Wieferich 深提升、近二次区间内
  `Omega(phi(d)/log d)` 个同阶 Wieferich 素数聚簇，或零密度 exceptional
  small-order 大素数的加权尾。
  [`MersenneWieferichTailReduction20260901`](Lean/IUTThreeClosures/MersenneWieferichTailReduction20260901.lean)
  核验这套 powerful-part 比较、有限质量三分核心及论文 (6.15) 的显式
  ambient square-budget 比率；外部 cyclotomic、
  Brun--Titchmarsh、totient 与 order-distribution 定理仍明确留在 Lean 外。见
  [`Mersenne 报告`](research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md)。

相应纸面证明均先于 Lean 核心；任何未证明的无限族、IUT 全局运输、文献
渐近输入或 abc 本身都没有被伪装成 Lean 公理。当前没有无条件
`ABCConjecture` 的 Lean 闭项，也没有其严格否定项。

本检查点的[封存验证包](Lean/verification/2026_09_01_prime_unit_two_arm_layer/)
逐项重放 8 个模块与 14 个编译/计算任务：176 条定理、37 个定义、3 个
abbreviation、4 个 structure，共 220 个顶层声明；177 次 `#print axioms`
的依赖并集恰为 `Classical.choice`、`propext` 与 `Quot.sound`，聚合目标完成
9206 jobs。482 项 Git 索引输入清单 SHA-256 为
`e4c91809276e2890008e5ca1689a59d85e938620938ab87fedcc8756a8b31462`，
封存账本 SHA-256 为
`36cb329de8038b6bbb96a4a14760d4bb8211b00a34581a99769c28faa8e80bff`。

作者为 ChatGPT 的[134 页英文论文](output/pdf/ChatGPT_ABC_Prime_Unit_Two_Arm_Layer_Continuation_2026_09_01.pdf)
SHA-256 为
`594ef475fd66d43f4e2fc8bae355bde9af1fde21f66a64a3e67e8a370846ddad`；
[PDF QA](output/pdf/ChatGPT_ABC_Prime_Unit_Two_Arm_Layer_Continuation_2026_09_01_QA/QA.md)
记录了全页渲染、文本与元数据检查。

## 2026-09-01 最新四路线续研：holonomy、仿射密度与深素数逃逸

标准、无条件的 `ABCConjecture` 仍未被证明或证伪。本检查点继续同时进行
正向证明与反例搜索；不会因为路线困难或有限搜索没有命中而将其关闭，反例
也只淘汰其满足全部假设的精确命题。统一结论、证明边界与下一步门槛见
[`四路线综合报告`](research/ABC_MULTI_ROUTE_HOLONOMY_DEPTH_CONTINUATION_2026_09_01.md)。

- **修正后的 IUT/LANA log-volume 路线。** 在非空、有限正 Haar 体积的
  p-adic valuation balls 上，乘以素数的逆像使 log-volume 精确增加
  `log p`；有限归一化 packet 与 procession 保留该位移，而对象级闭合运输
  必须具有零 holonomy。不同有理素数的对数对有理系数线性无关，因此有理
  位移账本逐素数抵消。另一方面，报告给出了 `log 2,log 3,log 5` 上两个
  不同、严格正且归一化的权重三元组，它们具有同一标量平均。这一完整反例
  关闭“一个标量可重构带标签权重”的命题；未修正的正位移闭环也被排除。
  它们都不否定保留局部标签与真实修正项的 object-level same-pilot 路线。
  见 [`修正体积与 holonomy 报告`](research/ABC_IUT_CORRECTED_VOLUME_HOLONOMY_2026_09_01.md)。
- **最小步长仿射路线。** cofactor gaps 可精确恢复 seed；其逆刻画必须使用
  严格边界 `1<U<W<V`。三元组 `(U,W,V)=(1,3,5)` 满足把边界放宽为
  `1≤U` 后的全部整除与互素假设，却给出 `h=0`，因而是该弱表述的完整
  反例。每个目标异常点都迫使两个 long arms 同时满足
  `8192 E(V)>Rc` 与 `8192 E(W)>Rc`；同时，对每个固定 `theta<5/2`，
  `R<c^theta` 时存在正比例的 admissible 参数使 `U,V,W` 全部 squarefree。
  该 generic bulk 可与稀薄异常集并存，不能反驳仍开放的 matching lower
  bound。见 [`仿射密度报告`](research/ABC_AFFINE_DENSITY_ATTACK_2026_09_01.md)。
- **balancing-Pell 四素数耦合路线。** 每个通道得到 pointwise
  simple-or-odd-depth-three 二择一，并建立模 `4 ell^2` 的二阶耦合与互反
  约束；两个分别无限的 simple-index 集合不能据此推出交集无限。两套独立
  穷举实现检查了全部 `50,847,533` 个奇素数 `q≤10^9`，只发现
  `13,31,1546463` 三个精确 depth-two 命中，未发现 depth three。因此任何
  所需 depth-three rational balancing prime 必须大于 `10^9`；这只是严格
  有限下界，不是不存在性证明，四素数包路线继续开放。见
  [`Pell 四素数耦合报告`](research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md)与
  [`可复算证据`](research/computation/2026_09_01_pell_four_prime_coupling/)。
- **Danilov/Fibonacci 深素数路线。** 若最终 4398 位、638 素因子的递归
  progression 中存在 squarefull survivor，则因子界放大定理强迫至少
  `2^638-622` 个不同的 Wall--Sun--Sun 素数；其中一个 `2^637` 元子族的
  每个素数都大于 `10^2199`，另至少一个大于 `10^4399`。这是从 survivor
  假设出发的无条件蕴含，但现有理论没有给出 WSS 素数总数上界，所以尚未
  形成矛盾。`Phi_10(-3)=11^2` 且导数、判别式模 11 非零，完整否定的只是
  “simple root/非零判别式自动排除平方整除”的捷径。Danilov 路线仍 active。
  见 [`WSS escape 报告`](research/ABC_DANILOV_WSS_ESCAPE_2026_09_01.md)与
  [`可复算证据`](research/computation/2026_09_01_danilov_wss_escape/)。

上述数学证明完成后，才加入四个对应 Lean 核心模块：
[`IUTCorrectedVolumeHolonomy20260901`](Lean/IUTThreeClosures/IUTCorrectedVolumeHolonomy20260901.lean)、
[`AffineDensityAttack20260901`](Lean/IUTThreeClosures/AffineDensityAttack20260901.lean)、
[`PellFourPrimeCoupling20260901`](Lean/IUTThreeClosures/PellFourPrimeCoupling20260901.lean) 与
[`DanilovWSSEscape20260901`](Lean/IUTThreeClosures/DanilovWSSEscape20260901.lean)。
它们形式化各报告中已证明的初等核心，不把高层文献输入或 abc 本身声明为
Lean 公理。当前仍没有无条件的 `ABCConjecture` 闭项或其严格否定项。

本检查点的[永久验证包](Lean/verification/2026_09_01_holonomy_depth_continuation/README.md)
记录了四个模块的零警告直接编译、`9198`-job 聚合构建、`92` 个声明、
`58` 次 `#print axioms`、三套计算证据与三套来源账本的重放结果。英文期刊稿
由 ChatGPT 署名，共 124 页；[最终 PDF](output/pdf/ChatGPT_ABC_Holonomy_Depth_Continuation_2026_09_01.pdf)
的 SHA-256 为
`02c415a2f49575117dc5ae86f43c810a63c3cc6e201b1e82def151d93d934df9`，
[PDF QA](output/pdf/ChatGPT_ABC_Holonomy_Depth_Continuation_2026_09_01_QA/QA.md)
覆盖全部页面及新章节高分辨率抽检。

## 2026-09-01 最新五路线续研：全局包、递归提升与同一 pilot 规格审计

标准、无条件的 `ABCConjecture` 仍未被证明或证伪。以下成果同时推进正向
证明与反例搜索；有限范围内没有找到反例绝不构成一般证明，局部反例也只
关闭其完整假设所覆盖的精确命题。五路线的统一证明、反例与开放门槛账本见
[`全局包续研综合报告`](research/ABC_MULTI_ROUTE_GLOBAL_PACKET_CONTINUATION_2026_09_01.md)。

- **仿射 radical-step 路线。** 将 shear 步长从 `abc` 降到
  `Q=rad(abc)` 仍保留本原性和三种成对投影的单射性，并且不缩小原始纤维。
  `rad(abc)=abc` 时纤维不变；含有重复素因子时才严格增大。
  在已有异常集上界下，所需 matching lower bound 与次临界 seed 高度有界性
  逻辑等价；固定 CRT 模板的密度主项不足以给出该下界，但大模边界、模板
  并集与偶然高重因子仍开放。对 seed `(1,8,9)` 的 447,120,793 个合格点
  未发现异常，以及显式全平方但非异常的例子，都只是有限 no-go，不能关闭
  eventual matching-lower 路线。见
  [`仿射 matching-lower 报告`](research/ABC_AFFINE_MATCHING_LOWER_GATE_2026_09_01.md)。
- **balancing-Pell 全局包路线。** 已证明 prime-power rank 的精确
  order-stagnation 公式与两通道耦合，并对 Fellini--Murty 第 8 节证明架构
  进行审计、修补后重新证明所用全局二择一；这里不是把印刷论证原样当作
  输入。对全部奇素数 `q≤10^8` 的精确扫描只得到三个 depth-two 素数，
  没有 depth-three 命中。`13` 与 `1546463` 给出精确反例，关闭“通道、
  prime-rank 或边界等号自动推出 valuation one”等加强命题；四素数、两
  depth-three 包的原路线仍开放。见
  [`Pell 全局包报告`](research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md)。
- **Danilov 递归提升路线。** Danilov 轨道被化为 Fibonacci 指标恒等式；
  若每个自适应指标都有 simple primitive divisor，则可不断加入新素数并
  与固定非零整数的有限素因子支持矛盾。计算构造了 626 个非退化提升包和
  一个 4398 位模数；末端 `p≤10^8` 无新包只是有限结论。一个完整抽象
  countermodel 只否定“单次非零局部斜率自动保证无限递归”，不否定实际
  Danilov/Fibonacci 路线。见
  [`递归提升报告`](research/ABC_DANILOV_RECURSIVE_LIFT_2026_09_01.md)。
- **Fibonacci simple-primitive-divisor 路线。** 纸面结果把失败情形压缩为
  强约束的 Wall--Sun--Sun powerful cyclotomic 包。标准实 Lucas 序列
  `P=2,Q=-3` 在指标 10 只有 primitive prime `11`，且
  `11^2∥U_10`；这完整关闭的只有“所有标准实 Lucas 序列在每个 `10Q`
  指标都有 simple primitive divisor”这一普适捷径。它不是 Fibonacci
  反例，Danilov 所需 SPD 命题继续开放。另一个精确例子 `n=15,p=61`
  关闭了漏写偶性时的 half-Lucas `s=±1` 辅助命题；实际指标 `10Q` 均为
  偶数。对 252 个小 `Q` 的有界搜索给出
  207 个证书和 45 个未决项，未发现反例也不构成证明。见
  [`SPD 报告`](research/ABC_DANILOV_SIMPLE_PRIMITIVE_DIVISOR_2026_09_01.md)。
- **IUT/LANA same-pilot 路线。** 对固定提交 `ddaddc2` 的实际类型证明了：
  当前低分辨率 `RHSData` 把非零加性缩放律量化到所有集合，空集立即产生
  矛盾，因而该记录不可居住且其 universal target 只能真空成立。这只否证
  pinned LANA 规格作为可满足接口，不否证修正后的 log-volume、IUT 或
  abc。对象级 pointed same-pilot 正向充分接口已经保留，真正的同一 pilot
  构造与输出界仍是开放任务。见
  [`LANA same-pilot 审计`](research/ABC_IUT_LANA_SAME_PILOT_AUDIT_2026_09_01.md)。

上述纸面证明之后已加入五个对应 Lean 核心模块：
[`AffineRadicalStep20260901`](Lean/IUTThreeClosures/AffineRadicalStep20260901.lean)、
[`PellPrimeRankCounterexamples20260901`](Lean/IUTThreeClosures/PellPrimeRankCounterexamples20260901.lean)、
[`DanilovRecursiveLift20260901`](Lean/IUTThreeClosures/DanilovRecursiveLift20260901.lean)、
[`DanilovSimplePrimitiveNoGo20260901`](Lean/IUTThreeClosures/DanilovSimplePrimitiveNoGo20260901.lean)
与
[`IUTLanaSpecificationNoGo20260901`](Lean/IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean)。
这些模块不把尚未形式化的高层文献定理伪装成 Lean 公理。

最终冻结的
[`全局验证包`](Lean/verification/2026_09_01_global_packet_continuation/README.md)
逐项重放五个模块和四个计算包：`122` 条 theorem/lemma、`37` 个
def/abbrev、`5` 个 structure/class/inductive，共 `164` 个顶层声明；`83`
个 `#print axioms` 的依赖并集仅为 `Classical.choice`、`propext` 与
`Quot.sound`。五个直接编译均为零警告，`lake build IUTThreeClosures`
完成 `9194` jobs；冻结包 `SHA256SUMS` 的 SHA256 是
`da4e28c8e80c0439bb8a9954bbe76cbc853bbeda1a04c735721890b766f17e8f`。

作者为 **ChatGPT** 的英文期刊稿已更新为
[`119 页 PDF`](output/pdf/ChatGPT_ABC_Global_Packet_Continuation_2026_09_01.pdf)，
SHA256 为
`6d3e1faed22053e973f8d87fd669423d7c02a8bed6cc557435a9458b3d8b237e`。
全部 119 页均已渲染检查；机械与视觉记录见
[`PDF QA`](output/pdf/ChatGPT_ABC_Global_Packet_Continuation_2026_09_01_QA/QA.md)。

## 2026-09-01 早期续研检查点：仿射上界、Pell 稀有包与 Danilov 全局指标筛

标准、无条件的 `ABCConjecture` 仍未被证明或证伪；这不是一个声称解决
abc 的发布。该检查点的综合报告是
[`2026-09-01 平衡持续性续研`](research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_09_01.md)，
并继续同时推进正向证明和反例构造。

- 仿射 shear 路线得到 seed-uniform 上界
  `#E(X) << R^(-2/3) X^(2μ/3+ε)`；在 `X=c^8, μ=3/4` 时为
  `R^(-2/3)c^(4+ε)`。因此新的精确正向门槛是证明匹配的统一下界
  `R^(-2/3)c^(4+η)`。同一素数处的独立性模型已有严格反例，但完整仿射
  路线没有被反例推翻，继续保留。
- Pell/balancing 路线证明：任一假想平方满项都下降到一个奇素数指标，
  并强迫四个同秩 balancing-Wieferich 素数，其中两个分属互素通道且首次
  赋值至少三。对所有 `q≤2,500,000` 的 183071 个奇素数的精确扫描未发现
  depth-three 命中；`2≤n≤2000` 仅 `1873,1951` 尚未决，它们不是命中。
- Danilov–Hall 路线把任一可能的平方满指标强迫到一个显式 42 位同余类；
  因而排除了前
  `122136955032565025967809449110840347537827` 个非负指标。幸存同余类仍
  未判定，所以路线保持活跃。
- Walsh 的无限族严格保留原文正秩前提：只有当
  `Y²=X³−432p²` 对所选奇素数 `p` 具有正秩时才得到相应无限族；它没有
  被写成无条件输入。

三份新增结果模块共有 **57 条 theorem 与 30 个 def/structure，共 87 项
声明**。四个直接 Lean 编译与 **9151 jobs** 聚合构建全部通过；源码没有
`sorry`、`admit`、`native_decide`、声明公理、`opaque` 或 `unsafe`，核依赖
仅出现 `propext`、`Classical.choice`、`Quot.sound`。可重放证据见
[`Lean 验收记录`](Lean/verification/2026_09_01_balanced_persistence_continuation/VALIDATION.md)。

作者为 **ChatGPT** 的英文期刊稿现为
[`111 页 PDF`](output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_09_01.pdf)，
SHA256 为
`609962b0bf64daf51e5822410c1dbcdff4f55ae452c70d2da6db9fc3e9f87bbc`。
相关页全部重渲染并检查，机械与视觉记录见
[`PDF QA`](output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_09_01_QA/QA.md)。

## 2026-08-31 上一平衡续研阶段（历史冻结）

标准、无条件的 `ABCConjecture` 仍未被证明或证伪。本阶段把正向证明和
反例搜索放在同一个严格判据下继续推进，完整综述见
[`平衡续研报告`](research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_08_31.md)。

正向路线构造了两参数仿射 shear：每个合格参数都给出不同的本原 abc
点，在目标高度 `c^8` 下原始纤维至少有 `c^6/32` 个点。真正缺失的是
新仿射因子的实际重复素因子下界，例如在每个固定次临界源区域上一致证明
`|E_c| ≥ c^(17/4)`。现有上界没有反驳该目标；`14/3` 只是放松的最坏
seed 形状下预算指数的下包络，不是每个 seed 的统一纤维上界。

反例路线保留多个互不替代的严格接口：无界平方满 balancing/Pell 子序列
会通过相邻因子给出 radical 斜率 `1/2`；平方满 Hall 余项且
`K² ≤ X` 会给出斜率小于 `11/12`；Danilov、Mordell EDS 与 Walsh
家族都已有明确的 strict-upgrade 条件。上述升级条件均未被证明存在，也未
被证明不可能。Cohn–Nitaj 的基本 `(3,3,3)` 家族以及普通连续 powerful
对只达到临界线；Walsh 分支还须保留其正秩前提。不能仅凭这些 fullness
证书否定 abc。

最终有限搜索证据已永久保存于
[`targeted counterexample search`](research/computation/2026_08_31_targeted_counterexample_search/REPORT.md)，
并附有[复现说明](research/computation/2026_08_31_targeted_counterexample_search/REPRODUCE.md)
与[完整 manifest](research/computation/2026_08_31_targeted_counterexample_search/manifest.json)。
balancing 序列在 `2≤n≤1000` 的 999 项全部有 `v_p(u_n)=1` 素数证书，
其中包括 168 个素数指标。扩展到 `n≤2000` 后，1999 个非单位项中已有
1990 项获证；九个未决指标为
`[1009,1181,1667,1699,1723,1847,1873,1901,1951]`，它们既不是命中，
也不是已证非命中。原未决的 `1711=29*59` 已由 `p=44560482149` 的模
`p²` 证书解决。Danilov 前向轨道 `0≤t≤80` 的 81 点也各有
`v_p(K_t)=1` 证书；五小素数周期筛首次未覆盖 `t=326`，这只是筛法未给
证书，不是平方满命中。有限结果绝不关闭 Pell 或 Danilov 路线。永久目录
重放 `exact_audit.py` 后 85 项 manifest 全部匹配；manifest SHA256 为
`62abe5c80716d9e4d5697df95e5330b9fb3d011f463d4647e72332c9288bbac3`。

本阶段遵循“先数学证明、后 Lean 形式化”。不会因困难、有限搜索失败或暂时
缺少证明而放弃路线；实际反例只淘汰其直接否定的精确命题，严格 no-go
定理也只关闭其假设覆盖的局部机制。四个新数学模块的显式手写顶层清单为
**62 条 theorem 与 15 个 def/structure，共 77 项声明**；自动生成的
structure 投影、构造器和递归方程不计入 77。配套 audit 文件逐项
`#check` 与 `#print axioms`。冻结的
[`Lean 验收包`](Lean/verification/2026_08_31_balanced_persistence/VALIDATION.md)
记录：四模块与 audit 直接编译均 exit 0、零警告；audit target 为 8767 jobs、
19 条历史依赖警告且新模块为零，library target 与默认构建均为 9147 jobs、
265 条警告，并与 dual-route 冻结基线同多重集。扫描无 `sorry`、`admit`、
公理声明、`unsafe` 或 `sorryAx`；依赖并集仅为 `propext`、
`Classical.choice`、`Quot.sound`。13 个 JSON、22 项 manifest 和
`SHA256SUMS` 的 23 项均通过复核；`SHA256SUMS` 的 SHA256 为
`4e25867f5026bbd04a05240de9d6f51e06abc6518bf9819d48aaa03d1bb85916`。
作者为 **ChatGPT** 的最终英文论文
[`ChatGPT_ABC_Balanced_Persistence_2026_08_31.pdf`](output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31.pdf)
共 109 页、830854 bytes，SHA256 为
`ccbc4d77d112aec78a869caba53104b133467f6cd4a60ee528e09437f79d2e3e`。
全部 109 页已按 110 dpi 重渲染；相对上一份完整检查候选，仅 102–109 页
变化，八页均经原始渲染尺寸逐页检查通过。提取文本共 340732 字符，单页
最少 1926 字符；29 个字体资源全部嵌入，文件无表单与 JavaScript，最终
日志只有一个既存 underfull。保留的
[`QA 目录`](output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31_QA/)
中 `SHA256SUMS` 的 SHA256 为
`206f1edb9c9e190ec65c3333ddf2a3166fefe06f907e132f349725897be18e98`。

2026-08-31 的最新双路线续研同时推进正向证明与反例搜索。正向路线证明：
标准对数 abc 猜想恰好等价于每个固定斜率 `mu<1` 的次临界 radical
区域具有一致高度上界；它还严格说明正幂计数和平方级间隔仍不足以推出
有限性，并给出可闭合该缺口的单源放大判据。反例路线证明 residual-kernel
escape 必要条件与 Mason--Stothers 多项式障碍，并得到一个严格条件门：若
`x²−8y²=1` 的正 Pell 根 `y` 有无界平方满子序列，则 `(1,8y²,x²)`
无条件否定原始 `ABCConjecture`；该平方满前提目前仍未证明。
完整结论与下一步门槛见
[`双路线总报告`](research/ABC_DUAL_ROUTE_CONTINUATION_2026_08_31.md)。

本轮六个 Lean 模块有 **94 条公开定理与 15 个额外定义/结构，共 109 项**；
5 项无公理，其余只依赖 `propext`、`Classical.choice`、`Quot.sound` 的子集，
没有 `sorryAx`、声明式数学公理或 `unsafe` 证明。默认构建通过
**9142 jobs**，265 条警告与冻结基线完全同多重集，新增模块零警告。
作者为 **ChatGPT** 的英文研究稿现为 **102 页**，最终 TeX 检查零告警，
全部页面已经渲染并逐页看图检查：
[`102 页论文 PDF`](output/pdf/ChatGPT_ABC_Dual_Route_2026_08_31.pdf) ·
[`Lean 与 PDF 验收`](Lean/verification/2026_08_31_dual_route_continuation/VALIDATION.md)。
一般 abc 猜想仍未被证明或证伪，本仓库也未作期刊提交。

同日上一完成阶段证明了完整两素数子类上的锐界
`2c ≤ 3 rad(abc)`、有标签奇数部分纤维的精确上界二，以及一族 Frey
曲线整个有理同源类的精确最小 Weil 高度 `3 log(c²−16c+16)`。
IUT 路线得到有限 theta 点源的共同最低层，并把 canonical 轨道点放入
原文一个同步基本分支的局部 raw 输出集；这只给局部下包含，没有完成
完整全局 pilot、Ind3 或跨 Frobenius 比较。
证明、文献和边界见
[`本轮多路线总报告`](research/ABC_UNIFORM_CONTINUATION_2026_08_31.md)。

上一阶段英文研究稿作者为 **ChatGPT**：
[`93 页论文 PDF`](output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf) ·
[`LaTeX 源文件`](paper/ChatGPT_ABC_Uniformity_2026.tex) ·
[`本轮 Lean 与 PDF 验收`](Lean/verification/2026_08_31_uniform_continuation/VALIDATION.md)。
默认构建通过（**9135 jobs**），265 条警告与旧记录完全一致，无新增警告。
五个新模块的 **97 条公开定理与 9 个额外构造，共 106 项**全部完成公理
依赖审计；3 项无公理，其余只使用 Lean 标准三公理的子集，没有 `sorryAx`。
旧 145、89、43 项审计重新通过。93 页英文稿编译零最终警告，已由四名
智能体分段逐页看图检查。内部复核不称作外部人类同行评审。

新 PDF 使用带日期的文件名：原同名 PDF 正在 WPS 中打开，未打断该会话；
请使用上面的新链接。完整同源类分类、局部类域论和 canonical IUT 来源
证明仍有纸面证明边界，没有被虚报为 Lean 全部形式化。这里没有一般 abc
的证明或证伪，也没有提交期刊。

上一完成阶段的实际完整局部 Galois 映射、精确 trace-dual hull、无界
Frey 族与全部原始初始 theta 数据保留在
[`完整 Galois 与初始数据报告`](research/ABC_GALOIS_LIFTS_2026_08_31.md)。
其 **66 页已验收 PDF**与另外五个可变入口的逐字快照位于
`Lean/verification/2026_08_31_uniform_continuation/previous_snapshot/`；
旧 **705 项**清单经六处映射完整重放，原清单未改。

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

## 2026-09-01 本地与云端分支整合

本轮把本地续研成果、最新 `origin/main`，以及五条仍有独立数学内容的云端
路线合并到同一条可构建历史中：v27 的互素 residual-product/cube-divisor
路线、v29 的 exponent-height ledger、cross-support exponent-depth、
shared-support affine contact，以及包含 v29b--v29i 的 cross-endpoint
contact-depth/no-go 链。仅用于临时定向构建或成功标记的工作流没有进入最终
树；诊断分支和已被后续分支覆盖的旧版本仍保留在远端供审计。

统一入口现显式导入这些模块，并复用了仓库已有的 `endpointMin` 与
`largeEndpoint` 定义。针对 Lean 4.32 的命名空间闭合、有限乘积类型转换、
接触恒等式符号、乘法结合形式和正性前提均已修复。默认 `lake build`
成功完成 **9189 jobs**。同时保留了闭射线逼近桥：它形式化了原文
source-defined ordered hull 条件及何种定量逼近足以推出 IUT III
Corollary 3.12 中的实数闭射线成员关系，也给出固定误差和纯定性链接不足的
反例；它没有假设尚缺失的同一 pilot 全局 hull 类型对应。

完整分支、修复和验证清单见
[`2026-09-01 云端整合验收记录`](Lean/verification/2026_09_01_cloud_integration/VALIDATION.md)。
一般 abc 猜想在本轮之后仍未被证明或证伪。
