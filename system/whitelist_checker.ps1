if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
    Write-Host "curl not installed!"
    pause
    exit
}

Get-Content "whitelist.txt" | ForEach-Object {
    Write-Host "Checking $_... " -NoNewline
    $response = ((curl.exe -k "https://$_/100MB.bin" -o NUL -r 0-65536 -s --connect-to "::5.78.7.195" --max-time 5 --connect-timeout 5 --show-error -w "%{http_code}" 2>&1) -join "`n")
    if ($response.EndsWith("000")) {

        Write-Host $response.Substring(0, $response.Length - 3).Trim() -ForegroundColor Red
    } else {
        Write-Host $response -ForegroundColor Green
    }
}