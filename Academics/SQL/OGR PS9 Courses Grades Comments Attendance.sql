SELECT
  students.id as studentID,
  students.lastfirst as studentName,
  students.grade_level as studentGradeLevel,
  courses.course_name as courseName,
  terms.abbreviation as termCode,
  storedgrades.grade as courseGrade,
  courses.credit_hours as potentialCredit,
  storedgrades.earnedcrhrs as earnedCredit,
  storedgrades.teacher_name as teacherName,
  TO_CHAR (storedgrades.comment_value) as teacherComment,
  CASE WHEN SUM(attendance_code.course_credit_points)>0 THEN SUM(attendance_code.course_credit_points) ELSE 0 END as rawAttendancePoints,
  CASE WHEN (SUM(attendance_code.course_credit_points)/courses.credit_hours)>0 THEN round((SUM(attendance_code.course_credit_points)/courses.credit_hours)) ELSE 0 END as adjustedAttendancePoints

FROM
  students

INNER JOIN
  cc ON students.id=cc.studentid AND cc.termid>=2500
  
INNER JOIN
  terms ON cc.termid=terms.id AND terms.schoolid=1036
  
INNER JOIN
  courses ON cc.course_number=courses.course_number AND courses.credit_hours>0

INNER JOIN
  storedgrades ON storedgrades.studentid=students.id AND storedgrades.course_number=cc.course_number AND storedgrades.termid=cc.termid AND storedgrades.storecode='P1'

LEFT JOIN
  attendance ON attendance.ccid=cc.id
  
LEFT JOIN
  attendance_code ON attendance_code.id=attendance.attendance_codeid
  
WHERE
  students.enroll_status=0 AND
  (attendance_code.course_credit_points>0 OR attendance_code.course_credit_points IS NULL)

GROUP BY students.id, students.lastfirst, students.grade_level, courses.course_name, terms.abbreviation, 
storedgrades.grade, courses.credit_hours, storedgrades.earnedcrhrs, storedgrades.teacher_name, TO_CHAR(storedgrades.comment_value)

ORDER BY students.lastfirst, terms.abbreviation, courses.course_name