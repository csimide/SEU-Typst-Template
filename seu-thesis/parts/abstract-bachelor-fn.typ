#import "../utils/fonts.typ": 字体, 字号

#let abstract-conf(
  cnabstract: none,
  cnkeywords: none,
  enabstract: none,
  enkeywords: none,
) = {
  // 摘要使用罗马字符的页码
  set page(numbering: "I", number-align: center)
  counter(page).update(1)

  set text(font: 字体.宋体, size: 字号.小四)

  if not cnabstract in (none, [], "") or not cnkeywords in (none, ()) {
    {
      set par(first-line-indent: 2em, leading: 14pt, justify: true)
      show par: set block(spacing: 14pt)
      // 我不理解为什么两个摘要需要不同的间距

      heading(outlined: true, bookmarked: true, level: 1, numbering: none)[摘要]

      v(3pt)

      cnabstract

      v(18pt)

      // 英文
      set par(first-line-indent: 0em)

      if not cnkeywords in (none, ()) {
        assert(type(cnkeywords) == array)
        "关键词：" + cnkeywords.join("，")
      }
    }
  }

  if not enabstract in (none, [], "") or not enkeywords in (none, ()) {
    {
      pagebreak(weak: true)

      set par(first-line-indent: 2em, leading: 15pt, justify: true)
      show par: set block(spacing: 15pt)
      // 我不理解为什么两个摘要需要不同的间距

      heading(
        outlined: true,
        bookmarked: true,
        level: 1,
        numbering: none,
      )[ABSTRACT]

      v(3pt)

      enabstract

      v(20pt)

      if not enkeywords in (none, ()) {
        assert(type(enkeywords) == array)
        "KEY WORDS: " + enkeywords.join("，")
      }
    }
  }
}

#abstract-conf(
  cnabstract: [示例摘要],
  cnkeywords: ("关键词1", "关键词2"),
  enabstract: none,
  enkeywords: ("Keywords1", "Keywords2"),
)
