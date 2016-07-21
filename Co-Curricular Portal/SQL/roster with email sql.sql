Sports Roster with Email SQL

select students.lastfirst as Name, students.grade_level as Grade, (students.student_web_id || '@foxcroftacademy.org') as Email

from students

inner join activities on students.dcid=activities.studentsdcid

where students.enroll_status=0 and activities.football=1

order by students.grade_level, students.lastfirst