if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
    Write-Host "curl not installed!"
    pause
    exit
}

Get-Content "autohosts.txt" | ForEach-Object {
    Write-Host "Checking $_... " -NoNewline
    $response = ((curl.exe --connect-timeout 5 --max-time 5 -s --show-error -o NUL -w "%{http_code}" "https://$_" 2>&1) -join "`n")
    if ($response.EndsWith("000")) {
        Write-Host $response.Substring(0, $response.Length - 3).Trim() -ForegroundColor Red
    } else {
        Write-Host $response -ForegroundColor Green
    }
}