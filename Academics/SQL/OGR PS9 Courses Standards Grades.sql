SELECT
  students.dcid as studentsDCID,
  students.lastfirst as lastFirst,
  courses.course_name as courseName,
  courses.credit_hours as coursePotentialCredit,
  terms.abbreviation as termAbbreviation,
  storedgrades.grade as courseGrade,
  storedgrades.earnedcrhrs as courseEarnedCredit,
  standardcourseassoc.standardID as standardID,
  standard.identifier as standardIdentifier,
  standard.name as standardName,
  standardgradesection.standardgrade as standardGrade

FROM
  students

INNER JOIN
  cc ON cc.studentid=students.id AND cc.termid>=2500

INNER JOIN
  courses ON courses.course_number=cc.course_number

INNER JOIN
  storedgrades ON storedgrades.studentid=students.id AND storedgrades.course_number=cc.course_number AND storedgrades.termid=cc.termid AND storedgrades.storecode='P1'

INNER JOIN
  terms on terms.id=cc.termid AND terms.schoolid=1036

LEFT OUTER JOIN
  standardcourseassoc ON standardcourseassoc.coursesdcid=courses.dcid
  
LEFT OUTER JOIN
  standard ON standard.standardid=standardcourseassoc.standardid
  
LEFT OUTER JOIN
  standardgradesection ON standardgradesection.standardid=standard.standardid AND standardgradesection.studentsdcid=students.dcid AND standardgradesection.storecode='P1'

WHERE
  students.enroll_status=0 AND
  (standard.yearid=25 OR standard.yearid IS NULL)

ORDER BY
  students.lastfirst, courses.course_name, standard.displayposition


---
Comments
-Changed storedgrades to inner join from left outer join so that only current courses with stored grades will show on the official grade report. Left outer join was allowing all CC records (all enrollments for the year) to come through. This also allows removal of the AND excludefromstoredgrades=0 condition on the inner join for the courses table.

-Changed WHERE clause to (standard.yearid OR standard.yearid IS NULL) to get EITHER courses with standards in current year OR courses without standards (either due to no standards ever for that course, or due to standards not affiliated to course in current year, given that standardcourseassoc is left join, so it'll throw null for courses that don't match at all, and then that standardcourseassoc.null will throw null for left join of standard table

