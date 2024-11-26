SELECT
    EXTRACT(YEAR FROM talk_date) AS year,
    ROUND(SUM(views), 0) AS total_yearly_views
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    year
ORDER BY
    total_yearly_views DESC
LIMIT 25
