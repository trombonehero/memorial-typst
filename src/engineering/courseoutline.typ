//
// Common language that goes in Engineering course outlines
//
#let boilerplate(safe_labs: false, extra_integrity: none) = [
  = Academic Integrity and Professional Conduct

  Students are expected to conduct themselves in all aspects of the course at
  the highest level of academic integrity.
  Any student found to commit academic misconduct will be dealt with
  according to the Faculty and University practices.
  More information is available at
  #link("http://www.mun.ca/engineering/undergrad/academicintegrity.php").
  Students are encouraged to consult the
  #link("http://www.mun.ca/engineering/undergrad/academicintegrity.php")[Faculty of Engineering and Applied Science Student Code of Conduct]
  and
  #link("https://www.mun.ca/student")[Memorial University’s Code of Student Conduct].

  #if extra_integrity != none [
    #extra_integrity
  ]

  #if not safe_labs [
    = Lab Safety

    Students are expected to demonstrate awareness of, and personal
    accountability for, safe laboratory conduct.
    Appropriate personal protective equipment (PPE) must be worn (e.g.
    steel-toed shoes, safety glasses, etc.) and safe work practices must be
    followed as indicated for individual laboratories, materials and
    equipment.
    Students will immediately report any concerns regarding safety to the
    teaching assistant, staff technologist or professor.
  ]

  = Inclusion and Equity

  Students who require accommodations are encouraged to contact the
  #link("http://www.mun.ca/blundon/about")[Glenn Roy Blundon Centre].
  The mission of the Blundon Centre is to provide and co-ordinate programs
  and services that enable students with disabilities to maximize their
  educational potential and to increase awareness of inclusive values among
  all members of the university community.

  The university experience is enriched by the diversity of viewpoints,
  values, and backgrounds that each class participant possesses.
  In order for this course to encourage as much insightful and comprehensive
  discussion among class participants as possible, there is an expectation
  that dialogue will be collegial and respectful across disciplinary,
  cultural, and personal boundaries.

  = Student Assistance

  Student Affairs and Services offers help and support in a variety of areas,
  both academic and personal.
  More information can be found at #link("http://www.mun.ca/student").
]
