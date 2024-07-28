---
title: Dockerfileのよく忘れる部分のメモ
date: 2021-03-14T13:13:16+09:00
tags: ["2021-03", "Docker", "Dockerfile"]
---

#### DEBIAN_FRONTEND

`apt install`時にインタラクティブな表示を無効にする。

```dockerfile
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y
```

#### Multi-Stage Build

[Multi-Stage](https://docs.docker.com/develop/develop-images/multistage-build/)で`COPY`する時の指定の仕方。

```dockerfile
FROM golang:rc-alpine3.12 AS build

FROM alpine:3.12
COPY --from=build /tmp/main /tmp/
```