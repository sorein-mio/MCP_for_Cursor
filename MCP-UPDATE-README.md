# Python 3.13 および Node.js 20 へのアップデートと MCP サーバー導入手順

このドキュメントでは、Python 3.13 と Node.js 20 LTS へのアップデート方法と、すべての MCP サーバーを導入する手順について説明します。

## 手順の概要

1. Python 3.13 をインストール
2. Node.js 20 LTS をインストール
3. すべての MCP サーバーをセットアップ
4. Cursor を再起動して設定を反映

## 1. Python 3.13 のインストール

Python 3.13 は、`mcp-text-editor` サーバーに必要です。以下のように進めます：

1. PowerShell を管理者権限で開きます
2. 次のコマンドを実行して、Python 3.13 インストーラーをダウンロードし実行します：

```powershell
./install-latest-python.ps1
```

3. インストーラーが起動したら、以下の点に注意してインストールを完了します：

   - **[Add python.exe to PATH]** のチェックボックスを必ずオンにしてください
   - **[Customize installation]** をクリックし、最後まで進んで **[Install for all users]** を選択することをお勧めします

4. インストールが完了したら、新しい PowerShell ウィンドウを開いて、以下のコマンドで Python 3.13 がインストールされたことを確認します：

```powershell
python --version
```

## 2. Node.js 20 LTS のインストール

Node.js 20 LTS は、TypeScript ベースの MCP サーバーに推奨されています：

1. PowerShell を管理者権限で開きます
2. 次のコマンドを実行して、Node.js 20 LTS インストーラーをダウンロードし実行します：

```powershell
./install-latest-nodejs.ps1
```

3. インストーラーが自動的にインストールを完了します
4. インストールが完了したら、新しい PowerShell ウィンドウを開いて、以下のコマンドで Node.js 20 がインストールされたことを確認します：

```powershell
node --version
npm --version
```

## 3. すべての MCP サーバーのセットアップ

Python 3.13 と Node.js 20 のインストールが完了したら、すべての MCP サーバーをセットアップします：

1. 新しい PowerShell ウィンドウを開きます（新しいパスを反映させるため）
2. プロジェクトのルートディレクトリに移動します
3. 次のコマンドを実行して、すべての MCP サーバーをセットアップします：

```powershell
./setup-all-mcp-servers.ps1
```

4. このスクリプトは、以下のことを行います：
   - docker-mcp のセットアップ
   - mcp-text-editor のセットアップ（Python 3.13 を使用）
   - filesystem MCP サーバーのセットアップ
   - github MCP サーバーのセットアップ
   - Cursor の設定ファイル (.cursor/mcp.json) の更新

## 4. Cursor の再起動と設定の反映

1. Cursor を終了します（すでに起動していた場合）
2. Cursor を再起動します
3. このプロジェクトを開きます
4. Cursor は自動的に `.cursor/mcp.json` を検出し、すべての MCP サーバーを使用可能にします

## トラブルシューティング

### セットアップ中にエラーが発生した場合

1. Python のバージョンを確認します：

```powershell
python --version
```

Python 3.13 が表示されることを確認します。違うバージョンが表示される場合は、PATH の設定を見直してください。

2. Node.js のバージョンを確認します：

```powershell
node --version
```

Node.js 20.x が表示されることを確認します。

3. 各 MCP サーバーを個別にテストします：

```powershell
# docker-mcp のテスト
cd mcp-repos/docker-mcp
python -m docker_mcp

# mcp-text-editor のテスト
cd mcp-repos/mcp-text-editor
python -m mcp_text_editor

# filesystem のテスト
cd mcp-repos/servers/src/filesystem
npx ts-node index.ts

# github のテスト
cd mcp-repos/servers/src/github
npx ts-node index.ts
```

## 注意事項

- Python 3.13 をインストールしても、既存の Python 3.12 環境は引き続き利用できます
- MCP サーバーは、Cursor の Agent 機能と連携して動作します
- 各 MCP サーバーの詳細については、それぞれのリポジトリドキュメントを参照してください
