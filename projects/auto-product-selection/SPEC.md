# SPEC — 自动选品流程（Fzwala ERP + eMAG 前台）

## 问题 / 机会
目前选品依赖人工在 ERP 与 eMAG 前台之间来回核对。目标是把“数据获取 → 中间层评分 → LLM 分析输出报告”做成可跑批、可扩展的 SOP/流水线。

## 目标用户/场景
- 主用户：你（选品负责人），后续可扩展给团队。
- 场景：给定一个或多个类目/卖家/产品集合，自动生成：类目/卖家评分 + 候选产品清单 + 最终选品报告（含分级：精品/精铺/复货/贝格卖）。

## 最终输出（Final output）
1) 一份可执行的“数据获取与字段映射”文档：ERP 已有字段 vs 前台缺失字段；每个字段来源（ERP API / 前台接口 / DOM/LD+JSON）。
2) 一个最小可运行的采集 PoC：
   - 输入：1 个 eMAG 类目 URL（示例：https://www.emag.ro/aspiratoare/c?ref=bc）
   - 输出：抓取 TopK（先 K=30）的产品基础信息 + 近 10 条评论摘要/计数（如果接口可得）+ 关键词/属性（如果可得）
3) 中间层数据模型草案（表结构/主键/增量策略）与评分规则草案（类目、卖家）。
4) 一份选品报告模板（表格字段 + 文本结构），后续自动化生成。

## 成功指标（量化）
- 能稳定抓取 1 个类目 Top30，不触发验证码时成功率 > 95%。
- ERP 字段字典与前台字段字典合并后，缺失字段列表清晰且可复现来源。
- 任意一步出错可回滚/可重跑（留痕：runbook + progress）。

## 约束
- 遇到验证码：立即停抓取/切换到其他研究任务，等你在场再人工过。
- 不在 git 保存 token/账号态。
- 先薄切片跑通，再扩展到多类目/并发。

## 资源（已提供/待提供）
已提供：
- ERP 站点：https://fzwala.com/home/dataBoard （你已在浏览器登录）
- 文档（Downloads）：
  - fzwala_api_catalog_and_flows.md
  - fzwala_api_map.md
  - fzwala_data_dictionary_readable.md 等
- 前台类目示例： https://www.emag.ro/aspiratoare/c?ref=bc

待提供（最小）：
- 你希望输出报告里必须包含的字段（优先级 Top10）
- 你用于“识别中国卖家”的规则线索（比如 sellerType/tip/companyCode 等）

## 风险/未知
- eMAG 前台可能频繁触发验证码/反爬；需要缓存、限速、分层采样。
- 前台关键字段可能在页面计算或二次请求中，需要抓包或解析页面内 JSON/LD。

## 最小可确定性（第一里程碑）
- 只做“字段盘点 + 1 类目 Top30 抓取 PoC（可重复）”。

## 验收/验证
- 产物都落盘：projects/auto-product-selection/ + runbooks/；并在 PROGRESS 记录复现步骤。
