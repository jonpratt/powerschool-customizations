SELECT
    storedgrades.teacher_name as teacher,
    terms.abbreviation as termAbbreviation,
    courses.course_name as courseName,
    sections.id as sectionID,
    students.lastfirst as studentName,
    storedgrades.grade as courseGrade

FROM
    students

INNER JOIN
    cc ON cc.studentid=students.id AND cc.termid BETWEEN 2500 AND 2510

INNER JOIN
    sections on sections.id=cc.sectionid
                
INNER JOIN
    courses ON courses.course_number=cc.course_number

INNER JOIN
    storedgrades ON storedgrades.studentid=students.id AND storedgrades.sectionid=sections.id AND storedgrades.storecode='P1'

INNER JOIN
    terms on terms.id=cc.termid AND terms.schoolid=1036

WHERE
    students.enroll_status=0

ORDER BY
    storedgrades.teacher_name, terms.abbreviation, courses.course_name, sections.id, students.lastfirst