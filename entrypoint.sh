#!/bin/bash

PORT="${PORT:-11434}"
export OLLAMA_HOST="0.0.0.0:${PORT}"
export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_CTX_SIZE=256

echo "🚀 Starting Ollama on 0.0.0.0:${PORT}"

# ── تشغيل Ollama في الخلفية ──
ollama serve &
OLLAMA_PID=$!

# ── انتظار إنشاء ملف السجل ──
sleep 30

ollama pull smollm:135m qwen2.5:0.5b &

sleep 120

# ── عرض السجلات مباشرة في stdout (سجلات Render) ──
# Ollama يكتب سجلاته إلى هذا المسار، نستخدم tail -f لإرسالها مباشرة إلى stdout
if [ -f /root/.ollama/logs/server.log ]; then
    tail -n 0 -f /root/.ollama/logs/server.log &
    TAIL_PID=$!
else
    # إذا لم يُنشئ الملف بعد، ننتظر ثانية ونحاول مجدداً
    sleep 2
    if [ -f /root/.ollama/logs/server.log ]; then
        tail -n 0 -f /root/.ollama/logs/server.log &
        TAIL_PID=$!
    fi
fi

# ── إيقاف نظيف عند استلام إشارة من Render/Docker ──
cleanup() {
    echo ""
    echo "🛑 Received shutdown signal, stopping Ollama..."
    kill $TAIL_PID 2>/dev/null
    kill $OLLAMA_PID 2>/dev/null
    wait $OLLAMA_PID 2>/dev/null
    echo "✅ Ollama stopped gracefully"
    exit 0
}
trap cleanup SIGTERM SIGINT

