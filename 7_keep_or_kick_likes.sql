SELECT
    author,
    title,
    (views / likes) AS adjusted_like_value,
    CASE
        WHEN (views / likes) >= 34
        THEN 'Bring Back'
        ELSE 'Dont Bring Back'
    END AS true_value
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
ORDER BY
    random()
LIMIT 10000;
