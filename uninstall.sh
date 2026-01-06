#!/bin/bash

# macOS WebP Converter - Uninstallation Script
# このスクリプトはWebP変換サービスをアンインストールします

set -e  # エラー時に停止

# 色付き出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  macOS WebP Converter - アンインストール  "
echo "=========================================="
echo ""
echo -e "${YELLOW}警告: 以下のファイルが削除されます：${NC}"
echo "  - ~/Library/Services/WebPに変換.workflow"
echo "  - ~/Scripts/convert_to_webp.sh"
echo "  - ~/Library/Logs/webp_conversion.log"
echo ""
echo "本当にアンインストールしますか？ (y/N)"
read -r response

if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "アンインストールをキャンセルしました。"
    exit 0
fi

echo ""
echo "🗑️  アンインストール中..."

# 1. Automatorサービスを削除
if [ -d ~/Library/Services/WebPに変換.workflow ]; then
    rm -rf ~/Library/Services/WebPに変換.workflow
    echo -e "${GREEN}✓ Automatorサービスを削除しました${NC}"
else
    echo "⚠️  Automatorサービスが見つかりませんでした"
fi

# 2. スクリプトを削除
if [ -f ~/Scripts/convert_to_webp.sh ]; then
    rm ~/Scripts/convert_to_webp.sh
    echo -e "${GREEN}✓ スクリプトを削除しました${NC}"
else
    echo "⚠️  スクリプトが見つかりませんでした"
fi

# 3. ログファイルを削除
if [ -f ~/Library/Logs/webp_conversion.log ]; then
    rm ~/Library/Logs/webp_conversion.log
    echo -e "${GREEN}✓ ログファイルを削除しました${NC}"
else
    echo "⚠️  ログファイルが見つかりませんでした"
fi

# 4. Finderを再起動
echo ""
echo "🔄 Finderを再起動中..."
killall Finder 2>/dev/null || true

echo ""
echo "=========================================="
echo -e "${GREEN}✅ アンインストールが完了しました${NC}"
echo "=========================================="
echo ""
echo "cwebpツールは残っています。"
echo "削除したい場合は以下を実行してください："
echo "  brew uninstall webp"
echo ""
