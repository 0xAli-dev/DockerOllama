# ── الصورة الرسمية (Debian-based) ──
FROM ollama/ollama:latest

# تثبيت curl و procps (لأمر pkill)
RUN apt-get update && apt-get install -y --no-install-recommends curl procps \
    && rm -rf /var/lib/apt/lists/*


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 11434


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
