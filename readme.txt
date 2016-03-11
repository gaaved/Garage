1 
	SELECT DISTINCT Status FROM tbl_task ORDER BY Status
2
	SELECT COUNT( t.Id ) AS  'AllTask'
		FROM tbl_project AS p
		INNER JOIN tbl_task AS t ON p.Id = t.ProjectId
			ORDER BY  'AllTask' DESC
3
	SELECT COUNT(t.Id) as 'AllTask' FROM tbl_project as p 
  		INNER JOIN tbl_task as t ON p.Id = t.ProjectId
			ORDER BY p.Name DESC
4
	SELECT * FROM `tbl_task` WHERE Name LIKE '4%'

5 get the list of all projects containing the ‘a’ letter in the middle of the name, and show the
  tasks count near each project. Mention that there can exist projects without tasks and 
  tasks with project_id=NULL

  SELECT p.Name AS 'Project Name' , Count(t.Id) AS 'Count Tasks' FROM tbl_project AS p
	INNER JOIN tbl_task AS t ON p.Id = t.ProjectId
    	WHERE p.Name LIKE '%w%';
6 get the list of tasks with duplicate names. Order alphabetically
	SELECT t.Name FROM tbl_task AS t 
	GROUP BY t.Name
	HAVING COUNT(t.Id) > 1
	ORDER BY t.Name
 
7. get the list of tasks having several exact matches of both name and status, from the
project ‘Garage’. Order by matches count
	SELECT * FROM tbl_task AS t
		GROUP BY t.Name, t.Status
		ORDER BY COUNT(t.Id)

8. get the list of project names having more than 10 tasks in status ‘completed’. Order by 
project_id

SELECT p.Name AS 'Project Name' FROM tbl_project AS p 
	INNER JOIN  tbl_task AS t ON p.Id = t.ProjectId
	WHERE t.Status = 1
	HAVING COUNT(t.Id) > 10
	ORDER BY p.Id