#!/usr/bin/env bash
# 墨读 · 公版书库 启动脚本
#
# 用法：
#   ADMIN_TOKEN=你的口令 ./start.sh
#   ADMIN_TOKEN=你的口令 PORT=9000 ./start.sh
#
# 不设 ADMIN_TOKEN 也能启动，只是删除功能（单本 + 批量）会返回 403。
set -euo pipefail
cd "$(dirname "$0")"

: "${PORT:=8000}"
: "${HOST:=0.0.0.0}"

if [ -z "${ADMIN_TOKEN:-}" ]; then
  echo "[提示] 未设置 ADMIN_TOKEN，删除功能不可用；阅读、导入、播放不受影响。" >&2
  echo "       需要删除请这样启动：ADMIN_TOKEN=你的口令 ./start.sh" >&2
fi

exec python3 -m uvicorn app:app --host "$HOST" --port "$PORT"
