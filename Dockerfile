# ── الصورة الرسمية (Debian-based) ──
FROM ollama/ollama:latest

# تثبيت curl و procps (لأمر pkill)
RUN apt-get update && apt-get install -y --no-install-recommends curl procps \
    && rm -rf /var/lib/apt/lists/*

# ── سحب النموذج أثناء البناء ──
# نستخدم bash + pkill بدلاً من kill %1
RUN bash -c '\
    ollama serve & \
    sleep 20 && \
    ollama pull smollm:135m qwen2.5:0.5b && \
    pkill -f "ollama serve" || true'

# نسخ سكريبت التشغيل
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 11434

HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=5 \
  CMD curl -fsS http://localhost:${PORT:-11434}/api/tags > /dev/null || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
