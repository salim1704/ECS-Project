FROM node:22-alpine AS frontend-build
WORKDIR /app/web

COPY app/web/package.json app/web/pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install

COPY app/web/ ./
RUN pnpm run release

FROM golang:1.25-alpine AS backend-build
WORKDIR /app

COPY app/ ./
COPY --from=frontend-build /app/server/router/frontend/dist ./server/router/frontend/dist

RUN go build -o memos ./cmd/memos

FROM alpine:3.20
WORKDIR /app

COPY --from=backend-build /app/memos ./memos

EXPOSE 8081
CMD ["./memos"]