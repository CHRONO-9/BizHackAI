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
- **プロジェクト履歴**: [`PROJECT_HISTORY.md`](./PROJECT_HISTORY.md)
- **プライバシーポリシー・ステマ開示方針**: [`privacy.html`](./privacy.html)
