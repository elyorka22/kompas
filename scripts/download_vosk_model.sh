#!/usr/bin/env bash
# Downloads the offline Russian Vosk model into assets/models/.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST_DIR="$ROOT/assets/models"
MODEL_NAME="vosk-model-small-ru-0.22"
ZIP_NAME="${MODEL_NAME}.zip"
DEST_ZIP="$DEST_DIR/$ZIP_NAME"

URLS=(
  "https://huggingface.co/localstack/vosk-models/resolve/main/${ZIP_NAME}"
  "https://huggingface.co/rhasspy/vosk-models/resolve/main/ru/${ZIP_NAME}"
  "https://alphacephei.com/vosk/models/${ZIP_NAME}"
)

mkdir -p "$DEST_DIR"

if [[ -f "$DEST_ZIP" ]]; then
  size="$(wc -c < "$DEST_ZIP" | tr -d ' ')"
  # Incomplete downloads from a stalled mirror are often a few KB.
  if [[ "$size" -gt 1000000 ]]; then
    echo "Model already present: $DEST_ZIP ($(du -h "$DEST_ZIP" | awk '{print $1}'))"
    exit 0
  fi
  echo "Removing incomplete model ($size bytes)…"
  rm -f "$DEST_ZIP"
fi

for url in "${URLS[@]}"; do
  echo "Downloading $url …"
  if curl -L --fail --retry 3 --connect-timeout 30 --max-time 600 -o "$DEST_ZIP" "$url"; then
    size="$(wc -c < "$DEST_ZIP" | tr -d ' ')"
    if [[ "$size" -gt 1000000 ]]; then
      echo "Saved $DEST_ZIP ($(du -h "$DEST_ZIP" | awk '{print $1}'))"
      echo "Remember: pubspec.yaml already lists assets/models/"
      exit 0
    fi
    echo "Download looked incomplete ($size bytes), trying next mirror…"
    rm -f "$DEST_ZIP"
  else
    echo "Mirror failed, trying next…"
    rm -f "$DEST_ZIP"
  fi
done

echo "ERROR: could not download $ZIP_NAME from any mirror." >&2
exit 1
