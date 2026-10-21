# 平安人寿在售产品文件

本目录为平安人寿官网公开产品目录中标记为“在售”的产品文件快照。

每个产品目录包含官网可用的公开文件：

- `保险条款.pdf`
- `费率表.pdf`
- `产品说明书.pdf`
- `product_meta.json`：产品编码、版本号、销售状态、日期和下载结果

来源接口：

- 产品目录：<https://life.pingan.com/ilife-home/product/getProductList>
- 产品文件：<https://life.pingan.com/ilife-home/product/getPlanClausePdf>

采集清单见 `products_manifest.csv`。采集状态以 `product_meta.json` 和清单为准；官网未标注的附件不会生成空文件。
