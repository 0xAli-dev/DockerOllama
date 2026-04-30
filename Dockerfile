FROM ubuntu:22.04


RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*


RUN curl -fsSL https://ollama.com/install.sh | sh


ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/root/.ollama/models
ENV PATH="/usr/local/bin:${PATH}"


RUN bash -c "\
    ollama serve & \
    sleep 8 && \
    ollama pull tinyllama:1.1b && \
    pkill -f 'ollama serve' || true"


EXPOSE 11434


ENTRYPOINT ["ollama"]
CMD ["serve"]
