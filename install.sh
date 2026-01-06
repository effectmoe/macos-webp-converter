#!/bin/bash

# macOS WebP Converter - Installation Script
# このスクリプトはWebP変換サービスをインストールします

set -e  # エラー時に停止

# 色付き出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================"
echo "  macOS WebP Converter - インストール  "
echo "========================================"
echo ""

# 1. Homebrewのチェックとインストール
echo "📦 Homebrewを確認中..."
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrewがインストールされていません。${NC}"
    echo "Homebrewをインストールしますか？ (y/N)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Homebrewをインストールしています..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Apple Silicon Macの場合、PATHを追加
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo -e "${RED}エラー: Homebrewが必要です。${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓ Homebrewがインストールされています${NC}"
fi

# 2. cwebpのチェックとインストール
echo ""
echo "🖼️  cwebpを確認中..."
if ! command -v cwebp &> /dev/null; then
    echo "cwebpをインストールしています..."
    brew install webp
    echo -e "${GREEN}✓ cwebpをインストールしました${NC}"
else
    echo -e "${GREEN}✓ cwebpがインストールされています${NC}"
fi

# 3. 必要なディレクトリを作成
echo ""
echo "📁 ディレクトリを作成中..."
mkdir -p ~/Scripts
mkdir -p ~/Library/Logs
mkdir -p ~/Library/Services
echo -e "${GREEN}✓ ディレクトリを作成しました${NC}"

# 4. スクリプトをコピー
echo ""
echo "📄 スクリプトをコピー中..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "$SCRIPT_DIR/scripts/convert_to_webp.sh" ~/Scripts/
chmod +x ~/Scripts/convert_to_webp.sh
echo -e "${GREEN}✓ スクリプトをコピーしました${NC}"

# 5. Automatorサービスをコピー
echo ""
echo "⚙️  Automatorサービスをインストール中..."
cp -R "$SCRIPT_DIR/services/WebPに変換.workflow" ~/Library/Services/
chmod -R 755 ~/Library/Services/WebPに変換.workflow
echo -e "${GREEN}✓ Automatorサービスをインストールしました${NC}"

# 6. Finderを再起動
echo ""
echo "🔄 Finderを再起動中..."
killall Finder 2>/dev/null || true
echo -e "${GREEN}✓ Finderを再起動しました${NC}"

# 7. 完了メッセージ
echo ""
echo "========================================"
echo -e "${GREEN}✅ インストールが完了しました！${NC}"
echo "========================================"
echo ""
echo "使い方："
echo "1. Finderで画像ファイルを選択"
echo "2. 右クリック → サービス → 「WebPに変換」"
echo ""
echo "アンインストール："
echo "  ./uninstall.sh を実行してください"
echo ""
echo "詳細なマニュアル："
echo "  https://github.com/tonychustudio/macos-webp-converter"
echo ""
