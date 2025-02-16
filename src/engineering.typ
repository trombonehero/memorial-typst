#import "addresses.typ"
#import "engineering/gas.typ": ga_names
#import "engineering/courseoutline.typ": boilerplate as course_outline_boilerplate
#import "faculties.typ"
#import "letterhead.typ": header

#let headers = (
  "ece": header(faculties.engineering, addresses.ece),
)

#let mini_headers = (
  "ece": header("Department of Electrical and Computer Engineering")[],
)
