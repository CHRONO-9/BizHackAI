# ==============================================================================
# BizHack AI - Daily Article Publisher (publish-daily-article.ps1)
# ASCII-only script to prevent Windows PowerShell encoding and parsing errors.
# Runs daily at 0:00 to publish, verify, commit, and push reserved draft articles.
# ==============================================================================

param (
    [int]$ArticleNumber = 0
)

$ErrorActionPreference = "Stop"
$WorkspaceRoot = "C:\Users\k_mil\Desktop\BzhackAI"
if (-not (Test-Path $WorkspaceRoot)) {
    $WorkspaceRoot = Split-Path -Parent $PSScriptRoot
}
Set-Location -Path $WorkspaceRoot

# Git execution environment setup
$env:Path = "C:\Users\k_mil\AppData\Local\Programs\Git\cmd;C:\Users\k_mil\AppData\Local\Programs\Git\ucrt64\bin;C:\Users\k_mil\AppData\Local\Programs\GitCredentialManager;$env:Path"
$env:GIT_EXEC_PATH = "C:\Users\k_mil\AppData\Local\Programs\Git\ucrt64\bin"

$Today = Get-Date
$TodayStr = $Today.ToString("yyyy-MM-dd")
$TodayDotStr = $Today.ToString("yyyy.MM.dd")
$NowTimestampStr = $Today.ToString("yyyy.MM.dd HH:mm")
$NowIsoStr = $Today.ToString("yyyy-MM-ddTHH:mm:ss+09:00")

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  BizHack AI Daily Publication Runner ($NowTimestampStr)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Identify article number
if ($ArticleNumber -eq 0) {
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
        for ($i = 12; $i -le 18; $i++) {
            if (-not (Test-Path "$WorkspaceRoot\article-$i.html")) {
                $ArticleNumber = $i
                break
            }
        }
    }
}

if ($ArticleNumber -eq 0) {
    Write-Host "[INFO] No target article found for today or all articles already published." -ForegroundColor Green
    exit 0
}

$DraftFile = "$WorkspaceRoot\drafts\article-$ArticleNumber.html"
$TargetFile = "$WorkspaceRoot\article-$ArticleNumber.html"

if (-not (Test-Path $DraftFile)) {
    Write-Host "[ERROR] Draft file not found: $DraftFile" -ForegroundColor Red
    exit 1
}

Write-Host "[STEP 1] Publishing draft: $DraftFile -> $TargetFile" -ForegroundColor Yellow
Copy-Item -Path $DraftFile -Destination $TargetFile -Force

# 2. Extract metadata
$DraftContent = [System.IO.File]::ReadAllText($TargetFile, [System.Text.Encoding]::UTF8)
$TitleMatch = [regex]::Match($DraftContent, '<title>(.*?)｜BizHack AI</title>')
$ArticleTitle = if ($TitleMatch.Success) { $TitleMatch.Groups[1].Value } else { "Article $ArticleNumber" }
$DescMatch = [regex]::Match($DraftContent, '<meta name="description" content="(.*?)">')
$ArticleDesc = if ($DescMatch.Success) { $DescMatch.Groups[1].Value } else { "" }

# 3. Update sitemap.xml
$SitemapPath = "$WorkspaceRoot\sitemap.xml"
if (Test-Path $SitemapPath) {
    $SitemapContent = [System.IO.File]::ReadAllText($SitemapPath, [System.Text.Encoding]::UTF8)
    $ArticleUrl = "https://www.bizhack-ai.com/article-$ArticleNumber.html"
    if ($SitemapContent -notlike "*$ArticleUrl*") {
        $NewEntry = "  <url>`n    <loc>$ArticleUrl</loc>`n    <lastmod>$TodayStr</lastmod>`n    <changefreq>weekly</changefreq>`n    <priority>0.8</priority>`n  </url>`n</urlset>"
        $SitemapContent = $SitemapContent.Replace('</urlset>', $NewEntry)
        [System.IO.File]::WriteAllText($SitemapPath, $SitemapContent, [System.Text.Encoding]::UTF8)
        Write-Host "[STEP 2] Added $ArticleUrl to sitemap.xml" -ForegroundColor Green
    }
}

# 4. Update index.html
$IndexPath = "$WorkspaceRoot\index.html"
if (Test-Path $IndexPath) {
    $IndexContent = [System.IO.File]::ReadAllText($IndexPath, [System.Text.Encoding]::UTF8)

    # 4a. Announcement bar direct link
    $IndexContent = [regex]::Replace($IndexContent, '<a href="[^"]*" class="announcement-bar-link">', "<a href=`"article-$ArticleNumber.html`" class=`"announcement-bar-link`">")

    # 4b. Announcement text
    $AnnFormatFile = "$WorkspaceRoot\config\templates\announcement-format.txt"
    $AnnFormat = if (Test-Path $AnnFormatFile) { [System.IO.File]::ReadAllText($AnnFormatFile, [System.Text.Encoding]::UTF8) } else { "Latest Vol.{0}: {1}" }
    $AnnText = [string]::Format($AnnFormat, $ArticleNumber, $ArticleTitle)
    $NewAnnouncementHtml = "<span class=`"announcement-text`">$AnnText</span>"
    $IndexContent = [regex]::Replace($IndexContent, '<span class="announcement-text">.*?</span>', { param($m) $NewAnnouncementHtml })

    # 4c. Update timestamp
    $NewTimeHtml = "<time datetime=`"$NowIsoStr`" class=`"update-time`">$NowTimestampStr</time>"
    $IndexContent = [regex]::Replace($IndexContent, '<time datetime=".*?" class="update-time">.*?</time>', { param($m) $NewTimeHtml })

    # 4d. Total articles count in nav/tabs
    $PrevNumber = $ArticleNumber - 1
    $ZenBytes = [byte[]]@(0xE5, 0x85, 0xA8)
    $DanBytes = [byte[]]@(0xE5, 0xBC, 0xBE)
    $PrevCountPattern = [System.Text.Encoding]::UTF8.GetString($ZenBytes) + $PrevNumber + [System.Text.Encoding]::UTF8.GetString($DanBytes)
    $NewCountPattern = [System.Text.Encoding]::UTF8.GetString($ZenBytes) + $ArticleNumber + [System.Text.Encoding]::UTF8.GetString($DanBytes)
    $IndexContent = $IndexContent.Replace($PrevCountPattern, $NewCountPattern)

    # 4e. Add card to featured grid if not already present
    if ($IndexContent -notmatch "article-$ArticleNumber\.html") {
        $MetaConfigFile = "$WorkspaceRoot\config\articles-metadata.json"
        $MetaJson = if (Test-Path $MetaConfigFile) { [System.IO.File]::ReadAllText($MetaConfigFile, [System.Text.Encoding]::UTF8) | ConvertFrom-Json } else { $null }
        $ArtMeta = if ($MetaJson -and $MetaJson.PSObject.Properties["$ArticleNumber"]) { $MetaJson."$ArticleNumber" } else { $null }

        $CardTplFile = "$WorkspaceRoot\config\templates\article-card.html"
        if (Test-Path $CardTplFile) {
            $CardTpl = [System.IO.File]::ReadAllText($CardTplFile, [System.Text.Encoding]::UTF8)
            $CardTpl = $CardTpl.Replace("{ARTICLE_NUMBER}", "$ArticleNumber")
            $CardTpl = $CardTpl.Replace("{ARTICLE_TITLE}", $ArticleTitle)
            $CardTpl = $CardTpl.Replace("{ARTICLE_DESC}", $ArticleDesc)
            $CardTpl = $CardTpl.Replace("{TODAY_DOT}", $TodayDotStr)

            if ($ArtMeta) {
                $CardTpl = $CardTpl.Replace("{CATEGORY_KEY}", $ArtMeta.categoryKey)
                $CardTpl = $CardTpl.Replace("{CATEGORY_CLASS}", $ArtMeta.categoryClass)
                $CardTpl = $CardTpl.Replace("{CATEGORY_LABEL}", $ArtMeta.categoryLabel)
                $CardTpl = $CardTpl.Replace("{GRADIENT_FROM}", $ArtMeta.gradientFrom)
                $CardTpl = $CardTpl.Replace("{GRADIENT_TO}", $ArtMeta.gradientTo)
                $CardTpl = $CardTpl.Replace("{THUMB_TITLE}", $ArtMeta.thumbTitle)
                $CardTpl = $CardTpl.Replace("{AUTHOR_NAME}", $ArtMeta.authorName)
                $CardTpl = $CardTpl.Replace("{AUTHOR_AVATAR}", $ArtMeta.authorAvatar)
                $CardTpl = $CardTpl.Replace("{AUTHOR_COLOR}", $ArtMeta.authorColor)
            } else {
                $CardTpl = $CardTpl.Replace("{CATEGORY_KEY}", "routine")
                $CardTpl = $CardTpl.Replace("{CATEGORY_CLASS}", "cat-biz")
                $CardTpl = $CardTpl.Replace("{CATEGORY_LABEL}", "AI DX")
                $CardTpl = $CardTpl.Replace("{GRADIENT_FROM}", "#047857")
                $CardTpl = $CardTpl.Replace("{GRADIENT_TO}", "#10b981")
                $CardTpl = $CardTpl.Replace("{THUMB_TITLE}", $ArticleTitle)
                $CardTpl = $CardTpl.Replace("{AUTHOR_NAME}", "BizHack AI")
                $CardTpl = $CardTpl.Replace("{AUTHOR_AVATAR}", "images/author-mizuno.jpg")
                $CardTpl = $CardTpl.Replace("{AUTHOR_COLOR}", "#10b981")
            }

            # Insert card before the closing of #featured articles grid
            $FeaturedPattern = '(?s)(<section id="featured"[^>]*>.*?)(</div>\s*</section>)'
            if ($IndexContent -match $FeaturedPattern) {
                $IndexContent = [regex]::Replace($IndexContent, $FeaturedPattern, { param($m) $m.Groups[1].Value + "`n" + $CardTpl + "`n      " + $m.Groups[2].Value })
            }
        }
    }

    [System.IO.File]::WriteAllText($IndexPath, $IndexContent, [System.Text.Encoding]::UTF8)
    Write-Host "[STEP 3] Updated index.html successfully" -ForegroundColor Green
}

# 5. Site quality check
Write-Host "[STEP 4] Running site quality check..." -ForegroundColor Yellow
$VerifyResult = powershell -ExecutionPolicy Bypass -File "$WorkspaceRoot\scripts\verify-site.ps1"
Write-Host $VerifyResult

if ($LASTEXITCODE -ne 0) {
    Write-Host "[FATAL] Site quality verification failed. Aborting push." -ForegroundColor Red
    exit 1
}

# 6. Git commit and push
Write-Host "[STEP 5] Committing and pushing to GitHub..." -ForegroundColor Yellow
git add .
$CommitMsg = "feat: publish article-$ArticleNumber.html (BizHack AI Vol.$ArticleNumber automated publish)"
git commit -m $CommitMsg
git push origin main

$LatestCommitSha = (git rev-parse --short HEAD).Trim()
Write-Host "[SUCCESS] Successfully published and pushed Article $ArticleNumber (commit $LatestCommitSha)" -ForegroundColor Green

# 7. Notification email
$EmailConfigFile = "$WorkspaceRoot\config\email-config.json"
if (Test-Path $EmailConfigFile) {
    try {
        Write-Host "[STEP 6] Sending completion report email..." -ForegroundColor Yellow
        $mailConfig = Get-Content -Raw $EmailConfigFile | ConvertFrom-Json

        $smtp = New-Object System.Net.Mail.SmtpClient($mailConfig.smtpServer, $mailConfig.smtpPort)
        $smtp.EnableSsl = $mailConfig.enableSsl
        $smtp.Credentials = New-Object System.Net.NetworkCredential($mailConfig.senderEmail, $mailConfig.appPassword)

        $mail = New-Object System.Net.Mail.MailMessage
        $senderDisplayNameBytes = [byte[]]@(0x42, 0x69, 0x7A, 0x48, 0x61, 0x63, 0x6B, 0x20, 0x41, 0x49, 0x20, 0xE9, 0x81, 0x8B, 0xE5, 0x96, 0xB6, 0xE4, 0xBA, 0x8B, 0xE5, 0x8B, 0x99, 0xE5, 0xB1, 0x80)
        $senderDisplayName = [System.Text.Encoding]::UTF8.GetString($senderDisplayNameBytes)
        $mail.From = New-Object System.Net.Mail.MailAddress($mailConfig.senderEmail, $senderDisplayName)
        $mail.To.Add($mailConfig.recipientEmail)

        # Subject
        $SubFormatFile = "$WorkspaceRoot\config\templates\mail-subject-format.txt"
        $SubFormat = if (Test-Path $SubFormatFile) { ([System.IO.File]::ReadAllText($SubFormatFile, [System.Text.Encoding]::UTF8)).Trim() } else { "[BizHack AI] Article {0} Published" }
        $mail.Subject = [string]::Format($SubFormat, $ArticleNumber)

        # Body
        $BodyTemplateFile = "$WorkspaceRoot\config\templates\mail-body.txt"
        if (Test-Path $BodyTemplateFile) {
            $BodyContent = [System.IO.File]::ReadAllText($BodyTemplateFile, [System.Text.Encoding]::UTF8)
            $BodyContent = $BodyContent.Replace("{TIMESTAMP}", $NowTimestampStr)
            $BodyContent = $BodyContent.Replace("{ARTICLE_NUMBER}", "$ArticleNumber")
            $BodyContent = $BodyContent.Replace("{ARTICLE_TITLE}", $ArticleTitle)
            $BodyContent = $BodyContent.Replace("{ARTICLE_URL}", "https://www.bizhack-ai.com/article-$ArticleNumber.html")
            $BodyContent = $BodyContent.Replace("{COMMIT_SHA}", $LatestCommitSha)
            $BodyContent = $BodyContent.Replace("{COMMIT_MSG}", $CommitMsg)
            $mail.Body = $BodyContent
        } else {
            $mail.Body = "Article $ArticleNumber published successfully.`nCommit: $LatestCommitSha"
        }

        $mail.BodyEncoding = [System.Text.Encoding]::UTF8
        $mail.SubjectEncoding = [System.Text.Encoding]::UTF8

        $smtp.Send($mail)
        $mail.Dispose()
        $smtp.Dispose()
        Write-Host "[SUCCESS] Report email sent to $($mailConfig.recipientEmail)!" -ForegroundColor Green
    } catch {
        Write-Host "[WARN] Email notification failed: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}
