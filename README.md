# BizHack AI（ビズハックAI）

> **「研ぎ澄まされた切れ味で無駄を一刀両断」**  
> 現場の仕事を3時間短縮する生成AI・SaaS実務検証マガジン

---

## 📁 ディレクトリ構成

```text
├── index.html            # トップページ（ヒーロー、6記事グリッド、著者紹介、PR開示）
├── article-1.html        # 記事1：ChatGPT議事録作成プロンプト（実測91%削減）
├── article-2.html        # 記事2：ChatGPT Team vs Claude Enterprise比較（損益分岐点・稟議書）
├── article-3.html        # 記事3：Notion AI×クラウド会計ワンオペコックピット
├── article-4.html        # 記事4：Claude 3.5 Sonnet×GAS自律型タスク抽出
├── article-5.html        # 記事5：Midjourney×ChatGPT売れるバナー爆速制作
├── article-6.html        # 記事6：ChatGPT×スプレッドシートデータクレンジング
├── privacy.html          # プライバシーポリシー・免責事項・ステマ規制PR基準・問い合わせ
├── css/
│   └── style.css         # レスポンシブデザイン、ダークモード調ヒーロー、Core Web Vitals対応
├── js/
│   └── main.js           # プログレスバー、コピペボタン、TOCスクロールスパイ
├── images/               # ブランドアイコン（日本刀案A/B/C、ネオン案等）
│   └── bizhack-icon-main.jpg # 採用メインアイコン（一刀両断シンボル）
└── articles/             # 各専属ライターによるMarkdown執筆原本
```

---

## 🚀 別のPCでの開き方・確認方法

### 方法1：手軽にブラウザで直接開く
フォルダを展開し、`index.html` をダブルクリックするだけでGoogle ChromeやEdgeなどのブラウザでそのまま閲覧できます。

### 方法2：ローカルWebサーバーで確認（推奨）
ターミナル（PowerShell / コマンドプロンプト / ターミナル）を開き、本フォルダに移動して以下を実行します：

```bash
# Pythonの簡易サーバー起動
python -m http.server 8080
```

ブラウザで `http://localhost:8080/index.html` にアクセスすると、本番環境と全く同じ挙動で確認できます。

---

## 🔒 ライセンス・運営
- 運営：BizHack AI 運営委員会
- 著作権：© 2026 BizHack AI. All rights reserved.
