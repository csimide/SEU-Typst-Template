# 东南大学论文模板

使用 Typst 复刻东大本科毕业设计模板和研究生学位论文模板。

> [!IMPORTANT]
>
> 此模板是民间模板，学校可能不会认可本模板。
>
> 此模板内可能仍然存在诸多格式问题。

> [!NOTE]
>
> 可以看看隔壁 <https://github.com/TideDra/seu-thesis-typst/>项目，也在使用 Typst 复刻本科毕业设计模板，并提供了毕设翻译模板。

此模板组参考了来自 <https://github.com/lucifer1004/pkuthss-typst> 的 typst 格式。在 `seu-thesis/utils.typ` 中使用了一部分来自此项目的代码。

## 本科毕业设计论文模板

此 Typst 模板基于东南大学本科毕业设计论文模板（2019 年 9 月）仿制，原模板可以在[教务处网站](https://jwc.seu.edu.cn/2021/1108/c21686a389963/page.htm)上下载。

模板主文件是 `seu-thesis/bachelor.typ`。目前，此模板已是初步成品。您可以打开 `demo_graduation_thesis.pdf` 查看效果。

## 学位论文模板

此 Typst 模板基于[《东南大学研究生学位论文格式规定》](https://seugs.seu.edu.cn/_upload/article/files/5d/c2/abe9785f44c8b3ea4823f14bfb92/cd829a73-1b86-400d-9bce-2c4b4fdb85b7.pdf)制作，制作时参考了 [SEUThesis 模板](https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/seuthesis/seuthesis.pdf)。

模板主文件是 `seu-thesis/advanced-degree.typ`。目前，此模板已是初步成品。您可以打开 `demo_degree_thesis.pdf` 查看效果。

## 说明

如需使用，先安装 `fonts` 目录下的字体。如需在 Typst.app 在线使用，需要将字体移动到根目录，可能需要修改 `seu-thesis\utils.typ` 内的字体声明。

此模板需要使用 Typst 0.10.0 编译，推荐在本地环境编译。您可以使用 VSCode 配合 Typst LSP、Typst Preview 等插件获得较佳的编辑体验。

模板的使用说明在各自的 Demo 文稿内。

## TODO List

毕设：

- [ ] 将模板内涉及计数器的部分重构。
- [ ] “代码展示块”功能。
- [ ] 实现“续表”功能。（暂时没想明白怎么实现）
- [ ] 改用符合东大要求的 csl。
- [x] 基本文档与使用教程。
- [ ] ref 样式。

学位：

- [x] 格式细化。
- [x] 修复自动切换奇数页。
- [x] 公式编号位置调整到最后一行。
- [x] Demo PDF。
- [x] 基本文档。
- [x] 使用教程。
- [ ] 为正文前的章节添加页眉（合并 header）。
- [ ] 盲审版本。
- [ ] ref 样式。

## 目前存在的问题

- 中文首段有时会自动缩进，有时不会。如果没有自动缩进，需要使用 `#h(2em)` 手动缩进两个字符。
- 中文粗体不可用（章节标题等目前没有加粗）。这是因为 Typst 0.10.0 尚未支持伪粗体，而宋体黑体等字体没有多重字重。在 0.10.0 后的 commit 中，mgt 等开发者为 Typst 提供了字体描边功能，预计 0.11.0 即可直接或间接支持伪粗体。
- 参考文献格式不完全符合要求。
- 行距、边距等有待调整。
- ~~学位论文中，自动切换奇数页暂时不工作。~~ 目前大部分场景自动切换已修复。
- 目前的模板暂时无法实现盲审版本自动隐藏致谢，**可能之后会将致谢内容改成单独的参数传入模板或使用专门的函数**。
- 目前缺少 ref 样式，待修。

## 协议

除下述特殊说明的文件外，此项目使用 MIT License 。

- `demo_image` 路径下的文件来自东南大学教务处本科毕设模板。
- `seu-thesis/image` 路径下的文件来是由东南大学教务处模板经二次加工得到。
- `fonts` 路径下的文件是此模板用到的字体。
- `毕业设计论文参考模板.docx` 是教务处提供的毕设论文模板。
