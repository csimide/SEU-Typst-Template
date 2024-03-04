# 东南大学论文模板

使用 Typst 复刻东南大学「本科毕业设计（论文）报告」模板和「研究生学位论文」模板。

> [!IMPORTANT]
>
> 此模板是民间模板，学校可能不会认可本模板。
>
> 此模板内可能仍然存在诸多格式问题。
>
> 如需使用此模板，请自行承担风险。

## 研究生学位论文模板

此 Typst 模板按照[《东南大学研究生学位论文格式规定》](https://seugs.seu.edu.cn/_upload/article/files/5d/c2/abe9785f44c8b3ea4823f14bfb92/cd829a73-1b86-400d-9bce-2c4b4fdb85b7.pdf)制作，制作时参考了 [SEUThesis 模板](https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/seuthesis/seuthesis.pdf)。

模板主文件是 `seu-thesis/advanced-degree.typ`。目前，此模板已是初步成品。您可以打开 [`demo_degree_thesis.pdf`](./demo_degree_thesis.pdf) 查看效果与模板使用说明。

## 本科毕业设计（论文）报告模板

此 Typst 模板基于东南大学本科毕业设计（论文）报告模板（2024 年 1 月）仿制，原模板可以在教务处网站上下载（[2019 年 9 月版](https://jwc.seu.edu.cn/2021/1108/c21686a389963/page.htm) , [2024 年 1 月版](https://jwc.seu.edu.cn/2024/0117/c21686a479303/page.htm)）。

模板主文件是 `seu-thesis/bachelor.typ`。目前，此模板已是初步成品。您可以打开 [`demo_bachelor_thesis.pdf`](./demo_bachelor_thesis.pdf) 查看效果与模板使用说明。

> [!NOTE]
>
> 可以看看隔壁 <https://github.com/TideDra/seu-thesis-typst/> 项目，也正在使用 Typst 实现毕业设计（论文）报告模板，还提供了毕设翻译模板。该项目的实现细节与本模板并不相同，您可以根据自己的喜好选择。

## 说明

如需使用，先安装 `fonts` 目录下的字体。如需在 Typst.app 在线使用，需要将字体移动到根目录，可能需要修改 `seu-thesis/utils.typ` 内的字体声明。

此模板需要使用 Typst 0.10.0 编译，推荐在本地环境编译。您可以使用 VSCode 配合 Typst LSP、Typst Preview 等插件获得较佳的编辑体验。

两个模板各自的使用说明在各自的 Demo 文稿内。

## TODO List

毕设：

- [ ] 将模板内涉及计数器的部分重构。
- [ ] “代码展示块”功能。
- [ ] 实现“续表”功能。（暂时没想明白怎么实现）
- [ ] 改用符合东大要求的 csl。（请见 [目前存在的问题-参考文献](#参考文献) ）
- [x] 基本文档与使用教程。
- [x] ref 样式。

学位：

- [x] 格式细化。
- [x] 修复自动切换奇数页。
- [x] 公式编号位置调整到最后一行。
- [x] Demo PDF。
- [x] 基本文档。
- [x] 使用教程。
- [ ] 为正文前的章节添加页眉（合并 header）。
- [ ] 盲审版本。
- [x] ref 样式。

## 目前存在的问题

- 中文首段有时会自动缩进，有时不会。如果没有自动缩进，需要使用 `#h(2em)` 手动缩进两个字符。
- 中文粗体不可用（章节标题等目前没有加粗）。这是因为 Typst 0.10.0 尚未支持伪粗体，而宋体黑体等字体没有多重字重。在 0.10.0 后的 commit 中，mgt 等开发者为 Typst 提供了字体描边功能，预计 0.11.0 即可直接或间接支持伪粗体。
- 参考文献格式不完全符合要求。由于 Typst 尚不支持一些不算标准的 csl 语法，目前暂时没有找到实现英文使用 `et al.` 中文使用 `等` 的方法。Typst 内置的 GB/T 7714-2015 numeric 格式会为所有 bib 内定义了链接/DOI 的文献添加 `OL` 标记和链接/DOI 。若想隐藏，可以使用如下办法（选其一即可）：
  - (Zotero) 使用 Better BibTeX 插件，在 `工具` - `Better BibTeX` - `Better BibTeX 首选项` - `导出` - `BibTeX` 设置项内，设置 `将 URL 添加到 BibTeX 导出的` 为 `否`。在之后导出参考文献表 bib 文件时，选择导出格式为 `Better BibTeX` 。请注意，副作用将导致纯电子文献也缺失
  - 删除相应条目的链接/DOI。
  - 使用经过修改的 csl 文件。
- 行距、边距等有待继续调整。
- ~~学位论文中，自动切换奇数页暂时不工作。~~ 目前大部分场景自动切换已修复。
- 目前的模板暂时无法实现盲审版本自动隐藏致谢，**可能之后会将致谢内容改成单独的参数传入模板或使用专门的函数**。
- ~~目前缺少 ref 样式，待修。~~ 已经添加 ref 格式。

### 参考文献

参考文献格式不完全符合要求。Typst 自带的 GB/T 7714-2015 numeric 格式与学校要求格式相比，有以下问题：

- 学校要求在作者数量较多时，英文使用 `et al.` 中文使用 `等` 来省略。但是，Typst 自带的格式目前仅可以显示为 `等`。

  此问题目前难以解决：Typst 尚不支持一些不算标准的 csl 语法，尚未找到根据声明的引文语言选择不同语言显示的方法。

- 学校给出的范例中，除了纯电子资源，即使引用文献来自线上渠道，也均不加 `OL`、访问日期、DOI 与 链接。但是，Typst 内置的 GB/T 7714-2015 numeric 格式会为所有 bib 内定义了链接/DOI 的文献添加 `OL` 标记和链接/DOI 。

  此问题目前可以临时解决，方法如下，择一即可：

  - (Zotero) 使用 Better BibTeX 插件，在 `工具` - `Better BibTeX` - `Better BibTeX 首选项` - `导出` - `BibTeX` 设置项内，设置 `将 URL 添加到 BibTeX 导出的` 为 `否`。在之后导出参考文献表 bib 文件时，选择导出格式为 `Better BibTeX` 。请注意，副作用将导致纯电子文献也缺失 URL 。
  - 手工删除相应条目的链接/DOI。
  - (推荐) 使用经过修改的 csl 文件：请将参考文献使用的 `style: "gb-7714-2015-numeric"` 修改为 `style: "./seu-thesis/gb-t-7714-2015-numeric-seu.csl"` 。
    > 该 csl 修改自 <https://github.com/redleafnew/Chinese-STD-GB-T-7714-related-csl/blob/main/003gb-t-7714-2015-numeric-bilingual-no-url-doi.csl> ，但是无法实现自动选用 `et al.` 或 `等`。
    >
    > 原文件基于 CC-BY-SA 3.0 协议共享。

## 开发与协议

此模板组参考了来自 <https://github.com/lucifer1004/pkuthss-typst> 的 typst 格式。在 `seu-thesis/utils.typ` 中使用了一部分来自此项目的代码。

如果您在使用过程中遇到任何问题，请提交 issue。本项目欢迎您的 PR。如果有其他模板需求也可以在 issue 中提出。

除下述特殊说明的文件外，此项目使用 MIT License 。

- `demo_image` 路径下的文件来自东南大学教务处本科毕设模板。
- `seu-thesis/image` 路径下的文件来是由东南大学教务处模板经二次加工得到。
- `fonts` 路径下的文件是此模板用到的字体。
- `东南大学本科毕业设计（论文）参考模板 (2024年1月修订).docx` 是教务处提供的毕设论文模板。
