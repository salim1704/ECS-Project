#Frontend Dockerfile
FROM node:22-alpine AS build
WORKDIR /app/web
RUN npm install -g pnpm
COPY app/web/package.json app/web/pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm-store,target=/root/.local/share/pnpm/store pnpm install --frozen-lockfile
COPY app/web/ .
RUN  pnpm run release

#Backend Dockerfile
FROM golang:1.25-alpine AS go-build
WORKDIR /app/
COPY app/go.mod app/go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod go mod download
COPY  app/ .
COPY --from=build /app/server/router/frontend/dist ./server/router/frontend/dist
RUN --mount=type=cache,target=/root/.cache/go-build go build -o /out/memos ./cmd/memos

#Runtime
FROM alpine:3.20
WORKDIR /app
COPY --from=go-build /out/memos ./memos
EXPOSE 8081
CMD ["./memos"]
