SELECT
    EXTRACT(MONTH FROM talk_date) AS month,
    ROUND(AVG(views), 0) AS avg_monthly_views_at
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    EXTRACT(MONTH FROM talk_date) 
ORDER BY
    avg_monthly_views_at DESC
LIMIT 25
