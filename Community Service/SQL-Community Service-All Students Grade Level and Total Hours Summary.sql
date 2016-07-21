SELECT
	teachers.lastfirst as Advisor,
	students.lastfirst as Student,
	students.id as StudentID,
	students.grade_level as Grade,
	SUM(CASE WHEN virtualtablesdata2.user_defined_integer=9 AND virtualtablesdata2.related_to_table='communityservice' THEN virtualtablesdata2.user_defined_numeric ELSE 0 END) as G09H,
	SUM(CASE WHEN virtualtablesdata2.user_defined_integer=10 AND virtualtablesdata2.related_to_table='communityservice' THEN virtualtablesdata2.user_defined_numeric ELSE 0 END) as G10H,
	SUM(CASE WHEN virtualtablesdata2.user_defined_integer=11 AND virtualtablesdata2.related_to_table='communityservice' THEN virtualtablesdata2.user_defined_numeric ELSE 0 END) as G11H,
	SUM(CASE WHEN virtualtablesdata2.user_defined_integer=12 AND virtualtablesdata2.related_to_table='communityservice' THEN virtualtablesdata2.user_defined_numeric ELSE 0 END) as G12H,
	SUM(CASE WHEN virtualtablesdata2.user_defined_numeric IS NOT NULL AND virtualtablesdata2.related_to_table='communityservice' THEN virtualtablesdata2.user_defined_numeric ELSE 0 END) as TotalHours

FROM students

INNER JOIN
	cc on students.id=cc.studentid
	
INNER JOIN
	teachers on cc.teacherid=teachers.id

LEFT JOIN
	virtualtablesdata2 on students.id=virtualtablesdata2.foreignkey

WHERE
	students.enroll_status=0
	AND cc.termid>=2300
	AND cc.course_number='104'

GROUP BY
	teachers.lastfirst,
	students.lastfirst,
	students.id,
	students.grade_level

ORDER BY
	students.grade_level,
	teachers.lastfirst,
	students.lastfirst