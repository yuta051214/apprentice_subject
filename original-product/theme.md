# オリジナルプロダクトテーマ
## 1. 一言サービスコンセプト（サービスのキャッチコピーを一言で）


## 2. 誰のどんな課題を解決するのか？
Who: 新型コロナワクチン接種のコールセンター
  - 基本情報
    - 営業日時: 年中無休、8:30 ~ 17:15
    - 所在地: 各都道府県と市区町村に１箇所ずつ
    - 各コールセンターの人数: (推測)15 ~ 30人ほど、ほとんどが女性(主婦)
    - 市からの業務委託として人材派遣会社が運営している
    - コロナの流行のタイミング、ワクチン接種実施のタイミングによって業務量が大きく変動する
      - 繁忙期は常に電話が鳴り止まず、1日に 3000 ~ 4000件以上対応する。
      - 対して、閑散期は1時間に 10 ~ 20件程度で、1日で100件にも達しないことも多い。
    - そのため、契約期間の満了などによる退職があり、メンバーの入れ替えが多く、その度に教育コストがかかる。

  - 対象とする業務: 初回接種にて2回目の予約をキャンセルした方の管理と、医療機関から依頼された予約の空き枠を管理する業務

  - 今回解決したい課題
    - 〜という課題がある


## 3. なぜそれを解決したいのか？
顧客管理や予約枠の管理は紙ベースであるため、多くのデメリットが存在している。
- 管理対象１件あたりの処理時間が通常の予約業務の3~4倍かかる。
  - 理由：
    - 市で用意している予約システムでは対応していないため、データを直接操作する必要がある。
    - 当該業務の担当者(1 ~ 2人、兼任)に対応が集中する。
    - 予約をした市民と、予約先の医療機関に再度電話連絡する必要がある(そのため単純に電話の回数が３倍)。
    - 複数枚ある管理用の帳票にそれぞれ記載し、各帳票を管理する各フォルダーにまとめたり移動したり等の作業が必要。
    - 業務終了後に「顧客リスト」と「接種枠リスト」を突き合わせて、抜け漏れ等がないことを数え上げる等の作業がある。
    - 業務時間終了後に市へ報告するためのメールの作成と、上長の確認作業が入り、基本的に残業必須となっている。
- ミスなどによる矛盾が生じやすく、また問題になるまで気づけない
  - 具体例：
    - 予約済みの顧客であるにも関わらず、データ上は予約済みになっていない。
    - 医療機関の都合などにより無くなった接種枠に対して、顧客の予約を入れてしまう。
- 市へ報告する際に、ファイルを取り出して１枚ずつ確認しなくてはならない
- 管理業務が複雑であるため、業務が属人化している
- 紙は汚れたり破れたりするため、情報の喪失や個人情報漏洩のリスクがある


## 4. どうやって解決するのか？
- 顧客と予約枠を管理する
- インターフェースを分かりやすくすることで、担当者以外でも業務を行えるようにする
- 市への報告用のデータを簡単に出力できるようにする(CSV形式)
- 管理ミスをさせないため、入力ミスや入力に矛盾があった時にエラー文を出すようにする
  - フロントエンド、バックエンド共に「Validation」を強化する


# 5. 機能要件
  - ログイン・ログアウト機能
  - ユーザー管理機能
  - 顧客に関するCRUD機能
  - 接種枠に関するCRUD機能
  - 顧客、接種枠の状態管理機能
  - 予約の管理機能
  - CSV出力機能


# 6. 非機能要件
  - 保守性
    - GitHub Actions を用いて Rubocop による静的解析、RSpec による自動テストを行う
  - 運用性
    - GitHub Actions を用いて AWS に自動デプロイする
  - 費用
  - セキュリティ
    - 通信：HTTPS
  - 性能
  - 可用性
    - AWS ELB(ALB) を用いて分散処理
