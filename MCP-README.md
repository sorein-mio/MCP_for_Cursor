# Cursor MCP (Model Context Protocol) サーバー導入手順

このリポジトリには、Cursor IDE 用の MCP サーバーセットアップが含まれています。

## 導入済み MCP サーバー

1. **docker-mcp**: Docker 操作を行うための MCP サーバー ✅
2. **filesystem**: ファイルシステム操作用 MCP サーバー ✅
3. **github**: GitHub 操作用 MCP サーバー ✅
4. **mcp-text-editor**: テキストファイル編集のための MCP サーバー ❌ (Python 3.13 以上が必要)

## 環境要件

- Python 3.12 以上 (docker-mcp 用)
- Python 3.13 以上 (mcp-text-editor 用) - 現在未サポート
- Node.js 18 以上 (Node バージョン 20 以上推奨)
- npm 9 以上
- Git
- Docker (docker-mcp を使用する場合)

## セットアップ状況

- docker-mcp: ✅ セットアップ完了
- filesystem: ✅ セットアップ完了
- github: ✅ セットアップ完了
- mcp-text-editor: ❌ Python 3.13 が必要なため未セットアップ

## セットアップ手順

### 1. リポジトリのクローン

```
git clone https://github.com/QuantGeekDev/docker-mcp.git mcp-repos/docker-mcp
git clone https://github.com/tumf/mcp-text-editor.git mcp-repos/mcp-text-editor
git clone https://github.com/modelcontextprotocol/servers.git mcp-repos/servers
```

### 2. Python サーバーのセットアップ

PowerShell を開き、以下のコマンドを実行します：

```powershell
./setup-mcp-servers.ps1
```

### 3. TypeScript サーバーのセットアップ

```powershell
./setup-typescript-servers.ps1
```

### 4. Cursor の設定

Cursor は`.cursor/mcp.json`を自動的に読み込みます。このファイルは既に作成されており、使用可能な MCP サーバーの設定が含まれています。

## 使用方法

1. Cursor を起動します
2. プロジェクトを開きます（このリポジトリをプロジェクトとして開く）
3. Cursor はプロジェクトルートの`.cursor/mcp.json`を検出し、MCP サーバーを自動的に使用可能にします

## トラブルシューティング

### MCP サーバーが動作しない場合

1. ターミナルから手動でサーバーを起動してエラーメッセージを確認：

```powershell
# Docker MCP
cd mcp-repos/docker-mcp
python -m docker_mcp

# Filesystem MCP
cd mcp-repos/servers/src/filesystem
npx ts-node index.ts

# GitHub MCP
cd mcp-repos/servers/src/github
npx ts-node index.ts
```

2. 依存関係の問題を確認：

```powershell
# Pythonの依存関係
pip list

# Node.jsの依存関係
cd mcp-repos/servers/src/filesystem
npm list

cd mcp-repos/servers/src/github
npm list
```

### Python 3.13 のインストール方法

mcp-text-editor を使用するには、Python 3.13 以上が必要です。以下の手順でインストールできます：

1. [Python 公式サイト](https://www.python.org/downloads/)から最新の Python 3.13 をダウンロード
2. インストーラーを実行して、Python 3.13 をインストール
3. インストール後、再度セットアップスクリプトを実行

### Node.js バージョンの更新

TypeScript サーバーは Node.js 20 以上を推奨していますが、Node.js 18 でも動作します。最新の Node.js にアップデートするには：

1. [Node.js 公式サイト](https://nodejs.org/)から最新の LTS 版をダウンロード
2. インストーラーを実行
3. インストール後、再度 TypeScript セットアップスクリプトを実行

## 詳細情報

各 MCP サーバーの詳細については、以下のリポジトリを参照してください：

- [docker-mcp](https://github.com/QuantGeekDev/docker-mcp)
- [mcp-text-editor](https://github.com/tumf/mcp-text-editor)
- [MCP Servers](https://github.com/modelcontextprotocol/servers)
