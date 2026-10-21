# 平安人寿产品文件

本仓库保存平安人寿官网公开的寿险产品文件，按销售状态分类：

- `在售/`：官网标记为在售的产品（338 个产品目录）。
- `停售/`：官网标记为停售的产品（1503 个产品目录）。

每个产品目录包含官网可用的 `保险条款.pdf`、`费率表.pdf`、`产品说明书.pdf` 和 `product_meta.json`。官网没有标注的附件不会虚构，产品目录中的元数据会记录对应状态。个别历史费率表由官网以 JPEG 返回，保留原始 `费率表.jpg`，同时提供对应的 PDF 版本。

数据来源：平安人寿官网公开接口

- 产品目录：https://life.pingan.com/ilife-home/product/getProductList
- 产品文件：https://life.pingan.com/ilife-home/product/getPlanClausePdf
