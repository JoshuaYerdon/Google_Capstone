SELECT
    EXTRACT(YEAR FROM talk_date) AS year,
    ROUND(COUNT(title), 0) AS num_of_yearly_speeches
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    year
ORDER BY
    num_of_yearly_speeches DESC
LIMIT 25
