#!/bin/bash

PORT="${PORT:-11434}"
export OLLAMA_HOST="0.0.0.0:${PORT}"
export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_CTX_SIZE=256

echo "🚀 Starting Ollama on 0.0.0.0:${PORT}"

# ── تشغيل Ollama في الخلفية ──

# تشغيل Ollama في الخلفية
ollama serve &

# انتظار السيرفر يشتغل
sleep 5

# تأكيد وجود النماذج (احتياط)
ollama pull smollm:135m

# إبقاء الحاوية شغالة
wait
