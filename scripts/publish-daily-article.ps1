# ==============================================================================
# BizHack AI - 日次記事自動公開＆プッシュスクリプト (publish-daily-article.ps1)
# 毎日 0:00 に実行され、予約されたドラフト記事を公開・検品・Gitプッシュします。
# ==============================================================================

param (
    [int]$ArticleNumber = 0
)

$ErrorActionPreference = "Stop"
$WorkspaceRoot = "C:\Users\k_mil\Desktop\BzhackAI"
Set-Location -Path $WorkspaceRoot

# Git実行環境の設定（GCM連携）
$env:Path = "C:\Users\k_mil\AppData\Local\Programs\Git\cmd;C:\Users\k_mil\AppData\Local\Programs\Git\ucrt64\bin;C:\Users\k_mil\AppData\Local\Programs\GitCredentialManager;$env:Path"
$env:GIT_EXEC_PATH = "C:\Users\k_mil\AppData\Local\Programs\Git\ucrt64\bin"

$Today = Get-Date
$TodayStr = $Today.ToString("yyyy-MM-dd")
$NowTimestampStr = $Today.ToString("yyyy.MM.dd HH:mm")
$NowIsoStr = $Today.ToString("yyyy-MM-ddTHH:mm:ss+09:00")

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  BizHack AI Daily Publication Runner ($NowTimestampStr)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. 記事番号の特定
if ($ArticleNumber -eq 0) {
    # 日付によるマッピング
    $DateSchedule = @{
        "2026-10-17" = 12
        "2026-10-18" = 13
        "2026-10-19" = 14
        "2026-10-20" = 15
        "2026-10-21" = 16
        "2026-10-22" = 17
        "2026-10-23" = 18
    }
    
    if ($DateSchedule.ContainsKey($TodayStr)) {
        $ArticleNumber = $DateSchedule[$TodayStr]
    } else {
        # スケジュール外の場合、未公開の最小ドラフトを探す
        for ($i = 12; $i -le 18; $i++) {
            if (-not (Test-Path "$WorkspaceRoot\article-$i.html")) {
                $ArticleNumber = $i
                break
            }
        }
    }
}

if ($ArticleNumber -eq 0) {
    Write-Host "[INFO] 今日公開すべき対象記事はありません、または全記事公開済みです。" -ForegroundColor Green
    exit 0
}

$DraftFile = "$WorkspaceRoot\drafts\article-$ArticleNumber.html"
$TargetFile = "$WorkspaceRoot\article-$ArticleNumber.html"

if (-not (Test-Path $DraftFile)) {
    Write-Host "[ERROR] ドラフトファイルが見つかりません: $DraftFile" -ForegroundColor Red
    exit 1
}

Write-Host "[STEP 1] 第$ArticleNumber弾 を公開配置中: $DraftFile -> $TargetFile" -ForegroundColor Yellow
Copy-Item -Path $DraftFile -Destination $TargetFile -Force

# 2. 記事メタデータの取得（タイトル・要約）
$DraftContent = Get-Content -Path $TargetFile -Raw -Encoding utf8
$TitleMatch = [regex]::Match($DraftContent, '<title>(.*?)｜BizHack AI</title>')
$ArticleTitle = if ($TitleMatch.Success) { $TitleMatch.Groups[1].Value } else { "第${ArticleNumber}弾実践記事" }

# 3. sitemap.xml の更新（未掲載なら追加）
$SitemapPath = "$WorkspaceRoot\sitemap.xml"
if (Test-Path $SitemapPath) {
    $SitemapContent = Get-Content -Path $SitemapPath -Raw -Encoding utf8
    $ArticleUrl = "https://www.bizhack-ai.com/article-$ArticleNumber.html"
    if ($SitemapContent -notlike "*$ArticleUrl*") {
        $NewEntry = @"
  <url>
    <loc>$ArticleUrl</loc>
    <lastmod>$TodayStr</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
</urlset>
"@
        $SitemapContent = $SitemapContent -replace '</urlset>', $NewEntry
        Set-Content -Path $SitemapPath -Value $SitemapContent -Encoding utf8 -NoNewline
        Write-Host "[STEP 2] sitemap.xml に $ArticleUrl を追加完了" -ForegroundColor Green
    }
}

# 4. index.html のお知らせバー＆最終更新日時更新
$IndexPath = "$WorkspaceRoot\index.html"
if (Test-Path $IndexPath) {
    $IndexContent = Get-Content -Path $IndexPath -Raw -Encoding utf8
    # お知らせバーのテキスト更新
    $NewAnnouncement = "<span class=`"announcement-text`">最新第${ArticleNumber}弾「$ArticleTitle」を公開！</span>"
    $IndexContent = [regex]::Replace($IndexContent, '<span class="announcement-text">.*?</span>', { param($m) $NewAnnouncement })
    # 更新日時の更新
    $NewTime = "<time datetime=`"$NowIsoStr`" class=`"update-time`">$NowTimestampStr</time>"
    $IndexContent = [regex]::Replace($IndexContent, '<time datetime=".*?" class="update-time">.*?</time>', { param($m) $NewTime })
    Set-Content -Path $IndexPath -Value $IndexContent -Encoding utf8 -NoNewline
    Write-Host "[STEP 3] index.html のお知らせバーと更新日時を更新完了" -ForegroundColor Green
}

# 5. 品質検品スクリプト (verify-site.ps1) の実行
Write-Host "[STEP 4] サイト品質自動検品を実行中..." -ForegroundColor Yellow
$VerifyResult = powershell -ExecutionPolicy Bypass -File "$WorkspaceRoot\scripts\verify-site.ps1"
Write-Host $VerifyResult

if ($LASTEXITCODE -ne 0) {
    Write-Host "[FATAL] 品質検品に失敗しました。プッシュを中止します。" -ForegroundColor Red
    exit 1
}

# 6. Git コミット ＆ プッシュ
Write-Host "[STEP 5] GitHubへのコミット・プッシュを実行中..." -ForegroundColor Yellow
git add .
$CommitMsg = "feat: publish article-$ArticleNumber.html (BizHack AI 第$ArticleNumber弾 自動公開)"
git commit -m $CommitMsg
git push origin main

$LatestCommitSha = (git rev-parse --short HEAD).Trim()

Write-Host "==========================================================" -ForegroundColor Green
Write-Host "  第$ArticleNumber弾 の公開とGitHubプッシュが完了しました！" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green

# 7. 完了報告メールの送信
$EmailConfigFile = "$WorkspaceRoot\config\email-config.json"
if (Test-Path $EmailConfigFile) {
    try {
        Write-Host "[STEP 6] 完了通知メールを送信中..." -ForegroundColor Yellow
        $mailConfig = Get-Content -Raw $EmailConfigFile | ConvertFrom-Json

        $smtp = New-Object System.Net.Mail.SmtpClient($mailConfig.smtpServer, $mailConfig.smtpPort)
        $smtp.EnableSsl = $mailConfig.enableSsl
        $smtp.Credentials = New-Object System.Net.NetworkCredential($mailConfig.senderEmail, $mailConfig.appPassword)

        $mail = New-Object System.Net.Mail.MailMessage
        $mail.From = New-Object System.Net.Mail.MailAddress($mailConfig.senderEmail, "BizHack AI 運営事務局")
        $mail.To.Add($mailConfig.recipientEmail)
        $mail.Subject = "【BizHack AI】第${ArticleNumber}弾の記事公開＆GitHubプッシュが完了しました"
        $mail.Body = @"
阿部 圭二 様

BizHack AI 日次記事自動公開システムよりご報告いたします。

本日（$NowTimestampStr）のスケジュール記事が正常に公開され、品質検品をクリアしてGitHubへ自動プッシュされました。

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
■ 公開完了レポート
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
・記事番号: 第${ArticleNumber}弾
・記事タイトル: $ArticleTitle
・公開URL: https://www.bizhack-ai.com/article-$ArticleNumber.html
・GitHubコミット: $LatestCommitSha
・コミットメッセージ: $CommitMsg
・自動検品ステータス: PASS（エラー0件）

数分以内にGitHub Pages（https://chrono-9.github.io/BizHackAI/）および公式サイトへ自動反映されます。

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
※本メールはBizHack AI自動運用システムより送信されています。
"@
        $mail.BodyEncoding = [System.Text.Encoding]::UTF8
        $mail.SubjectEncoding = [System.Text.Encoding]::UTF8

        $smtp.Send($mail)
        $mail.Dispose()
        $smtp.Dispose()
        Write-Host "[SUCCESS] 完了通知メールを $($mailConfig.recipientEmail) へ送信しました！" -ForegroundColor Green
    } catch {
        Write-Host "[WARN] メール送信に失敗しました: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

