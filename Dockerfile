FROM ollama/ollama:latest

# تثبيت الأدوات الأساسية
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl procps \
    && rm -rf /var/lib/apt/lists/*

# نسخ سكربت التشغيل
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# تحميل النماذج مسبقاً أثناء build
RUN ollama serve & sleep 5 && \
    ollama pull smollm:135m && \
    ollama pull qwen2.5:0.5b && \
    pkill ollama

EXPOSE 11434

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
