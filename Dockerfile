FROM alpine/ollama:latest

# تثبيت curl لفحص الصحة
RUN apk add --no-cache curl

# ── سحب النموذج أثناء البناء ──
RUN sh -c '\
    ollama serve & \
    sleep 10 && \
    ollama pull smollm:135m && \
    kill %1 || true'

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 11434
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
  CMD curl -fsS http://localhost:${PORT:-11434}/api/tags > /dev/null || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
