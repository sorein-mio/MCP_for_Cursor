# TypeScript MCPサーバーセットアップスクリプト

# 作業ディレクトリを設定
$WORKSPACE_ROOT = $PWD.Path
echo "ワークスペースルート: $WORKSPACE_ROOT"

# Node.js環境の確認
echo "Node.js環境のセットアップを開始します..."
echo "Node.js バージョン: "
node --version
echo "npm バージョン: "
npm --version

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

# 元のディレクトリに戻る
cd $WORKSPACE_ROOT
echo "TypeScriptサーバーのセットアップが完了しました。" 