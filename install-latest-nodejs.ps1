# Node.js 20 LTS インストーラーのダウンロードとインストール
$nodeUrl = "https://nodejs.org/dist/v20.10.0/node-v20.10.0-x64.msi"
$installerPath = "$env:TEMP\node-v20.10.0-x64.msi"

Write-Host "Node.js 20 LTS インストーラーをダウンロードしています..." -ForegroundColor Green
Invoke-WebRequest -Uri $nodeUrl -OutFile $installerPath

Write-Host "Node.js 20 LTS をインストールしています... (インストーラーが起動したら指示に従ってインストールしてください)" -ForegroundColor Yellow

# インストーラーを実行
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $installerPath, "/quiet", "/norestart" -Wait

Write-Host "Node.js 20 LTS のインストールが完了しました。新しいターミナルを開いて 'node --version' で確認してください。" -ForegroundColor Green 