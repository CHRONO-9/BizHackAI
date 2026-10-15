# BizHack AI 新規記事作成 ＆ 広告自動選定ルール (AIプロンプト規定)

本ドキュメントは、「BizHack AI」においてAI（Antigravityおよび各委員会サブエージェント）が新しい記事を執筆・作成する際に**完全自動で読み込み、遵守すべき広告選定・配置の標準規定**です。

---

## 📌 1. 基本原則（committee-monetize ＆ committee-legal 監修）

1. **Google AdSenseは触らない（完全自動）**:
   - `<head>` 内にAdSenseスクリプト（`ca-pub-4599027497639401`）が配置されていれば、審査完了後にGoogle AIが本文隙間へ自動配信します。記事本文中に手動AdSenseコードを直貼りする必要はありません。
2. **文脈連動型ASP広告の自動選定（1記事1〜2案件）**:
   - 記事の「テーマ」および「読者ペルソナの悩み」に基づき、以下の「広告選定マッピング表」に従って最適な案件を自動抽出し、[`AFFILIATE_TAGS.md`](../AFFILIATE_TAGS.md) から正確なコードを引用して配置します。
3. **景表法・ステマ規制の完全遵守**:
   - 記事冒頭のPR開示バーを維持すること。
   - 広告枠には必ず `PR（広告）` バッジと `提携先：〇〇` を明記すること。
   - すべてのアフィリエイトリンクに `rel="nofollow"` および `target="_blank"` を付与すること。
   - ASP（A8.net等）の**計測用1px画像（トラッキングピクセル）を絶対に削除・改変しない**こと。

---

## 🎯 2. テーマ・ペルソナ別 広告自動選定マトリクス

AIが記事を執筆する際は、記事のテーマに該当する以下の案件を自動で選択・配置してください。

| 記事の主要テーマ | 対象読者ペルソナ | 自動選定する広告案件 | 訴求ベネフィット・選定理由 |
| :--- | :--- | :--- | :--- |
| **セキュリティ / 社内DX / リモートワーク / 仮想環境** | 現場主任、情シス、DX推進担当 | **ConoHa for Windows Server**<br>（GMOインターネット） | **【安全な仮想デスクトップ】**<br>会社のローカル環境と分離されたセキュアなWindows環境で、社内規制を回避しながら24時間ツールやAIを安全稼働。 |
| **エクセル自動化 / Python集計 / 定型業務放置** | 総務・経理、一般事務、データ集計担当 | **マネーフォワード クラウド**<br>または **ConoHa** | **【手入力の全自動化】**<br>エクセル集計を根本からなくすクラウド自動連携、またはマクロや集計スクリプトを24時間放置稼働できるVPS。 |
| **ビジネスメール / 問い合わせ対応 / 営業DX** | 若手営業、営業事務、カスタマーサポート | **お名前.com**（独自ドメインメール）<br>または **TAKETIN** | **【信頼性の向上と自動化】**<br>AIで作成したメールを信頼性の高い独自ドメインで送信、または定型問い合わせ・連絡のノーコード自動化。 |
| **会議・議事録 / タスク管理 / 業務効率化** | 現場リーダー、マネージャー、課長 | **TAKETIN**<br>（ノーコードSaaS） | **【社内連絡・会員運営の自動化】**<br>議事録で会議を時短した次の一歩として、社内連絡や顧客管理をノーコードで丸ごと自動化。 |
| **企画書 / プレゼン / スライド / 戦略立案** | 営業企画、マーケター、事業企画 | **sXars**<br>（関西特化コンサル転職） | **【思考力・企画力の年収化】**<br>AIを駆使して磨いた課題解決力・企画力を市場価値に変える、年収アップ・ハイクラスコンサル転職。 |
| **デザイン / Canva / バナー / Web・LP制作** | 広報、SNS運用担当、マーケター | **お名前.com**<br>（ドメイン・Webサーバー） | **【制作物の公開・発信基盤】**<br>CanvaとAIで作った告知バナーや制作物を発信するための、自社サイト・特設LP用独自ドメイン取得。 |
| **一人起業 / 副業 / フリーランス / 法人化** | 個人事業主、週末起業家、独立志望者 | **【ダブル実装】**<br>① **0円創業くん**<br>② **TAKETIN** | **【事業自動化 ＆ 登記実費0円支援】**<br>TAKETINによる会員制サービス自動化と、法人化時の設立登記実費を最大0円にする強力な起業支援。 |
| **契約書 / 社内規程 / 難解文書 / 法務・総務** | 総務・法務担当、管理部門ベテラン | **sXars**<br>（関西特化コンサル転職） | **【高度な構造化スキルのキャリア化】**<br>難解な文書や規程を整理・要約する実務力を武器に、経営・DX変革コンサルタントへの転身を提案。 |
| **超初心者向け（AI入門・概念解説・触り始め）** | 40代〜50代事務、IT苦手層 | **ASP広告はあえて非掲載**<br>（※AdSenseのみ） | **【信頼獲得と離脱防止最優先】**<br>初心者が最初に入る記事では押し売り感をゼロにし、徹底的に純粋な学習体験を提供してファン化を図る。 |

---

## 🛠️ 3. 記事内への広告配置フォーマット（HTML仕様）

記事作成時は、[`article-template.html`](../article-template.html) の該当枠に以下の形式でコードを流し込みます。

### ① 記事中PR枠（読者が課題解決した直後のセクション後に配置）
```html
<!-- スポンサー・PR枠 -->
<div class="pr-recommend-box" style="margin:2.5rem 0; padding:1.75rem 1.5rem; background:var(--card-bg, #ffffff); border:1px solid var(--border-color, #e2e8f0); border-radius:12px; box-shadow:0 4px 16px rgba(0,0,0,0.06); text-align:center;">
  <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:1rem; border-bottom:1px dashed var(--border-color, #e2e8f0); padding-bottom:0.5rem;">
    <span style="font-size:0.75rem; font-weight:700; color:#dc2626; background:#fee2e2; padding:0.2rem 0.6rem; border-radius:4px;">PR（広告）</span>
    <span style="font-size:0.8rem; color:var(--text-muted, #64748b);">[案件カテゴリー]</span>
  </div>
  <h3 style="font-size:1.2rem; margin:0 0 0.6rem 0; color:var(--text-color, #1e293b); font-weight:700;">
    [読者の悩みを解決する強力なキャッチコピー]
  </h3>
  <p style="font-size:0.9rem; color:var(--text-muted, #64748b); line-height:1.65; margin-bottom:1.25rem;">
    [記事の文脈から次のステップへ導く提案文]
  </p>

  <!-- 高CVRテキストリンク -->
  <div style="margin-bottom:1.25rem; padding:0.85rem 1rem; background:#eff6ff; border:1px solid #dbeafe; border-radius:8px;">
    <div style="font-size:0.95rem; font-weight:700;">
      <!-- AFFILIATE_TAGS.mdの公式テキストリンク＋計測ピクセル -->
      <a href="[公式リンク]" rel="nofollow" target="_blank" style="color:#1d4ed8; text-decoration:underline;">
        👉 [高CVRアンカーテキスト]
      </a>
      <img border="0" width="1" height="1" src="[計測ピクセルURL]" alt="">
    </div>
  </div>

  <!-- 特徴3点 -->
  <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(180px, 1fr)); gap:0.75rem; margin-bottom:1.25rem; text-align:left;">
    <div style="background:#f8fafc; padding:0.6rem 0.8rem; border-radius:6px; border:1px solid #e2e8f0; font-size:0.8rem;">
      <strong style="color:#1d4ed8;">① [メリット1]</strong><br>[説明]
    </div>
    <div style="background:#f8fafc; padding:0.6rem 0.8rem; border-radius:6px; border:1px solid #e2e8f0; font-size:0.8rem;">
      <strong style="color:#1d4ed8;">② [メリット2]</strong><br>[説明]
    </div>
    <div style="background:#f8fafc; padding:0.6rem 0.8rem; border-radius:6px; border:1px solid #e2e8f0; font-size:0.8rem;">
      <strong style="color:#1d4ed8;">③ [メリット3]</strong><br>[説明]
    </div>
  </div>

  <!-- 公式300x250バナー -->
  <div style="display:inline-block; margin:0 auto; max-width:100%;">
    <a href="[公式リンク]" rel="nofollow" target="_blank" style="display:block; text-decoration:none;">
      <img border="0" width="300" height="250" alt="[サービス名]" src="[バナー画像URL]" style="max-width:100%; height:auto; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);">
    </a>
    <img border="0" width="1" height="1" src="[計測ピクセルURL]" alt="">
  </div>

  <p style="font-size:0.75rem; color:var(--text-muted, #64748b); margin-top:0.75rem; margin-bottom:0;">
    ※提携先：[企業名]（[サービス名]）/ 公式サイト・詳細はこちら
  </p>
</div>
```

### ② サイドバーPRカード（右カラム）
```html
<!-- サイドバーPRカード -->
<div class="sidebar-card" style="text-align:center;">
  <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:0.75rem; border-bottom:1px dashed var(--border-color, #e2e8f0); padding-bottom:0.4rem;">
    <span style="font-size:0.7rem; font-weight:700; color:#dc2626; background:#fee2e2; padding:0.15rem 0.4rem; border-radius:4px;">PR（広告）</span>
    <span style="font-size:0.75rem; color:var(--text-muted, #64748b);">[カテゴリー]</span>
  </div>
  <div style="font-size:0.95rem; font-weight:700; color:var(--text-color, #1e293b); margin-bottom:0.4rem; text-align:left;">
    [魅力的なタイトル]
  </div>
  <p style="font-size:0.8rem; color:var(--text-muted, #64748b); line-height:1.5; margin-bottom:0.75rem; text-align:left;">
    [簡潔な要約文]
  </p>
  <div style="margin:0 auto 0.5rem auto; display:inline-block; max-width:100%;">
    <a href="[公式リンク]" rel="nofollow" target="_blank" style="display:block;">
      <img border="0" width="120" height="60" alt="[サービス名]" src="[120x60画像URL]" style="max-width:100%; height:auto; border-radius:6px; box-shadow:0 2px 6px rgba(0,0,0,0.08);">
    </a>
    <img border="0" width="1" height="1" src="[計測ピクセルURL]" alt="">
  </div>
  <div style="font-size:0.85rem; font-weight:700; text-align:left; margin-top:0.6rem;">
    <a href="[公式リンク]" rel="nofollow" target="_blank" style="color:#1e40af; text-decoration:underline;">
      ▶ [テキストリンク文言]
    </a>
    <img border="0" width="1" height="1" src="[計測ピクセルURL]" alt="">
  </div>
  <p style="font-size:0.72rem; color:var(--text-muted, #64748b); margin-top:0.5rem; margin-bottom:0; text-align:right;">
    提携：[企業名]
  </p>
</div>
```

---

## 📋 4. AI執筆時の自動実行チェックリスト

AIが新規記事を生成・保存する直前に、以下の5点を自律点検してください：

- [ ] `<head>` にGoogle AdSense自動広告タグ（`ca-pub-4599027497639401`）が含まれているか
- [ ] CSS読み込みがキャッシュバスター付き（`css/styles.css?v=...`）になっているか
- [ ] 記事テーマに合致したASP案件が「広告選定マトリクス」から選ばれているか
- [ ] 広告リンクに `rel="nofollow"` と `target="_blank"` が付与されているか
- [ ] A8.netの1px透明画像（計測ピクセル）が改変されずに保持されているか
