# PROGRESS — 自动选品流程

## 2026-02-16
- 项目启动：明确三层架构（ERP+前台采集 → 中间层评分/沉淀 → LLM 输出报告）。
- 收到并读取 Downloads 文档：API 清单/拼装链路、字段字典、广告得分规则、销量/排名推断框架。

Next (薄切片优先):
1) 把“ERP 已有字段 vs 前台缺失字段”做成一张对照表（Top20 字段）。
2) eMAG 前台字段勘探结论：JSON-LD 不足/可能不存在；优先从页面 `window.EM.listingGlobals` 抽取 items（id/name/category/vendor/availability/badges 等），并用 DOM 解析补齐价格与 SKU（从 URL 提取）。
3) 反爬策略：AWS WAF Captcha 触发敏感；先按“有头浏览器低频过一次验证码→复用 cookie 用 request 高频”的路线验证可行性；遇验证码就暂停并记日志，等你在场处理。
4) 需要你提供/确认：
   - 你同事验证的“cookie 复用 + request 高频”具体口径（有效 cookie 哪些键、有效期/刷新条件）
   - 最小需要抓取的字段 Top10（用于第一版表格输出）
