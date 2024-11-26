SELECT
    author,
    (views / likes) AS adjusted_like_value
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
ORDER BY
    adjusted_like_value DESC
LIMIT 10000;
