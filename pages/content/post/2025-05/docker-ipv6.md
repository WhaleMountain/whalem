---
title: "DockerのIpv6を有効にする"
date: 2025-05-05T00:04:44+09:00
tags: ["2025-05", "Docker"]
---

Raspberry Piに[AdGuard Homeの導入](../2025-02/adgurd-home-setup.md)を導入したが、IPv6のDNSを利用できなかったのでDockerのIPv6サポートを有効にする。

### IPv6サポートの有効化

ほとんど公式通り
* [IPv6 サポートの有効化](https://docs.docker.jp/config/daemon/ipv6.html)

`/etc/docker/daemon.json` に下記の内容を追加する。`daemon.json`がない場合は新規作成で大丈夫です。
```json
{
  "ipv6": true,
  "fixed-cidr-v6": "2001:db8:2::/64"
}
```

Dockerを再起動する。
```shell
$ systemctl reload docker.service
```

`ip a`でIPv6アドレスが降られているか確認できます。表示されなければ再起動したらよさそう。

```
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether be:bb:67:84:c8:22 brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 2001:db8:2::1/64 scope global nodad
       valid_lft forever preferred_lft forever
```

### 使い方

IPv6が使えるようになったので`compose.yaml`の`networks`で明示的に宣言します。  
下記のように設定してコンテナを落として作り直したらIPv6が使えるようになります。

```yaml
services:
  adgaurd:
    container_name: "adguard-home"
    image: adguard/adguardhome:v0.107.61
    networks:
      - adguard
networks:
  adguard:
    enable_ipv6: true
```
