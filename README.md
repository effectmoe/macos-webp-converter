# macOS WebP Converter

[![macOS](https://img.shields.io/badge/macOS-10.14%2B-blue.svg)](https://www.apple.com/macos/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)

macOSのFinder右クリックメニューから、画像ファイルを簡単にWebP形式に変換できるAutomatorサービスです。

## ✨ 特徴

- 🖱️ **右クリックで変換** - Finderの右クリックメニューから直接実行
- 🗑️ **元ファイル自動削除** - 変換後、元のファイルを自動削除
- 📦 **複数ファイル対応** - 一括で複数の画像を変換可能
- 🎨 **高品質変換** - 品質80%で変換（ファイルサイズを大幅削減しながら高画質を維持）
- 📊 **ログ記録** - すべての変換処理をログファイルに記録
- 💾 **メタデータ保持** - 可能な限り元画像のメタデータを保持

## 📸 変換効果

| 形式 | サイズ | 削減率 |
|------|--------|--------|
| JPG (元) | 605 KB | - |
| WebP (変換後) | 55 KB | **91%削減** |

平均70-90%のファイルサイズ削減を実現し、肉眼では判別困難なレベルで高画質を維持します。

## 📋 対応フォーマット

- ✅ JPG / JPEG
- ✅ PNG
- ✅ GIF
- ✅ BMP
- ✅ TIFF / TIF

## 🚀 インストール

### 1行コマンド（推奨）

```bash
git clone https://github.com/effectmoe/macos-webp-converter.git && cd macos-webp-converter && chmod +x install.sh && ./install.sh
```

### 手動インストール

```bash
# 1. リポジトリをクローン
git clone https://github.com/effectmoe/macos-webp-converter.git
cd macos-webp-converter

# 2. インストールスクリプトを実行
chmod +x install.sh
./install.sh
```

## 📖 使い方

### 基本的な使い方

1. **Finderで画像ファイルを選択**（単一または複数）
2. **右クリック**（またはControl+クリック）
3. **「サービス」→「WebPに変換」を選択**
4. **変換完了を待つ**

完了すると、元のファイル（例: `image.jpg`）が削除され、WebPファイル（例: `image.webp`）が作成されます。

### 複数ファイルの一括変換

複数の画像を選択（⌘+クリックまたはShift+クリック）→ 右クリック → 「サービス」→「WebPに変換」

## ⚙️ カスタマイズ

### 変換品質の変更

デフォルトは品質80%です。変更したい場合：

```bash
open -e ~/Scripts/convert_to_webp.sh
```

以下の行を編集：
```bash
/opt/homebrew/bin/cwebp -q 80 -metadata all "$file" -o "$webp_file"
```

`-q 80` を変更：
- `0` - 最低品質（最小ファイルサイズ）
- `100` - 最高品質（最大ファイルサイズ）
- 推奨: `75-85`

### 元ファイルを残す設定

元のファイルを削除せずに残したい場合、スクリプト内の削除処理をコメントアウトしてください。

## 📝 ログの確認

```bash
# 最新50行を表示
tail -50 ~/Library/Logs/webp_conversion.log

# リアルタイムでログを監視
tail -f ~/Library/Logs/webp_conversion.log
```

## 🗑️ アンインストール

```bash
cd macos-webp-converter
./uninstall.sh
```

## 🛠️ システム要件

- **macOS**: 10.14 (Mojave) 以降
- **Homebrew**: 自動インストールされます
- **cwebp**: 自動インストールされます

## 🔧 トラブルシューティング

### サービスメニューに表示されない

```bash
killall Finder
```

### cwebpがインストールされていない

```bash
brew install webp
```

### スクリプトに実行権限がない

```bash
chmod +x ~/Scripts/convert_to_webp.sh
```

詳細なトラブルシューティングは、[ユーザーマニュアル](https://github.com/effectmoe/macos-webp-converter/wiki)を参照してください。

## 📂 ファイル構成

```
macos-webp-converter/
├── README.md
├── LICENSE
├── .gitignore
├── install.sh                    # インストールスクリプト
├── uninstall.sh                  # アンインストールスクリプト
├── scripts/
│   └── convert_to_webp.sh        # 変換スクリプト本体
└── services/
    └── WebPに変換.workflow       # Automatorサービス
```

インストール後のシステム構成：

```
/Users/<username>/
├── Scripts/
│   └── convert_to_webp.sh          # 変換スクリプト本体
├── Library/
│   ├── Services/
│   │   └── WebPに変換.workflow      # Automatorサービス
│   └── Logs/
│       └── webp_conversion.log     # 変換ログ
```

## 🤝 コントリビューション

プルリクエストを歓迎します！大きな変更の場合は、まずissueを開いて変更内容を議論してください。

## 📄 ライセンス

[MIT License](LICENSE)

## 👤 作者

**effectmoe**

- GitHub: [@effectmoe](https://github.com/effectmoe)

## 🙏 謝辞

- [Google WebP](https://developers.google.com/speed/webp) - WebP画像フォーマット
- [Homebrew](https://brew.sh/) - macOSパッケージマネージャー

## 📚 関連リンク

- [WebP公式サイト](https://developers.google.com/speed/webp)
- [cwebpドキュメント](https://developers.google.com/speed/webp/docs/cwebp)
- [Automatorユーザーガイド](https://support.apple.com/ja-jp/guide/automator/welcome/mac)

---

⭐ このプロジェクトが役に立った場合は、GitHubでスターをつけてください！
