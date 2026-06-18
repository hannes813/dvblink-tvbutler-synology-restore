#!/bin/sh
set -eu

IN="${1:-}"
OUT="${2:-}"
if [ -z "$IN" ] || [ -z "$OUT" ]; then
  echo "Usage: $0 input.log output.log" >&2
  exit 1
fi

sed -E \
  -e 's#https?://[^[:space:]]+#<url-redacted>#g' \
  -e 's#([Pp]assword|[Pp]asswort|token|secret|serial|SerialNumber)[=: ]+[^[:space:]]+#\1=<redacted>#g' \
  -e 's#[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}#<uuid-redacted>#g' \
  "$IN" > "$OUT"
