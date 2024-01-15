#import "base.typ": *

#let headingtopmargin = (1cm, 0cm, 0cm)
#let headingbottommargin = (1cm, 0cm, 0cm)
#let headingtext = (
  (font: 字体.黑体, size: 字号.三号, weight: "bold"),
  (font: 字体.宋体, size: 字号.四号, weight: "bold"),
  (font: 字体.黑体, size: 字号.小四, weight: "bold"),
)

#set text(lang: "zh")

#set text(font: 字体.宋体, size: 字号.小四, weight: "regular")

#show figure.caption: it => {
  if it.kind != table {
    v(0.5em)
  } // 图和图序号行间隔 0.5em

  set text(font: 字体.宋体, size: 字号.五号, weight: "regular")

  locate(loc => {
    let baseloc = query(
      selector(
        heading.where(level: 1)
      ).before(loc), 
      loc
    ).last().location()
    // 使用此一级章节的开始处作为基准点
    
    it.supplement // "图 1-1" "表 1-2" 里的 "图" "表" 字符

    if appendixcounter.at(loc).first() == 0 {
      numbering(
        if it.kind == table {"1.1"} else {"1-1"}, 
        chaptercounter.at(loc).first(), // 章节号
        (
          counter(figure.where(kind: it.kind))
          .at(loc)
          .first() - 
          counter(figure.where(kind: it.kind))
          .at(baseloc)
          .first()
        ) // 图序号，使用总序号减章节开始时序号实现
      )
    } else {
      numbering(
        if it.kind == table {"A.1"} else {"A-1"}, 
        chaptercounter.at(loc).first(), // 章节号
        (
          counter(figure.where(kind: it.kind))
          .at(loc)
          .first() - 
          counter(figure.where(kind: it.kind))
          .at(baseloc)
          .first()
        ) // 图序号，使用总序号减章节开始时序号实现
      )
    }
  })
  h(0.5em) // numbering 和 body 之间隔1个空格
  it.body

  if it.kind == table {
    v(0.5em)
  } // 表格序号行和表格间隔 0.5em
}

#show figure.where(
  kind: table
): set figure.caption(position: top)

#show figure: it => {
  if it.kind == table {
    it
    v(0.5em)
  } else if it.kind == image {
    v(0.5em)
    it
  }
}

#set math.equation(numbering: it => {
  locate(loc => {
    numbering("(1.1)", chaptercounter.at(loc).first(), equationcounter.at(loc).first())
  })
})



// WIP
// 思路：先做一个相似的文档，再模板化 

#set page(margin: (top: 2cm, bottom: 2cm, left:2cm, right: 2cm))

// 封面
#{
  set align(center + top)
  image("image/cover_school.png", height: 11cm)

  v(-11cm)
  grid(
    columns: (1fr, 1fr),
    {
      v(0.5cm) // 原始模板左侧列和右侧校徽不等高
      set align(left)
      set text(font: 字体.宋体, size: 字号.小五)
      set par(justify: true)
      block(
        {
          set align(center + horizon)
          grid(
            columns: (4em, 1em, 6em),
            row-gutter: 0.5em,
            [学校代码 分类号 密~~~~~~级 U~D~C 学~~~~~~~~号],
            [：\ ：\ ：\ ：\ ：],
            grid(
              columns: 1fr,
              rows: 5,
              row-gutter: 0.4em,
              {
                chineseunderline("10286")
              },
              {
                chineseunderline("1111")
              },
              {
                chineseunderline("1111")
              },
              {
                chineseunderline("1111")
              },
              {
                chineseunderline("1111")
              },
            )
          )
          
        },
      )
    },
    {
      set align(right + top)
      image("image/seu_logo.png", width: 1.97cm)
    }
  )


  v(5.3cm)
  text(font: "STZhongsong", size: 字号.小初, weight: "extrabold")[电子信息硕士学位论文]

  


  parbreak()

  text(font: 字体.黑体, size: 字号.一号)[论文题目 题目题目题目题目题目题目题目题目题目题目题目题目题目题目]

  parbreak()

  text(font: "STZhongsong", size: 字号.三号, weight: "extrabold")[（学位论文形式：应用研究）]
  parbreak()

  set text(font: 字体.黑体, size: 字号.小二)
  set par(leading: 1em)

  grid(
    columns: (5em, 1em, 10em),
    row-gutter: 1em,

    text(font: 字体.宋体)[研究生姓名],[：], {chineseunderline("研究生姓名")},
    text(font: 字体.宋体, "导师姓名".clusters().join(h(1em/3))),[：], chineseunderline("导师 \n 副导师")
  )

  // v(-6.2em)
  // "                        张三"

  // v(-4.25em)
  // box({
  //   set align(right)
  //   "教授"
  // }, width: 16em)
  // v(0.2em)
  // box({
  //   set align(right)
  //   "副教授"
  // }, width: 16em)

  v(1em)

  set text(font: 字体.黑体, size: 字号.小四)
  grid(
    columns: (16em, 16em),
    column-gutter: 1em,
    grid(
      columns: (7em, 9em),
      row-gutter: 1em,
      text(font: 字体.宋体, "申请学位类别".clusters().join(h(1em / 5))),
      chineseunderline("工学硕士"),
      text(font: 字体.宋体, "一级学科名称".clusters().join(h(1em / 5))),
      chineseunderline("一级学科"),
      text(font: 字体.宋体, "二级学科名称".clusters().join(h(1em / 5))),
      chineseunderline("二级学科"),
      text(font: 字体.宋体, "答辩委员会主席"),
      chineseunderline(" "),
    ),
    grid(
      columns: (6em, 10em),
      row-gutter: 1em,
      text(font: 字体.宋体, "学位授予单位"),
      chineseunderline("东 南 大 学"),
      text(font: 字体.宋体, "论文答辩日期"),
      chineseunderline("2099年01月02日"),
      text(font: 字体.宋体, "学位授予日期"),
      chineseunderline("2099年01月03日"),
      text(font: 字体.宋体, "评阅人".clusters().join(h(3em/2))),
      chineseunderline(" "),
    )
  )

  v(1em)

  set text(font: 字体.宋体, size: 字号.四号)

  "2098年12月30日"
}


#pagebreak(weak: true)
// 中文扉页
#{
  set align(center)
  v(1cm)
  set text(font: "STZhongsong", size: 字号.小初, weight: "bold")
  image("image/seu.png", width: 5em)
  [硕士学位论文]
  parbreak()

  set text(font: 字体.黑体, size: 字号.一号, weight: "bold")
  [论文题目 题目题目题目题目题目题目题目题目题目题目题目]
  parbreak()

  v(1em)

  set text(font: 字体.宋体, size: 字号.小二, weight: "bold")
  grid(
    columns: (5em, 1em, 10em),
    row-gutter: 3em,
    text(font: 字体.黑体, "专业名称".clusters().join(h(1em/3))), "：", chineseunderline("某个专业"),
    text(font: 字体.黑体, "研究生姓名"), "：", chineseunderline("王东南"),
    text(font: 字体.黑体, "导师姓名".clusters().join(h(1em/3))), "：", chineseunderline("教授\n 副教授"),
  )
}

#pagebreak(weak: true)
// 英文扉页
#{
  set align(center)
  v(1cm)
  set text(font: "Times New Roman", size: 24pt)
  upper(lorem(13))

  v(1cm)

  set text(16pt)
  set par(leading: 1.5em)
  set block(spacing: 1.8cm)
  [A Thesis submitted to \ Southeast University \ For the Academic Degree of Master of Touchfish]

  parbreak()
  [BY \ Someone]
  parbreak()
  [Supervised by \ Prof. Advisor’s Name \ and \ Associate Prof. Co-advisor’s Name]
  parbreak()

  [School of Touchfish \ Southeast University \ Jan 14, 2024]
  
}

#pagebreak(weak: true)
// 声明页
#{
  set page(margin: 2.5cm)

  show heading.where(level: 1): it => {
    set align(center) 
    set text(font: 字体.黑体, size: 15pt)
    it.body.text.clusters().join(h(0.3em))
    v(2em)
  }

  set text(font: 字体.宋体, size: 10.6pt, lang: "zh")
  // 字号来自“附件1：学位论文独创性和使用授权声明.pdf”

  set par(first-line-indent: 2em, leading: 1.5em, justify: true)
  set block(spacing: 1.5em)

  set align(horizon)
  block({
    heading(numbering: none, outlined: false, bookmarked: false)[东南大学学位论文独创性声明]

    [
  本人声明所呈交的学位论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得东南大学或其它教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示了谢意。
    ]

    v(1cm)

    align(right, grid(
      columns: (auto, 6em, auto, 6em),
      column-gutter: 3pt,
      [研究生签名：],
      line(start: (0pt, 0.9em), length: 6em, stroke: 0.5pt),
      [日期：],
      line(start: (0pt, 0.9em), length: 6em, stroke: 0.5pt),
    ))

    v(4cm)

    heading(numbering: none, outlined: false, bookmarked: false)[东南大学学位论文使用授权声明]

    [
  东南大学、中国科学技术信息研究所、国家图书馆有权保留本人所送交学位论文的复印件和电子文档，可以采用影印、缩印或其他复制手段保存论文。本人电子文档的内容和纸质论文的内容相一致。除在保密期内的保密论文外，允许论文被查阅和借阅，可以公布（包括刊登）论文的全部或部分内容。论文的公布（包括刊登）授权东南大学研究生院办理。
    ]

    v(1cm)

    align(right, grid(
      columns: (auto, 6em, auto, 6em, auto, 6em),
      column-gutter: 3pt,
      [研究生签名：],
      line(start: (0pt, 0.9em), length: 6em, stroke: 0.5pt),
      [导师签名：],
      line(start: (0pt, 0.9em), length: 6em, stroke: 0.5pt),
      [日期：],
      line(start: (0pt, 0.9em), length: 6em, stroke: 0.5pt),
    ))
  })
}

// 标题 heading

#show heading: it => {showheading(
  headingtopmargin: (1cm, 0cm, 0cm),
  headingbottommargin: (1cm, 0cm, 0cm),
  headingtext: (
    (font: 字体.黑体, size: 字号.三号, weight: "regular"),
    (font: 字体.宋体, size: 字号.四号, weight: "bold"),
    (font: 字体.黑体, size: 字号.小四, weight: "regular"),
  ),
  thesistype: "Degree",
  it
)}

#pagebreak(weak: true)

// 从摘要开始使用罗马字符标识页码
#set page(footer: locate(loc => {
  pagecounter.step()
  set text(font: 字体.宋体, size: 字号.小五)
  set align(center)
  [
    #numbering("I", pagecounter.at(loc).first())
    #label("__footer__")
  ]
}))
#pagecounter.update(1)

// 中文摘要
#{
  set par(first-line-indent: 2em, justify: true)
  heading(numbering: none, level: 1, outlined: true, bookmarked: true)[摘要]

  [论文摘要包括题名、硕士（博士）研究生姓名、导师姓名、学校名称、正文、关键词。中文约 500 字左右，英文约 200~300 词左右，二者应基本对应。它是论文内容的高度概括，应说明研究目的、研究方法、成果和结论，要突出本论文的创造性成果或新的见解，用语简洁、准确。论文摘要后还应注明本文的关键词 3 至 5 个。关键词应为公知公用的词和学术术语，不可采用自造字词和略写、符号等，词组不宜过长。]

  v(1em)
  parbreak()

  text(weight: "bold")[关键词：]
  [关键词，关键词，关键词]
  parbreak()
}

#pagebreak(weak: true)
// 英文摘要
#{
  set par(first-line-indent: 2em, justify: true)
  heading(numbering: none, level: 1, outlined: true, bookmarked: true)[ABSTRACT]


  lorem(300)

  v(1em)
  parbreak()

  text(weight: "bold")[Keywords: ]
  [Keyword1, Keyword2, Keyword3]
}

#pagebreak(weak: true)
// 目录
#switchtopart("目录")
#cnoutline(
  outlinedepth: 3, 
  thesistype: "Degree",
  baseindent: 0pt,
  firstlevelspacing: 1.3em,
  firstlevelfontweight: "bold",
  itemspacing: 1em
)

#pagebreak(weak: true)

// 注释表
#switchtopart("注释表")
#[
  #heading(numbering: none, level: 1, outlined: true, bookmarked: true)[本论文专用术语的注释表]
  #import "@preview/tablex:0.0.8": tablex, rowspanx, colspanx

  #figure(
    tablex(
      columns: 2,
      [test], [test]
    ),
    kind: table,
    caption: "本论文专用术语（符号、变量、缩略词等）的注释表"
  )
]

// 参考文献格式
#show bibliography: it => {
  partstate.update("参考文献")
  it
  pagebreak(weak: true)
  appendix()
}

// 正文
#partstate.update("正文")
#[
  #set page(
    header: locate(loc => {
      set align(center)
      set text(font: 字体.宋体, size: 字号.小五, lang: "zh")
      if calc.even(loc.page()) {
        "东南大学"
      } else{
        let thischapterheading = query(selector(heading.where(level: 1)).before(
          query(selector(<__footer__>).after(loc), loc).first().location()
        ), loc).last()

        if thischapterheading.numbering == chinesenumbering and thischapterheading.body.text != "致谢" {
          chinesenumbering(..counter(heading).at(thischapterheading.location()), location: thischapterheading.location())
          h(1em)
        }
        thischapterheading.body.text
      }
      v(-0.5em)
      line(length: 100%, stroke: (thickness: 0.5pt))
    }), 
    footer: locate(loc => {
      pagecounter.step()
      set text(font: 字体.宋体, size: 字号.小五)
      set align(center)
      [
        #numbering("1", pagecounter.at(loc).first())
        #label("__footer__")
      ]
    }), 
    header-ascent: 15%,
    footer-descent: 20%
    )

  #pagecounter.update(1)

  #set heading(numbering: chinesenumbering)

  #set par(first-line-indent: 2em, justify: true, leading: 0.8em)

  = 测试章节1

#lorem(200)

#lorem(200)

#lorem(200)

#lorem(200)

#lorem(200)

#lorem(200)

#lorem(200)

#figure(
  image("../demo_image/24h_rain.png", width: 60%),
  caption: "测试图片1"
)

  = 测试章节2

  $ 
  alpha + beta = gamma \
  1234567890
  $
  TODO: 编号当有续行时，应标注于最后一行的最右边。typst 没有提供修改位置的选项，todo用 `#show` 重新实现一下编号。或许之后还需要参考一下 LaTeX 模板的做法，如果 LaTeX 模板把编号放中间的话就不改位置了。

  == 测试小节21

#lorem(1000)

== 测试小节22

#lorem(200) @wang2010guide

= 致谢
 
#lorem(200) @kopka2004guide

#bibliography(
  "../ref.bib",
  style: "gb-7714-2015-numeric"
)

= 测试附录1

= 测试附录2

== 附录小节21

]



