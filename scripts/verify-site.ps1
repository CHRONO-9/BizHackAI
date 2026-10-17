# BizHack AI Site Quality & Consistency Checker
# ASCII-only comments to prevent encoding issues on Windows PowerShell

$htmlFiles = Get-ChildItem -Path . -Filter "*.html" | Where-Object { $_.Name -ne "bookmarklet.html" }
$errorsFound = 0

Write-Host "=========================================================="
Write-Host "   BizHack AI Site Quality Checker"
Write-Host "=========================================================="

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $filename = $file.Name
    $isTemplate = ($filename -eq "article-template.html")
    $fileErrors = New-Object System.Collections.Generic.List[string]

    # 1. Check CSS Link
    if ($content.IndexOf('href="css/style.css') -ge 0) {
        if (-not (Test-Path "css/style.css")) {
            $fileErrors.Add("CSS file missing: css/style.css")
        }
    } elseif ($content.IndexOf("css/") -ge 0) {
        $fileErrors.Add("Invalid CSS path detected (expected css/style.css)")
    } else {
        $fileErrors.Add("No CSS link found")
    }

    # 2. Check Google AdSense code
    if ($content.IndexOf("ca-pub-4599027497639401") -lt 0) {
        $fileErrors.Add("Google AdSense code missing")
    }

    # 3. Check Article Specific Requirements
    if ($filename.StartsWith("article-")) {
        # Check Google Analytics (gtag.js)
        if ($content.IndexOf("G-PXPDE46RFR") -lt 0) {
            $fileErrors.Add("Google Analytics (gtag.js) missing")
        }

        # Check Required Layout Containers
        if ($content.IndexOf('class="main-wrapper"') -lt 0) {
            $fileErrors.Add(".main-wrapper container missing")
        }
        if ($content.IndexOf('class="article-layout"') -lt 0) {
            $fileErrors.Add(".article-layout container missing")
        }
        if ($content.IndexOf('class="article-main"') -lt 0) {
            $fileErrors.Add(".article-main container missing")
        }
        if ($content.IndexOf('class="article-sidebar"') -lt 0) {
            $fileErrors.Add(".article-sidebar container missing")
        }
        if ($content.IndexOf('id="sidebar-latest-articles"') -lt 0 -and $content.IndexOf('data-dynamic="articles"') -lt 0) {
            $fileErrors.Add("Dynamic sidebar container (#sidebar-latest-articles) missing")
        }
        if ($content.IndexOf('articles-data.js') -lt 0) {
            $fileErrors.Add("js/articles-data.js script missing")
        }

        # Check PR disclosure bar
        if ($content.IndexOf('pr-disclosure-bar') -lt 0 -and $content.IndexOf('ad-disclosure-bar') -lt 0) {
            $fileErrors.Add("PR disclosure bar missing")
        }

        # Check for unreplaced template placeholders
        if (-not $isTemplate) {
            if ($content.IndexOf("{{") -ge 0 -and $content.IndexOf("}}") -ge 0) {
                $fileErrors.Add("Unreplaced template placeholder found")
            }
        }

        # Check Affiliate Tracking Pixels
        if ($content.IndexOf("px.a8.net") -ge 0) {
            if ($content.IndexOf("0.gif") -lt 0) {
                $fileErrors.Add("A8 1px tracking pixel missing")
            }
            if ($content.IndexOf('rel="nofollow"') -lt 0) {
                $fileErrors.Add("rel=nofollow missing on affiliate link")
            }
        }
    }

    # Output Results
    if ($fileErrors.Count -eq 0) {
        Write-Host " [PASS] $filename" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] $filename" -ForegroundColor Red
        foreach ($err in $fileErrors) {
            Write-Host "        $err" -ForegroundColor Red
            $errorsFound++
        }
    }
}

Write-Host "----------------------------------------------------------"
if ($errorsFound -eq 0) {
    Write-Host "All files passed quality check. (Errors: 0)" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Quality check failed with $errorsFound error(s)." -ForegroundColor Red
    exit 1
}
