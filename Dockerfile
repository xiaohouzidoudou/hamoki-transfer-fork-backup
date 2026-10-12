FROM node:22-alpine AS frontend-builder
WORKDIR /web
COPY web/package.json web/package-lock.json ./
RUN npm ci
COPY web/ ./
RUN npm run build

FROM python:3.12-slim-bookworm
ARG APP_VERSION=0.1.0
ARG VCS_REF=unknown
LABEL org.opencontainers.image.title="Hamoki Transfer"
LABEL org.opencontainers.image.source="https://github.com/xiaohouzidoudou/hamoki-transfer"
LABEL org.opencontainers.image.licenses="LGPL-3.0"
LABEL org.opencontainers.image.version="${APP_VERSION}"
LABEL org.opencontainers.image.revision="${VCS_REF}"
WORKDIR /app
COPY . .
COPY --from=frontend-builder /web/dist/ /app/themes/hamoki/
ENV APP_VERSION="${APP_VERSION}" HOST="0.0.0.0" PORT=12345 WORKERS=1 APP_ENV="production" LOG_LEVEL="warning" ACCESS_LOG="false" FORWARDED_ALLOW_IPS=""
RUN pip install --no-cache-dir --require-hashes -r requirements.lock.txt
EXPOSE 12345
CMD ["sh", "-c", "exec uvicorn main:app --host \"$HOST\" --port \"$PORT\" --workers \"$WORKERS\" --log-level \"$LOG_LEVEL\" --no-access-log --proxy-headers --forwarded-allow-ips \"${FORWARDED_ALLOW_IPS:-}\""]
