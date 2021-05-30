---
title: GiteaにSSH接続できるようにする
date: 2021-03-13T17:09:30+09:00
tags: ["2021-03", "Gitea", "SSH", "ProxyJump"]
---

GiteaはDockerで作成したブリッジネットワークのIPアドレスを振ってNginxでリバースプロキシしてる。Dockerのブリッジドライバーのルールにより、そのブリッジないのコンテナ、もしくはDockerのホストからしかアクセスできない。SSH接続どうしようかなと思ってたのですが、ホスト側を踏み台にしたらいいのか。

ということで、手元のPC側の`~/.ssh/config`を編集する。`ProxyJump`によりホストを踏み台にできる(ﾌﾐﾌﾐ。

```
Host gitea.whalem.net
  HostName [Container IP Address]
  User git
  IdentityFile [Private Key]
  ProxyJump docker-host

Host docker-host
  HostName [Host Server IP Address]
  User user
```

あとは、CloneしたりPushしたり。Gitea側に**SSH Keyの登録**も忘れずに。