SELECT
    storedgrades.teacher_name as teacher,
    terms.abbreviation as termAbbreviation,
    courses.course_name as courseName,
    cc.sectionid as sectionID,
    students.lastfirst as studentName,
    storedgrades.grade as courseGrade,
    standard.standardid as standardID,
    standard.name as standardName,
    standardgradesection.standardgrade as standardGrade

FROM
    students

INNER JOIN
    cc ON cc.studentid=students.id AND cc.termid BETWEEN 2500 AND 2510

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
    storedgrades.teacher_name, terms.abbreviation, courses.course_name, cc.sectionid, students.lastfirst, standard.displayposition