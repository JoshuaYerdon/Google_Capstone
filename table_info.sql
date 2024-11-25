--Talk about changing the data of Date from December format >
-- 12.1.20 format
DROP TABLE ted_talks_stats

CREATE TABLE ted_talks(
    talk_id
    title VARCHAR(100),
    author VARCHAR(100),
    talk_date DATE,
    link VARCHAR(255)
 );

 CREATE TABLE ted_talks_stats(
    talk_id
    views INTEGER,
    likes INTEGER
 );

COPY ted_talks (title, author, talk_date, link)
FROM 'C:\Users\Josh\Desktop\Ted Talk Capstone\ted_talks.csv'
    DELIMITER ',' 
    CSV HEADER;

COPY ted_talks_stats ( views, likes)
FROM 'C:\Users\Josh\Desktop\Ted Talk Capstone\ted_talks_stats.csv'
    DELIMITER ',' 
    CSV HEADER;