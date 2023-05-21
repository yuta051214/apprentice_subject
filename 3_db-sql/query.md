1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください。
- エピソード視聴数が最も多いトップ3のエピソードの「タイトル」「視聴数」を取得します。

```sql
SELECT 
    Episodes.title AS episode_title, 
    Schedules.view AS view_count 
FROM 
    Episodes 
JOIN 
    Schedules ON Episodes.id = Schedules.episode_id 
ORDER BY 
    Schedules.view DESC 
LIMIT 3;
```


- ただし、このクエリは各エピソードが1回だけスケジュールされると仮定しています。
もし同じエピソードが複数回スケジュールされ、それぞれの視聴数を合算する必要がある場合は、以下のようなクエリになります。
こちらのクエリでは、`GROUP BY`句を使用してエピソードごとに視聴数を合算し、その合計値で並べ替えています。


```sql
SELECT 
    Episodes.title AS episode_title, 
    SUM(Schedules.view) AS total_view_count 
FROM 
    Episodes 
JOIN 
    Schedules ON Episodes.id = Schedules.episode_id 
GROUP BY 
    Episodes.id 
ORDER BY 
    total_view_count DESC 
LIMIT 3;
```



2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください。

```sql
SELECT 
    Programs.title AS program_title, 
    Seasons.title AS season_title,
    COUNT(E2.id) OVER(PARTITION BY Seasons.id) AS episode_count,
    Episodes.title AS episode_title, 
    SUM(Schedules.view) AS total_view_count 
FROM 
    Programs
JOIN
    Seasons ON Programs.id = Seasons.program_id
JOIN
    Episodes ON Seasons.id = Episodes.season_id
JOIN
    Schedules ON Episodes.id = Schedules.episode_id
LEFT JOIN
    Episodes E2 ON Seasons.id = E2.season_id
GROUP BY 
    Programs.id, Seasons.id, Episodes.id, E2.id 
ORDER BY 
    total_view_count DESC 
LIMIT 3;

```








3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします。
- **特定の日** に放送される全ての番組のチャンネル名、放送開始時刻、放送終了時刻、シーズンID、エピソード番号、エピソードタイトル、エピソード詳細を取得するものです。
  'yyyy-mm-dd'に年月日を入力する。

```sql
SELECT 
    Channels.name AS channel_name,
    Schedules.start AS broadcast_start,
    Schedules.end AS broadcast_end,
    Seasons.id AS season_id,
    Episodes.number AS episode_number,
    Episodes.title AS episode_title,
    Episodes.description AS episode_description
FROM 
    Schedules
JOIN 
    Channels ON Schedules.channel_id = Channels.id
JOIN 
    Episodes ON Schedules.episode_id = Episodes.id
JOIN 
    Seasons ON Episodes.season_id = Seasons.id
WHERE 
    DATE(Schedules.start) = 'yyyy-mm-dd'
ORDER BY 
    Channels.name, 
    Schedules.start;
```


- **今日** 放送される全ての番組のチャンネル名、放送開始時刻、放送終了時刻、シーズンID、エピソード番号、エピソードタイトル、エピソード詳細を取得するものです。

```sql
SELECT 
    Channels.name AS channel_name,
    Schedules.start AS broadcast_start,
    Schedules.end AS broadcast_end,
    Seasons.id AS season_id,
    Episodes.number AS episode_number,
    Episodes.title AS episode_title,
    Episodes.description AS episode_description
FROM 
    Schedules
JOIN 
    Channels ON Schedules.channel_id = Channels.id
JOIN 
    Episodes ON Schedules.episode_id = Episodes.id
JOIN 
    Seasons ON Episodes.season_id = Seasons.id
WHERE 
    DATE(Schedules.start) = CURDATE()
ORDER BY 
    Channels.name, 
    Schedules.start;

```




4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください。

特定のチャンネルで特定の日から1週間分の番組表を表示します。
チャンネル名、放送開始時刻、放送終了時刻、シーズンID、エピソード番号、エピソードタイトル、エピソードの詳細を取得します。
特定のチャンネル名を 'Channel Name' とし、特定の日を 'yyyy-mm-dd' 形式で入力することを想定しています。

```sql
SELECT 
    c.name AS channel_name,
    s.start AS broadcast_start,
    s.end AS broadcast_end,
    se.id AS season_id,
    e.number AS episode_number,
    e.title AS episode_title,
    e.description AS episode_description
FROM 
    Schedules s
JOIN 
    Channels c ON s.channel_id = c.id
JOIN 
    Episodes e ON s.episode_id = e.id
JOIN 
    Seasons se ON e.season_id = se.id
WHERE 
    c.name = 'Channel Name'
    AND DATE(s.start) >= 'yyyy-mm-dd'
    AND DATE(s.start) < DATE_ADD('yyyy-mm-dd', INTERVAL 1 WEEK)
ORDER BY 
    s.start;
```
