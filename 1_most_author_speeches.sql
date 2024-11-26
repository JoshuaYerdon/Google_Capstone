SELECT
    COUNT(title) AS total_author_speeches,
    author
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    author
ORDER BY
    total_author_speeches DESC
