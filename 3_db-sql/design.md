- Genres (ジャンル)

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | UNIQUENESS |
|---------|---------|------|------|-------|----------------|------------|
| id      | INT     | -    | PK   | NULL  | -              | YES        |
| name    |VARCHAR(255)| - | PK   | NULL  | -              | YES        |



- Genres_Programs

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | UNIQUENESS |
|---------|---------|------|------|-------|----------------|------------|
|genre_id	|Integer|	-|	FK	|NULL|	-|	-|
|program_id	|Integer	|-	|FK	|NULL	|-|	-|



- Programs (番組)

| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | UNIQUENESS |
|---------|---------|------|------|-------|----------------|------------|
|id	|INT|	-|	PK	|NULL	|YES|	YES|
|title	|VARCHAR(255)|	-	|-|	NULL|	-|	YES|
|description	|TEXT|	YES|	-|	NULL	|-|	-|



- Season (シーズン)

| カラム名   | データ型      | NULL | キー | 初期値 | AUTO INCRIMENT | UNIQUENESS |
|------------|--------------|------|------|-------|----------------|------------|
| Id         | INT          | -    | PK   | NULL  | YES            | YES        |
| title      | VARCHAR(255) | YES  | -    | NULL  | -              | -          |
| program_id | INT          | NO   | FK   | NULL  | -              | -          |



- Episodes (エピソード)

| カラム名       | データ型      | NULL | キー | 初期値 | AUTO INCRIMENT | UNIQUENESS |
|----------------|--------------|------|------|-------|----------------|------------|
| Id             | INT          | -    | PK   | NULL  | YES            | YES        |
| number         | INT          | -    | -    | NULL  | -              | -          |
| title          | VARCHAR(255) | -    | -    | NULL  | -              | -          |
| description    | TEXT         | YES  | -    | NULL  | -              | -          |
| length         | INT          | -    | -    | NULL  | -              | -          |
| release_date   | DATETIME     | -    | -    | NULL  | -              | -          |
| season_id      | INT          | -    | FK   | NULL  | -              | -          |



- Channels (チャンネル)

| カラム名 | データ型      | NULL | キー | 初期値 | AUTO INCRIMENT | UNIQUENESS |
|---------|--------------|------|------|-------|----------------|------------|
| Id      | INT          | -    | PK   | NULL  | YES            | YES        |
| name    | VARCHAR(255) | -    | -    | NULL  | -              | YES        |



- Schedules (番組表)

| カラム名    | データ型   | NULL | キー | 初期値 | AUTO INCRIMENT | UNIQUENESS |
|-------------|-----------|------|------|-------|----------------|------------|
| Id          | INT       | -    | PK   | NULL  | YES            | YES        |
| start       | DATETIME  | -    | -    | NULL  | -              | -          |
| end         | DATETIME  | -    | -    | NULL  | -              | -          |
| view        | INT       | YES  | -    | NULL  | -              | -          |
| channel_id  | INT       | -    | FK   | NULL  | -              | -          |
| episode_id  | INT       | -    | FK   | NULL  | -              | -          |
