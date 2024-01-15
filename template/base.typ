#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let 字体 = (
  仿宋: ("Times New Roman", "FangSong"),
  宋体: ("Times New Roman", "SimSun"),
  黑体: ("Times New Roman", "SimHei"),
  标题黑体: ("SimHei"),
  楷体: ("Times New Roman", "KaiTi"),
  代码: ("New Computer Modern Mono", "Times New Roman", "SimSun"),
)

#let numberwithcircle(num) = "①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳".clusters().at(num - 1, default: "®")


#let lengthceil(len, unit: 字号.小四) = calc.ceil(len / unit) * unit

#let chaptercounter = counter("chapter")
#let appendixcounter = counter("appendix")
#let pagecounter = counter("page")
#let equationcounter = counter(math.equation)

#let partstate = state("part", "封面")
#let skippedstate = state("skip", false)

#let switchtopart(part) = {
  partstate.update(part)

  if part == "正文" {

  } else if part == "附录" {
    appendixcounter.update(1)
    counter(heading).update(0)
  }
}

#let appendix() = {
  switchtopart("附录")
}

#let chineseunderline(s, width: 300pt, bold: false) = {
  let chars = s.clusters()
  let n = chars.len()
  style(styles => {
    let i = 0
    let now = ""
    let ret = ()

    while i < n {
      let c = chars.at(i)
      let nxt = now + c

      if measure(nxt, styles).width > width or c == "\n" {
        if bold {
          ret.push(strong(now))
        } else {
          ret.push(now)
        }
        ret.push(v(-1em))
        ret.push(line(length: 100%, stroke: (thickness: 0.5pt)))
        if c == "\n" {
          now = ""
        } else {
          now = c
        }
      } else {
        now = nxt
      }

      i = i + 1
    }

    if now.len() > 0 {
      if bold {
        ret.push(strong(now))
      } else {
        ret.push(now)
      }
      ret.push(v(-0.9em))
      ret.push(line(length: 100%, stroke: (thickness: 0.5pt)))
    }

    ret.join()
  })
}

#let chinesenumber(num, standalone: false) = if num < 11 {
  ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十").at(num)
} else if num < 100 {
  if calc.rem(num, 10) == 0 {
    chinesenumber(calc.floor(num / 10)) + "十"
  } else if num < 20 and standalone {
    "十" + chinesenumber(calc.rem(num, 10))
  } else {
    chinesenumber(calc.floor(num / 10)) + "十" + chinesenumber(calc.rem(num, 10))
  }
} else if num < 1000 {
  let left = chinesenumber(calc.floor(num / 100)) + "百"
  if calc.rem(num, 100) == 0 {
    left
  } else if calc.rem(num, 100) < 10 {
    left + "零" + chinesenumber(calc.rem(num, 100))
  } else {
    left + chinesenumber(calc.rem(num, 100))
  }
} else {
  let left = chinesenumber(calc.floor(num / 1000)) + "千"
  if calc.rem(num, 1000) == 0 {
    left
  } else if calc.rem(num, 1000) < 10 {
    left + "零" + chinesenumber(calc.rem(num, 1000))
  } else if calc.rem(num, 1000) < 100 {
    left + "零" + chinesenumber(calc.rem(num, 1000))
  } else {
    left + chinesenumber(calc.rem(num, 1000))
  }
}

#let chinesenumbering(..nums, location: none, brackets: false) = locate(loc => {
  let actual_loc = if location == none { loc } else { location }
  if appendixcounter.at(actual_loc).first() == 0 {
    if nums.pos().len() == 1 {
      "第" + chinesenumber(nums.pos().first(), standalone: true) + "章"
    } else {
      numbering(if brackets { "(1.1)" } else { "1.1" }, ..nums)
    }
  } else {
    if nums.pos().len() == 1 {
      "附录 " + numbering("A.1", ..nums)
    } else {
      numbering(if brackets { "(A.1)" } else { "A.1" }, ..nums)
    }
  }
})

#let cnoutline(
  outlinedepth: 3, 
  thesistype: "Undergraduate",
  baseindent: 1em,
  firstlevelspacing: none,
  firstlevelfontweight: "regular",
  itemspacing: 14pt
) = [
  #partstate.update("目录")

  #heading(
    numbering: none, 
    outlined: if thesistype == "Undergraduate" {true} else {false}, 
    bookmarked: true
  )[目录]

  #set text(font: 字体.宋体, size: 字号.小四)
  #set par(leading: itemspacing)
  #set block(spacing: if firstlevelspacing != none {firstlevelspacing} else {itemspacing})

  #locate(loc => {
    let elems = query(heading.where(outlined: true), loc)
    for el in elems {
      let outlineline = {
        if (el.level == 1) {parbreak()}

        h((el.level - 1) * 2em + baseindent)

        if el.level == 1 {
          set text(weight: firstlevelfontweight)
          if el.numbering == chinesenumbering and el.body.text != "致谢" {
            chinesenumbering(..counter(heading).at(el.location()), location: el.location())
            h(0.5em)
          }

          if el.body.text in ("摘要", "致谢", "目录") and thesistype == "Undergraduate" {
            // 原始模板里加了空格
            el.body.text.first() 
            h(2em)
            el.body.text.last()
          } else {
            el.body.text
          }
        } else if el.level <= outlinedepth and el.numbering == chinesenumbering {
          chinesenumbering(..counter(heading).at(el.location()), location: el.location())
            h(0.3em)
            el.body.text
        } else {continue}

        box(width: 1fr, h(10pt) + box(width: 1fr, repeat[.]) + h(10pt))

        let footer = query(selector(<__footer__>).after(el.location()), el.location())
        footer.first()

          linebreak()
      }

      link(el.location())[#outlineline]

    }
  })
]

#let showheading(
  headingtopmargin: (0cm, 0cm, 0cm),
  headingbottommargin: (0cm, 0cm, 0cm),
  headingtext: (
    (font: 字体.黑体, size: 字号.三号, weight: "bold"),
    (font: 字体.黑体, size: 字号.四号, weight: "regular"),
    (font: 字体.宋体, size: 字号.小四, weight: "regular")
  ),
  thesistype: "Undergraduate",
  it
) = [
  #set par(first-line-indent: 0em)

  #if it.level == 1 {
    pagebreak(weak: true)
  }

  #v(headingtopmargin.at(
    it.level - 1, 
    default: headingtopmargin.at(2)
  ))

  #if it.level == 1 {

    set align(center)
    set text(..headingtext.at(0))


    if it.numbering == none or it.body.text == "致谢"{
      if it.body.text.clusters().len() == 2 {
        it.body.text.first()
        h(2em)
        it.body.text.last()
      } else {
        it.body.text
      }
    } else {
      it
    }

    if thesistype == "Undergraduate" and it.body.text in ("摘要", "目录", "致谢", "ABSTRACT") {
      if it.body.text == "目录" {v(5pt)} else {v(1em)}
    }

    locate(loc => {
      let itpart = partstate.at(loc)
      equationcounter.update(0)
      if itpart == "正文" { 
        chaptercounter.step()
      } else if itpart == "附录" { 
        appendixcounter.step()
      }
    })
  } else {
    set text(..headingtext.at(
      it.level - 1,
      default: headingtext.at(2)
    ))
    it
  }

  #v(headingbottommargin.at(
    it.level - 1, 
    default: headingbottommargin.at(2)
  ))
]