SELECT
	students.first_name as FirstName,
	students.last_name as LastName,
  students.sched_yearofgraduation as YOG,
	(students.student_web_id || '@foxcroftacademy.org') as Email,
	students.guardianemail || ', ' ||
	ps_customfields.getstudentscf(students.id, 'Non_Custodial___Email_Address') || ', ' ||
	ps_customfields.getstudentscf(students.id, 'international_parent_email_1') || ', ' ||
	ps_customfields.getstudentscf(students.id, 'international_parent_email_2') || ', ' ||
	ps_customfields.getstudentscf(students.id, 'international_agent_email') || ', ' ||
	u_student_demographics.pha1_email || ', ' ||
	u_student_demographics.pha2_email || ', ' ||
  u_secondary_household.sha1_email || ', ' ||
  u_secondary_household.sha2_email as BCC,
	students.web_id as AccessID,
	students.web_password as AccessPassword
	
FROM
	students
	
LEFT OUTER JOIN
	u_student_demographics on u_student_demographics.studentsdcid=students.dcid

LEFT OUTER JOIN
  u_secondary_household on u_secondary_household.studentsdcid=students.dcid

WHERE
	students.enroll_status=0

ORDER BY
	students.lastfirst