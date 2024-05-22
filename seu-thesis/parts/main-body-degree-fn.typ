#import "../utils/states.typ": part-state
#import "../utils/fonts.typ": 字体, 字号

#let main-body-bachelor-conf(
  thesisname: [], 
  first-level-title-page-disable-heading: false, //  一级标题页不显示页眉
  // 启用此选项后，“第X章 XXXXX” 一级标题所在页面将不显示页眉
  doc
) = {
  set page(
    header: {
        set align(center)
        set text(font: 字体.宋体, size: 字号.小五, lang: "zh")
        set par(first-line-indent: 0pt, leading: 16pt, justify: true)
        show par: set block(spacing: 16pt)

        locate(loc => {
          if calc.even(loc.page()) {
            thesisname.heading
            v(-1em)
            line(length: 100%, stroke: (thickness: 0.5pt))
          } else {
            // 先确定下一个一级标题
            let next-level-1-heading = query(selector(heading.where(level: 1)).after(loc)).at(0, default: none)
            // 如果下一个一级标题存在，且这个一级标题不在这一页
            // 那么下一个一级标题的上一个一级标题就是本章标题
            // （章内页的情形）
            if next-level-1-heading != none and next-level-1-heading.location().page() != loc.page() {
              if first-level-title-page-disable-heading {
                []
              } else {
                let prev-level-1-heading = query(selector(heading.where(level: 1)).before(next-level-1-heading.location())).at(-2)

                if prev-level-1-heading.numbering != none {
                  counter(heading.where(level: 1)).display()
                  h(0.5em)
                }
                prev-level-1-heading.body
                v(-1em)
                line(length: 100%, stroke: (thickness: 0.5pt))
              }
            } else {
              // 启用此选项后，“第X章 XXXXX” 一级标题所在页面将不显示页眉
              if first-level-title-page-disable-heading {
                []
              } else {
                if next-level-1-heading.numbering != none {
                  (next-level-1-heading.numbering)(counter(heading.where(level: 1)).at(next-level-1-heading.location()).first())
                  h(0.5em)
                }
                next-level-1-heading.body
                v(-1em)
                line(length: 100%, stroke: (thickness: 0.5pt))
              }
            }
          }
        })
        counter(footnote).update(0)
      },
    numbering: "1",
    header-ascent: 10%,
    footer-descent: 10%
  )

  pagebreak(weak: false)
  
  counter(page).update(1)
  counter(heading.where(level: 1)).update(0)
  part-state.update("正文")

  doc
}