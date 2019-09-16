/*Challenge 1*/

CREATE TABLE intermediate AS
SELECT t.title, t.title_id, t.pub_id, ta.au_id
FROM titles t
LEFT JOIN titleauthor ta ON (t.title_id = ta.title_id)
GROUP BY t.title, t.title_id, t.pub_id, ta.au_id
;

CREATE TABLE master_table AS
SELECT pubs.pub_name, inter.title, inter.title_id, inter.pub_id, inter.au_id 
FROM intermediate inter
LEFT JOIN publishers pubs ON (inter.pub_id = pubs.pub_id)
;

SELECT DISTINCT au.au_id AS 'AUTHOR ID', au.au_lname AS 'LAST NAME', au.au_fname AS 'FIRST NAME', ma.title AS 'TITLE', ma.pub_name AS 'PUBLISHER'
FROM master_table ma
LEFT JOIN `authors` au ON (ma.au_id = au.au_id)
WHERE au.au_id IS NOT NULL
ORDER BY 'AUTHOR ID' DESC
;

/*Challenge 2*/

CREATE TABLE intermediate AS
SELECT t.title, t.title_id, t.pub_id, ta.au_id
FROM titles t
LEFT JOIN titleauthor ta ON (t.title_id = ta.title_id)
GROUP BY t.title, t.title_id, t.pub_id, ta.au_id
;

CREATE TABLE master_table AS
SELECT pubs.pub_name, inter.title, inter.title_id, inter.pub_id, inter.au_id 
FROM intermediate inter
LEFT JOIN publishers pubs ON (inter.pub_id = pubs.pub_id)
;

SELECT `AUTHOR ID` AS 'AUTHOR ID', `LAST NAME` AS 'LAST NAME', `FIRST NAME` AS 'FIRST NAME', `PUBLISHER` AS 'PUBLISHER',COUNT(DISTINCT(`TITLE`)) AS 'TITLE COUNT'

FROM
(SELECT au.au_id AS 'AUTHOR ID', au.au_lname AS 'LAST NAME', au.au_fname AS 'FIRST NAME', ma.title AS 'TITLE', ma.pub_name AS 'PUBLISHER'
FROM master_table ma
LEFT JOIN `authors` au ON (ma.au_id = au.au_id)
WHERE au.au_id IS NOT NULL
GROUP BY au.au_id , au.au_lname , au.au_fname , ma.title , ma.pub_name
ORDER BY 'AUTHOR ID' DESC) AS QUERY_FROM_TABLE

GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME` , `PUBLISHER`
ORDER BY `PUBLISHER` DESC
;

/*Challenge 3*/

CREATE TABLE qty_intermediate AS
SELECT ta.title_id, s.qty, ta.au_id
FROM sales s
RIGHT JOIN titleauthor ta ON (s.title_id = ta.title_id)
;

SELECT au.au_id AS 'AUTHOR ID', au.au_lname AS 'LAST NAME', au.au_fname AS 'FIRST NAME', CASE WHEN SUM(qty_int.qty) IS NULL THEN 0 ELSE SUM(qty_int.qty) END AS 'TOTAL'
FROM qty_intermediate qty_int
RIGHT JOIN authors au ON (qty_int.au_id = au.au_id)
GROUP BY au.au_id, au.au_lname, au.au_fname
ORDER BY `TOTAL` DESC
LIMIT 3
;

/*Challenge 4*/

CREATE TABLE qty_intermediate AS
SELECT ta.title_id, s.qty, ta.au_id
FROM sales s
RIGHT JOIN titleauthor ta ON (s.title_id = ta.title_id)
;

SELECT au.au_id AS 'AUTHOR ID', au.au_lname AS 'LAST NAME', au.au_fname AS 'FIRST NAME', CASE WHEN SUM(qty_int.qty) IS NULL THEN 0 ELSE SUM(qty_int.qty) END AS 'TOTAL'
FROM qty_intermediate qty_int
RIGHT JOIN authors au ON (qty_int.au_id = au.au_id)
GROUP BY au.au_id, au.au_lname, au.au_fname
ORDER BY `TOTAL` DESC
;