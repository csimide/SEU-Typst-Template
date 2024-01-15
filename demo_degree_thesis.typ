#import "template/degree.typ": *
#import "@preview/tablex:0.0.8": tablex, rowspanx, colspanx

#show: doc => conf(
  author: (CN: "王东南", EN: "WANG Dong-nan", ID: "012345"),
  thesisname: (
    CN: "摸鱼学硕士学位论文",
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
  alwaysstartodd: true,
  terminology: none,
  doc,
)


= 测试1

= 测试2