#import "fonts.typ": 字体, 字号
#import "packages.typ": show-cn-fakebold, i-figured
#import "states.typ": *
#import "to-string.typ": to-string
#import "fake-par.typ": fake-par

#let show-heading(
  heading-top-margin: (0.2cm, 0cm, 0cm),
  heading-bottom-margin: (0cm, 0cm, 0cm),
  heading-indent: (0cm, 0em, 0em),
  heading-align: (center, left, left),
  heading-text: (
    (font: 字体.黑体, size: 字号.三号, weight: "bold"),
    (font: 字体.黑体, size: 字号.四号, weight: "regular"),
    (font: 字体.宋体, size: 字号.小四, weight: "regular")
  ),
  always-new-page: false, // 每次一级标题都切换到新的页面，取值为 bool 或 function ，如果 function 则会以 function 作为分页时执行的操作
  auto-h-spacing: true, // 为 true 时，二字标题会变为 A #h(2em) B
  it
) = {
  set par(first-line-indent: 0em)

  let chapter-name-string = to-string(it.body)

  // 处理新页面换页
  if it.level == 1 and always-new-page != false {
    if type(always-new-page) == function {
      always-new-page()
    } else {
      pagebreak(weak: true)
    }
  }

  // 标题前间距
  v(
    heading-top-margin.at(
      it.level - 1,
      default: heading-top-margin.last(),
    ),
  )

  // 标题
  {
    set align(
      heading-align.at(
        it.level - 1,
        default: heading-align.last(),
      ),
    )

    set text(
      ..heading-text.at(
        it.level - 1,
        default: heading-text.last(),
      ),
    )

    h(
      heading-indent.at(
        it.level - 1,
        default: heading-indent.last(),
      ),
    )

    //
    if it.numbering == none {
      // 两个字标题的特殊处理
      if auto-h-spacing and chapter-name-string.clusters().len() == 2 {
        chapter-name-string.clusters().first()
        h(2em)
        chapter-name-string.clusters().last()
      } else {
        it.body
      }
    } else {
      context counter(heading).display()
      h(0.5em)
      it.body
    }
  }

  // 标题后间距
  v(
    heading-bottom-margin.at(
      it.level - 1,
      default: heading-bottom-margin.last(),
    ),
  )

  i-figured.reset-counters((level: it.level), return-orig-heading: false)

  fake-par
}