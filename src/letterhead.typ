#import "colours.typ"
#import "fonts.typ"
#import "logo.typ"

#let header = (faculty, address) => [
  #logo.colour

  #h(4.5pt)
  #box(
    text(fill: colours.neutral)[
      #text(font: fonts.body, size: 10pt, weight: 600, faculty)

      #text(font: fonts.accent, size: 8pt, weight: 200, address)
    ]
  )
]
