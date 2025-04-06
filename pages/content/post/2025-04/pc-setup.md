---
title: "新しいPCのセットアップ"
date: 2025-04-06T15:11:36+09:00
tags: ["2025-04", "Windows"]
---

新しくWindows PCを購入したので環境構築でやったことを軽くメモする。
- 使用環境
  - Vivobook S14 M5406WA

全て載せるのは面倒なので忘れやすそうなもののみ雑にまとめる。

# デバイス関連

### JIS/US配列の設定

ノートPCのキーボードはJIS配列、Bluetoothで繋ぐ外付けキーボードはUS配列なのでそのまま使うとJIS配列になる。  
下記サイトを参考に設定する。感謝!!
* [外付けUSキーボードと内蔵JISキーボードを共存させたい(Win10/11)](https://zenn.dev/kakuhito/articles/d27128d0b62098)

Windowsの設定を開き `時刻と言語 > 言語と地域 > 日本語の(・・・)メニュー > 言語のオプション > キーボード > レイアウトを変更する > 接続済みキーボード レイアウトを使用する > OK` を押す。

(本当はこれだけで設定できたら嬉しい)  
このままでは内臓キーボードもUS配列で認識されるので、サイトを参考に `.reg` ファイルを作成してレジストリに値を追加する。  
インスタンスパスはデバイスマネージャーの「標準 PS/2 キーボード」で問題なく設定できました。

### Ctrl2Cap

***これが一番重要!!かも***

MicrosoftのページからCtrl2Cap v3.0をダウンロードする。
* [Ctrl2Cap v3.0](https://learn.microsoft.com/ja-jp/sysinternals/downloads/ctrl2cap)

ダウンロードしたzipファイルを展開して、Windows Terminalを管理者モードで開く。  
PowerShellで展開したフォルダの場所まで移動して、インストールコマンドを叩いたらPCを再起動する。
```shell
.\ctrl2cap.exe /install
```

平穏が訪れる。

---

# ソフトウェア関連

### WSL2の導入

Microsoftのページに従ってPowerShellからインストール。デフォルトでUbuntu24.04がインストールされました。
* [WSL を使用して Windows に Linux をインストールする方法](https://learn.microsoft.com/ja-jp/windows/wsl/install)
```shell
wsl --install
```

### Rancher Desktop

Docker Desktopでもいいが、使ったことがなかったのでRancher Desktopを導入しました。
* [Installing Rancher Desktop on Windows](https://docs.rancherdesktop.io/getting-started/installation/#installing-rancher-desktop-on-windows)

公式サイトに従ってインストール後、起動し `Preferences > WSL > Ubuntu` にチェックを入れ `Apply` で反映する。  
あとはWSL2のUbuntuから`docker`コマンドを使用できる。特に設定もなく`docker compose`も利用でき、今のところ不便はなさそう。

### Go

Ubuntu24.04からはPPAのリポジトリを追加しなくてもインストールできました。
```shell
apt install golang
```

あとは `$HOME/.zsh/zsh-custom.zsh` に環境変数を設定する。
```zsh
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
```

### 1Password SSH Agent

1PasswordでSSHキーを管理しているので、WSL2から鍵を参照できるように設定する。  
(SSHキーの作成やGitHubへの登録は事前に終わっている前提です。)
* [Use the 1Password SSH agent with WSL](https://developer.1password.com/docs/ssh/integrations/wsl/)

1Password Desktopの設定から `SSHエージェント` を有効にしたら、WSL2からアクセスできるか確認する。  
```shell
ssh-add.exe -l
```

キーを表示出来たらGitHubにSSHリクエストを送って確認する。Ubuntuの `ssh` ではなく、 `ssh.exe` を利用します。
```shell
ssh.exe -T git@github.com
```

最後にGitコマンドのSSH設定を変更する。
```shell
git config --global core.sshCommand ssh.exe
```