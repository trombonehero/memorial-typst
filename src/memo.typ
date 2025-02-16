#import "addresses.typ"
#import "faculties.typ"
#import "letterhead.typ"
#import "logo.typ"


// A signature block
#let signature(closing, sender) = {
  v(.5em)

  closing
  ","

  v(2em)

  sender
}


// This function gets your whole document as its `body`
// and formats it as a simple letter.
#let memo(
  // The faculty to show in the letterhead
  faculty: "Faculty Not Specified",

  // The address to show in the letterhead
  address: "Address Not Specified",

  // The letter's recipient, which is displayed close to the top.
  recipient: none,

  // The date, displayed to the right.
  date: datetime.today(),

  // The subject line.
  subject: none,

  // The name with which the letter closes.
  sender: none,

  /// How to close the letter
  closing: "Sincerely",

  // The letter's content.
  body
) = {
  // Configure page and text properties.
  set page(margin: 1in)
  set par(first-line-indent: 0pt, justify: true)
  set text(font: "Adobe Garamond Pro")

  let claret = cmyk(0%, 100%, 61%, 43%)
  let grey = cmyk(61%, 53%, 48%, 19%)

  v(-.5in)

  letterhead.header(faculty, address)

  v(.5em)

  // Display date. If there's no date add some hidden
  // text to keep the same spacing.
  if date != none {
    date.display("[day padding:none] [month repr:short] [year]")
  }

  v(.5em)

  // Display recipient.
  recipient

  v(1em)

  // Add the subject line, if any.
  if subject != none {
    align(center, strong(subject))
  }

  // Add body and name.
  body

  if closing != none {
    signature(closing, sender)
  }
}
