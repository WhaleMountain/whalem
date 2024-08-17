---
title: "Raspberry Piの初期設定"
date: 2024-08-17T16:07:50+09:00
draft: true
tags: ["2024-08", "Raspberry Pi"]
---

久しぶりにRaspberry Piを使おうと思ったが初期設定を色々忘れていたので、よく利用する箇所をまとめる。
- 使用環境
    - Raspberry Pi 3B+ (多分)

### SDカードにイメージを書き込む

[Raspberry Pi Imager](https://www.raspberrypi.com/software/) を利用して microSDカードにイメージを書き込みます。  
GUI は利用しないので Raspberry Pi OS (other) から lite を選択する。あとは初期ユーザー、SSHを有効にして書き込んで終わり。  
簡単！！

### sudoの初期設定

デフォルトだと sudo の実行にパスワードが要求されない。`sudoers.d` 内にあるファイルを確認すると `NOPASSWD` が設定されている。
* デフォルトの設定
```shell
$ sudo cat /etc/sudoers.d/010_pi-nopasswd 
[ユーザー] ALL=(ALL) NOPASSWD: ALL
```

対象のファイルを削除して終わり。(中身の書き換えでも良さそう、好みで。)
```shell
$ sudo rm /etc/sudoers.d/010_pi-nopasswd
```

### 無線関連の設定

有線で利用することが多いので Wi-Fi は無効にする。あと Bluetooth も利用しないので無効にする。  
`/boot/overlays/README` を見てフラグを確認して下記ファイルに書き込む。

* /boot/firmware/config.txt 
```
dtoverlay=disable-bt
dtoverlay=disable-wifi
```

再起動後に `ip a` で `wlan0` が表示されないことを確認する。

### IPアドレスの設定

Raspberry Pi OS 12(Bookworm) から NetworkManager で設定するらしい。下記サイトを参考にIPアドレスを固定しました。
* 参考: [Raspberry Pi OS のネットワーク設定](https://hassiweb.gitlab.io/memo/docs/memo/raspberry-pi/raspberry-pi-os/network-config/)
```shell
$ sudo nmcli connection modify 'Wired connection 1' ipv4.addresses "[IPアドレス/サブネット]" ipv4.gateway "[ゲートウェイ]" ipv4.dns "[DNS]" ipv4.method "manual"
```

DNSを複数設定するには `ipv4.dns "8.8.8.8,8.8.4.4"` みたいに指定したら設定できました。

### その他諸々

必要なパッケージのインストール
```shell
$ sudo apt install vim zsh git
```

デフォルトエディターの変更
```shell
$ sudo update-alternatives --config editor
```

Docker のインストールは過去の記事を参考にする。
* [Raspberry PiにDocker環境のインストール](/post/2021-03/docker-on-raspberrypi/)