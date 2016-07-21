SELECT DISTINCT
  courses.dcid,
  courses.course_number,
  courses.course_name,
  standard.standardid,
  standard.identifier,
  standard.name as standardName

FROM
  cc
  
INNER JOIN
  courses on cc.course_number=courses.course_number
  
LEFT JOIN
  standardcourseassoc on standardcourseassoc.coursesdcid=courses.dcid
  
LEFT JOIN
  standard on standardcourseassoc.standardid=standard.standardid and standard.yearid=25
  
WHERE
  cc.termid>=2500
  
ORDER BY
  courses.course_number