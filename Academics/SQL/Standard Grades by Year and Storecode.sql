SELECT
  students.lastfirst as lastFirst,
  courses.course_name as courseName,
  standard.name as standardName,
  standardgradesection.standardgrade as standardGrade

FROM
  standardgradesection
  
INNER JOIN
  students on students.dcid=standardgradesection.studentsdcid

INNER JOIN
  sections on sections.dcid=standardgradesection.sectionsdcid

INNER JOIN
  courses on courses.course_number=sections.course_number

INNER JOIN
  standard on standard.standardid=standardgradesection.standardid

WHERE
  students.enroll_status=0 AND
  standardgradesection.storecode='P1' AND
  standardgradesection.yearid=25
  
ORDER BY
  students.lastfirst, courses.course_name, standard.displayposition

---

SELECT
  students.lastfirst as lastFirst,
  courses.course_name as courseName,
  standardcourseassoc.standardID as standardID,
  standard.name as standardName

FROM
  students

INNER JOIN
  cc on cc.studentid=students.id

INNER JOIN
  courses on cc.course_number=courses.course_number
  
LEFT OUTER JOIN
  standardcourseassoc on standardcourseassoc.coursesdcid=courses.dcid
  
LEFT OUTER JOIN
  standard on standard.standardid=standardcourseassoc.standardid

WHERE
  students.enroll_status=0 AND
  cc.termid>=2500 AND
  standard.yearid=25

ORDER BY
  students.lastfirst, courses.course_name, standard.displayposition
