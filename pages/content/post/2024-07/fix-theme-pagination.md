---
title: "ページネーションの修正"
date: 2024-08-01T21:48:27+09:00
tags: ["2024-07", "Bugfix"]
---
 
下記コミットの内容についての記事です。
* [fix pagination](https://github.com/WhaleMountain/hugo-theme-yuki/commit/a68896df01a2e32293fe6b0396c81d442667b084)

## tags画面の修正

[Tags](https://whalem.net/tags/) ページを見ていたらテーマを確認したところページネーションがうまくいっていないことを確認。  
下記の記述になっていました。
* layouts/_default/single.html
```html
{{ range .Pages }}
    <div class="index-posts__list">
        <div class="l-time"><a href="{{.Permalink}}">{{ .Date.Format "2006.01.02 15:04" }}</a></div>
        <div class="l-title"><a href="{{.Permalink}}">{{ .Title }}</a></div>
    </div>
{{ end }}

<div class="index-paginate">
    {{ partial "pagination.html" . }}
</div>
```

単純に [Pagination](https://gohugo.io/templates/pagination/) が使われていないのを確認、使うように修正。

```diff
- {{ range .Pages }}
+ {{ range .Paginator.Pages }}
```

## ページネーションの修正

他におかしいところないかと大量に記事を追加して確認するとエラーが。。
```shell
pagination.html:106:28": execute of template failed at <$pag.Last.Permalink>: can’t evaluate field Permalink in type *page.Pager
```

[Pagination](https://gohugo.io/templates/pagination/) のドキュメントを眺めると `.Last` はあるけど `.Last.Permalink` については書かれていない。  
よく見るとドキュメントに[正しい書き方](https://gohugo.io/methods/pager/last/)があるのでそれに修正する。
* layouts/partials/pagination.html
```diff
<!-- Last page. -->
- {{ if ne $pag.PageNumber $pag.TotalPages }}
- <li><a href="{{ $pag.Last.Permalink }}">&#62;&#62;</a></li>
+ {{ with $pag.Last }}
+ <li><a href="{{ .URL }}">&#62;&#62;</a></li>
{{ end }}
```

あとはドキュメントを見ながら同様に `.First`、`.Prev`、`.Next` を修正する。

## 最後に

使用しているテーマ [hugo-theme-yuki](https://github.com/iCyris/hugo-theme-yuki) は2020年にリポジトリはアーカイブされています。  
[フォーク](https://github.com/WhaleMountain/hugo-theme-yuki)して使っていますが、やっぱりメンテは大変 (数年放置してましたが) ですが勉強になりますね。