# 仿东南大学论文模板

使用 Typst 复刻东大本科毕业设计模板和研究生学位论文模板。

> [!IMPORTANT]
>
> 此模板是民间模板，学校可能不会认可本模板。
>
> 此模板内可能仍然存在诸多格式问题。

## 本科毕业设计论文模板

此 Typst 模板基于东南大学本科毕业设计论文模板（2019 年 9 月）仿制，原模板可以在[教务处网站](https://jwc.seu.edu.cn/2021/1108/c21686a389963/page.htm)上下载。

此模板参考了来自 <https://github.com/lucifer1004/pkuthss-typst> 的 typst 格式。在 `template/graduation.typ` 中使用了一部分来自此项目的代码。

模板主文件是 `template/graduation.typ`。目前，此模板已是初步成品。您可以打开 `demo_graduation_thesis.pdf` 查看效果。

## 学位论文模板

此 Typst 模板基于[《东南大学研究生学位论文格式规定》](https://seugs.seu.edu.cn/_upload/article/files/5d/c2/abe9785f44c8b3ea4823f14bfb92/cd829a73-1b86-400d-9bce-2c4b4fdb85b7.pdf)制作，制作时参考了 [SEUThesis 模板](https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/seuthesis/seuthesis.pdf)。

模板主文件是 `template/degree.typ`。目前，此模板已是初步成品。

## TODO List

毕设：

- [ ] 将模板内涉及计数器的部分重构。
- [ ] “代码展示块”功能。
- [ ] 实现“续表”功能。
- [ ] 改用符合东大要求的 csl。
- [ ] 基本文档与使用教程。

学位：

- [ ] 格式细化。
- [ ] 修复自动切换奇数页。
- [ ] 公式编号位置调整到最后一行。
- [ ] Demo PDF。
- [ ] 基本文档。
- [ ] 使用教程。

## 目前存在的问题

- 中文首段有时会自动缩进，有时不会。如果没有自动缩进，需要使用 `#h(2em)` 手动缩进两个字符。
- 中文粗体不可用（章节标题等目前没有加粗）。这是因为 Typst 0.10.0 尚未支持伪粗体，而宋体黑体等字体没有多重字重。在 0.10.0 后的 commit 中，mgt 等开发者为 Typst 提供了字体描边功能，预计 0.11.0 即可直接或间接支持伪粗体。
- 参考文献格式不完全符合要求。
- 行距、边距等有待调整。
- 学位论文中，自动切换奇数页暂时不工作。

## 协议

除下述特殊说明的文件外，此项目使用 MIT License 。

- `demo_image` 路径下的文件来自东南大学教务处本科毕设模板。
- `template/image` 路径下的文件来是由东南大学教务处模板经二次加工得到。
- `font` 路径下的文件是此模板用到的字体。
- `毕业设计论文参考模板.docx` 是教务处提供的毕设论文模板。
