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
  courses ON courses.course_number=cc.course_number AND courses.excludefromstoredgrades=0

LEFT JOIN
  storedgrades ON storedgrades.studentid=students.id AND storedgrades.course_number=cc.course_number AND storedgrades.termid=cc.termid AND storedgrades.storecode='P1'

INNER JOIN
  activities on activities.studentsdcid=students.dcid AND activities.fieldhockey=1

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
  (standard.yearid=25 OR standard.yearid IS NULL) AND
  terms.abbreviation!='S2'

ORDER BY
  students.lastfirst, courses.course_name, standard.displayposition