# Python 3.13 インストーラーのダウンロードとインストール
$pythonUrl = "https://www.python.org/ftp/python/3.13.0/python-3.13.0-amd64.exe"
$installerPath = "$env:TEMP\python-3.13.0-amd64.exe"

Write-Host "Python 3.13 インストーラーをダウンロードしています..." -ForegroundColor Green
Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath

Write-Host "Python 3.13 をインストールしています... (インストーラーが起動したら指示に従ってインストールしてください)" -ForegroundColor Yellow
Write-Host "※ インストール時に [Add python.exe to PATH] のチェックボックスをオンにしてください" -ForegroundColor Red
Write-Host "※ [Customize installation] で最後まで進み、[Install for all users] を選択することをお勧めします" -ForegroundColor Red

# インストーラーを実行
Start-Process -FilePath $installerPath -Wait

Write-Host "Python 3.13 のインストールが完了しました。新しいターミナルを開いて 'python --version' で確認してください。" -ForegroundColor Green 