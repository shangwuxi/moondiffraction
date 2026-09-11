# MoonDiffraction 查重与方向决策

日期：2026-09-11。MoonINI 因 MoonConfigKit 重合被退回，旧项目保留；不是改名重投。用户授权选择新方向并上传 shangwuxi。

## 不同领域候选
|候选|工作流/相邻证据|决策|
|---|---|---|
|MoonCutStock|下料优化；rectloom 0.1.0 与 moonbit_constraint 0.1.0 已有装箱约束|放弃相邻风险|
|MoonDew|湿空气焓露点；liying-han/moonbit-energybalance 0.2.3 已含 psychrometrics|拒绝直接重合|
|MoonTransit|公交时刻到旅程；ATS timetable 与保留 MoonRecur 相邻|不选|
|MoonWeave|织造矩阵/浮线；另一窗口已新登记同工作流|拒绝碰撞，未改动其文件|
|MoonCrystal|晶胞/CIF 模型；BioSeqs 0.1.9 已有 Bio.Crystal|拒绝通用晶体库|
|MoonDiffraction|已有分数坐标到倒易反射、相消、粉末谱|选定，明确扩展 BioSeqs 数据的计算下游|

## 搜索证据与局限
按 osc2026-guide Project Research Guide，检查 MoonCakes 官方 search API、docs 和相关 GitHub 源码。旧 moon 无 search 子命令，web 检索无结果，因此用 HTTP API，不能声称 moon search 成功。关键词：mooncrystal、crystal、crystallography、diffraction、reciprocal lattice、unit cell、Miller indices、structure factor、periodic neighbor、moondiffraction、powder。原始 JSON 保存在 evidence；模糊匹配的 power 等不作为直接重合。零结果不是不存在证明。

主要相邻：https://mooncakes.io/docs/IvanAXu/BioSeqs ，https://github.com/paipai-Studio/BioSeqs 。包 0.1.9，Apache-2.0，仓库未归档，本次所见 pushed_at 2026-09-11。审阅 src/crystal.mbt 的 public API，已有 UnitCell/体积/密度/正交化/坐标转换/空间群小表/原子模型/距离/CIF 解析。该文件未见 reciprocal metric、Miller 枚举、kinematic structure factor、powder profile。这是限定文件的证据，不是全仓库不存在的保证。

## 互补界面和验收差异
从上游 UnitCell 提取 a/b/c/alpha/beta/gamma，从已有 fractional atoms 提取 x/y/z/occupancy，用户另给常数散射权重；本库完成倒易二次型、有限反射、复相位叠加、Bragg 转换及谱线。核心不强依赖大型生物库，文档桥接契约，不重新实现 CIF、晶体化学或通用正交坐标 API。不调用上游坐标转换。禁止扩展完整空间群数据库、真实元素 X 射线散射表、结构精修。不是实验数据分析认证工具。

验收三例：立方 d 间距/Bragg；体心面心相消；三斜反射到分组谱。核心数据 hkl/倒易 Gram 矩阵/复振幅/多重度，完全不同于配置 AST。源码独立实现，参考数学定义而非移植。

## 全登记对照与决策
前序已逐段审阅完整 registry，本次保存最新标题及外部条目比较清单。最接近 BioSeqs，因此须把上述接口边界同时写入 README 和中文申报书；所有其余登记核心领域保留，不复用。工程共同项不算项目身份。registry-comparison.md 不把元数据阅读冒充源码审计。

结论：已完成限定范围查重，未找到同核心成熟 MoonBit 包；BioSeqs 明确相邻且必须互补，残余风险中等。不能保证组委会通过。复核 2026-09-11。
