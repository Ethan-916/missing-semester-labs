#!/usr/bin/env bash
set -euo pipefail

STUDENT_ID="${1:-20240001}"
TARGET_DIR="work/${STUDENT_ID}"

echo "[Step 1] Absolute Path & Long listing:"
pwd
ls -laR input

echo "[Step 2] Copying .txt files preserving structure..."
mkdir -p "$TARGET_DIR"
find input -name "*.txt" -print0 | cpio -pdm0 "$TARGET_DIR"

echo "[Step 3] Setting permissions (dir: 750, file: 640)..."
find "$TARGET_DIR" -type d -exec chmod 750 {} +
find "$TARGET_DIR" -type f -exec chmod 640 {} +

echo "[Step 4] Generating inventory.txt..."
find "$TARGET_DIR" -type f -printf "%P %s\n" > inventory.txt
