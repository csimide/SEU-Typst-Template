#let gen-smart-pagebreak(
  always-skip-even: true,
  skip-with-page-blank: true,
) = {
  if always-skip-even == false {
    return (_ => {
      pagebreak(weak: true)
    })
  } else if skip-with-page-blank == false {
    return (_ => {
      pagebreak(weak: true, to: "odd")
    })
  } else {
    return (_ => {
      page(header: none, footer: none)[~]
    })
  }
}