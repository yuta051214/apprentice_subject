# データベースの構築
[テーブル定義](https://github.com/yuta051214/apprentice_subject/blob/main/3_db-sql/design.md)に従ってSQLを作成し、データベースを作成します。

```sql
CREATE DATABASE (db_name);
```

次に、このデータベースを使用するように指定します。

```sql
USE (db_name);
```

その後、各テーブルを作成します。
ただし、他のテーブルに存在するidを参照する外部キー制約がある場合、その参照先のテーブルを先に作成する必要があります。
参照先のテーブルが存在しない場合、テーブルの作成がエラーとなります。






# テーブルの構築
テーブルの作成順
1. 外部キーを持たないテーブル（Genres, Programs, Channels）
2. 上記1のテーブルに紐づくテーブル（Genres_Programs, Seasons）
3. 上記２のテーブルに紐づくテーブル（Episodes）
4. 上記３のテーブルとChannelsに紐づくテーブル（Schedules）



```
CREATE TABLE Programs (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    PRIMARY KEY (id),
    UNIQUE (title)
);



CREATE TABLE Channels (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);



CREATE TABLE Genres (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);



CREATE TABLE Genres_Programs (
    genre_id INT NOT NULL,
    program_id INT NOT NULL,
    PRIMARY KEY (genre_id, program_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(id),
    FOREIGN KEY (program_id) REFERENCES Programs(id)
);



CREATE TABLE Seasons (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    program_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (program_id) REFERENCES Programs(id)
);



CREATE TABLE Episodes (
    id INT NOT NULL AUTO_INCREMENT,
    number INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    length INT NOT NULL,
    release_date DATETIME NOT NULL,
    season_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (season_id) REFERENCES Seasons(id)
);



CREATE TABLE Schedules (
    id INT NOT NULL AUTO_INCREMENT,
    start DATETIME NOT NULL,
    end DATETIME NOT NULL,
    view INT,
    channel_id INT NOT NULL,
    episode_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (channel_id) REFERENCES Channels(id),
    FOREIGN KEY (episode_id) REFERENCES Episodes(id)
);
```





# サンプルデータの投入
以下のSQLを実行することで、サンプルデータを挿入することができます。
こちらも投入する際には順番に注意が必要です。

```
 <!-- ジャンルデ-タの挿入 -->
INSERT INTO Genres(name)
VALUES ('drama'), ('comedy'), ('mystery');

 <!-- 番組デ-タの挿入 -->
INSERT INTO Programs(title, description)
VALUES ('program1', 'This is the detail of program1'),
       ('program2', 'This is the detail of program2'),
       ('program3', 'This is the detail of program3');

 <!-- ジャンルと番組の中間テ-ブルにデ-タを挿入 -->
INSERT INTO Genres_Programs(genre_id, program_id)
VALUES (1, 1), (2, 2), (3, 3);

 <!-- channelデ-タの挿入 -->
INSERT INTO Channels(name)
VALUES ('channel1'), ('channel2'), ('channel3');

 <!-- seasonデ-タの挿入 -->
INSERT INTO Seasons(title, program_id)
VALUES ('program1 - season1', 1),
       ('program2 - season1', 2), ('program2 - season2', 2),
       ('program3 - season1', 3), ('program3 - season2', 3), ('program3 - season3', 3);

 <!-- episodeデ-タの挿入 -->
INSERT INTO Episodes(number, title, description, length, release_date, season_id)
VALUES 
    (1, 'episode1', 'This is program1 - season1 - the detail of episode1', 60, '2023-01-01 00:00:00', 1),
    (2, 'episode2', 'This is program1 - season1 - the detail of episode2', 60, '2023-01-02 00:00:00', 1),
    (3, 'episode3', 'This is program1 - season1 - the detail of episode3', 60, '2023-01-03 00:00:00', 1),
    (4, 'episode4', 'This is program1 - season1 - the detail of episode4', 60, '2023-01-04 00:00:00', 1),
    (5, 'episode5', 'This is program1 - season1 - the detail of episode5', 60, '2023-01-05 00:00:00', 1),
    (1, 'episode1', 'This is program2 - season1 - the detail of episode1', 60, '2023-01-01 00:00:00', 2),
    (2, 'episode2', 'This is program2 - season1 - the detail of episode2', 60, '2023-01-02 00:00:00', 2),
    (3, 'episode3', 'This is program2 - season1 - the detail of episode3', 60, '2023-01-03 00:00:00', 2),
    (4, 'episode4', 'This is program2 - season1 - the detail of episode4', 60, '2023-01-04 00:00:00', 2),
    (5, 'episode5', 'This is program2 - season1 - the detail of episode5', 60, '2023-01-05 00:00:00', 2),
    (1, 'episode1', 'This is program2 - season2 - the detail of episode1', 60, '2023-01-01 00:00:00', 3),
    (2, 'episode2', 'This is program2 - season2 - the detail of episode2', 60, '2023-01-02 00:00:00', 3),
    (3, 'episode3', 'This is program2 - season2 - the detail of episode3', 60, '2023-01-03 00:00:00', 3),
    (4, 'episode4', 'This is program2 - season2 - the detail of episode4', 60, '2023-01-04 00:00:00', 3),
    (5, 'episode5', 'This is program2 - season2 - the detail of episode5', 60, '2023-01-05 00:00:00', 3),
    (1, 'episode1', 'This is program3 - season1 - the detail of episode1', 60, '2023-01-01 00:00:00', 4),
    (2, 'episode2', 'This is program3 - season1 - the detail of episode2', 60, '2023-01-02 00:00:00', 4),
    (3, 'episode3', 'This is program3 - season1 - the detail of episode3', 60, '2023-01-03 00:00:00', 4),
    (4, 'episode4', 'This is program3 - season1 - the detail of episode4', 60, '2023-01-04 00:00:00', 4),
    (5, 'episode5', 'This is program3 - season1 - the detail of episode5', 60, '2023-01-05 00:00:00', 4),
    (1, 'episode1', 'This is program3 - season2 - the detail of episode1', 60, '2023-01-01 00:00:00', 5),
    (2, 'episode2', 'This is program3 - season2 - the detail of episode2', 60, '2023-01-02 00:00:00', 5),
    (3, 'episode3', 'This is program3 - season2 - the detail of episode3', 60, '2023-01-03 00:00:00', 5),
    (4, 'episode4', 'This is program3 - season2 - the detail of episode4', 60, '2023-01-04 00:00:00', 5),
    (5, 'episode5', 'This is program3 - season2 - the detail of episode5', 60, '2023-01-05 00:00:00', 5),
    (1, 'episode1', 'This is program3 - season3 - the detail of episode1', 60, '2023-01-01 00:00:00', 6),
    (2, 'episode2', 'This is program3 - season3 - the detail of episode2', 60, '2023-01-02 00:00:00', 6),
    (3, 'episode3', 'This is program3 - season3 - the detail of episode3', 60, '2023-01-03 00:00:00', 6),
    (4, 'episode4', 'This is program3 - season3 - the detail of episode4', 60, '2023-01-04 00:00:00', 6),
    (5, 'episode5', 'This is program3 - season3 - the detail of episode5', 60, '2023-01-05 00:00:00', 6);



 <!-- 番組表デ-タの挿入 -->
INSERT INTO Schedules(start, end, view, channel_id, episode_id)
VALUES 
    ('2023-01-01 00:00:00', '2023-01-01 01:00:00', 500000, 1, 1),
    ('2023-01-02 00:00:00', '2023-01-02 01:00:00', 450000, 1, 2),
    ('2023-01-03 00:00:00', '2023-01-03 01:00:00', 400000, 1, 3),
    ('2023-01-04 00:00:00', '2023-01-04 01:00:00', 350000, 1, 4),
    ('2023-01-05 00:00:00', '2023-01-05 01:00:00', 300000, 1, 5),
    ('2023-01-01 00:00:00', '2023-01-01 01:00:00', 600000, 2, 6),
    ('2023-01-02 00:00:00', '2023-01-02 01:00:00', 550000, 2, 7),
    ('2023-01-03 00:00:00', '2023-01-03 01:00:00', 500000, 2, 8),
    ('2023-01-04 00:00:00', '2023-01-04 01:00:00', 450000, 2, 9),
    ('2023-01-05 00:00:00', '2023-01-05 01:00:00', 400000, 2, 10),
    ('2023-01-01 00:00:00', '2023-01-01 01:00:00', 700000, 2, 11),
    ('2023-01-02 00:00:00', '2023-01-02 01:00:00', 650000, 2, 12),
    ('2023-01-03 00:00:00', '2023-01-03 01:00:00', 600000, 2, 13),
    ('2023-01-04 00:00:00', '2023-01-04 01:00:00', 550000, 2, 14),
    ('2023-01-05 00:00:00', '2023-01-05 01:00:00', 500000, 2, 15),
    ('2023-01-01 00:00:00', '2023-01-01 01:00:00', 800000, 3, 16),
    ('2023-01-02 00:00:00', '2023-01-02 01:00:00', 750000, 3, 17),
    ('2023-01-03 00:00:00', '2023-01-03 01:00:00', 600000, 3, 18),
    ('2023-01-04 00:00:00', '2023-01-04 01:00:00', 550000, 3, 19),
    ('2023-01-05 00:00:00', '2023-01-05 01:00:00', 500000, 3, 20),
    ('2023-01-01 00:00:00', '2023-01-01 01:00:00', 900000, 3, 21),
    ('2023-01-02 00:00:00', '2023-01-02 01:00:00', 850000, 3, 22),
    ('2023-01-03 00:00:00', '2023-01-03 01:00:00', 800000, 3, 23),
    ('2023-01-04 00:00:00', '2023-01-04 01:00:00', 750000, 3, 24),
    ('2023-01-05 00:00:00', '2023-01-05 01:00:00', 700000, 3, 25),
    ('2023-01-01 00:00:00', '2023-01-01 01:00:00', 1000000, 3, 26),
    ('2023-01-02 00:00:00', '2023-01-02 01:00:00', 950000, 3, 27),
    ('2023-01-03 00:00:00', '2023-01-03 01:00:00', 900000, 3, 28),
    ('2023-01-04 00:00:00', '2023-01-04 01:00:00', 850000, 3, 29),
    ('2023-01-05 00:00:00', '2023-01-05 01:00:00', 800000, 3, 30);


<!-- 追加分 -->
INSERT INTO Schedules(start, end, view, channel_id, episode_id)
VALUES 
    ('2023-02-01 00:00:00', '2023-02-01 01:00:00', 500000, 3, 26),
    ('2023-02-02 00:00:00', '2023-02-02 01:00:00', 450000, 3, 27),
    ('2023-02-03 00:00:00', '2023-02-03 01:00:00', 400000, 3, 28);

```



データベースに挿入されたデータを確認する。

```sql
SELECT * FROM (table_name);
```
