#import "base.typ": *

#let conf(
  studentID: "00121001",
  author: "王东南",
  school: "示例学院",
  major: "示例专业",
  advisor: "湖牌桥",
  thesisname: "示例论文标题\n此行空白时下划线自动消失",
  date: "某个起止日期",
  cnabstract: [示例摘要],
  cnkeywords: ("关键词1", "关键词2"),
  enabstract: [#lorem(100)],
  enkeywords: ("Keywords1", "Keywords2"),
  outlinedepth: 3,
  doc,
) = {
  set page(paper: "a4", margin: (top: 2cm+0.5cm, bottom: 2cm+0.5cm, left: 2cm + 0.5cm, right: 2cm))
  set text(lang: "zh")

  set footnote(numbering: num => numberwithcircle(num))

  set footnote.entry(
    separator: line(start: (2.5em, 0pt),length: 30%, stroke: 0.5pt)+v(0.5em),
    gap: 1em
    )

  show footnote.entry: it => {
    let loc = it.note.location()
    set par(leading: 14pt)
    h(2em)
    text(font: 字体.宋体, size: 字号.小五/2, weight: "regular", baseline: -0.5em, numbering(numberwithcircle, ..counter(footnote).at(loc)))
    h(0.5em)
    set text(font: 字体.宋体, size: 字号.小五, weight: "regular", baseline: 0em)
    it.note.body
  }

  // 每章节的标题
  show heading: it => showheading(
    headingtopmargin: (0cm, 0cm, 0cm),
    headingbottommargin: (0cm, 0cm, 0cm),
    headingtext: (
      (font: 字体.黑体, size: 字号.三号, weight: "bold"),
      (font: 字体.黑体, size: 字号.四号, weight: "regular"),
      (font: 字体.宋体, size: 字号.小四, weight: "regular")
    ),
    thesistype: "Undergraduate",
    it
  )

  // 封面 Cover Page
  partstate.update("封面")
  [
    #set align(center)
    #hide[#heading(outlined: false, bookmarked: true)[封面]]
    #v(36pt-0.5cm)
    #grid(
      columns: (25pt, auto),
      [],
      image("./image/cover_title.png", width: 12.11cm, height: 4.64cm, fit: "stretch")
    ) // 为了让这个标题图能显示在“正确”的位置上
    
    #v(60pt)

    #box(height: 2.5cm)[
      #set text(font: 字体.标题黑体, size: 字号.二号)
      #grid(
        columns: (2.85cm, 12.84cm),
        [
          题 目：
        ],
        [
          #chineseunderline(thesisname, width: 12.8cm, bold: false)
        ]
      )
    ]

    #v(40pt)

    #[
      #set text(font: 字体.宋体, size: 字号.小二)
      #grid(
        columns: (3.44cm, 8cm),
        rows: 1.4cm,
        [学#h(2em)号：], chineseunderline(studentID),
        [姓#h(2em)名：], chineseunderline(author),
        [学#h(2em)院：], chineseunderline(school),
        [专#h(2em)业：], chineseunderline(major),
        [指导教师：], chineseunderline(advisor),
        [起止日期：], chineseunderline(date),
      )
    ]

    #pagebreak()
  ]

  // 独创性声明
  partstate.update("声明")
  [
    #v(80pt-0.5cm)

    #set text(font: 字体.宋体, size: 字号.小四)

    #align(right, image("./image/page2.svg", width: 39em))
    // 使用最暴力的方法解决
    #pagebreak()
  ]

// 从摘要开始使用罗马字符标识页码
  set page(footer: locate(loc => {
    pagecounter.step()
    set text(font: 字体.宋体, size: 字号.小五)
    set align(center)
    [
      #numbering("I", pagecounter.at(loc).first())
      #label("__footer__")
    ]
  }))
  pagecounter.update(1)

  // 摘要
  partstate.update("摘要")
  [

    #set text(font: 字体.宋体, size: 字号.小四)
    #set par(first-line-indent: 2em, leading: 14pt, justify: true)
    #show par: set block(spacing: 14pt)
    // 这个14pt是试出来的，用模板里的22pt直接寄

  #heading(outlined: true, bookmarked: true, level: 1)[摘要]

  #cnabstract

  #linebreak()

  关键词： #cnkeywords.join("，")

  #pagebreak()

  #heading(outlined: true, bookmarked: true, level: 1)[ABSTRACT]

  #h(2em) #enabstract

  #linebreak()

  KEY WORDS: #enkeywords.join(", ")

  #pagebreak(weak: true)

  ]

    
  // 目录
  partstate.update("目录")
  {
    cnoutline(
      outlinedepth: outlinedepth,
      thesistype: "Undergraduate"
    )
  }

  // 正文
  partstate.update("正文")
  [
    #set page(
      header: {
        set align(center)
        set text(font: 字体.宋体, size: 字号.小五, lang: "zh")
        [东南大学本科毕业设计（论文）]
        v(-0.5em)
        line(length: 100%, stroke: (thickness: 0.5pt))
        counter(footnote).update(0)
      }, 
      footer: locate(loc => {
        pagecounter.step()
        set text(font: 字体.宋体, size: 字号.小五)
        set align(center)
        [
          #numbering("1", pagecounter.at(loc).first())
          #label("__footer__")
        ]
      }), 
      header-ascent: 10%,
      footer-descent: 10%
      )

    #pagecounter.update(1)

    #set heading(numbering: chinesenumbering)

    #set par(first-line-indent: 2em, leading: 14pt, justify: true)

    #set text(font: 字体.宋体, size: 字号.小四, weight: "regular", lang: "zh")

    // 图和表的自动编码
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


    #show bibliography: it => {
      partstate.update("参考文献")
      set text(font: 字体.宋体, size: 字号.五号)
      it
      pagebreak(weak: true)
      appendix()
    }
    #doc
  ]
}