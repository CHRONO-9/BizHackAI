# ==============================================================================
# BizHack AI - GA4 Data API Summary Fetcher (get-ga4-summary.ps1)
# 100% ASCII-only code to prevent Windows PowerShell 5.1 CP932 encoding issues.
# Reads credentials from config/ga4-credentials.json
# Property ID: 558928664
# ==============================================================================

param(
    [string]$PropertyId = "558928664",
    [string]$CredentialsPath = "config\ga4-credentials.json"
)

function Base64UrlEncode([byte[]]$bytes) {
    [Convert]::ToBase64String($bytes).Replace('+', '-').Replace('/', '_').Replace('=', '')
}

function Get-GA4AccessToken([string]$jsonPath) {
    if (-not (Test-Path $jsonPath)) { return $null }
    $cred = Get-Content -Raw $jsonPath | ConvertFrom-Json
    if (-not $cred.private_key -or -not $cred.client_email) { return $null }

    # Clean PEM private key
    $privKeyPem = $cred.private_key
    $privKeyBase64 = $privKeyPem -replace '-----BEGIN [A-Z ]+-----', '' -replace '-----END [A-Z ]+-----', '' -replace '\s+', ''
    $keyBytes = [Convert]::FromBase64String($privKeyBase64)

    # Import PKCS#8 key into RSACng
    $cngKey = [System.Security.Cryptography.CngKey]::Import($keyBytes, [System.Security.Cryptography.CngKeyBlobFormat]::Pkcs8PrivateBlob)
    $rsa = New-Object System.Security.Cryptography.RSACng($cngKey)

    # Create JWT Header and Claims
    $nowEpoch = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $headerJson = '{"alg":"RS256","typ":"JWT"}'
    $headerB64 = Base64UrlEncode([System.Text.Encoding]::UTF8.GetBytes($headerJson))

    $claims = @{
        iss = $cred.client_email
        scope = "https://www.googleapis.com/auth/analytics.readonly"
        aud = "https://oauth2.googleapis.com/token"
        exp = $nowEpoch + 3600
        iat = $nowEpoch
    }
    $claimsJson = $claims | ConvertTo-Json -Compress
    $claimsB64 = Base64UrlEncode([System.Text.Encoding]::UTF8.GetBytes($claimsJson))

    # Sign JWT
    $unsignedToken = "$headerB64.$claimsB64"
    $signatureBytes = $rsa.SignData([System.Text.Encoding]::UTF8.GetBytes($unsignedToken), [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)
    $sigB64 = Base64UrlEncode($signatureBytes)
    $jwt = "$unsignedToken.$sigB64"

    # Exchange JWT for Access Token
    $body = @{
        grant_type = "urn:ietf:params:oauth:grant-type:jwt-bearer"
        assertion = $jwt
    }
    $tokenRes = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
    return $tokenRes.access_token
}

function Get-GA4Metrics([string]$accessToken, [string]$propId) {
    if (-not $accessToken) { return $null }
    $headers = @{
        Authorization = "Bearer $accessToken"
        "Content-Type" = "application/json"
    }

    $reportUrl = "https://analyticsdata.googleapis.com/v1beta/properties/$propId`:runReport"

    # Query 1: Yesterday overall summary
    $summaryBody = @{
        dateRanges = @(@{ startDate = "yesterday"; endDate = "yesterday" })
        metrics = @(
            @{ name = "screenPageViews" },
            @{ name = "activeUsers" },
            @{ name = "userEngagementDuration" }
        )
    } | ConvertTo-Json -Depth 5

    $summaryRes = Invoke-RestMethod -Uri $reportUrl -Method Post -Headers $headers -Body $summaryBody

    $views = if ($summaryRes.rows -and $summaryRes.rows[0].metricValues) { $summaryRes.rows[0].metricValues[0].value } else { "0" }
    $users = if ($summaryRes.rows -and $summaryRes.rows[0].metricValues) { $summaryRes.rows[0].metricValues[1].value } else { "0" }
    $totalEngSec = if ($summaryRes.rows -and $summaryRes.rows[0].metricValues) { [int]$summaryRes.rows[0].metricValues[2].value } else { 0 }
    $avgEngSec = if ([int]$users -gt 0) { [math]::Round($totalEngSec / [int]$users) } else { 0 }
    $minPart = [math]::Floor($avgEngSec / 60)
    $secPart = $avgEngSec % 60

    # Query 2: Top 3 articles
    $topPagesBody = @{
        dateRanges = @(@{ startDate = "yesterday"; endDate = "yesterday" })
        dimensions = @(@{ name = "pageTitle" })
        metrics = @(@{ name = "screenPageViews" })
        limit = 3
        orderBys = @(@{ metric = @{ metricName = "screenPageViews" }; desc = $true })
    } | ConvertTo-Json -Depth 5

    $topPagesRes = Invoke-RestMethod -Uri $reportUrl -Method Post -Headers $headers -Body $topPagesBody
    $topPagesList = @()
    if ($topPagesRes.rows) {
        $zenBar = [System.Text.Encoding]::UTF8.GetString([byte[]]@(0xEF, 0xBD, 0x9C))
        foreach ($row in $topPagesRes.rows) {
            $rawTitle = $row.dimensionValues[0].value
            $cleanTitle = $rawTitle.Split('|')[0]
            if ($cleanTitle.Contains($zenBar)) {
                $cleanTitle = $cleanTitle.Substring(0, $cleanTitle.IndexOf($zenBar))
            }
            $cleanTitle = $cleanTitle.Trim()
            $cnt = $row.metricValues[0].value
            $topPagesList += "  - $cleanTitle ($cnt PV)"
        }
    }
    $topPagesText = if ($topPagesList.Count -gt 0) { $topPagesList -join "`n" } else { "  - None" }

    # Query 3: prompt_copy events
    $eventBody = @{
        dateRanges = @(@{ startDate = "yesterday"; endDate = "yesterday" })
        dimensions = @(@{ name = "eventName" })
        metrics = @(@{ name = "eventCount" })
        dimensionFilter = @{
            filter = @{
                fieldName = "eventName"
                stringFilter = @{ value = "prompt_copy" }
            }
        }
    } | ConvertTo-Json -Depth 5

    $eventRes = Invoke-RestMethod -Uri $reportUrl -Method Post -Headers $headers -Body $eventBody
    $copyCount = if ($eventRes.rows -and $eventRes.rows[0].metricValues) { $eventRes.rows[0].metricValues[0].value } else { "0" }

    # Query 4: Domestic Japan access regions
    $regionBody = @{
        dateRanges = @(@{ startDate = "yesterday"; endDate = "yesterday" })
        dimensions = @(@{ name = "region" }, @{ name = "city" })
        metrics = @(@{ name = "activeUsers" }, @{ name = "screenPageViews" })
        dimensionFilter = @{
            filter = @{
                fieldName = "country"
                stringFilter = @{ value = "Japan" }
            }
        }
        limit = 5
        orderBys = @(@{ metric = @{ metricName = "screenPageViews" }; desc = $true })
    } | ConvertTo-Json -Depth 5

    $regionRes = Invoke-RestMethod -Uri $reportUrl -Method Post -Headers $headers -Body $regionBody
    $regionList = @()

    $prefJsonPath = Join-Path "C:\Users\k_mil\Desktop\BzhackAI" "config\prefectures.json"
    $prefMap = if (Test-Path $prefJsonPath) { [System.IO.File]::ReadAllText($prefJsonPath, [System.Text.Encoding]::UTF8) | ConvertFrom-Json } else { $null }
    $meiStr = [System.Text.Encoding]::UTF8.GetString([byte[]]@(0x20, 0xE5, 0x90, 0x8D))

    if ($regionRes.rows) {
        foreach ($row in $regionRes.rows) {
            $rawRegion = $row.dimensionValues[0].value
            $rawCity = $row.dimensionValues[1].value
            $u = $row.metricValues[0].value
            $v = $row.metricValues[1].value

            if ($rawRegion -eq "(not set)") { continue }

            $prefName = if ($prefMap -and $prefMap.PSObject.Properties[$rawRegion]) { $prefMap."$rawRegion" } else { $rawRegion }
            $locStr = if ($rawCity -and $rawCity -ne "(not set)") { "$prefName ($rawCity)" } else { $prefName }
            $regionList += "  - $locStr ($v PV / $u$meiStr)"
        }
    }
    $noneRegion = [System.Text.Encoding]::UTF8.GetString([byte[]]@(0x20, 0x20, 0x2D, 0x20, 0xE5, 0x9B, 0xBD, 0xE5, 0x86, 0x85, 0xE3, 0x82, 0xA2, 0xE3, 0x82, 0xAF, 0xE3, 0x82, 0xBB, 0xE3, 0x82, 0xB9, 0xE9, 0x9B, 0x86, 0xE8, 0xA8, 0x88, 0xE4, 0xB8, 0xAD))
    $regionText = if ($regionList.Count -gt 0) { $regionList -join "`n" } else { $noneRegion }

    return @{
        Views = $views
        Users = $users
        MinPart = $minPart
        SecPart = $secPart
        TopPages = $topPagesText
        PromptCopies = $copyCount
        Regions = $regionText
    }
}

function Get-GA4MetricsBlock([string]$WorkspaceRoot = "C:\Users\k_mil\Desktop\BzhackAI", [string]$CredentialsPath = "config\ga4-credentials.json", [string]$PropertyId = "558928664") {
    $FullCredPath = Join-Path $WorkspaceRoot $CredentialsPath

    if (-not (Test-Path $FullCredPath)) {
        Write-Host "[INFO] GA4 credentials ($CredentialsPath) not configured yet." -ForegroundColor Yellow
        return ""
    }

    try {
        $token = Get-GA4AccessToken -jsonPath $FullCredPath
        if (-not $token) {
            Write-Host "[WARN] Could not retrieve GA4 access token." -ForegroundColor Yellow
            return ""
        }

        $metrics = Get-GA4Metrics -accessToken $token -propId $PropertyId
        if (-not $metrics) { return "" }

        $tplPath = Join-Path $WorkspaceRoot "config\templates\ga4-mail-block.txt"
        if (Test-Path $tplPath) {
            $block = [System.IO.File]::ReadAllText($tplPath, [System.Text.Encoding]::UTF8)
            $block = $block.Replace("{GA4_VIEWS}", "$($metrics.Views)")
            $block = $block.Replace("{GA4_USERS}", "$($metrics.Users)")
            $block = $block.Replace("{GA4_AVG_MIN}", "$($metrics.MinPart)")
            $block = $block.Replace("{GA4_AVG_SEC}", "$($metrics.SecPart)")
            $block = $block.Replace("{GA4_COPIES}", "$($metrics.PromptCopies)")
            $block = $block.Replace("{GA4_REGIONS}", "$($metrics.Regions)")
            $block = $block.Replace("{GA4_TOP_ARTICLES}", "$($metrics.TopPages)")
            return $block
        }
        return ""
    } catch {
        Write-Host "[WARN] GA4 query failed: $($_.Exception.Message)" -ForegroundColor Yellow
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $errBody = $reader.ReadToEnd()
            if ($errBody -match "PERMISSION_DENIED") {
                Write-Host "[INFO] Please add service account to GA4 Property (558928664) Access Management as Viewer." -ForegroundColor Yellow
            } else {
                Write-Host "[DEBUG] $errBody" -ForegroundColor Red
            }
        }
        return ""
    }
}

# Run when executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Get-GA4MetricsBlock
}
