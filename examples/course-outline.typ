#import "@preview/memorialu:0.1.0": courseoutline, engineering
#import "@preview/tablex:0.0.7": cellx, gridx, hlinex

#let course = courseoutline.setup(
  "ECE",
  "ECE",
  7420,
  "Computer Security",
  "Spring 2023–24",
  unit: "Department of Electrical and Computer Engineering",
);

#show: doc => courseoutline.template(doc, course)

#courseoutline.summary_table(
  course,
  (
    (name: "Jonathan Anderson", email: "jonathan.anderson@mun.ca", office: "CSF-4123"),
  ),

  schedule: (
    (name: "Lecture", times: "MTR 13:00–13:50", room: "EN-2006"),
    (name: "Lab ", times: "F 14:00–17:00", room: "CSF-2112"),
  ),

  calendar_description: [
    introduces students to key computer security concepts for
    applications, hosts, networks and the Web.
    Students will learn to employ the primitives provided by
    programming languages, cryptography, operating systems and
    network protocols for protecting engineered systems and their users.
  ],

  prerequisites: ("ECE 6500: Computer Architectures", "ECE 6610: Communication Networks"),

  communication: [
    Please email me using my `@mun.ca` address, as
    I check Brightspace/D2L/`online.mun.ca` infrequently.
  ],
  office_hours: "Tue, Wed 16:00–17:00",
  website: "https://introsec.ca",

  textbook: [
    _Computer Security and the Internet: Tools and Jewels from Malware to Bitcoin_,
    van Oorschot,
    2#super[nd] Ed. (2021).
  ],

  references: (
    [
      _Security Engineering: A Guide to Building Dependable Distributed Systems_,
      Anderson,
      3#super[rd] Ed. (2020).
    ],
  ),

  engineering_gas: ("KB", "PA", "Impacts"),
  safe_labs: true,
)

= Course outcomes and graduate attributes

Upon successful completion of #course.full_name, students should be able to:

#gridx(
  columns: (1fr, auto, 1.75in),
  align: (left, center, left),

  hlinex(start: 0, end: 3),

  courseoutline.head("Learning outcome"),
  [#courseoutline.head("Attr-Prof") #footnote[
    Each course outcome is linked to a
    #link("https://www.mun.ca/engineering/media/production/memorial/academic/faculty-of-engineering/faculty-of-engineering-and-applied-science/media-library/facultystaff/forms/Graduate-Attributes.pdf")[Graduate Attribute],
    which is an overarching expectation for engineers who graduate from our
    program.
    Each attribute is taught and/or assessed at an Introduced (I), Applied (A)
    or Developed (D) level.
  ]],
  courseoutline.head("Assessment"),

  hlinex(start: 0, end: 3, stroke: .75pt),

  "explain how cryptography helps protect engineered systems",
  "KB–D, Imp–D",
  "assignments, case study, exams",

  [explain mitigation techniques such as `W^X` and ASLR],
  "KB–A, PA–A",
  "assignments, labs, exams",

  "design sandboxable software using language and OS primitives",
  "PA–A, D–A",
  "assignments, exams",

  "evaluate potential authentication approaches for specified systems",
  "KB–A, Imp–D",
  "assignments, labs, exams",

  "formulate appropriate threat models for engineered systems",
  "PA–A, Imp–D",
  "assignments, case study, exams",

  "specify security policies using both local and network primitives",
  "PA–A, D–D",
  "assignments, exams",

  "explain how protocols are used to overcome trust limitations",
  "PA–A, Imp–D",
  "assignments, case study, exams",

  [
    demonstrate practical attacks against processes, hosts, networks,
    Web applications and their users.
  ],
  "Inv–D, T–D",
  "assignments, labs",

  hlinex(start: 0, end: 3),
)

#v(5em)

= Assessment

Your progression through #course.full_name will be assessed both individually and
together with a lab partner.
To pass #course.name, *you must pass the exam portion of the course*,
and *you must complete all labs*.
Exams will be closed-book: students may not bring written materials or electronic devices
(including calculators or phones) to their seats.

#let grade_category(name, weight, n: 1) = {
  let label = if n == 1 {
    name
  } else [
    #name (#n)
  ]

  (courseoutline.head(label), courseoutline.head(align(right)[#weight%]))
}

#let grade_item(name, date, description: "(tentative)") = {
  (h(1em) + name, align(center, date), description)
}


#gridx(
  columns: (1fr, auto, 3fr),

  ..grade_category("Assignments", 10, n: 5),
  [Individual work],

  ..grade_category("Labs", 16, n: "6–8"),
  [Guided exploration of security tools and applications],

  ..grade_category("Case study", 10),
  [Independent research into a system, attack or defensive technique],

  ..grade_item("Proposal", "May 19th"),
  ..grade_item("Outline", "June 2nd"),
  ..grade_item("Report", "July 7th"),
  ..grade_item("Presentation", "mid-July", description: "during a lab slot"),

  ..grade_category("Midterm test", 24),
  [June 24th],

  ..grade_category("Final exam", 40),
)


= Major Topics

What we teach


#engineering.course_outline_boilerplate(safe_labs: true, extra_integrity: [
  Academic integrity means taking full responsibility for the academic work you
  submit in this course, so that I can evaluate you on the basis of
  *your own knowledge and effort*.
  When you submit work, you must *acknowledge sources* of both facts
  (references) and their presentation (authorship).
  It is an academic offence to claim work as original when it has been
  substantially derived from another source without attribution, whether that
  source is another person or a generative artificial intelligence tool.
  If GAI is permitted in a deliverable, you must reference any GAI tools you
  use and provide the sequence of prompts in an appendix.
])
