---
title: DroneのカスタムDNS設定
date: 2021-03-10T12:58:54+09:00
tags: ["2021-03", "Drone", "Docker"]
---

自宅の環境でGitea/Droneを構築していたが、CI時にGiteaからリポジトリをCloneできない。ドメインに接続できないと。自宅のLANからWAN側のIPにはアクセスできないので、内部DNSとして[Unbound](https://unbound.jp/unbound/)を構築した。

```shell
Initialized empty Git repository in /drone/src/.git/
+ git fetch origin +refs/heads/master:
fatal: unable to access 'http://gitea.whalem.net/whalem/drone_ci_test.git/': Failed to connect to gitea.whalem.net port 80: Operation timed out
```

DNSを構築したので、Drone Runnerへ設定したが、同じように`Failed to connect to gitea.whalem.net port 80: Operation timed out`となる。Pingしてみると。

```shell
$ ping -c 4 gitea.whalem.net
PING gitea.whalem.net (<WAN_IP>): 56 data bytes
64 bytes from <WAN_IP>: seq=0 ttl=254 time=0.890 ms
```

あらら。Runnerに設定したけど、Pipelineの処理は別コンテナが作成され実行されるので、Runnerに設定しても意味ないと。Droneが作成するコンテナへDNSの設定方法を調べたけど、あまり良さそうな解決策は見つからなかったので、下の方法をとる。

* [Specify a host or a custom dns in drone-git image](https://discourse.drone.io/t/specify-a-host-or-a-custom-dns-in-drone-git-image/308)

`/etc/docker/daemon.json`に内部DNSのアドレスを追加する。`daemon.json`は無ければ新しく作成する。
```json
{
    "dns": ["CUSTOM_DNS", "8.8.8.8"]
}
```

`daemon.json`を編集後にDocker daemonを再起動する。

```shell
$ systemctl restart docker.service
```

これで、コンテナは内部DNSを参照する。あとは、いつも通りに。

```shell
Initialized empty Git repository in /drone/src/.git/
+ git fetch origin +refs/heads/master:
From http://gitea.whalem.net/whalem/drone_ci_test
 * branch            master     -> FETCH_HEAD
 * [new branch]      master     -> origin/master
+ git checkout 7595bbbcdbb63575efda8795510067620ebbd148 -b master
Already on 'master'
```

ヘアピンNATできるルータが欲しい...。

## ネットワーク設定

Droneが作成するコンテナのネットワークを指定したい場合は、[DRONE_RUNNER_NETWORKS](https://docs.drone.io/runner/docker/configuration/reference/drone-runner-networks/)を設定する。

```
service:
    server:
        ...
    runner:
        ...
        environment:
            - DRONE_RUNNER_NETWORKS=mynet_bridge
```