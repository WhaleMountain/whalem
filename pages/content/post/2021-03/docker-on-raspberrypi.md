---
title: Raspberry PiにDocker環境のインストール
date: 2021-03-13T00:50:55+09:00
tags: ["2021-03", "Docker", "docker-compose"]
---

## Dockerのインストール

[公式ドキュメント](https://docs.docker.com/engine/install/debian/)に従っても良いが、インストール用のスクリプトがあるのでそれを使う。

```shell
$ curl -fsSL https://get.docker.com -o install-docker.sh

$ sh ./install-docker.sh
```

簡単だね。

## docker-composeのインストール

docker-composeの[リポジトリ](https://github.com/docker/compose.git)のリリースにはarm用のバイナリはないので、ソースからビルドを行う。

```shell
$ git clone https://github.com/docker/compose.git

$ cd compose

$ git checkout 1.27.4

$ ./script/build/linux
```

しばし待つ。`dist`下にバイナリが吐かれていれば成功。あとは、`/usr/local/bin`にコピって終了。

```shell
$ ls dist/
docker-compose-linux-aarch64

$ cp dist/dockeer-compose /usr/local/bin/docker-compose

$ chown root:root /usr/local/bin/docker-compose

$ chmod 755 /usr/local/bin/docker-compose

$ docker-compose version
docker-compose version 1.27.4, build 40524192
docker-py version: 4.3.1
CPython version: 3.7.7
OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019
```

Version 1.28.x からビルド時の`Dockerfile`と`script/build/linux`の中身が変わり、今回の環境ではバイナリが吐かれなかった。ビルドは成功してるのにね。面倒なので1.27.4を使用する。