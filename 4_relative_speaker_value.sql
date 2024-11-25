SELECT
    EXTRACT(YEAR FROM talk_date) AS year,
    SUM(views) / COUNT(title) AS relative_value
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    year
ORDER BY
    relative_value DESC
LIMIT 25;
