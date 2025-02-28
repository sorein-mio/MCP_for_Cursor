# MCPサーバーセットアップスクリプト

# 作業ディレクトリを設定
$WORKSPACE_ROOT = $PWD.Path
echo "ワークスペースルート: $WORKSPACE_ROOT"

# Python環境の設定
echo "Python環境のセットアップを開始します..."
echo "Python バージョン: "
python --version

# docker-mcpのセットアップ
echo "docker-mcpのセットアップを開始します..."
cd "$WORKSPACE_ROOT/mcp-repos/docker-mcp"
pip install -e .
echo "docker-mcp セットアップ完了"

# mcp-text-editorのセットアップ
echo "mcp-text-editorのセットアップを開始します..."
cd "$WORKSPACE_ROOT/mcp-repos/mcp-text-editor"
pip install -e .
echo "mcp-text-editor セットアップ完了"

# 元のディレクトリに戻る
cd $WORKSPACE_ROOT
echo "セットアップが完了しました。"

# Cursor設定を確認
echo ".cursor/mcp.json が以下の場所に作成されました: $WORKSPACE_ROOT/.cursor/mcp.json"
echo "Cursorを再起動して、MCPサーバーを有効にしてください。" 