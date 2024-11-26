
SELECT
    title,
    ROUND(AVG(views), 0) AS total_avg_views,
    CASE
        WHEN ROUND(AVG(views), 0) > (SELECT AVG(views) FROM ted_talks_stats) 
        THEN 'Bring Back'
        ELSE 'Dont Bring Back'
    END AS topic_value
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    title
ORDER BY
    RANDOM()
LIMIT
    25;

