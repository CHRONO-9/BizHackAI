# BizHack AI アフィリエイト・広告タグ管理台帳 (AFFILIATE_TAGS.md)

本ドキュメントは、「BizHack AI」に掲載中およびストックされている各種ASP（A8.net等）の公式広告タグ・アフィリエイトリンクコードの一覧台帳です。
ステマ規制（景表法）に準拠した表示ルール、広告コードの改変禁止事項、各記事への推奨導線を記録・管理しています。

---

## 📌 運用ガイドライン・法務遵守事項（committee-legal 監修）

1. **ステマ規制対応（景表法）**:
   - 広告を掲載する箇所には必ず「PR」「広告」「スポンサーリンク」のいずれかを明確に表記すること。
   - 広告主（提携先企業名）およびサービス名を明記すること。
2. **タグ改変の禁止**:
   - ASP（A8.net等）の規約に基づき、リンクURL、計測用1px画像（`<img>` / `<amp-pixel>`）、認証コードの改変・削除は行わないこと。
   - レスポンシブ対応のためのCSSラッパーによるスタイル指定（`max-width: 100%`、外枠デザイン等）は許容。
3. **リンク属性**:
   - すべてのアフィリエイトリンクには `rel="nofollow"`（および外部リンク用 `target="_blank"`）を付与すること。

---

## 🏢 案件1：0円創業くん（株式会社リアンコネクション）

- **ジャンル**: 起業・会社設立・法人化・資金調達（補助金/助成金/融資）
- **対象読者**: 一人起業家、フリーランス、副業から独立・法人化を目指すビジネスパーソン
- **主な掲載推奨先**:
  - `article-7.html`（【一人起業・副業】Notion×AIで仕事・予定・メモを一括管理する超シンプル仕事術）
  - サイドバー（一人起業・独立支援枠）
  - メールマガジン / ニュースレター

### 1. レクタングルバナー（記事中・末尾推奨）

#### ① 300 × 250（標準レクタングル A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKTKM9" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www28.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070010000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKTKM9" alt="">
```

#### ② 300 × 250（標準レクタングル B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKXFI9" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www20.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070028000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKXFI9" alt="">
```

#### ③ 336 × 280（ラージレクタングル - 高CTR）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKU7RL" rel="nofollow">
<img border="0" width="336" height="280" alt="" src="https://www22.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070013000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKU7RL" alt="">
```

#### ④ 250 × 250（スクエア - サイドバー推奨）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKUN75" rel="nofollow">
<img border="0" width="250" height="250" alt="" src="https://www29.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070015000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKUN75" alt="">
```

---

### 2. 横長バナー（ヘッダー下・記事中・フッター上部推奨）

#### ① 728 × 90（リーダーボード - PC横長）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKUFHD" rel="nofollow">
<img border="0" width="728" height="90" alt="" src="https://www20.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070014000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www10.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKUFHD" alt="">
```

#### ② 468 × 60（フルバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKU01T" rel="nofollow">
<img border="0" width="468" height="60" alt="" src="https://www25.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070012000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKU01T" alt="">
```

#### ③ 320 × 50（モバイルバナー - スマホ表示最適）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKTSC1" rel="nofollow">
<img border="0" width="320" height="50" alt="" src="https://www29.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070011000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKTSC1" alt="">
```

#### ④ 234 × 60（ハーフバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKTCWH" rel="nofollow">
<img border="0" width="234" height="60" alt="" src="https://www23.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070009000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKTCWH" alt="">
```

#### ⑤ 120 × 60（ボタンサイズバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKT56P" rel="nofollow">
<img border="0" width="120" height="60" alt="" src="https://www26.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070008000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKT56P" alt="">
```

#### ⑥ 100 × 60（マイクロバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKSXGX" rel="nofollow">
<img border="0" width="100" height="60" alt="" src="https://www27.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070007000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKSXGX" alt="">
```

#### ⑦ 100 × 100（スクエア小）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKUUWX" rel="nofollow">
<img border="0" width="100" height="100" alt="" src="https://www27.a8.net/svt/bgt?aid=261014879464&wid=001&eno=01&mid=s00000017718070016000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www11.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKUUWX" alt="">
```

---

### 3. テキストリンク（インライン・リスト・CTAボタン用）

#### ① フリーランス向け訴求（article-7最適）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKSABM" rel="nofollow">フリーランスから法人化を検討しているから必見！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKSABM" alt="">
```

#### ② コスト削減・費用訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKV2MQ" rel="nofollow">法人設立費用30万円が、サービスを導入で最大0円に減額できる！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKV2MQ" alt="">
```

#### ③ 登記費用0円訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKRN6A" rel="nofollow">サービスを導入いただくだけで、設立登記の実費負担が0円！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKRN6A" alt="">
```

#### ④ 資金調達・補助金・助成金サポート訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKS2LU" rel="nofollow">融資、補助金、助成金などの資金調達をサポート！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKS2LU" alt="">
```

#### ⑤ 手続きお任せ訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKSI1E" rel="nofollow">起業時の面倒なことはプロにお任せ！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKSI1E" alt="">
```

#### ⑥ 実績訴求（信頼性重視）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKVI2A" rel="nofollow">創業実績150社以上！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKVI2A" alt="">
```

#### ⑦ ワンストップ案内訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKVACI" rel="nofollow">会社運営に必要な商品をワンストップでご案内！【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKVACI" alt="">
```

#### ⑧ シンプルブランドリンク
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKRUW2" rel="nofollow">0円創業くん【0円創業くん】</a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEGDB+7O95GY+3SPO+BKRUW2" alt="">
```

---

### 4. メールマガジン・ニュースレター用原稿

```
■□■━━━━━━━━━━━━━━━━━━━━━━━━━━━━
弊社サービスを導入いただくことで、登記費用を最大0円にできる！
起業時の面倒な手続きはプロにお任せ！
コストをかけずに会社設立したいなら『0円創業くん』

補助金・融資相談、創業後もサポートします。

まずは無料問い合わせ↓↓
https://px.a8.net/svt/ejp?a8mat=4BEGDB+7O95GY+3SPO+BKSPR7
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■□■
```

---

## 🏢 案件2：お名前.com メールアドレス・ドメイン（GMOインターネットグループ）

- **ジャンル**: ドメイン取得・専用ビジネスメールアドレス運用
- **掲載先**:
  - `article-2.html`（日常実務・ビジネスメール術）: 専用メールアドレス訴求
  - `article-6.html`（デザイン・Web作成）: 独自ドメイン取得訴求

---

## 🏢 案件3：マネーフォワード クラウド（株式会社マネーフォワード）

- **ジャンル**: クラウド会計・バックオフィス自動化・請求書管理
- **掲載先**:
  - `article-4.html`（事務職・エクセル集計時短）: 会計・明細データ自動連携訴求

---

## 🏢 案件4：TAKETIN（ノーコードSaaS / 会員制ビジネス運営自動化）

- **ジャンル**: 会員管理・決済・サブスク・コミュニティ運営のオールインワン自動化
- **対象読者**: 会員制ビジネス、オンラインサロン、定期講座、有料コミュニティ、サブスクリプションを運営する個人事業主・法人
- **掲載推奨先**:
  - `article-7.html`（個人事業・副業DX）: サブスク・会員管理の自動化ツールとして
  - `article-3.html` / `article-8.html`: 業務運営DX・ノーコード自動化として

### 1. バナー各種

#### ① 300 × 250（レクタングル）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7YDIR6+5Y2Y+5ZEMP" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www26.a8.net/svt/bgt?aid=261015882481&wid=001&eno=01&mid=s00000027745001005000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www14.a8.net/0.gif?a8mat=4BEH56+7YDIR6+5Y2Y+5ZEMP" alt="">
```

#### ② 120 × 60（ボタンバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7YDIR6+5Y2Y+5Z6WX" rel="nofollow">
<img border="0" width="120" height="60" alt="" src="https://www24.a8.net/svt/bgt?aid=261015882481&wid=001&eno=01&mid=s00000027745001004000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEH56+7YDIR6+5Y2Y+5Z6WX" alt="">
```

#### ③ 100 × 60（マイクロバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7YDIR6+5Y2Y+5YZ75" rel="nofollow">
<img border="0" width="100" height="60" alt="" src="https://www28.a8.net/svt/bgt?aid=261015882481&wid=001&eno=01&mid=s00000027745001003000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEH56+7YDIR6+5Y2Y+5YZ75" alt="">
```

---

### 2. テキストリンク

#### ① 機能・ベネフィット訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7YDIR6+5Y2Y+5YJRM" rel="nofollow">会員制ビジネスの運営を丸ごと自動化！ノーコードSaaS【TAKETIN】</a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEH56+7YDIR6+5Y2Y+5YJRM" alt="">
```

#### ② シンプルブランドリンク
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7YDIR6+5Y2Y+5YRHE" rel="nofollow">【TAKETIN】</a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEH56+7YDIR6+5Y2Y+5YRHE" alt="">
```

---

## 🏢 案件5：sXars（スカーズ / 関西コンサル転職特化エージェント）

- **ジャンル**: コンサルタント転職、ハイクラス転職、関西キャリア支援
- **対象読者**: 企画職、BizDev、マーケター、ITコンサル志望者、現職コンサルタント、キャリア・年収アップを目指すビジネスパーソン
- **掲載推奨先**:
  - `article-5.html`（企画・プレゼン）: ロジカルシンキング・スライド構成力を活かすキャリアアップとして
  - `article-9.html`（文書・PDF時短 / 規程・法務）: ビジネス文書分析力を活かしたコンサルキャリアとして

### 1. レクタングル・スクエアバナー

#### ① 300 × 250（レクタングル A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+614CX" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www20.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001013000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+614CX" alt="">
```

#### ② 300 × 250（レクタングル B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+61C2P" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www24.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001014000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www11.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+61C2P" alt="">
```

#### ③ 336 × 280（ラージレクタングル A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+61Z81" rel="nofollow">
<img border="0" width="336" height="280" alt="" src="https://www25.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001017000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+61Z81" alt="">
```

#### ④ 336 × 280（ラージレクタングル B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+626XT" rel="nofollow">
<img border="0" width="336" height="280" alt="" src="https://www26.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001018000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+626XT" alt="">
```

#### ⑤ 250 × 250（スクエア - サイドバー推奨）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+60WN5" rel="nofollow">
<img border="0" width="250" height="250" alt="" src="https://www28.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001012000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+60WN5" alt="">
```

---

### 2. 横長バナー

#### ① 728 × 90（リーダーボード）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+62MDD" rel="nofollow">
<img border="0" width="728" height="90" alt="" src="https://www21.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001020000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+62MDD" alt="">
```

#### ② 468 × 60（フルバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+62ENL" rel="nofollow">
<img border="0" width="468" height="60" alt="" src="https://www26.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001019000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+62ENL" alt="">
```

#### ③ 320 × 50（モバイルバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+61JSH" rel="nofollow">
<img border="0" width="320" height="50" alt="" src="https://www21.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001015000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www14.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+61JSH" alt="">
```

#### ④ 320 × 100（ラージモバイルバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+61RI9" rel="nofollow">
<img border="0" width="320" height="100" alt="" src="https://www24.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001016000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+61RI9" alt="">
```

#### ⑤ 120 × 60（ボタンバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+5ZEMP" rel="nofollow">
<img border="0" width="120" height="60" alt="" src="https://www22.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001005000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+5ZEMP" alt="">
```

#### ⑥ 100 × 60（マイクロバナー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+5YZ75" rel="nofollow">
<img border="0" width="100" height="60" alt="" src="https://www24.a8.net/svt/bgt?aid=261015882467&wid=001&eno=01&mid=s00000027799001003000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www11.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+5YZ75" alt="">
```

---

### 3. テキストリンク

#### ① 機能・ベネフィット訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+5YJRM" rel="nofollow">関西コンサル転職に特化！経歴を強みに変える専門エージェント【sXars】</a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+5YJRM" alt="">
```

#### ② シンプルブランドリンク
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+7Q1GAA+5YHY+5YRHE" rel="nofollow">【sXars】</a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEH56+7Q1GAA+5YHY+5YRHE" alt="">
```

---

## 🖥️ 案件6：ConoHa for Windows Server（GMOインターネットグループ株式会社）

- **ジャンル**: Windows仮想デスクトップ（VPS）、クラウドサーバー、リモートワーク、Microsoft Office環境、24時間常時稼働環境
- **対象読者**: 
  - 職場のセキュリティや社内ルールで制約があるビジネスパーソン・主任・情シス（第8弾）
  - エクセルマクロやPython・自動集計プログラムを24時間クラウドで常時稼働させたい事務・経理（第4弾）
  - MacやiPad、出先からWindows環境・Officeをセキュアに操作したい一人起業家・フリーランス（第7弾）
- **主な掲載推奨先**:
  - `article-8.html`（【職場導入・セキュリティ】会社の情報漏洩を防ぎながら安全にAIを活用する社内ルール完全策定ガイド）
  - `article-4.html`（【事務職・エクセル時短】関数もマクロも不要！ChatGPTで一瞬で終わらせる表計算テクニック）
  - `article-7.html`（【一人起業・副業】Notion×AIで仕事・予定・メモを一括管理する超シンプル仕事術）
  - サイドバー（リモートデスクトップ・クラウドPC枠）

### 1. レクタングル・スクエアバナー（記事中・サイドバー推奨）

#### ① 300 × 250（標準レクタングル A - 記事中推奨）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MH3EP" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www25.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034008000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MH3EP" alt="">
```

#### ② 300 × 250（標準レクタングル B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MHB4H" rel="nofollow">
<img border="0" width="300" height="250" alt="" src="https://www23.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034009000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MHB4H" alt="">
```

#### ③ 336 × 280（ラージレクタングル - 高CTR）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MJVPT" rel="nofollow">
<img border="0" width="336" height="280" alt="" src="https://www28.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034021000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MJVPT" alt="">
```

#### ④ 250 × 250（スクエア - サイドバー推奨）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MKIV5" rel="nofollow">
<img border="0" width="250" height="250" alt="" src="https://www26.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034024000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MKIV5" alt="">
```

#### ⑤ 300 × 600（ハーフページ / スカイスクレイパー）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MJO01" rel="nofollow">
<img border="0" width="300" height="600" alt="" src="https://www24.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034020000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MJO01" alt="">
```

---

### 2. 横長バナー（ヘッダー下・記事中・フッター上部・サイドバー推奨）

#### ① 728 × 90（リーダーボード - PC横長）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MK3FL" rel="nofollow">
<img border="0" width="728" height="90" alt="" src="https://www23.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034022000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www14.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MK3FL" alt="">
```

#### ② 468 × 60（フルバナー A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MGG9D" rel="nofollow">
<img border="0" width="468" height="60" alt="" src="https://www28.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034005000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MGG9D" alt="">
```

#### ③ 468 × 60（フルバナー B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MG8JL" rel="nofollow">
<img border="0" width="468" height="60" alt="" src="https://www29.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034004000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MG8JL" alt="">
```

#### ④ 320 × 50（モバイルバナー A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MGVOX" rel="nofollow">
<img border="0" width="320" height="50" alt="" src="https://www26.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034007000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MGVOX" alt="">
```

#### ⑤ 320 × 50（モバイルバナー B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MGNZ5" rel="nofollow">
<img border="0" width="320" height="50" alt="" src="https://www20.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034006000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MGNZ5" alt="">
```

#### ⑥ 234 × 60（ハーフバナー A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MHQK1" rel="nofollow">
<img border="0" width="234" height="60" alt="" src="https://www23.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034011000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MHQK1" alt="">
```

#### ⑦ 234 × 60（ハーフバナー B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MHIU9" rel="nofollow">
<img border="0" width="234" height="60" alt="" src="https://www27.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034010000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MHIU9" alt="">
```

#### ⑧ 120 × 60（ボタンバナー A）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MHY9T" rel="nofollow">
<img border="0" width="120" height="60" alt="" src="https://www22.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034012000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MHY9T" alt="">
```

#### ⑨ 120 × 60（ボタンバナー B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MI5ZL" rel="nofollow">
<img border="0" width="120" height="60" alt="" src="https://www20.a8.net/svt/bgt?aid=261014880124&wid=001&eno=01&mid=s00000000018034013000&mc=1"></a>
<img border="0" width="11" height="1" src="https://www11.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MI5ZL" alt="">
```

---

### 3. テキストリンク

#### ① 最新OS機能訴求（Windows Server 2025）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MJ0UQ" rel="nofollow">最新OS「Windows Server 2025」が使える！『ConoHa for Windows Server』</a>
<img border="0" width="1" height="1" src="https://www15.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MJ0UQ" alt="">
```

#### ② 自由入力リンク（文脈に合わせた自然なテキスト挿入）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MLDQA" rel="nofollow">自由入力</a>
<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MLDQA" alt="">
```

#### ③ シンプルブランドリンク
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MIT4Y" rel="nofollow">ConoHa for Windows Server</a>
<img border="0" width="1" height="1" src="https://www11.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MIT4Y" alt="">
```

#### ④ 気軽・初心者向け訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MFLEA" rel="nofollow">気軽に使える【ConoHa for Windows Server】</a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MFLEA" alt="">
```

#### ⑤ 24時間安定稼働・初期費用無料訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MFT42" rel="nofollow">24時間安定稼働の初期費用無料、【ConoHa for Windows Server】</a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEGDC+21TRSI+50+5MFT42" alt="">
```

#### ⑥ メルマガ・テキストURL
```text
https://px.a8.net/svt/ejp?a8mat=4BEGDC+21TRSI+50+5MG0TVhttps://vps.conoha.jp/windows/
```

---

## 🚀 案件7：TechGO（テックゴー / ハイクラスITエンジニア・ITコンサル転職）

- **ジャンル**: ハイクラスITエンジニア転職、ITコンサル転職、上流工程転職、キャリア年収アップ
- **対象読者**:
  - 生成AIやGAS・Python等の業務自動化スキルを身につけ、IT・DXエンジニアへの転身や年収アップを目指すビジネスパーソン
  - スプレッドシートやデータベース集計からシステム開発・上流工程へステップアップしたい実務担当者
  - 現役エンジニアでハイクラス転職・コンサルタントへのキャリアアップを狙う読者
- **主な掲載推奨先**:
  - `article-11.html`（【業務自動化・スプシ時短】GAS・自動化スクリプト活用からエンジニアキャリアへ）
  - `article-8.html`（【職場導入・セキュリティ】社内DX・IT推進担当者向け）
  - `article-4.html`（【事務職・エクセル時短】データ集計からITスキルへの発展）
  - `article-5.html`（【企画・プレゼン】ITコンサルタント・上流工程志向）
  - サイドバー（ハイクラスIT転職枠）

### 1. レクタングル・バナー

#### ① 300 × 250（標準レクタングル A - 記事中・サイドバー推奨）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HVNAP" rel="nofollow">
<img border="0" width="300" height="250" alt="TechGO ハイクラスITエンジニア転職" src="https://www25.a8.net/svt/bgt?aid=261015882507&wid=001&eno=01&mid=s00000024757003003000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HVNAP" alt="">
```

#### ② 300 × 250（標準レクタングル B）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+I0KRL" rel="nofollow">
<img border="0" width="300" height="250" alt="TechGO ITエンジニア転職" src="https://www26.a8.net/svt/bgt?aid=261015882507&wid=001&eno=01&mid=s00000024757003026000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www11.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+I0KRL" alt="">
```

#### ③ 100 × 60（マイクロバナー / 小型アイコン枠推奨）
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HVV0H" rel="nofollow">
<img border="0" width="100" height="60" alt="TechGO" src="https://www26.a8.net/svt/bgt?aid=261015882507&wid=001&eno=01&mid=s00000024757003004000&mc=1"></a>
<img border="0" width="1" height="1" src="https://www10.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HVV0H" alt="">
```

---

### 2. テキストリンク

#### ① ハイクラスエンジニア転職訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+I0D1U" rel="nofollow">TechGO（テックゴー）ハイクラスに届くエンジニア転職</a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+I0D1U" alt="">
```

#### ② ITエンジニア転職訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HV7V6" rel="nofollow">ITエンジニアの転職なら【TechGO（テックゴー）】</a>
<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HV7V6" alt="">
```

#### ③ 上流工程・キャリアアップ訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HWAG2" rel="nofollow">上流工程へのキャリアアップ転職【TechGO】</a>
<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HWAG2" alt="">
```

#### ④ ITコンサル訴求
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HX5B6" rel="nofollow">ITコンサル・ハイクラス転職【TechGO】</a>
<img border="0" width="1" height="1" src="https://www19.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HX5B6" alt="">
```

#### ⑤ シンプルブランドリンク A
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HVFKY" rel="nofollow">TechGO（テックゴー）</a>
<img border="0" width="1" height="1" src="https://www12.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HVFKY" alt="">
```

#### ⑥ シンプルブランドリンク B
```html
<a href="https://px.a8.net/svt/ejp?a8mat=4BEH56+8DUSHE+5B0Y+HWPVM" rel="nofollow">TechGO（テックゴー）</a>
<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=4BEH56+8DUSHE+5B0Y+HWPVM" alt="">
```


