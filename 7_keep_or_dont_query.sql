SELECT
    author,
    COUNT(talk_date) AS num_of_speeches,
    ROUND(AVG(views), 0) AS avg_authors_views,
    CASE
        WHEN ROUND(AVG(views), 0) > (SELECT ROUND(AVG(views), 0) FROM ted_talks_stats) 
        THEN 'Bring Back'
        ELSE 'Dont Bring Back'
    END AS speaker_value
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    author
HAVING
    author IS NOT NULL
ORDER BY
    num_of_speeches DESC
LIMIT 25;
