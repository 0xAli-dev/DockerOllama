#!/bin/bash
set -e

# Render يُمرّر المنفذ عبر متغير البيئة PORT
PORT="${PORT:-11434}"
export OLLAMA_HOST="0.0.0.0:${PORT}"

echo "🚀 Starting Ollama on 0.0.0.0:${PORT}"
exec ollama serve
