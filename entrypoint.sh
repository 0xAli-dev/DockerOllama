#!/bin/bash
set -e
set -x  # ← يطبع كل أمر يُنفّذ

PORT="${PORT:-11434}"
export OLLAMA_HOST="0.0.0.0:${PORT}"
export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_CTX_SIZE=256

echo "=== DIAGNOSTICS ==="
echo "PORT: $PORT"
echo "OLLAMA_HOST: $OLLAMA_HOST"
echo "RAM available:"
free -h 2>/dev/null || cat /proc/meminfo | head -5
echo "Disk space:"
df -h /root/.ollama 2>/dev/null || df -h /
echo "Ollama binary path:"
which ollama || echo "NOT FOUND"
echo "Ollama version:"
ollama --version 2>/dev/null || echo "VERSION CHECK FAILED"
echo "Models installed:"
ls -la /root/.ollama/models/manifests/ 2>/dev/null || echo "NO MODELS FOUND"
echo "==================="

echo "🚀 Starting Ollama..."
exec ollama serve
