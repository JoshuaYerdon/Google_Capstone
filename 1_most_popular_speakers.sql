SELECT
    author,
    COUNT(title) AS num_of_speeches
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    author
HAVING
    author IS NOT NULL 
    AND COUNT(title) IS NOT NULL
ORDER BY
    num_of_speeches DESC
LIMIT 25