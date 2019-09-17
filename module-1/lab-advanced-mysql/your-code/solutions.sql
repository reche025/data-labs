-- Challenge 1

CREATE TEMPORARY TABLE royalty_calculation AS
SELECT ta.title_id AS 'TITLE ID', ta.au_id AS 'AUTHOR ID', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'ROYALTY', t.advance AS 'ADVANCE'
FROM titleauthor ta
LEFT JOIN sales s ON (ta.title_id = s.title_id)
LEFT JOIN titles t ON (ta.title_id = t.title_id)
;

CREATE TEMPORARY TABLE royalty_aggregation AS
SELECT `TITLE ID`, `AUTHOR ID`, `ADVANCE`,ROUND(SUM(`ROYALTY`),2) AS 'ROYLATY' 
FROM royalty_calculation rc
GROUP BY `TITLE ID`, `AUTHOR ID`, `ADVANCE`
;

SELECT `AUTHOR ID`, ROUND(`ADVANCE` + `ROYLATY`, 2) AS 'PROFITS'
FROM royalty_aggregation
ORDER BY CAST(`PROFITS` AS SIGNED) DESC
LIMIT 3
;

--Challenge 2

SELECT `AUTHOR ID`, ROUND(`ADVANCE` + `ROYLATY`, 2) AS 'PROFITS'
FROM(
	SELECT `TITLE ID`, `AUTHOR ID`, `ADVANCE`,ROUND(SUM(`ROYALTY`),2) AS 'ROYLATY' 
	FROM (
		SELECT ta.title_id AS 'TITLE ID', ta.au_id AS 'AUTHOR ID', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'ROYALTY', t.advance AS 'ADVANCE'
		FROM titleauthor ta
		LEFT JOIN sales s ON (ta.title_id = s.title_id)
		LEFT JOIN titles t ON (ta.title_id = t.title_id)
	) AS royalty_calculation
	GROUP BY `TITLE ID`, `AUTHOR ID`, `ADVANCE`
) AS royalty_aggregation
ORDER BY CAST(`PROFITS` AS SIGNED) DESC
LIMIT 3
;

-- Challenge 3

CREATE TEMPORARY TABLE royalty_calculation AS
SELECT ta.title_id AS 'TITLE ID', ta.au_id AS 'AUTHOR ID', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'ROYALTY', t.advance AS 'ADVANCE'
FROM titleauthor ta
LEFT JOIN sales s ON (ta.title_id = s.title_id)
LEFT JOIN titles t ON (ta.title_id = t.title_id)
;

CREATE TEMPORARY TABLE royalty_aggregation AS
SELECT `TITLE ID`, `AUTHOR ID`, `ADVANCE`,ROUND(SUM(`ROYALTY`),2) AS 'ROYLATY' 
FROM royalty_calculation rc
GROUP BY `TITLE ID`, `AUTHOR ID`, `ADVANCE`
;

CREATE TABLE most_profiting_authors AS
SELECT `AUTHOR ID`, ROUND(`ADVANCE` + `ROYLATY`, 2) AS 'PROFITS'
FROM royalty_aggregation
ORDER BY CAST(`PROFITS` AS SIGNED) DESC
LIMIT 3
;
