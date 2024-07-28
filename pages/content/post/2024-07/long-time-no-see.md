---
title: 久しぶりに更新
date: 2024-07-28T16:55:43+09:00
tags: ["2024-07", "GitHub Pages", "GitHub Actions", "Hugo"]
---

## 久しぶりに更新

全然運用していなかったので、ブログを更新できるか確認していた。  
とりあえずやったことのメモ。

## Hugoの確認

GitHub Pages に移行したときの Hugo のバージョンは `0.83.0` だったけど、今は `0.129.0` になってた。  
とりあえずビルドできるか確認したら、エラーが。。  

```bash
 parse failed: template: _default/list.html:4: function "sanitizeurl" not defined
```

sanitizeurl がないとのことで代わりのもの探したけどぱっと見見つけられないので、一旦削除で対応 (そんなんでいいのか)  
baseUrl のシリアライズなので多分問題ないと思いたい。

## GitHub Actionsの更新

Yaml ファイルの中身を忘れているけど、まぁ使っているものは色々バージョンは上げとく。
- [actions/checkout](https://github.com/actions/checkout)
    - v2 > v4
- [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo)
    - v2 > v3
- [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages)
    - v3 > v4


あとはDeploy Keyの再設定  
GitHub Pages 用のリポジトリに [Deploy keys](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/managing-deploy-keys) を登録して、Markdown ファイルを置くリポジトリに Repository secrets を設定する。  
- WhaleMountain.github.io
    - `Settings > Deploy kyes` に公開鍵を登録
- whalem
    - `Settings > Secrets and variables > Repository secrets` に秘密鍵を登録    

鍵は 1Password で管理。あとはブログ更新しなくなったら Deploy keys の登録を削除する。