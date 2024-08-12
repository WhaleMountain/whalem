---
title: "こだわりのないdotfiles"
date: 2024-08-06T22:18:41+09:00
tags: ["2024-08", "dotfiles", "zsh"]
---

利用している `dotfiles` のリポジトリは非公開にしているので、`dotfiles` の供養。   
シェルは `zsh`、ターミナルは MacOS のデフォルトのターミナルを利用します。 

### dotfiles

ホームディレクトリに `.dotfile` ディレクトリを作成して、以下のように設定ファイルを配置します。
```
.dotfile
├── .zsh
│   ├── [plugin] zsh-autosuggestions
│   ├── [plugin] zsh-syntax-highlighting
│   ├── zsh-darwin.zsh
│   ├── zsh-linux.zsh
│   └── zsh-custom.zsh
└── .zshrc
```

※実際は `git clone` するだけです。

#### 環境別の設定

MacOS、Linux での使用を想定しているので `.zshrc` に OS ごとの設定ファイルを読み込むように指定します。  
```zsh
case ${OSTYPE} in
    darwin*)
        source $HOME/.zsh/zsh-darwin.zsh
        ;;
    linux*)
        source $HOME/.zsh/zsh-linux.zsh
        ;;
esac
if [ -e $HOME/.zsh/zsh-custom.zsh ]; then
    source $HOME/.zsh/zsh-custom.zsh
fi
```

`zsh-darwin.zsh` や `zsh-linux.zsh` には `LANG` などの環境変数や `ls` の色の調整などを記述します。  
環境ごとの個別設定 (`PATH`など) は `zsh-custom.zsh` に書き込むと管理しやすいです。

#### プラグインの設定

あると便利なプラグインを2つ `.dotfile/.zsh` にクローンします。
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

あとは `.zshrc` に読み込む設定を追加します。
```zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
```

#### コマンド実行時間の表示

コマンドを打った時の時刻を表示したいので、StackOverflow にあったコードを利用します。
* 参考: [zsh: update prompt with current time when a command is started](https://stackoverflow.com/a/14084584)
```zsh
# Show current time when a command is started
# ref. https://stackoverflow.com/a/14084584
preexec () {
  DATE=`date +"%H:%M:%S on %Y-%m-%d"`
  C=$(($COLUMNS-28))
  echo -e "\033[1A\033[${C}C \033[1;37m [${DATE}] \033[0m"
}
```

設定したら下記のように表示されます。便利！
```shell
$ echo $SHELL                                        [22:47:11 on 2024-08-06] 
/bin/zsh
```

#### リンクを貼る

ファイルができたら設定ファイルを読めるようにシンボリックリンクを貼ります。
```shell
$ cd ~/.dotfile
$ ln -s $PWD/.zshrc $HOME/.zshrc
$ ln -s $PWD/.zsh $HOME/.zsh
```

### 最後に

[Warp](https://www.warp.dev/) や [Weve Terminal](https://www.waveterm.dev/) など綺麗で便利なターミナルもありますが、ターミナルでガッツリ作業するわけではないので、これくらいが個人的には合ってそうだなと思いました。