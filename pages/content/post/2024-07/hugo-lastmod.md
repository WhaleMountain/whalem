---
title: "記事に更新時間の追加"
date: 2024-07-30T22:12:49+09:00
tags: ["2024-07", "Hugo"]
---

個人的にブログの公開日と更新日があるとありがたい。なので Hugo のテーマをいじって更新日を表示する。

## テンプレートの修正
  
とりあえず公式サイトを調べると [Lastmod](https://gohugo.io/methods/page/lastmod/) が使えそう。


Hugo テーマのテンプレートを操作して `Edited on` を追加する。  
```html
{{ if ne .Date .Lastmod }}
    Edited on {{ .Lastmod.Format "2006.01.02 15:04" }}
{{ end }}
```

とりあえず設定されている `Date` と更新時間が違うなら表示する。~~あと無理やり `&ensp;` で幅を調整。~~  
表示形式は [Format](https://gohugo.io/methods/time/format/) を参考にする。

## 補足

GitHub Actions でビルドして Lastmod を取得すると GitHub にプッシュした時間が取得されるので(多分)、必ず更新時間が表示されます。。。