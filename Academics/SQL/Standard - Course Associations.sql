SELECT
  courses.course_name as courseName,
  courses.course_number as courseNumber,
  standard.standardid as standardID,
  standard.identifier as standardIdentifier,
  standard.name as standardName
  
FROM
  standardcourseassoc
  
RIGHT OUTER JOIN
   courses on courses.dcid=standardcourseassoc.coursesdcid
  
RIGHT OUTER JOIN
  standard on standard.standardid=standardcourseassoc.standardid
  
WHERE
  standard.yearid=25 AND
  standard.isactive=1

ORDER BY
  standard.identifier