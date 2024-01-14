#import "base.typ": *

#set text(lang: "zh")

// WIP
// 思路：先做一个相似的文档，再模板化 

// 封面
#{
  set page(margin: (top: 2cm, bottom: 2cm, left:2cm, right: 2cm))
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