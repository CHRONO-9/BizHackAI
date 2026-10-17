# BizHack AI - Sidebar and Footer Migration Script
# 100% ASCII-only code to prevent CP932 encoding issues on Windows PowerShell 5.1

$WorkspaceRoot = "c:\Users\k_mil\Desktop\BzhackAI"
$SidebarTpl = [System.IO.File]::ReadAllText("$WorkspaceRoot\config\templates\sidebar-dynamic.html", [System.Text.Encoding]::UTF8)
$FooterTpl  = [System.IO.File]::ReadAllText("$WorkspaceRoot\config\templates\footer-categories.html", [System.Text.Encoding]::UTF8)

$TargetFiles = @(
    "$WorkspaceRoot\article-template.html"
) + (Get-ChildItem -Path "$WorkspaceRoot" -Filter "article-*.html").FullName + (Get-ChildItem -Path "$WorkspaceRoot\drafts" -Filter "article-*.html").FullName

Write-Host "Found $($TargetFiles.Count) files to inspect."

foreach ($filePath in $TargetFiles) {
    if (-not (Test-Path $filePath)) { continue }
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    $origContent = $content

    # 1. Add articles-data.js script tag if not present
    if ($content -notmatch "articles-data\.js") {
        $content = [regex]::Replace($content, '(<script src="js/main\.js(?:\?v=[^"]*)?"></script>)', {
            param($m)
            "<script src=`"js/articles-data.js?v=20261017b`"></script>`n  " + $m.Groups[1].Value
        })
    }
    # Update cache buster on main.js
    $content = [regex]::Replace($content, 'js/main\.js\?v=[^"]*', 'js/main.js?v=20261017b')

    # 2. Replace sidebar card matching recent-article-item structure
    $SidebarPattern = '(?s)(<!--[^\n]*-->\s*)?<div class="sidebar-card"[^>]*>\s*<div class="sidebar-title">.*?</div>(?:\s*<div class="recent-article-item".*?</div>)+\s*</div>'
    if ($content -match $SidebarPattern) {
        $content = [regex]::Replace($content, $SidebarPattern, { param($m) $SidebarTpl.Trim() })
    }

    # 3. Replace footer categories col matching article-1.html in footer-links
    $FooterPattern = '(?s)<div class="footer-col">\s*<h4>.*?</h4>\s*<ul class="footer-links">\s*<li><a href="article-1\.html".*?</ul>\s*</div>'
    if ($content -match $FooterPattern) {
        $content = [regex]::Replace($content, $FooterPattern, { param($m) $FooterTpl.Trim() })
    }

    if ($content -ne $origContent) {
        [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated: $(Split-Path $filePath -Leaf)" -ForegroundColor Green
    } else {
        Write-Host "Skipped (no change or already migrated): $(Split-Path $filePath -Leaf)" -ForegroundColor Yellow
    }
}
Write-Host "Migration completed!" -ForegroundColor Cyan
