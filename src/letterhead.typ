#import "colours.typ"
#import "fonts.typ"
#import "logo.typ"

#let header = (faculty, address) => [
  #logo.colour

  #h(4.5pt)
  #box(
    text(fill: colours.neutral)[
      #text(font: fonts.body, size: 11pt, weight: 600, faculty)

      #text(font: fonts.accent, size: 9pt, weight: 200, address)
    ]
  )
]
