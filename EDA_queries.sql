CREATE TABLE top_100
AS
WITH cte AS (
SELECT *
FROM staging
ORDER BY streams DESC
), cte2 AS (
SELECT 
	*,
	ROW_NUMBER() OVER() AS Ranking
FROM cte
) SELECT *
FROM cte2
WHERE Ranking <= 100
;

WITH cte AS (
SELECT *
FROM staging
ORDER BY streams DESC
), cte2 AS (
SELECT 
	*,
	ROW_NUMBER() OVER() AS Ranking
FROM cte
) SELECT *
FROM cte2
WHERE Ranking <= 100
;

-- Finding artists with more then 1 song in the top 100

SELECT 
	artist_name,
    COUNT(artist_name) AS top_songs
FROM top_100
GROUP BY artist_name
HAVING top_songs > 1
ORDER BY top_songs DESC
;

-- ATTRIBUTES ANALYSIS

-- Danceability based on release_year

SELECT released_year, AVG(danceability)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
ORDER BY released_year DESC
;

-- Valence based on release_year

SELECT released_year, AVG(valence)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
ORDER BY released_year DESC
;

-- Energy based on release_year

SELECT released_year, AVG(energy)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
ORDER BY released_year DESC
;

-- Acousticness based on release_year

SELECT released_year, AVG(acousticness)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
ORDER BY released_year DESC
;

-- Instrumentalness based on release_year

SELECT released_year, AVG(instrumentalness)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
ORDER BY released_year DESC
;

-- liveness based on release_year

SELECT released_year, AVG(liveness)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
ORDER BY released_year DESC
;

-- Speechiness based on release_year

SELECT released_year, AVG(speechiness)
FROM top_100
WHERE released_year > 2013
GROUP BY released_year, `speechiness`
ORDER BY released_year DESC
;

-- TOP ATTRIBUTE FOR EACH YEAR
-- Creating a table of Average Values of all attributes per year
CREATE TABLE attributes
AS
SELECT released_year, AVG(danceability) AS `value`, 'danceability' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
UNION
SELECT released_year, AVG(valence) AS `value`, 'valence' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
UNION
SELECT released_year, AVG(energy) AS `value`, 'energy' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
UNION
SELECT released_year, AVG(acousticness) AS `value`, 'acousticness' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
UNION
SELECT released_year, AVG(instrumentalness) AS `value`, 'instrumentalness' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
UNION
SELECT released_year, AVG(liveness) AS `value`, 'liveness' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
UNION
SELECT released_year, AVG(speechiness) AS `value`, 'speechiness' AS attribute
FROM top_100
WHERE released_year > 2013
GROUP BY released_year
;
-- Getting the dominant attribute of most popular songs per year

WITH cte AS (
SELECT *, ROW_NUMBER() OVER(PARTITION BY released_year ORDER BY `value` DESC) AS ranking
FROM attributes
) SELECT released_year, attribute AS dominant_attribute
FROM cte
WHERE ranking = 1
;

-- What was the most popular BPM?

WITH cte AS (
SELECT bpm, COUNT(bpm), ROW_NUMBER() OVER(ORDER BY COUNT(bpm) DESC) AS ranking
FROM top_100
GROUP BY bpm
ORDER BY COUNT(bpm) DESC
) SELECT *
FROM cte
WHERE ranking = 1
;

-- What was the most popular mode?

WITH cte AS (
SELECT `mode`, COUNT(`mode`), ROW_NUMBER() OVER(ORDER BY COUNT(`mode`) DESC) AS ranking
FROM top_100
GROUP BY `mode`
ORDER BY COUNT(`mode`) DESC
) SELECT *
FROM cte
WHERE ranking = 1
;

-- What was the most popular key?

WITH cte AS (
SELECT `key`, COUNT(`key`), ROW_NUMBER() OVER(ORDER BY COUNT(`key`) DESC) AS ranking
FROM top_100
GROUP BY `key`
ORDER BY COUNT(`key`) DESC
) SELECT *
FROM cte
WHERE ranking = 1
;