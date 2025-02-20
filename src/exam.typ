#import "@preview/ttt-exam:0.1.2"
#import "@preview/ttt-utils:0.1.2": random
#import "colours.typ"
#import "fonts.typ"
#import "letterhead.typ"


#let header(course, faculty, address, date, exam_kind: "Final exam") = {
  grid(
    columns: (1fr, 1fr),
    gutter: 2em,
    letterhead.header(faculty, address),
    text(font: fonts.accent)[
      #text(
        fill: colours.claret,
        weight: 800,
        course.code + ": " + course.name
      )

      #text(weight: 200)[
        #exam_kind
        \
        #date
      ]

      #text(size: 9pt, weight: 800)[
        #box(stroke: 0.5pt, height: 3.5em, width: 1fr, inset: .5em)[Name:]

        #v(-.5em)

        #box(stroke: 0.5pt, height: 3.5em, width: 1fr, inset: .5em)[Student ID:]
      ]
    ],
  )

  v(1em)
}


#let assignment(body, ..args) = {
  v(.25em)

  ttt-exam.assignments.assignment(
    box(
      baseline: 100% - .65em,
      width: 1fr,
      body
    )
  )

  v(.25em)
}


#let question(body, ..args) = {
  ttt-exam.assignments.question(
    box(
      baseline: 100% - .65em,
      inset: (bottom: .5em),
      width: 1fr,
      body
    ),
    ..args
  )
}

#let multiple-choice(prompt, answers, columns: none, direction: ttb, points: 1, choosemany: false, randomize: false) = {
  question(points: points)[
    #prompt

    #if randomize {
      answers = random.shuffle(answers)
    } else if direction in (btt, rtl) {
      answers = answers.rev()
    }

    #let answers = answers.map(answer => {
      if choosemany {
        ttt-exam.components.checkbox()
      } else {
        $circle.stroked.big$
      }
      
      h(.5em)
      answer
    })

    #if columns == none {
      for a in answers {
        a

        if direction in (ttb, btt) {
          v(0em)
        } else {
          h(1fr)
        }
      }
    } else {
      grid(
        columns: columns,
        column-gutter: .5em,
        row-gutter: 1.5em,
        ..answers.map(answer => [
          #answer
        ])
      )
    }

  ]
}

#let answer(body, workings: none, ..args) = {
  v(1.5em)

  if workings != none [
    *Workings:*
    #v(workings)

    *Answer:*

  ]

  box(ttt-exam.assignments.answer(body, ..args))
}

#let answerbox(body, height: 3em, width: 8em, label: none, workings: none, ..args) = {
  if workings != none [
    *Workings:*
    #v(workings)

    *Answer:*

  ]

  if label != none {
    return grid(
      align: horizon,
      columns: (1fr, auto, width),
      gutter: .5em,
      [], [#label:], answerbox(height: height, width: 100%)[],
    )
  }

  ttt-exam.assignments.answer(
    body,
    field: {
      h(1fr)
      box(
        height: height,
        width: width,
        stroke: .5pt,
      )
    },
    ..args,
  )
}


#let answerline(body, width: 12em, workings: none, ..args) = {
  if workings != none [
    *Workings:*
    #v(workings)

    *Answer:*

  ]

  ttt-exam.assignments.answer(
    body,
    field: {
      h(1fr)
      box(
        height: 1em,
        width: width,
        stroke: (bottom: .5pt),
      )
    },
    ..args,
  )
}

#let answerlines(body, lines: 1, workings: none) = {
  answer(body, field: ttt-exam.lines(lines), workings: workings)
}


#let tf(prompt, points: 1) = {
  question(points: points)[
    #box(prompt)
    #answerline(width: 2em)[]
  ]
}


/// A horizontal points table
#let points_table_h = {
  pad(
    1em, 
    context {
      let points = ttt-exam.grading.get_points()
      table(
        align: (col, _) => if (col == 0) { left } else { center },
        inset: (x: 1em),
        rows: (auto, auto, 1cm),
        columns: (auto, ..((1cm,) * points.len()), auto),
        stroke: 0.5pt,

        text(weight: 800)[Question],
        ..points.enumerate().map(((i,_)) => [#{i+1}]),
        text(weight: 800)[Total],

        text(weight: 800)[Points],
        ..points.map(str),
        ttt-exam.total_points,

        text(weight: 800)[Awarded],
      )
    }
  )
}

/// A vertical points table
#let points_table_v = {
  pad(
    1em, 
    context {
      let points = ttt-exam.grading.get_points()

      table(
        align: center+horizon,
        columns: 3,
        rows: (auto, ..((1cm,) * points.len()), 1cm),
        inset: (x: 1em),
        stroke: 0.5pt,

        text(weight: 800)[Question],
        text(weight: 800)[Points],
        text(weight: 800)[Assigned],

        ..points.enumerate()
          .map(((q, points)) => ([#{q+1}], [#points], []))
          .flatten(),

        text(weight: 800)[Total],
        text(weight: 800)[#ttt-exam.total_points],
        [],
      )
    }
  )
}
