//  原本想改用 i-figure ，但是我发现各种要求挺烦的，最后还是用自己造的轮子了
#import "states.typ": part-state
#import "fonts.typ": 字体, 字号

// 用法:
// #show figure: show-figure
// #show ref: show-ref
// #show

#let tb-numbering(
  it,
  loc: none,
  baseloc: none,
  main-body-table-numbering: "1.1",
  main-body-image-numbering: "1-1", // 其他也会视为 image
  appendix-table-numbering: "A.1",
  appendix-image-numbering: "A-1", // 其他也会视为 image
) = {
  if part-state.at(loc) != "附录" {
    numbering(
      if it.kind == table {main-body-table-numbering} else {main-body-image-numbering},
      counter(heading.where(level: 1)).at(loc).first(), // 章节号
      (
        counter(figure.where(kind: it.kind))
        .at(loc)
        .first() -
        counter(figure.where(kind: it.kind))
        .at(baseloc)
        .first()
      ) // 图序号，使用总序号减章节开始时序号实现
    )
  } else if part-state.at(loc) == "附录" {
    numbering(
      if it.kind == table {appendix-table-numbering} else {appendix-image-numbering},
      counter(heading.where(level: 1)).at(loc).first(), // 章节号
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
}
