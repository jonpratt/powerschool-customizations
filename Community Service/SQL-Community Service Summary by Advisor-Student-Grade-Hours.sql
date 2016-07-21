SELECT
	teachers.lastfirst as Advisor,
	students.lastfirst as Student,
	virtualtablesdata2.user_defined_integer as Grade,
	SUM(virtualtablesdata2.user_defined_numeric) as Hours

FROM students

INNER JOIN
	virtualtablesdata2 on virtualtablesdata2.foreignkey=students.id
	
INNER JOIN
	cc on students.id=cc.studentid
	
INNER JOIN
	teachers on cc.teacherid=teachers.id

WHERE
	students.enroll_status=0
	AND cc.termid>0
	AND cc.course_number='104'
	AND virtualtablesdata2.related_to_table='communityservice'

GROUP BY
	teachers.lastfirst,
	students.lastfirst,
	virtualtablesdata2.user_defined_integer

ORDER BY
	teachers.lastfirst,
	students.lastfirst,
	virtualtablesdata2.user_defined_integer