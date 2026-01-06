#!/bin/bash

# WebP変換スクリプト
# 選択されたファイルをWebP形式に変換し、元のファイルを置き換えます

# ログファイル
LOG_FILE="$HOME/Library/Logs/webp_conversion.log"

# ログ関数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== WebP変換開始 ==="
log "受け取った引数の数: $#"

for file in "$@"; do
    log "処理中のファイル: $file"

    # ファイルが存在するか確認
    if [ ! -f "$file" ]; then
        log "エラー: ファイルが見つかりません: $file"
        continue
    fi

    # 拡張子を取得
    extension="${file##*.}"
    filename="${file%.*}"
    # 拡張子を小文字に変換（macOS互換）
    extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    log "拡張子: $extension (小文字: $extension_lower), ベース名: $filename"

    # サポートされている画像形式か確認
    case "$extension_lower" in
        jpg|jpeg|png|gif|bmp|tiff|tif)
            # WebPファイルのパス
            webp_file="${filename}.webp"
            log "変換先: $webp_file"

            # cwebpで変換（品質80、メタデータ保持）
            log "cwebpを実行中..."
            if /opt/homebrew/bin/cwebp -q 80 -metadata all "$file" -o "$webp_file" 2>&1 | tee -a "$LOG_FILE"; then
                log "変換成功: $file → $webp_file"

                # WebPファイルが実際に作成されたか確認
                if [ -f "$webp_file" ]; then
                    log "WebPファイルの存在を確認しました"

                    # 元のファイルを削除
                    log "元のファイルを削除中: $file"
                    if rm -f "$file"; then
                        log "削除成功: $file"
                    else
                        log "エラー: 削除に失敗しました: $file (終了コード: $?)"
                    fi
                else
                    log "エラー: WebPファイルが作成されませんでした: $webp_file"
                fi
            else
                log "エラー: 変換に失敗しました: $file (終了コード: $?)"
            fi
            ;;
        webp)
            log "スキップ: すでにWebP形式です: $file"
            ;;
        *)
            log "スキップ: サポートされていない形式です: $file (.$extension)"
            ;;
    esac
done

log "=== WebP変換完了 ==="

# 完了通知
osascript -e 'display notification "WebP変換が完了しました" with title "画像変換"'
