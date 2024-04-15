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

模板主文件是 `seu-thesis/templates/degree.typ`。目前，此模板已是初步成品。您可以打开 [`demo_degree_thesis.pdf`](./demo/demo_degree_thesis.pdf) 查看效果与模板使用说明。

## 本科毕业设计（论文）报告模板

此 Typst 模板基于东南大学本科毕业设计（论文）报告模板（2024 年 1 月）仿制，原模板可以在教务处网站上下载（[2019 年 9 月版](https://jwc.seu.edu.cn/2021/1108/c21686a389963/page.htm) , [2024 年 1 月版](https://jwc.seu.edu.cn/2024/0117/c21686a479303/page.htm)）。

模板主文件是 `seu-thesis/templates/bachelor.typ`。目前，此模板已是初步成品。您可以打开 [`demo_bachelor_thesis.pdf`](./demo/demo_bachelor_thesis.pdf) 查看效果与模板使用说明。

> [!NOTE]
>
> 可以看看隔壁 <https://github.com/TideDra/seu-thesis-typst/> 项目，也正在使用 Typst 实现毕业设计（论文）报告模板，还提供了毕设翻译模板。该项目的实现细节与本模板并不相同，您可以根据自己的喜好选择。

## 说明

如需使用，先安装 `fonts` 目录下的字体。如需在 Typst.app 在线使用，需要将字体移动到根目录，可能需要修改 `seu-thesis/utils/fonts.typ` 内的字体声明。

此模板需要使用 Typst 0.11.0 编译，推荐在本地环境编译。您可以使用 VSCode 配合 Typst LSP、Typst Preview 等插件获得较佳的编辑体验。

两个模板各自的使用说明在各自的 Demo 文稿内。

## TODO List

毕设：

- [x] 将模板内涉及计数器的部分重构。
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
- [ ] 盲审版本。
- [x] ref 样式。

## 目前存在的问题

- 中文首段有时会自动缩进，有时不会。如果没有自动缩进，需要使用 `#h(2em)` 手动缩进两个字符。
- ~~中文粗体不可用（章节标题等目前没有加粗）。这是因为 Typst 0.10.0 尚未支持伪粗体，而宋体黑体等字体没有多重字重。在 0.10.0 后的 commit 中，mgt 等开发者为 Typst 提供了字体描边功能，预计 0.11.0 即可直接或间接支持伪粗体。~~ 0.11.0 版本下已经提供了间接支持伪粗体的方法，此模板已支持伪粗体。
- 参考文献格式不完全符合要求。请见下方参考文献小节。
- 行距、边距等有待继续调整。
- ~~学位论文中，自动切换奇数页暂时不工作。~~ 目前大部分场景自动切换已修复。
- ~~目前缺少 ref 样式，待修。~~ 已经添加 ref 格式。

### 参考文献

参考文献格式不完全符合要求。Typst 自带的 GB/T 7714-2015 numeric 格式与学校要求格式相比，有以下问题：

1. 学校要求在作者数量较多时，英文使用 `et al.` 中文使用 `等` 来省略。但是，Typst 目前仅可以显示为单一语言。

   **A:** 该问题系 Typst 的 CSL 解析器不支持 CSL-M 导致的。

   <details>
   <summary> 详细原因 </summary>

   - 使用 CSL 实现这一 feature 需要用到 [CSL-M](https://citeproc-js.readthedocs.io/en/latest/csl-m/index.html#cs-layout-extension) 扩展的多 `layout` 功能，而 Typst 尚不支持 CSL-M 扩展功能。详见 [typst issue #2793](https://github.com/typst/typst/issues/2793) 与 [citationberg issue #5](https://github.com/typst/citationberg/issues/5)。
   - Typst 目前会忽视 BibTeX/CSL 中的 `language` 字段。参见 [hayagriva issue #126](https://github.com/typst/hayagriva/pull/126)。

   因为上述原因，目前很难使用 Typst 原生方法实现根据语言自动选用 `et al.` 与 `等`。

   </details>

   OrangeX4 和我写了一个基于查找替换的 `bilingual-bibliography` 功能，试图在 Typst 支持 CSL-M 前实现中文西文使用不同的关键词。

   本模板的 Demo 文档内已使用 `bilingual-bibliography` 引用，请查看 Demo 文档以了解用法。注意，该功能仍在测试，很可能有 Bug，详见 https://github.com/csimide/SEU-Typst-Template/issues/1 。

   > 请在 https://github.com/nju-lug/modern-nju-thesis/issues/3 查看更多有关双语参考文献实现的讨论。
   >
   > 本模板曾经尝试使用 https://github.com/csimide/cslper 作为双语参考文献的实现方法。

2. 学校给出的范例中，除了纯电子资源，即使引用文献来自线上渠道，也均不加 `OL`、访问日期、DOI 与 链接。但是，Typst 内置的 GB/T 7714-2015 numeric 格式会为所有 bib 内定义了链接/DOI 的文献添加 `OL` 标记和链接/DOI 。

   **A:** 该问题系学校的标准与 GB/T 7714-2015 不完全一致导致的。

   请使用 `style: "./seu-thesis/gb-t-7714-2015-numeric-seu.csl"` ，会自动依据文献类型选择是否显示 `OL` 标记和链接/DOI。

   > 该 csl 修改自 <https://github.com/redleafnew/Chinese-STD-GB-T-7714-related-csl/blob/main/003gb-t-7714-2015-numeric-bilingual-no-url-doi.csl>
   >
   > 原文件基于 CC-BY-SA 3.0 协议共享。

3. 作者大小写（或者其他细节）与学校范例不一致。

   **A:** 学校用的是 GB/T 7714-2015 的方言，曾经有学长把它叫做 GB/T 7714-SEU ，目前没找到完美匹配学校要求的 CSL（不同学院的要求也不太一样），后续会写一个符合要求的 CSL 文件。

4. 正文中连续引用，上标合并错误（例如，引用 1 2 3 4 应当显示为 [1-4] ，但是显示为 [1,4] ）。

   临时方案是把 csl 文件里 `after-collapse-delimiter=","` 改成 `after-collapse-delimiter="-"`。

   <details>
   <summary> 详细原因 </summary>

   正常情况下， `after-collapse-delimiter` 不应该控制折叠符号，但是 Typst 的实现中 `after-collapse-delimiter` 控制了折叠符号，我认为这应该是不正确的。

   </details>

## 开发与协议

此模板组参考了来自 <https://github.com/lucifer1004/pkuthss-typst> 的 typst 格式。在 `seu-thesis/utils.typ` 中使用了一部分来自此项目的代码。

如果您在使用过程中遇到任何问题，请提交 issue。本项目欢迎您的 PR。如果有其他模板需求也可以在 issue 中提出。

除下述特殊说明的文件外，此项目使用 MIT License 。

- `demo/demo_image` 路径下的文件来自东南大学教务处本科毕设模板。
- `seu-thesis/assets/` 路径下的文件是由东南大学教务处模板经二次加工得到，或从东南大学视觉设计中取得。
- `fonts` 路径下的文件是此模板用到的字体。
- `东南大学本科毕业设计（论文）参考模板 (2024年1月修订).docx` 是教务处提供的毕设论文模板。
