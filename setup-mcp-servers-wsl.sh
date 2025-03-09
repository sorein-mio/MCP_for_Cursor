#!/bin/bash
# スクリプト名: setup-mcp-servers-wsl.sh
# 説明: このスクリプトは、WSL環境でCursorのMCPサーバーを導入するためのセットアップを行います。
#        WSL環境かどうかのチェック、Node.jsおよびPython3のインストール、各MCPサーバーの初期セットアップを実施します。
#        なお、システム管理下のPythonはapt経由で提供されるため自動アップデートは行いません。
#        もし最新のPython (>=3.13) を利用したい場合は、オプション --upgrade-python を渡すと、pyenvを用いてユーザーレベルでアップデートを試みます。
#        すべての出力はoutput.logへ記録されます。



echo "----- MCP Servers Setup for WSL Environment -----"
echo "開始時刻: $(date)"

# WSL環境かどうか確認
if grep -qi "microsoft" /proc/version; then
    echo "WSL環境が検出されました。"
else
    echo "WSL環境ではありません。WSL環境でスクリプトを実行してください。"
    exit 1
fi

# パッケージリストの更新
echo "aptリポジトリの更新中..."
sudo apt update

# Node.jsのインストールチェック
if ! command -v node >/dev/null; then
    echo "Node.jsがインストールされていません。インストールを開始します..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.jsは既にインストールされています: $(node -v)"
fi

# Python3のインストールチェック
if ! command -v python3 >/dev/null; then
    echo "Python3がインストールされていません。インストールを開始します..."
    sudo apt-get install -y python3 python3-pip
else
    echo "Python3は既にインストールされています: $(python3 --version)"
fi

# オプション: --upgrade-python が渡された場合、pyenvを用いてPythonをアップデートする
if [ "$1" = "--upgrade-python" ]; then
    echo "オプション --upgrade-python が指定されました。pyenvを使用してPythonのアップデートを試みます..."
    if ! command -v pyenv >/dev/null; then
        echo "pyenv が見つかりません。pyenv のインストールを開始します..."
        # 依存関係のインストール (python-opensslは削除)
        sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
                                 libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                                 libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git
        curl https://pyenv.run | bash
        export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"
        # pyenv の初期化
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi
    # インストールするPythonバージョンを指定 (例: 3.13.0)
    TARGET_PYTHON="3.13.0"
    if pyenv versions | grep -q "$TARGET_PYTHON"; then
        echo "Python $TARGET_PYTHON は既にインストールされています。"
    else
        echo "Python $TARGET_PYTHON をインストールします..."
        pyenv install $TARGET_PYTHON
    fi
    pyenv global $TARGET_PYTHON
    echo "Python バージョンを更新しました: $(python --version)"
fi

echo "----- MCPサーバーのセットアップ開始 -----"

# 例: mcp-repos/docker-mcp のセットアップ
if [ -d "mcp-repos/docker-mcp" ]; then
    echo "docker-mcp サーバーのセットアップを開始します..."
    pushd mcp-repos/docker-mcp && {
        if [ -f "package.json" ]; then
            echo "Node.jsプロジェクトとして認識: npm install を実行します..."
            npm install
            echo "npm run build を実行します..."
            npm run build
        elif [ -f "pyproject.toml" ]; then
            echo "Pythonプロジェクトとして認識: pip install -e . --break-system-packages を実行します..."
            pip install -e . --break-system-packages
        else
            echo "package.json や pyproject.toml が見つかりません。docker-mcpのセットアップをスキップします。"
        fi
        popd
    }
else
    echo "mcp-repos/docker-mcp ディレクトリが見つかりません。"
fi

# 例: mcp-repos/mcp-text-editor のセットアップ
if [ -d "mcp-repos/mcp-text-editor" ]; then
    echo "mcp-text-editor サーバーのセットアップを開始します..."
    pushd mcp-repos/mcp-text-editor && {
        if [ -f "package.json" ]; then
            echo "Node.jsプロジェクトとして認識: npm install を実行します..."
            npm install
        elif [ -f "pyproject.toml" ]; then
            echo "Pythonプロジェクトとして認識"
            PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" )
            if [[ "$PYTHON_VERSION" < "3.13" ]]; then
                echo "Pythonバージョン $PYTHON_VERSION は mcp-text-editor の必要条件 (>=3.13) を満たしていません。インストールをスキップします。"
            else
                echo "pip install -e . --break-system-packages を実行します..."
                pip install -e . --break-system-packages
            fi
        else
            echo "package.json や pyproject.toml が見つかりません。mcp-text-editorのセットアップをスキップします。"
        fi
        popd
    }
else
    echo "mcp-repos/mcp-text-editor ディレクトリが見つかりません。"
fi

echo "----- MCPサーバーのセットアップ完了 -----"
echo "完了時刻: $(date)"
