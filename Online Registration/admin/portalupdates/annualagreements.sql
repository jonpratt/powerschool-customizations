SELECT
  students.dcid as studentsDCID,
  students.lastfirst as studentsName,
  students.grade_level as studentsGradeLevel,
  teachers.lastfirst as advisor,
  CASE WHEN u_student_demographics.emergency_agree=1 THEN u_student_demographics.emergency_agree ELSE 0 END as emergencyValue,
  CASE WHEN u_student_demographics.clinic_agree=1 THEN u_student_demographics.clinic_agree ELSE 0 END as clinicValue,
  CASE WHEN u_student_demographics.bus_agree=1 THEN u_student_demographics.bus_agree ELSE 0 END as busValue,
  CASE WHEN u_student_demographics.handbook_agree=1 THEN u_student_demographics.handbook_agree ELSE 0 END as handbookValue,
  CASE WHEN u_student_demographics.ipad_agree=1 THEN u_student_demographics.ipad_agree ELSE 0 END as ipadValue,
  CASE WHEN u_student_demographics.enrollment_agree=1 THEN u_student_demographics.enrollment_agree ELSE 0 END as enrollmentValue,
  CASE WHEN u_student_demographics.forms_complete=1 THEN u_student_demographics.forms_complete ELSE 0 END as formsCompleteValue
  
FROM
  students
  
LEFT OUTER JOIN
  u_student_demographics on u_student_demographics.studentsdcid=students.dcid

LEFT OUTER JOIN
  cc on cc.studentid=students.id AND cc.termid BETWEEN 2600 AND 2610 AND cc.course_number='104'

LEFT OUTER JOIN
  teachers on teachers.id=cc.teacherid

WHERE
  students.enroll_status=0
  
ORDER BY
  students.grade_level, students.lastfirst