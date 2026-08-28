#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" || ! -f "$file" ]]; then
    echo "Error: File '$file' does not exist." >&2
    exit 1
fi

echo "=== Top 2 HTTP 5xx Paths ==="
awk -F',' 'NR > 1 && $4 ~ /^5[0-9]{2}$/ { count[$3]++ } END { for (p in count) printf "%d\t%s\n", count[p], p }' "$file" \
    | sort -k1,1nr -k2,2 \
    | head -n 2

echo "=== Average Latency (ms) ==="
awk -F',' 'NR > 1 { sum += $5; count++ } END { if (count > 0) printf "%.2f\n", sum / count; else print "0.00" }' "$file"
