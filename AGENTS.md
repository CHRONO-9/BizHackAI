# BizHack AI プロジェクト運用ガイドライン (AGENTS.md)

本ファイルは、Webメディア「BizHack AI」におけるコーディング規約、コンテンツ制作基準、および広告実装の最優先ルールを定義したものです。Antigravityおよびすべてのサブエージェントは本規定を遵守してください。

---

## 📌 1. 新規記事作成時のルール（必須）

新規記事（`article-*.html`）を作成する際は、必ず以下の標準リソースを使用し、ルールに従って執筆・実装してください。

1. **標準テンプレートの使用**:
   - 必ず [`article-template.html`](./article-template.html) をベースにしてHTMLを生成すること。
   - CSS読み込みは必ずキャッシュバスター付き（`css/style.css?v=...`）にすること。
   - `<head>` にGoogle AdSense自動広告タグ（`ca-pub-4599027497639401`）を必ず含めること。
2. **広告自動選定ルール（AIプロンプト規定）の遵守**:
   - 記事を執筆する際は、[`.agents/rules/article-creation-ad-rules.md`](./.agents/rules/article-creation-ad-rules.md) に規定された**「テーマ別広告自動選定マトリクス」**に従い、記事のテーマに最適なASP案件を自動選定して組み込むこと。
   - 広告コードは必ず [`AFFILIATE_TAGS.md`](./AFFILIATE_TAGS.md) の公式コードを使用し、計測用1pxトラッキングピクセル（`<img>`）を一切改変・削除しないこと。
   - すべての広告リンクに `rel="nofollow"` と `target="_blank"` を付与すること。
   - 「PR（広告）」ラベルおよび広告主企業名を明記し、ステマ規制（景品表示法）を完全遵守すること。

---

## 📚 2. 主要ドキュメント一覧

- **標準記事テンプレート**: [`article-template.html`](./article-template.html)
- **広告自動選定ルール**: [`.agents/rules/article-creation-ad-rules.md`](./.agents/rules/article-creation-ad-rules.md)
- **公式広告コード台帳**: [`AFFILIATE_TAGS.md`](./AFFILIATE_TAGS.md)
- **品質検品スクリプト**: [`scripts/verify-site.ps1`](./scripts/verify-site.ps1)
- **プロジェクト履歴**: [`PROJECT_HISTORY.md`](./PROJECT_HISTORY.md)
- **プライバシーポリシー・ステマ開示方針**: [`privacy.html`](./privacy.html)

---

## 🛡️ 3. 公開前自動検品プロトコル（必須実行チェック）

記事の追加、HTMLの修正、デザイン変更を行った際は、コミット・プッシュする前に**必ず以下の自動検品スクリプトを実行し、全ファイルが「PASS（エラー0件）」であることを機械的に検証すること**を義務付けます。

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-site.ps1
```

### 検証項目：
1. **CSSリンクの整合性**：`css/style.css` の実在ファイルとの完全一致（404・タイポ防止）
2. **広告・トラフィックタグ**：Google AdSense（`ca-pub-4599027497639401`）および Google Analytics（`G-PXPDE46RFR`）の存在
3. **必須レイアウト構造**：`.main-wrapper`, `.article-layout`, `.article-main`, `.article-sidebar` の完全性
4. **ステマ規制遵守**：`.pr-disclosure-bar` の明記
5. **テンプレート残骸**：未置換のプレースホルダー（`{{...}}`）の非残留
6. **ASPアフィリエイト整合性**：1px計測画像の保持および `rel="nofollow"` の付与

---

## 📊 4. GA4 定期アクセス解析＆改善提案プロトコル

ユーザーからGA4の定期解析を求められた際は、今回と同じ以下の標準フローで実測データを取得し、具体的な改善提案・一括実装を行うこと。

1. **対象GA4プロパティ**:
   - **プロパティ名**: BizHack AI（アカウントID: `411971549` / プロパティID: `558928664` / 測定ID: `G-PXPDE46RFR`）
   - **管理画面URL**: `https://analytics.google.com/analytics/web/#/a411971549p558928664/reports/intelligenthome?params=_u..nav%3Dmaui`
2. **データ取得・解析手順**:
   - **`browser` サブエージェント**（`/browser` コマンド経由、またはスクリーンショット・CSV共有）で、以下4つの主要レポートを取得する：
     1. **ホーム（全体サマリー）**：アクティブユーザー、表示回数、エンゲージメント率、平均エンゲージメント時間
     2. **ページとスクリーン**：記事別のPV数・ユーザー数・平均滞在時間（熟読記事・即離脱記事・埋没記事の特定）
     3. **トラフィック獲得**：Organic Search（自然検索）、Direct、Referral等の流入チャネル推移
     4. **イベント**：標準イベントに加え、実装済みカスタムイベント（`prompt_copy`、`affiliate_click`、`internal_circulation_click`）の発火回数と地域別分布（ボット/クローラー比率の推察）
   - 取得した数値を **`committee-seo`（SEO・データアナリスト）**（および必要に応じて `committee-monetize`）へ渡し、以下をセットでレポートする：
     - **「本当の現在地（ボット除外後の実ユーザー行動・前回比の伸び・課題記事）」**
     - **「今すぐコードベースに打てる具体的な改善アクションプラン（SEO・UI/回遊・CV導線・新規記事テーマ）」**


