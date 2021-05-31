---
title: ラズパイで動かしていたWikiをGithub Pagesに移行した
date: 2021-05-30T18:54:00+09:00
tags: ["2021-05", "Github Pages", "Hugo"]
---

#### 移行

ラズパイの`Docker`で自分用のWikiを動かしていたが、Github Pagesの誘惑に負けたので移行する。  
Github Pagesの公開用のリポジトリと、ソース用のリポジトリを分けて作成しているが、個人的にこの構成が好きだからで、特に深い意味はありません。

#### 手順

1. **Username.github.io** のリポジトリを作成する
1. 上で作成したリポジトリに[Deploy Key](https://docs.github.com/ja/developers/overview/managing-deploy-keys#デプロイキー)を設定する
1. 次にHugoなどの **.md** ファイルを置くリポジトリを作成する
1. 1で作成したリポジトリにPushするために[Secret Key](https://docs.github.com/ja/actions/reference/encrypted-secrets#リポジトリの暗号化されたシークレットの作成)を設定する
1. Github Actionを設定し終了

※ 2, 4で設定したKeyはMacOS上で`ssh-keygen`で作成したKeyを設定する。1には公開鍵(`.pub`)、3には秘密鍵を設定する。

#### Github Action

Hugo公式の[Host on Github](https://gohugo.io/hosting-and-deployment/hosting-on-github/)を参考に作成する。  

```yaml

name: github pages

on:
  push:
    branches:
      - main  # Set a branch to deploy
    paths:
      - 'pages/**'
  pull_request:

jobs:
  deploy:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true  # Fetch Hugo themes (true OR recursive)
          fetch-depth: 0    # Fetch all history for .GitInfo and .Lastmod

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          extended: true

      - name: Build
        run: hugo
        working-directory: ./pages

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with: 
          external_repository: WhaleMountain/WhaleMountain.github.io
          publish_branch: main
          publish_dir: ./pages/public
          deploy_key: ${{ secrets.ACTIONS_DEPLOY_KEY }}
          cname: whalem.net
```

`paths`を設定することで、設定したパス(`pages/**`)に変更があった場合にGithub Actionが動くようになる。(参考: [GitHub Actionsのワークフロー構文](https://docs.github.com/ja/actions/reference/workflow-syntax-for-github-actions))  
また、ソース用のリポジトリに旧構成のバックアップがあるため、Build時にHugoのソースがあるディレクトリに`working-directory`で移動する。

#### Reference

* [Hugo + GitHub Pages + GitHub Actions で独自ドメインのウェブサイトを構築する](https://zenn.dev/nikaera/articles/hugo-github-actions-for-github-pages)
