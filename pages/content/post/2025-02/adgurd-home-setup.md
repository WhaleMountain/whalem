---
title: "AdGuard Homeの導入"
date: 2025-02-24T21:03:34+09:00
tags: ["2025-02", "AdGuard Home", "Raspberry Pi"]
---

Raspberry PiにAdGuard Homeを導入したので設定内容をまとめる。
- 使用環境
    - Raspberry Pi 3B+ (多分)

### AdGuard Homeの起動

Docker を使って Adguard Home を起動します。  
作業用のディレクトリを作成し、`compose.yaml`を作成します。ポートは利用すもののみ設定します。

```yaml
services:
  adgaurd:
    container_name: "adguard-home"
    image: adguard/adguardhome:v0.107.57
    restart: always
    volumes:
      - ./work:/opt/adguardhome/work
      - ./conf:/opt/adguardhome/conf
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
```

### ダッシュボードにアクセス

ブラウザから Adguard Home のダッシュボードにアクセスします。`http://ラズパイのHost名.local` を開きパスワード等を設定します。  
設定 > DNS設定 > アップストリームDNSサーバー に `8.8.8.8` など好みのDNSを設定します。  

* 設定例
```txt
8.8.8.8
8.8.4.4
1.1.1.1
1.0.0.1
2001:4860:4860::8888
2001:4860:4860::8844
2606:4700:4700::1111
2606:4700:4700::1001
https://dns10.quad9.net/dns-query
https://cloudflare-dns.com/dns-query
```

あとは好みの設定をしたら終わりです。

### DNSの設定

ダッシュボードのセットアップガイドではコンテナ内のIPが表示されるので、ラズパイ側のIPを `ip a` などで確認します。  
スマホやPCなどのDNS設定をするか、ルーターにDNS設定して利用してください。

### 参考

- [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome)
- [AdGuard Home - Docker](https://hub.docker.com/r/adguard/adguardhome)
- [Google Public DNS](https://developers.google.com/speed/public-dns/docs/using?hl=ja)
- [1.1.1.1 (DNS Resolver)](https://developers.cloudflare.com/1.1.1.1/ip-addresses/)
- [quad9](https://www.quad9.net/service/service-addresses-and-features/)