SELECT
    students.first_name as firstName,
    students.last_name as lastName,
    students.student_web_id || '@foxcroftacademy.org' as email,
    students.id as studentID,
    students.home_phone as homePhone,
    students.gender as gender,
    to_char (Students.DOB, 'DD/MM/YYYY') as dateOfBirth,
    students.grade_level as gradeLevel,
    u_student_demographics.pha1_firstname as c1FirstName,
    u_student_demographics.pha1_lastname as c1LastName,
    'Dorm Parent' as c1Relationship,
    students.guardianemail as c1Email,
    studentcorefields.father_home_phone as c1HomePhone,
    u_student_demographics.pha1_cellphone as c1MobilePhone,
    students.mailing_street || ', ' || students.mailing_city || ', ' || students.mailing_state || ', ' || students.zip as c1Address,
    ps_customfields.getstudentscf(students.id, 'international_father''s_name') as c2Name,
    'FatherField' as c2Relationship,
    ps_customfields.getstudentscf(students.id, 'international_parent_email_1') as c2Email,
    ps_customfields.getstudentscf(students.id, 'international_home_phone') as c2HomePhone,
    ps_customfields.getstudentscf(students.id, 'international_cell_phone') as c2MobilePhone,
    ps_customfields.getstudentscf(students.id, 'international_address_1') || ', ' || ps_customfields.getstudentscf(students.id, 'international_address_2') || ', ' || ps_customfields.getstudentscf(students.id, 'international_city/town') || ', ' || ps_customfields.getstudentscf(students.id, 'international_province') || ', ' || ps_customfields.getstudentscf(students.id, 'international_country') || ', ' || ps_customfields.getstudentscf(students.id, 'international_postal_code') as c2Address,
    ps_customfields.getstudentscf(students.id, 'international_mother''s_name') as c3Name,
    'MotherField' as c3Relationship,
    ps_customfields.getstudentscf(students.id, 'international_parent_email_2') as c3Email,
    ps_customfields.getstudentscf(students.id, 'international_home_phone') as c3HomePhone,
    ps_customfields.getstudentscf(students.id, 'international_cell_phone') as c3MobilePhone,
    ps_customfields.getstudentscf(students.id, 'international_address_1') || ', ' || ps_customfields.getstudentscf(students.id, 'international_address_2') || ', ' || ps_customfields.getstudentscf(students.id, 'international_city/town') || ', ' || ps_customfields.getstudentscf(students.id, 'international_province') || ', ' || ps_customfields.getstudentscf(students.id, 'international_country') || ', ' || ps_customfields.getstudentscf(students.id, 'international_postal_code') as c3Address,
    ps_customfields.getstudentscf(students.id, 'international_agent_name') as c4Name,
    'Agent' as c4Relationship,
    ps_customfields.getstudentscf(students.id, 'international_agent_email') as c4Email,
    'NA' as c4HomePhone,
    'NA' as c4MobilePhone,
    'NA' as c4Address

FROM
    students

INNER JOIN
    u_student_demographics on u_student_demographics.studentsdcid=students.dcid
    
INNER JOIN
    studentcorefields on studentcorefields.studentsdcid=students.dcid
    
WHERE
    students.enroll_status=0 AND
    studentcorefields.area='Non-Resident'
    
ORDER BY
    students.grade_level, students.last_name, students.first_name