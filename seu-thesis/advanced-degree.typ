#import "utils.typ": *
#import "@preview/cuti:0.2.0": show-cn-fakebold

#let conf(
  author: (CN: "王东南", EN: "WANG Dong-nan", ID: "012345"),
  thesisname: (
    CN: "硕士学位论文",
    EN: [
    A Thesis submitted to \
    Southeast University \
    For the Academic Degree of Master of Touching Fish
    ],
    heading: "东南大学硕士学位论文"
  ),
  title: (
    CN: "摸鱼背景下的Typst模板使用研究",
    EN: "A Study of the Use of the Typst Template During Touching Fish"
  ),
  advisors: (
    (CN: "湖牌桥", EN:"HU Pai-qiao", CNTitle: "教授", ENTitle: "Prof."),
    (CN: "苏锡浦", EN:"SU Xi-pu", CNTitle: "副教授", ENTitle: "Associate Prof.")
  ),
  school: (
    CN: "摸鱼学院",
    EN: "School of Touchingfish"
  ),
  major: (
    main: "摸鱼科学",
    submajor: "计算机摸鱼"
  ),
  degree: "摸鱼学硕士",
  categorynumber: "N94",
  secretlevel: "公开",
  UDC: "303",
  schoolnumber: "10286",
  committeechair: "张三 教授",
  readers: (
    "李四 副教授",
    "王五 副教授"
  ),
  date: (
    CN: (
      defenddate: "2099年01月02日", 
      authorizedate: "2099年01月03日",
      finishdate: "2024年01月15日"
    ),
    EN: (
      finishdate: "Jan 15, 2024"
    )
  ),
  thanks: "本论文受到摸鱼基金委的基金赞助（123456）",
  degreeform: "应用研究",
  cnabstract: [示例摘要],
  cnkeywords: ("关键词1", "关键词2"),
  enabstract: [#lorem(100)],
  enkeywords: ("Keywords1", "Keywords2"),
  alwaysstartodd: false,
  terminology: none,
  anonymous: false,
  doc,
) = [
  
  #let smartpagebreak = () => {
    if alwaysstartodd {
      skippedstate.update(true)
      pagebreak(to: "odd", weak: true)
      skippedstate.update(false)
    } else {
      pagebreak(weak: true)
    }
  }


  #set text(font: 字体.宋体, size: 字号.小四, weight: "regular", lang: "zh")

  #show: show-cn-fakebold

  // 图和表格序号显示
  #show figure.caption: it => {
    if it.kind != table {
      v(0.5em)
    } // 图和图序号行间隔 0.5em

    //set text(font: 字体.宋体, size: 字号.五号, weight: "regular")

    locate(loc => {
      let baseloc = query(
        selector(
          heading.where(level: 1)
        ).before(loc), 
        loc
      ).last().location()
      // 使用此一级章节的开始处作为基准点
      
      it.supplement // "图 1-1" "表 1-2" 里的 "图" "表" 字符

      if partstate.at(loc) == "正文" {
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
      } else if partstate.at(loc) == "附录" {
        numbering(
          "A-1", 
          appendixcounter.at(loc).first(), // 章节号
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

  // 参考文献格式
  #show bibliography: it => {
    partstate.update("参考文献")
    it
    smartpagebreak()
    appendix()
  }

  // 公式序号显示：格式
  #set math.equation(numbering: it => {
    locate(loc => {
      if partstate.at(loc) == "附录" {
        numbering("(A-1)", appendixcounter.at(loc).first(), equationcounter.at(loc).first())
      } else {
        numbering("(1.1)", chaptercounter.at(loc).first(), equationcounter.at(loc).first())
      }
    })
  })

  // 公式序号显示：右侧最下一行
  // 参考 https://github.com/typst/typst/discussions/3106
  #show math.equation: eq => {
    // apply custom style only to block equations with numbering enabled
    if eq.block and eq.numbering != none {
      // default numbering of the equation
      let eqCounter = counter(math.equation).at(eq.location())
      let eqNumbering = numbering(eq.numbering, ..eqCounter)

      set align(left)
    
      grid(
        // change "0pt" to "auto" to give the numbering its own space on the line
        columns: (4em, 100% - 4em, 0pt),
        
        // note that "numbering: none" avoids infinite recursion
        h(4em),
        
        block(math.equation(eq.body, block: true, numbering: none)),

        align(right + bottom)[#eqNumbering],
      )
    } else {
      eq
    }
  }

  // 标题 heading

  #show heading: it => {
    if it.level == 1 {
      smartpagebreak()
    }
    showheading(
      headingtopmargin: (1cm, 0cm, 0cm),
      headingbottommargin: (1cm, 0cm, 0cm),
      headingtext: (
        (font: 字体.黑体, size: 字号.三号, weight: "regular"),
        (font: 字体.宋体, size: 字号.四号, weight: "bold"),
        (font: 字体.黑体, size: 字号.小四, weight: "regular"),
      ),
      thesistype: "Degree",
      it
    )
  }

  #show ref: it => {
    let el = it.element

    if el != none and el.func() == figure {
      let loc = el.location()
      let baseloc = query(
        selector(
          heading.where(level: 1)
        ).before(loc), 
        loc
      ).last().location()

      el.supplement
      
      if partstate.at(loc) == "正文" {
        numbering(
          if el.kind == table {"1.1"} else {"1-1"}, 
          chaptercounter.at(loc).first(), // 章节号
          (
            counter(figure.where(kind: el.kind))
            .at(loc)
            .first() - 
            counter(figure.where(kind: el.kind))
            .at(baseloc)
            .first()
          ) // 图序号，使用总序号减章节开始时序号实现
        )
      } else if partstate.at(loc) == "附录" {
        numbering(
         "A-1",  
          appendixcounter.at(loc).first(), // 章节号
          (
            counter(figure.where(kind: el.kind))
            .at(loc)
            .first() - 
            counter(figure.where(kind: el.kind))
            .at(baseloc)
            .first()
          ) // 图序号，使用总序号减章节开始时序号实现
        )
      }
    } else if el != none and el.func() == math.equation {  
      let loc = el.location()
      el.supplement
      " "
      if partstate.at(loc) == "附录" {
        numbering("(A.1)", appendixcounter.at(loc).first(), equationcounter.at(loc).first())
      } else {
        numbering("(1.1)", chaptercounter.at(loc).first(), equationcounter.at(loc).first())
      }
    } else {
      it
    }
  }

  #set page(margin: (top: 2cm, bottom: 2cm, left:2cm, right: 2cm))

  // 封面页
  #partstate.update("封面")
  #{
    set align(center + top)
    set par(first-line-indent: 0pt)
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
                  chineseunderline(schoolnumber)
                },
                {
                  chineseunderline(categorynumber)
                },
                {
                  chineseunderline(secretlevel)
                },
                {
                  chineseunderline(UDC)
                },
                {
                  chineseunderline(author.ID)
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
    text(font: "STZhongsong", size: 字号.小初, weight: "extrabold", thesisname.CN)

    parbreak()

    text(font: 字体.黑体, size: 字号.一号, title.CN)

    parbreak()

    text(font: "STZhongsong", size: 字号.三号, weight: "extrabold")[（学位论文形式：#degreeform）]
    parbreak()

    set text(font: 字体.黑体, size: 字号.小二)
    set par(leading: 1em)

    grid(
      columns: (5em, 1em, 10em),
      row-gutter: 1em,

      text(font: 字体.宋体)[研究生姓名],
      [：], 
      {chineseunderline(author.CN)},

      text(font: 字体.宋体, "导师姓名".clusters().join(h(1em/3))),
      [：], 
      chineseunderline(
        advisors.map(it => it.CN + " " + it.CNTitle).join("\n")
      )
    )

    v(1em)

    set text(font: 字体.黑体, size: 字号.小四)
    grid(
      columns: (16em, 16em),
      column-gutter: 1em,
      grid(
        columns: (7em, 9em),
        row-gutter: 1em,
        text(font: 字体.宋体, "申请学位类别".clusters().join(h(1em / 5))),
        chineseunderline(degree),
        text(font: 字体.宋体, "一级学科名称".clusters().join(h(1em / 5))),
        chineseunderline(major.main),
        text(font: 字体.宋体, "二级学科名称".clusters().join(h(1em / 5))),
        chineseunderline(major.submajor),
        text(font: 字体.宋体, "答辩委员会主席"),
        chineseunderline(committeechair),
      ),
      grid(
        columns: (6em, 10em),
        row-gutter: 1em,
        text(font: 字体.宋体, "学位授予单位"),
        chineseunderline("东 南 大 学"),
        text(font: 字体.宋体, "论文答辩日期"),
        chineseunderline(date.CN.defenddate),
        text(font: 字体.宋体, "学位授予日期"),
        chineseunderline(date.CN.authorizedate),
        text(font: 字体.宋体, "评阅人".clusters().join(h(3em/2))),
        chineseunderline(readers.join("\n")),
      )
    )

    v(1em)

    set text(font: 字体.宋体, size: 字号.四号)

    date.CN.finishdate
  }

  #smartpagebreak()
  // 中文扉页
  #{
    set align(center)
    set par(first-line-indent: 0pt)
    v(1cm)
    set text(font: "STZhongsong", size: 字号.小初, weight: "bold")
    image("image/seu.png", width: 5em)
    thesisname.CN
    parbreak()

    set text(font: 字体.黑体, size: 字号.一号, weight: "bold")
    title.CN
    parbreak()

    v(1em)

    set text(font: 字体.宋体, size: 字号.小二, weight: "bold")
    grid(
      columns: (5em, 1em, 10em),
      row-gutter: 3em,

      text(font: 字体.黑体, "专业名称".clusters().join(h(1em/3))), 
      "：", 
      chineseunderline(major.main),

      text(font: 字体.黑体, "研究生姓名"), 
      "：", 
      chineseunderline(author.CN),

      text(font: 字体.黑体, "导师姓名".clusters().join(h(1em/3))), 
      "：", 
      chineseunderline(advisors.map(it => it.CN + " " + it.CNTitle).join("\n")),
    )

    if thanks != none {
      place(bottom + left, text(font: 字体.宋体, size: 字号.小四, thanks))
    }
  }

  #smartpagebreak()

  // 英文扉页
  #{
    set par(first-line-indent: 0pt)
    set align(center)
    v(1cm)
    set text(font: "Times New Roman", size: 24pt, weight: "bold")
    upper(title.EN)

    v(1cm)

    set text(16pt, weight: "regular")
    set par(leading: 1.5em)
    set block(spacing: 1.8cm)
    thesisname.EN

    parbreak()
    [BY]
    linebreak()
    author.EN

    parbreak()
    [Supervised by]
    linebreak()
    advisors.map(it => it.ENTitle + " " + it.EN).join("\n and \n")
    
    parbreak()

    school.EN 
    linebreak()
    [Southeast University]
    linebreak()
    date.EN.finishdate
  }

  #smartpagebreak()
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
  #smartpagebreak()

  #set par(first-line-indent: 2em, justify: true, leading: 0.8em)
  #show par: set block(spacing: 0.8em)

  // 中文摘要
  #{
    heading(numbering: none, level: 1, outlined: true, bookmarked: true)[摘要]

    cnabstract

    v(1em)
    parbreak()

    text(weight: "bold")[关键词：]
    cnkeywords.join("，")
    parbreak()
  }

  #smartpagebreak()
  // 英文摘要
  #{
    heading(numbering: none, level: 1, outlined: true, bookmarked: true)[ABSTRACT]


    enabstract

    v(1em)
    parbreak()

    text(weight: "bold")[Keywords: ]
    enkeywords.join(", ")
  }

  #smartpagebreak()

  // 目录
  #switchtopart("目录")
  #cnoutline(
    outlinedepth: 3, 
    thesistype: "Degree",
    baseindent: 0pt,
    firstlevelspacing: 1.4em,
    firstlevelfontweight: "bold",
    itemspacing: .9em
  )

  // 注释表
  #if terminology != none {
    smartpagebreak()
    switchtopart("注释表")
    {
      heading(numbering: none, level: 1, outlined: true, bookmarked: true)[本论文专用术语的注释表]
      terminology
    }
  }

  // 特殊处理：
  // 由于 #set page() 会发生换页，因此这里不能简单使用 #smartpagebreak()
  // 否则可能导致正文内有部分页面还是之前的 header / footer 
  // 这里需要判断情况和强行加空白页
  //  后续 set page 与前文的合并后，此处可以改用 smartpagebreak
  // (TODO)
  #locate(loc => {
    if alwaysstartodd and calc.even(loc.page()) {
      pagebreak()
    }
  })

  // 正文
  #partstate.update("正文")
  #[
    #set page(
      header: locate(loc => [
        #{
          set align(center)
          
          set text(font: 字体.宋体, size: 字号.小五, lang: "zh")
          if calc.even(loc.page()) {
            thesisname.heading
          } else {

              // 这里是要找到这个页眉对应的一级章节
              // 但是由于一级标题换页是在 show 中实现的，也就是说， heading 可能是开始于上一页、结束于下一页的。
              // 所以跨页的情况很麻烦，最后通过两次查询（查一次 label 查一次 heading）实现
              // label 可以保证与标题几个字在同一页上，heading 锚点在 label 之前

              // 先记录当前页眉所在的页码
              let thispage = loc.page()

              // 记录这里之后的页眉和标题+之前的标题
              let nextheadings = query(
                selector(<__l1heading__>).after(loc),
                loc
              )
              
              let thisheadinglabelloc = if nextheadings != () and nextheadings.first().location().page() == thispage {
                nextheadings.first().location()
              } else {
                query(
                  selector(<__l1heading__>).before(loc),
                  loc
                ).last().location()
              }

              let thischapterheading = query(selector(heading.where(level: 1)).before(thisheadinglabelloc), thisheadinglabelloc).last()

              if thischapterheading.numbering == chinesenumbering and thischapterheading.body.text != "致谢" {
                chinesenumbering(..counter(heading).at(thischapterheading.location()), location: thischapterheading.location())
                h(1em) 
              }
              thischapterheading.body.text
          }
        }
        #label("__header__")
        #v(-0.5em)
        #line(length: 100%, stroke: (thickness: 0.5pt))
      ]), 
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

    #pagebreak(to: "odd", weak: true)

    #doc
  ]
]