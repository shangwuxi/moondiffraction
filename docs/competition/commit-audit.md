# Commit audit / 提交审查

审查日期：2026-09-11。开发快照 8c59bf4 共 21 个非空 commit；保守计入 20，排除 1 个已有粉末工作流的修复。后续仅发布/证据同步不用于凑此门槛。

逐个 git archive 到独立临时目录，从原提交运行 moon test --deny-warn；oracle/三个示例在出现后的每个提交也重跑。唯一无代码提交审阅查重及方向证据。原始命令/退出码见 evidence/history-replay.json。计数是人工保守判断，不是组委会有效提交认定。

|SHA|主题/目的|变更文件|验证|计入|
|---|---|---|---|---|
|efb46bea8ec8c1416d062068f0176dc9899b726d|docs: select reciprocal diffraction with source-backed ecosystem boundary|docs/competition/duplicate-check.md<br>docs/competition/evidence/Miller_indices.json<br>docs/competition/evidence/crystal.json<br>docs/competition/evidence/crystallography.json<br>docs/competition/evidence/diffraction.json<br>docs/competition/evidence/mooncrystal.json<br>docs/competition/evidence/moondiffraction.json<br>docs/competition/evidence/periodic_neighbor.json<br>docs/competition/evidence/powder.json<br>docs/competition/evidence/reciprocal_lattice.json<br>docs/competition/evidence/structure_factor.json<br>docs/competition/evidence/unit_cell.json<br>docs/competition/external-catalog.md<br>docs/competition/registry-comparison.md|manual source-boundary review: PASS|是|
|97732cbdd2a6386814425ad311ea1bf30c7c73ec|feat: validate cell scalars and derive reciprocal Gram metric|.gitignore<br>metric.mbt<br>metric_test.mbt<br>moon.mod<br>moon.pkg|moon test --deny-warn: PASS|是|
|19bac9f300bcfd2b0199e406500b545cef54f952|feat: model bounded Miller indices and reciprocal plane spacing|miller.mbt<br>miller_test.mbt|moon test --deny-warn: PASS|是|
|7c857f7ea1bc35ccb7aa41027d04d6c70a2bafb9|feat: enumerate complete reciprocal ellipsoids with preflight work budgets|enumerate.mbt<br>enumerate_test.mbt|moon test --deny-warn: PASS|是|
|786b5cc77861fc5d5f0d2076a98c0aa58dd24b1d|feat: validate fractional scatterers with occupancy and isotropic attenuation|site.mbt<br>site_test.mbt|moon test --deny-warn: PASS|是|
|4a0a40e5d13e4845686bf2a290c21a130f8b1550|feat: compute compensated complex structure factors and verify phase invariants|amplitude.mbt<br>amplitude_test.mbt|moon test --deny-warn: PASS|是|
|c10d74ea0352a3350a3df07061b3889d6720f1f9|feat: validate seven translational extinction rules against explicit phase sums|centering.mbt<br>centering_test.mbt|moon test --deny-warn: PASS|是|
|b262f748577d9b7f99da285b7851807470f8b1ab|feat: convert Bragg angles with explicit inaccessible reflections|bragg.mbt<br>bragg_test.mbt|moon test --deny-warn: PASS|是|
|d1ca410a5d6eff490770c8b9547310a3371bca94|feat: integrate complete reflection simulations with separate phase-work budgets|simulate.mbt<br>simulate_test.mbt|moon test --deny-warn: PASS|是|
|79cdf25654b6620fd57d7cfec8c30d25d12b6aea|feat: group powder reflections without tolerance chaining or multiplicity loss|powder.mbt<br>powder_test.mbt<br>powder_wbtest.mbt|moon test --deny-warn: PASS|是|
|fd8f705a8cac42020cdedfde5fd5cbc203602f35|feat: sample area-normalized powder lines with explicit finite-window semantics|profile.mbt<br>profile_test.mbt|moon test --deny-warn: PASS|是|
|9c4507a6f58e5313f720fa5e11bad379eff3e504|feat: match observed peak positions without hiding ambiguous or missing matches|matching.mbt<br>matching_test.mbt|moon test --deny-warn: PASS|是|
|5f9d778ab595a710d1508b69d3a04b1e7a2727ee|feat: derive reciprocal plane angles and bounded zone-axis patterns|zone.mbt<br>zone_test.mbt|moon test --deny-warn: PASS|是|
|aa08f8f8692c42cfff89d84a54653c42e48add4d|feat: expose analytic site sensitivities verified by central finite differences|sensitivity.mbt<br>sensitivity_test.mbt|moon test --deny-warn: PASS|是|
|bdd5e7137ba6f66b17f3bfc6acebfa132ea44b2d|feat: export unit-explicit numeric CSV and versioned reflection JSON|export.mbt<br>export_test.mbt|moon test --deny-warn: PASS|是|
|c17bfaeb0fff3aa3362351b39924f2d642d5675a|test: cross-check reciprocal metrics and amplitudes with independent Cartesian oracle|cmd/oracle/main.mbt<br>cmd/oracle/moon.pkg<br>scripts/oracle.py|moon test --deny-warn: PASS; python scripts/oracle.py: PASS|是|
|a117eb5ed4f1b04a314b5bf4b110024347e30201|test: exercise nonfinite inputs, scale invariants, shell counts and resource limits|properties_test.mbt|moon test --deny-warn: PASS; python scripts/oracle.py: PASS|是|
|187ef7c01be398def132a7e0062f96b30265fdc7|feat: ship three executable diffraction workflows with acceptance assertions|cmd/cubic/main.mbt<br>cmd/cubic/moon.pkg<br>cmd/extinction/main.mbt<br>cmd/extinction/moon.pkg<br>cmd/powder/main.mbt<br>cmd/powder/moon.pkg|moon test --deny-warn: PASS; python scripts/oracle.py: PASS; moon run cmd/cubic: PASS; moon run cmd/extinction: PASS; moon run cmd/powder: PASS|是|
|3843af1cd11c95ee530db2eb1e2e82efed7252f7|fix: reject mixed-wavelength powder input and canonicalize equal-angle members|export.mbt<br>powder.mbt<br>powder_test.mbt<br>powder_wbtest.mbt<br>simulate.mbt|moon test --deny-warn: PASS; python scripts/oracle.py: PASS; moon run cmd/cubic: PASS; moon run cmd/extinction: PASS; moon run cmd/powder: PASS|否：不把已计功能修复另算|
|d6a09dabc30f9991e2c2ed6d3242c6a85c007c94|docs: document scientific contracts, upstream boundary, three workflows and provenance|AI_USAGE.md<br>CHANGELOG.md<br>CONTRIBUTING.md<br>LICENSE<br>README.md<br>SECURITY.md<br>THIRD_PARTY.md<br>cmd/cubic/pkg.generated.mbti<br>cmd/extinction/pkg.generated.mbti<br>cmd/oracle/pkg.generated.mbti<br>cmd/powder/pkg.generated.mbti<br>docs/ARCHITECTURE.md<br>docs/UPSTREAM.md<br>pkg.generated.mbti|moon test --deny-warn: PASS; python scripts/oracle.py: PASS; moon run cmd/cubic: PASS; moon run cmd/extinction: PASS; moon run cmd/powder: PASS|是|
|8c59bf4abe454abbfd7995cf8330feffe223723c|ci: verify four backends, runnable workflows and independent oracle|.github/workflows/ci.yml<br>scripts/verify.ps1|moon test --deny-warn: PASS; python scripts/oracle.py: PASS; moon run cmd/cubic: PASS; moon run cmd/extinction: PASS; moon run cmd/powder: PASS|是|
