FROM alpine:3.18

# ca-certificates  — HTTPS for cloudflared and Telegram
# wget + tar       — download and extract bot binary
RUN apk add --no-cache ca-certificates wget tar

WORKDIR /app

# Full write permissions for fsb.env and fsb.session writes at runtime
RUN chmod -R 777 /app

# Download bot binary
RUN wget -q https://github.com/EverythingSuckz/TG-FileStreamBot/releases/download/v3.2.0/TG-FileStreamBot-v3.2.0-linux-amd64.tar.gz \
    && tar -xzf TG-FileStreamBot-v3.2.0-linux-amd64.tar.gz \
    && mv fsb /usr/local/bin/tg-filestreambot \
    && chmod +x /usr/local/bin/tg-filestreambot \
    && rm TG-FileStreamBot-v3.2.0-linux-amd64.tar.gz

# Download cloudflared binary
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    -O /usr/local/bin/cloudflared \
    && chmod +x /usr/local/bin/cloudflared

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Render sets PORT automatically, default 8080
ENV PORT=8080
EXPOSE 8080

CMD ["/app/start.sh"]
