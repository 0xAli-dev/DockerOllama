#!/bin/sh
set -e

PORT="${PORT:-11434}"
export OLLAMA_HOST="0.0.0.0:${PORT}"

# تقليل استهلاك الذاكرة إلى أقصى حد
export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_CTX_SIZE=512
export OLLAMA_KEEP_ALIVE=30m

export OLLAMA_DEBUG=1

# إعادة توجيه ملف سجل Ollama إلى stdout حتى تظهر في Render
mkdir -p /root/.ollama/logs
ln -sf /dev/stdout /root/.ollama/logs/server.log

echo "🚀 Starting Ollama on 0.0.0.0:${PORT}"
echo "📋 Logs will appear below..."

echo "🚀 Starting Ollama on 0.0.0.0:${PORT}"
exec ollama serve
