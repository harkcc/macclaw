# ERP 已有字段 vs 前台缺失字段 — Top20 对照表（雏形）

> 目的：第一阶段薄切片的“字段对照表”。
> 说明：
> - ERP 已有字段主要来自：`/api/pnkStockMonitorBas/list*`、`/pnkRankServer/*`、`/api/emSellerInfo/*`、`/api/emCategoryMetrics/*`。
> - 前台缺失字段：指 ERP 文档/字典未明确提供、但选品/运营常用的字段。部分可能存在于 Listing 经营接口里（需抓 `/api/listing/list` 样例确认）。

## A. 类目层（ERP 已有）
| 字段 | ERP来源 | 用途 | 前台是否还需补 | 备注 |
|---|---|---|---|---|
| scm_id | /api/emCategoryMetrics/list, /api/emCategory/list | join 类目、聚合容量 | 否 |  |
| name_ro | 同上 | 类目名 | 否 |  |
| cateUrl | /api/emCategoryMetrics/list | 类目URL | 否 |  |
| totalProducts | /api/emCategoryMetrics/list | 类目产品规模 | 否 |  |
| livrateDeEmag | /api/emCategoryMetrics/list | 平台介入度/FBE数量 | 否 |  |
| topFavoriteSummary.* | /api/emCategoryMetrics/list | 竞争/分布特征 | 否 | 结构需解析 |

## B. 卖家层（ERP 已有）
| 字段 | ERP来源 | 用途 | 前台是否还需补 | 备注 |
|---|---|---|---|---|
| vendorId | /api/emSellerInfo/list, /api/emSellerInfo/getByIds | 主键 | 否 |  |
| vendorName | 同上 | 卖家名 | 否 |  |
| fbType | 同上 | FBE/FBM | 否 |  |
| sellerType | 同上 | 卖家类型（用于识别中国卖家候选） | 可能 | 需要你确认口径 |
| productCount | 同上 | 店铺规模 | 否 |  |
| tip | 同上 | 备注/标签 | 可能 | 可能含人工标注 |

## C. 产品/PNK层（ERP 已有）
| 字段 | ERP来源 | 用途 | 前台是否还需补 | 备注 |
|---|---|---|---|---|
| pnk | /api/pnkStockMonitorBas/list* | 产品标识 | 否 |  |
| seller_id | /api/pnkStockMonitorBas/list* | 行主键之一 | 否 |  |
| vendor_id | list* 或 /pnkRankServer/getPnksInfo.lastInfo | join 卖家 | 否 |  |
| scm_id | list* | join 类目 | 否 |  |
| price | list* | 价格带 | 类目页可能需校验 | 前台价格可能更实时 |
| soldT7 / soldT30 | list* | 核心销量信号 | 否 |  |
| lastNatrueRank / lastAdRank | list* | 竞争/曝光信号 | 否 |  |
| stock | list* 或 getPnksInfo.lastInfo.stock | 库存快照 | 否 | 有封顶/遮蔽问题 |
| rating / reviews | list* | 口碑信号 | 类目页可校验 |  |
| availability_text/type_id | list* / getPnksInfo.lastInfo | 库存/配送状态 | 可能 |  |

## D. 仍需前台/单品页补齐（优先级高）
> 这些字段大概率来自：单品页 DOM / 页面内 JSON（如 window.EM.*）/ 或你提到的“最简单接口”。

| 缺口字段 | 为什么需要 | 预计来源 | 备注 |
|---|---|---|---|
| 近10条评论（文本/星级/时间） | 选品质量/差评原因/定位 | 单品页/接口 | 你提到接口可直接给 |
| 详情属性词/规格（容量/功率/尺寸等） | 关键词库/差异化 | 单品页 DOM/JSON |  |
| 关键词/SD词（搜索/推荐词） | 关键词库、广告/SEO | 单品页/接口 | 需要验证是否可得 |
| 图组质量特征（图数量/是否带场景/尺寸） | 评分/精选 | 单品页图片/DOM | 可计算特征 |
| 卖家更完整信息（国家/是否中国卖家） | 只分析中国卖家 | 单品页/ERP sellerType/tip | 需要你定义规则 |

## E. 经营/利润侧缺口（需抓 Listing 样例确认）
| 字段 | 状态 | 下一步 |
|---|---|---|
| profit.* / emSaleInfo.* / emAttribute.* / customeCostInfo.* | 文档未展开（unknown） | 抓 `/api/listing/list` 返回样例，补字段字典与 JSON path |

## 下一步（薄切片）
1) 从 ERP 里抓一份 `/api/listing/list` 的真实返回（脱敏）补齐 Listing 字段字典。
2) 你给 1 个 eMAG 单品链接：验证“最简单接口”能否直接给评论/详情/关键词等。
