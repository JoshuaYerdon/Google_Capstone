## Quick Introduction
This is my capstone project for the [Google Data Analytics Professional certificate](https://www.coursera.org/professional-certificates/google-data-analytics#courses). For this project, I chose "Case Study 3," where I had the opportunity to build my own case study instead of working with one of the two pre-designed options. I mainly used Visual Studio Code for querying, PostgreSQL for database management, and Google Sheets for visualizations. <br>
[Click here for the full scenario description](https://github.com/JoshuaYerdon/Google_Capstone/blob/main/Assets/Project%20Scenario.png)

## Topic
I chose the [TED Talk](https://www.kaggle.com/datasets/ashishjangra27/ted-talks) dataset from [Kaggle](https://www.kaggle.com/) for my project . This dataset contains information about various TED Talks, including details like the speaker, duration, views, and categories of the talks. The problem I will be exploring is identifying which topics are most effective at attracting viewers, which speakers are best suited for gaining viewership, and analyzing other factors that contribute to a TED Talk's popularity. My chosen metrics will help assess the impact of different speakers and topics on viewer engagement, the following metrics have been chosen:  
- The following metrics have been chosen to talk about:

    - Total yearly viewership 
    - Total yearly speeches given
    - Individual Speakers
    - "Adjusted likes value"
    - "Adjusted views value"
   

## Other Topic Information
**_1: Who are the stakeholders?_** <br> 
**_2: Who is your audience?_** <br> 
**_3: How can your insights help your client make decisions?_** <br> 
- 1: My stakeholders are the upper levels of TED, including event planners.
- 2: My audience includes both the event planners/upper levels of TED and the viewers themselves, as I aim to provide more of what the audience wants to see.
- 3: My insights will identify the ideal speakers, topics, timing for events, and more!

## Data
The data for this project will primarily come from CSV files, they can be found [HERE](https://github.com/JoshuaYerdon/Ted-Talk-Capstone/tree/main/SVC%20Files) or in this project's repository.The data has been slightly modified into two CSV files, labeled "ted_talks_stats" and "ted_talks," as I wanted multiple tables for my database rather than just one. I have included a copy of the original if anyone would like to look at it, labeled "ted_talks_original". This dataset has a 10/10 usability score from Kaggle, which indicates it is highly credible and usable. The license for this dataset can be found [HERE](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Project Findings & Analysis
###### *All of the projects visualizations are accessable [HERE](https://github.com/JoshuaYerdon/Ted-Talk-Capstone/tree/main/Assets).*

## 1: Years With Most Speech Views
I started by wondering which years had the most views and thought it might show steady growth over time. To figure this out, I wrote a query to find the years with the highest total speech views. To do this:

- I used SUM to calculate the total views for all speeches, naming the result "total_yearly_views".
- Extracted the year from the "talk_date" field.
- Grouped the data by year and sorted it in descending order to display the years with the most views first.

```SQL
SELECT
    ROUND(SUM(views), 0) AS total_yearly_views,
    EXTRACT(YEAR FROM talk_date) AS year
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    year
ORDER BY
    total_yearly_views DESC
LIMIT 25
```

Below is a chart displaying the results of this query. As you can see, years like 2015, 2013, and 2017 stand out as having the most views for their speeches. At first glance, we might ask ourselves: _What did these years do differently to achieve more success?_ A logical explanation could be that they simply had more speeches. Let’s investigate this further.

![Most Viewed Speeches by Year](/Assets/Most%20Viewed%20Speeches.png) <br>
**Visualization of Most Viewed Speeches by Year** - **_[Click here to access the chart](/Assets/Most%20Viewed%20Speeches.png)_**

## 2: Most Speeches Given per Year
Following the results of the previous section, I wrote the following query to show me how many speeches were given per year. To achieve this:
- I used **COUNT** to count the number of speeches giveen for all years, naming the result **"num_of_yearly_speeches"**.
- Extracted the year from the **"talk_date"** field.
- Grouped the data by year and sorted it in descending order to display the years with the most total speches given.

```SQL
SELECT
    ROUND(COUNT(title), 0) AS num_of_yearly_speeches,
    EXTRACT(YEAR FROM talk_date) AS year
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
GROUP BY
    year
ORDER BY
    num_of_yearly_speeches DESC
LIMIT 25
```

The results were quite different from the previous chart. They showed that 2019 had the most speeches given, while 2015, the leader in the last chart, dropped to 8th place. This raised another question: why did 2019 have fewer views than 2015, even with dozens more speeches?

![Most Speeches Given by Year](/Assets/Most%20Speeches%20Given.png) <br>
**Visualization of Most Speeches Given by Year** - **_[Click here to access the chart](/Assets/Most%20Speeches%20Given.png)_**


## 3: Most Listened to Speakers
So far we have been analyzing the yearly data of speeches, but now we will talk about individual speakers. The following query will give the authors with the most total speeches given at Ted Talk.

```SQL
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
```

The data suggests that audiences may be drawn to speeches based on their favorite speakers. To identify the ideal speakers and topics with a greater certainty, we need a method that reveals how much people enjoy a particular speech or speaker.

![Most Author Speeches](/Assets/Most%20Author%20Speeches%20Given.png) <br>
**Visualization of Most Author Speeches** - **_[Click here to access the chart](/Assets/Most%20Author%20Speeches%20Given.png)_**

## 4: Adjusted Likes and Views Value
What is an "Adjust Likes Value" you may ask? This is a method I developed to fairly evaluate speeches, rather than just looking at views or likes by themselves. 

```SQL
SELECT
    author,
    title,
    (views / likes) AS adjusted_like_value
FROM
    ted_talks
LEFT JOIN ted_talks_stats ON ted_talks.link = ted_talks_stats.link
ORDER BY
    adjusted_like_value DESC
LIMIT 5;
```

This query calculates the ratio of views to likes for each speech, producing a score ranging from 30 to 36. A score of 30 represents the lowest possible rating, indicating that the audience was not particularly engaged. On the other hand, a score of 36 is the highest possible, representing a near perfect audience approval. Based on this query, we can identify the top rated speeches: <br>


| Author            | Title                                               | Adjusted Like Value |
|-------------------|-----------------------------------------------------|---------------------|
| Ming Luke         | What's the point(e) of ballet?                      | 36                  |
| David Lindell     | A camera that can see around corners                | 36                  |
| Elizabeth Cox     | Can you outsmart the fallacy that divided a nation? | 36                  |
| Iseult Gillespie  | How to see more and care less: The art of Georgia O'Keeffe | 36          |
| Debbie Millman    | The function and fashion of eyeglasses              | 36                  |

Additionally, there is an **"Adjusted Views Value"** query I have written. This query calculates the total views of a given year and divides it by the number of speakers, providing an average value that reflects how valuable each speaker's speech is in that year. With this, we can identify the years with the most valuable speeches on average. <br>
_**[View The Query File Here](/5_adjusted_views_value.sql)**_

| Year | Adjusted Views Value |
|------|----------------------|
| 2006 | 3,696,122            |
| 2004 | 3,405,393            |
| 2015 | 3,062,971            |
| 2013 | 2,738,498            |
| 2012 | 2,659,556            |

## 5: Applying Our Findings
Now that we know the most optimal speeches, we can use this to determine which speakers should or should not return. I’ve written a query that compares a speaker’s average views to the all-time average. If their views exceed the all-time average, they may return; if not, they should be reconsidered:

```SQL
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
```

Additionally I have made a query that bases the decision off of their Adjusted Likes Value too:

```SQL
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
```

## 6: Conclusion
This project examined key factors behind the success of TED Talks by analyzing metrics like total views, adjusted likes, adjusted views, and the number of speeches given by authors. Key takeaways include:

- Higher viewership years don't always correlate with more speeches, indicating that timing and frequency are crucial for engagement.
- Repeat speakers can significantly influence audience viewership.
- Adjusted Like and Views Value provides a clearer understanding of audience engagement, highlighting what resonates with viewers.
- Using these insights, I developed a system to assess which speakers should return, helping TED optimize speaker selection and topic planning for future events.
