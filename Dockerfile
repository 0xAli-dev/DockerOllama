FROM langchain4j/ollama-qwen2.5:0.5b

RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 11434
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
  CMD curl -fsS http://localhost:${PORT:-11434}/api/tags > /dev/null || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
