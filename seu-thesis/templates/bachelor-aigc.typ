#import "@preview/cuti:0.3.0": show-cn-fakebold
// #import "@preview/valkyrie:0.2.2" as z
#import "../utils/fonts.typ": 字体, 字号

#show: show-cn-fakebold

#let use-aigc = true // 在这里设置是否使用 AIGC

#let checkbox = box(image("../assets/icon/Box.svg"))
#let checked = box(image("../assets/icon/Checked.svg"))

#set page(margin: (x: 3cm, y:2.54cm))
#set align(center)

#set block(spacing: 1em)
#set par(leading: 1.1em, justify: true)

#text(font: 字体.黑体, size: 字号.三号, weight: "bold", "东南大学本科毕业论文（设计）AI工具使用情况说明表")

#set text(font: 字体.宋体, size: 字号.五号)
#let key = (s) => align(center, par(text(font: 字体.黑体, size: 字号.小四, weight: "bold", s)))
#let bold-value = (s) => align(center, par(text(font: 字体.宋体, size: 字号.小四, weight: "bold", s)))

#table(
  columns: (3cm, 4cm, 3.5cm, 4.5cm),
  inset: (x: 5pt, y: 8pt),
  stroke: 0.5pt,
  align: center + horizon,
  key[课题名称], table.cell(colspan: 3, bold-value[]),
  key[学#h(2em)号], bold-value[], key[姓#h(2em)名], bold-value[],
  key[是否使用生成式人工智能], table.cell(colspan: 3)[
    #{if use-aigc {checked} else {checkbox}} 是 
    #h(8em) 
    #{if use-aigc {checkbox} else {checked}} 否
  ]
)

#v(-1em)

#if use-aigc {
  table(
    columns: (3cm, 4cm, 5cm, 3cm),
    inset: (x: 5pt, y: 8pt),
    align: left + horizon,
    stroke: 0.5pt,
    key[工具、版本号], key[使用范围], key[使用过程], key[章节（页码）#h(-0.6em)], // 手动调整，看上去居中
    [DeepSeek-V3], [
      #checkbox 文本生成及内容修改\  // #checkbox 为不勾选，#checked 为勾选
      #checkbox 数据、图表分析、代码调试\ 
      #checkbox 其他：请具体说明\ ],
    [输入哪些关键词或主题，指导AI工具生成或修改了哪些内容],
    [第二章1.1（P5）]
  )
} else {
  table(
    columns: 15cm,
    inset: (x: 5pt, y: 8pt),
    align: left + horizon,
    stroke: 0.5pt,
    [
      #h(2em)在本人毕业论文（设计）的撰写过程中，未使用任何生成式人工智能辅助工具。所有内容均由本人独立撰写和创作完成，能够确保学术诚信，不存在任何AI生成的内容。
    ]
  )
}

#v(-1em)

#table(
  columns: (3cm, 12cm),
  inset: (x: 5pt, y: 8pt),
  align: left + horizon,
  stroke: 0.5pt,
  key[学生诚信申明],
  [
    #h(2em) 本人郑重声明，上述关于生成式人工智能使用情况的陈述真实无误，已对使用此类技术的所有细节进行了全面且诚实的报告。本人深知学术诚信的重要性，如有任何隐瞒或虚假之处，愿承担学术不端行为带来的相关惩处。
    #v(1.2em)
    #h(20em) 学生签名：
    #align(right, [年 #h(1em)月 #h(1em)日])
    #v(2pt)
  ],
  key[指导教师意见],
  [
    #set align(left)
    // #set par(first-line-indent: (amount: 2em, all: true))
    意见：
    #v(1.2em)
    #h(20em) 指导教师签名:
    #align(right, [年 #h(1em)月 #h(1em)日])
    #v(2pt)

  ]
)