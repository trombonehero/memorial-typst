#import "@preview/tablex:0.0.7": cellx, gridx, tablex

#import "colours.typ"
#import "fonts.typ"
#import "letterhead.typ"


//
// A moderate highlight (in Memorial Claret)
//
#let head(singular, plural: none, n: 1) = {
  set text(font: fonts.accent, weight: 600, size: 9pt)

  let content = if n > 1 and plural != none {
    plural
  } else if n == 1 {
    singular
  } else {
    ""
  }

  text(fill: colours.claret, weight: 600, content)
}

#let title(course) = [
  #set text(font: fonts.body, fill: colours.neutral, weight: 600)

  #box(width: 100%, [
    #box(baseline: 50%)[
      #letterhead.header(course.unit, text(fill: colours.claret, size: 14pt, weight: 800, course.full_name))
    ]
    #h(1fr)
    #box(baseline: 0%, text(font: fonts.accent, size: 9pt, weight: 200)[
      Course Outline
      \
      #course.code

      #course.semester
    ])
  ])
]

#let template(doc, course) = {
  set page(
    "us-letter",
    margin: (bottom: 1in, rest: .75in),
    header: locate(
      loc => if loc.page() > 1 {
         h(1fr)
         text(font: fonts.accent,
              weight: 200,
              size: 9pt,
              fill: colours.claret,
              style: "italic")[
           #course.full_name (#course.semester)
         ]
      }
    ),
    footer: place(center, counter(page).display("1")),
  )

  set heading(numbering: "1.")
  set par(justify: true, leading: .55em)
  set text(font: fonts.body, size: 10pt)

  show heading: it => {
    set text(fill: colours.claret, weight: 600)

    counter(heading).display()
    " "
    it.body
  }

  show terms.item: it => {
    box(width: 10em, head(it.term))
    h(0.6em)
    it.description
    linebreak()
  }

  show raw: content => text(font: "Inconsolata", content)
  show link: content => text(font: "Inconsolata", size: .9em, content)

  title(course)

  doc
}


#let setup(
  subject_code,
  subject_name,
  course_code,
  course_name,
  semester,
  unit: "Faculty of Engineering and Applied Science",
) = {
  let code = [#subject_code~#course_code]
  let full_name = [#subject_name~#course_code: #course_name]

  (
    code: code,
    head: head,
    full_name: full_name,
    name: [#subject_name~#course_code],
    semester: semester,
    short_code: subject_code + str(course_code),
    unit: unit,
  )
}

//
// A table that summarizes key information about the course
// (instructor, calendar entry, office, schedule, etc.)
//
#let summary_table(
  course,
  instructors,
  tas: (),

  calendar_description: none,
  credits: 3,
  prerequisites: (),
  safe_labs: false,
  schedule: (),

  textbook: none,
  references: (),

  communication: none,
  office_hours: none,
  semester: none,
  website: none,

  engineering_gas: (),
) = {
  let instructor_boxes = ()

  for i in instructors {
    instructor_boxes.push([
      #i.name
      \
      #i.office
      \
      #link("mailto:" + i.email + "?subject=" + course.short_code, i.email)
    ])
  }

  let cells = (
    head("Instructor"),
    cellx(colspan: if tas.len() == 0 { 3 } else { 1 },
      for i in instructors {
        box([
          #i.name
          \
          #i.office
          \
          #link("mailto:" + i.email + "?subject=" + course.short_code, i.email)
        ])
        h(1em)
      }
    ),
  )

  if tas.len() > 0 {
    cells.push(head("TA", plural: "TAs", n: tas.len()))
    cells.push(for ta in tas {
      block([
        #ta.name
        (#link("mailto:" + ta.email + "?subject=Engineering%201020", ta.email))
      ])
    })
  }

  if office_hours != none {
    cells.push(head("Office Hours"))
    cells.push(cellx(colspan: 3, office_hours))
  }

  if website != none {
    cells.push(head("Website"))
    cells.push(cellx(colspan: 3, link(website)))
  }

  if communication != none {
    cells.push(head("Communication"))
    cells.push(cellx(colspan: 3, communication))
  }

  if calendar_description != none {
    cells.push(head("Calendar"))
    cells.push(cellx(colspan: 3)[
      *#course.full_name* #calendar_description
    ])
  }

  if prerequisites.len() > 0 {
    cells.push(head("Prerequisite", plural: "Prerequisites", n: prerequisites.len()))
    cells.push(cellx(colspan: 3, prerequisites.join(", ")))
  }

  if schedule.len() > 0 {
    cells.push(head("Schedule"))
    cells.push(
      cellx(colspan: 3, grid(
        columns: (auto, auto, auto),
        column-gutter: 2em,
        row-gutter: .5em,
        ..for item in schedule {
          (item.name, item.times, item.room)
        })
      )
    )
  }

  cells.push(head("Credit value"))
  cells.push([#credits credit-hours])

  cells.push([])
  cells.push([])

  // Always show a textbook row (even if it's "none")
  cells.push(head("Textbook"))
  cells.push(cellx(colspan: 3, if textbook == none { "None" } else { textbook }))

  if references != none {
    cells.push(head("Reference", plural: "References", n: references.len()))
    cells.push(cellx(colspan: 3)[
      #for r in references {
        block(r)
      }
    ])
  }

  if engineering_gas != none and engineering_gas.len() > 0 {
    import "engineering.typ": ga_names

    cells.push(
      head("Graduate Attribute",
           plural: "Graduate Attributes",
           n: engineering_gas.len())
    )

    cells.push(cellx(colspan: 3, for ga in engineering_gas [
      *#ga:* #ga_names.at(ga),
    ]))
  }

  gridx(
    columns: (auto, 1fr, 1in, 1fr),
    ..cells,
  )
}
