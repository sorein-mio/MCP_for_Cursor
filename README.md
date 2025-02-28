# MCP for Cursor

Cursor IDE 用の Model Context Protocol（MCP）ツール集です。このリポジトリは複数の MCP サーバーを簡単にセットアップし、Cursor IDE で AI エージェント機能を強化するためのツールセットを提供します。

[English version below](#mcp-for-cursor-english)

## 概要

このリポジトリには以下の MCP サーバーセットアップが含まれています：

1. **docker-mcp**: Docker 操作を行うための MCP サーバー
2. **mcp-text-editor**: テキストファイル編集のための MCP サーバー（Python 3.13 以上が必要）
3. **filesystem**: ファイルシステム操作用 MCP サーバー
4. **github**: GitHub 操作用 MCP サーバー

## 環境要件

- Python 3.12 以上（docker-mcp 用）
- Python 3.13 以上（mcp-text-editor 用）
- Node.js 18 以上（Node.js 20 以上推奨）
- npm 9 以上
- Git
- Docker（docker-mcp 使用時）

## セットアップ手順

### 1. リポジトリのクローン

```bash
git clone https://github.com/[YOUR_USERNAME]/MCP_for_Cursor.git
cd MCP_for_Cursor
```

### 2. 必要なリポジトリのクローン

```bash
git clone https://github.com/QuantGeekDev/docker-mcp.git mcp-repos/docker-mcp
git clone https://github.com/tumf/mcp-text-editor.git mcp-repos/mcp-text-editor
git clone https://github.com/modelcontextprotocol/servers.git mcp-repos/servers
```

### 3. 依存関係のインストール

#### Python 3.13 のインストール（必要な場合）

Windows 環境では以下のコマンドを実行してインストーラーを起動します：

```powershell
./install-latest-python.ps1
```

#### Node.js 20 のインストール（必要な場合）

Windows 環境では以下のコマンドを実行してインストーラーを起動します：

```powershell
./install-latest-nodejs.ps1
```

### 4. MCP サーバーのセットアップ

以下のコマンドを実行して、すべての MCP サーバーをセットアップします：

```powershell
./setup-all-mcp-servers.ps1
```

または、個別にセットアップする場合：

```powershell
# Pythonベースのサーバー
./setup-mcp-servers.ps1

# TypeScriptベースのサーバー
./setup-typescript-servers.ps1
```

### 5. Cursor の設定

インストールが完了すると、自動的に`.cursor/mcp.json`が作成されます。Cursor を起動し、このプロジェクトを開くだけで、MCP サーバーが自動的に認識されます。

## 使用方法

1. Cursor を起動します
2. このリポジトリをプロジェクトとして開きます
3. Cursor はプロジェクトルートの`.cursor/mcp.json`を検出し、MCP サーバーを自動的に使用可能にします
4. AI エージェントを使用する際に、追加の MCP 機能が利用できるようになります

## トラブルシューティング

### MCP サーバーが動作しない場合

1. 各サーバーを手動で起動してエラーメッセージを確認：

```powershell
# Docker MCP
cd mcp-repos/docker-mcp
python -m docker_mcp

# Text Editor MCP
cd mcp-repos/mcp-text-editor
python -m mcp_text_editor

# Filesystem MCP
cd mcp-repos/servers/src/filesystem
npx ts-node index.ts

# GitHub MCP
cd mcp-repos/servers/src/github
npx ts-node index.ts
```

2. Python および node.js のバージョンを確認：

```powershell
python --version
node --version
npm --version
```

## 関連プロジェクト

- [docker-mcp](https://github.com/QuantGeekDev/docker-mcp)
- [mcp-text-editor](https://github.com/tumf/mcp-text-editor)
- [MCP Servers](https://github.com/modelcontextprotocol/servers)

## ライセンス

各 MCP サーバーは、それぞれのリポジトリで定義されているライセンスに従います。

---

<a id="mcp-for-cursor-english"></a>

# MCP for Cursor (English)

A collection of Model Context Protocol (MCP) tools for Cursor IDE. This repository provides a toolkit to easily set up multiple MCP servers and enhance AI agent functionality in Cursor IDE.

## Overview

This repository includes setup for the following MCP servers:

1. **docker-mcp**: MCP server for Docker operations
2. **mcp-text-editor**: MCP server for text file editing (requires Python 3.13+)
3. **filesystem**: MCP server for filesystem operations
4. **github**: MCP server for GitHub operations

## Requirements

- Python 3.12+ (for docker-mcp)
- Python 3.13+ (for mcp-text-editor)
- Node.js 18+ (Node.js 20+ recommended)
- npm 9+
- Git
- Docker (when using docker-mcp)

## Setup Instructions

### 1. Clone this repository

```bash
git clone https://github.com/[YOUR_USERNAME]/MCP_for_Cursor.git
cd MCP_for_Cursor
```

### 2. Clone required repositories

```bash
git clone https://github.com/QuantGeekDev/docker-mcp.git mcp-repos/docker-mcp
git clone https://github.com/tumf/mcp-text-editor.git mcp-repos/mcp-text-editor
git clone https://github.com/modelcontextprotocol/servers.git mcp-repos/servers
```

### 3. Install dependencies

#### Install Python 3.13 (if needed)

On Windows, run the following command to start the installer:

```powershell
./install-latest-python.ps1
```

#### Install Node.js 20 (if needed)

On Windows, run the following command to start the installer:

```powershell
./install-latest-nodejs.ps1
```

### 4. Set up MCP servers

Run the following command to set up all MCP servers:

```powershell
./setup-all-mcp-servers.ps1
```

Or, to set up servers individually:

```powershell
# Python-based servers
./setup-mcp-servers.ps1

# TypeScript-based servers
./setup-typescript-servers.ps1
```

### 5. Configure Cursor

After installation, `.cursor/mcp.json` will be created automatically. Just start Cursor and open this project to automatically recognize the MCP servers.

## Usage

1. Start Cursor
2. Open this repository as a project
3. Cursor will detect `.cursor/mcp.json` in the project root and make MCP servers available automatically
4. Additional MCP features will be available when using AI agents

## Troubleshooting

### If MCP servers are not working

1. Start each server manually to check for error messages:

```powershell
# Docker MCP
cd mcp-repos/docker-mcp
python -m docker_mcp

# Text Editor MCP
cd mcp-repos/mcp-text-editor
python -m mcp_text_editor

# Filesystem MCP
cd mcp-repos/servers/src/filesystem
npx ts-node index.ts

# GitHub MCP
cd mcp-repos/servers/src/github
npx ts-node index.ts
```

2. Check Python and Node.js versions:

```powershell
python --version
node --version
npm --version
```

## Related Projects

- [docker-mcp](https://github.com/QuantGeekDev/docker-mcp)
- [mcp-text-editor](https://github.com/tumf/mcp-text-editor)
- [MCP Servers](https://github.com/modelcontextprotocol/servers)

## License

Each MCP server follows the license defined in its respective repository.
