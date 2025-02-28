# すべての MCP サーバーをセットアップするスクリプト

# 作業ディレクトリを設定
$WORKSPACE_ROOT = $PWD.Path
echo "ワークスペースルート: $WORKSPACE_ROOT"

# 環境の確認
echo "Python バージョン: "
python --version
echo "Node.js バージョン: "
node --version
echo "npm バージョン: "
npm --version

# Python パスの確認
$pythonPath = (Get-Command python).Path
echo "使用する Python のパス: $pythonPath"

# docker-mcp のセットアップ
echo "docker-mcp のセットアップを開始します..."
cd "$WORKSPACE_ROOT/mcp-repos/docker-mcp"
pip install -e .
echo "docker-mcp セットアップ完了"

# mcp-text-editor のセットアップ
echo "mcp-text-editor のセットアップを開始します..."
cd "$WORKSPACE_ROOT/mcp-repos/mcp-text-editor"
pip install -e .
echo "mcp-text-editor セットアップ完了"

# filesystem MCPサーバーのセットアップ
echo "filesystem MCPサーバーのセットアップを開始します..."
cd "$WORKSPACE_ROOT/mcp-repos/servers/src/filesystem"
npm install
echo "filesystem MCPサーバー セットアップ完了"

# github MCPサーバーのセットアップ
echo "github MCPサーバーのセットアップを開始します..."
cd "$WORKSPACE_ROOT/mcp-repos/servers/src/github"
npm install
echo "github MCPサーバー セットアップ完了"

# .cursor/mcp.json の更新
echo "Cursor の設定ファイルを更新しています..."
cd $WORKSPACE_ROOT

# mcp.json の内容
$mcpJson = @"
{
  "servers": {
    "docker-mcp": {
      "command": "python",
      "args": [
        "-m",
        "docker_mcp"
      ],
      "cwd": "\${workspaceRoot}/mcp-repos/docker-mcp"
    },
    "text-editor": {
      "command": "python",
      "args": [
        "-m",
        "mcp_text_editor"
      ],
      "cwd": "\${workspaceRoot}/mcp-repos/mcp-text-editor"
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "ts-node",
        "index.ts"
      ],
      "cwd": "\${workspaceRoot}/mcp-repos/servers/src/filesystem"
    },
    "github": {
      "command": "npx",
      "args": [
        "ts-node",
        "index.ts"
      ],
      "cwd": "\${workspaceRoot}/mcp-repos/servers/src/github"
    }
  }
}
"@

# .cursor ディレクトリがない場合は作成
if (!(Test-Path ".cursor")) {
    New-Item -Path ".cursor" -ItemType Directory
}

# mcp.json ファイルを作成/上書き
$mcpJson | Out-File -FilePath ".cursor/mcp.json" -Encoding utf8

echo "セットアップが完了しました。"
echo ".cursor/mcp.json が以下の場所に作成されました: $WORKSPACE_ROOT/.cursor/mcp.json"
echo "Cursor を再起動して、MCP サーバーを有効にしてください。" 