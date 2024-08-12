---
title: "Highlight.jsのアップデート"
date: 2024-08-12T19:38:41+09:00
tags: ["2024-08", "Highlight.js", "Hugo"]
---

下記コミットの内容についての記事です。
* [update submodule and config.toml](https://github.com/WhaleMountain/whalem/commit/915fa2653faf452a911f054bc17ed8cbd372cdff)
* [update highlightjs](https://github.com/WhaleMountain/hugo-theme-yuki/commit/e00767e95db6532b5cb5892f8627795c694c582d)

### リンクの変更

テーマで使用されていた [Highlight.js](https://highlightjs.org/) のバージョンが `v9.13.1` でした。  
脆弱性の報告もあるのでバージョンを上げようと思いました。
* 参考: [highlight.js@9.13.1 vulnerabilities](https://security.snyk.io/package/npm/highlight.js/9.13.1)

公式サイトからJSファイルをダウンロードしてファイルを更新してもいいけど、バージョンアップがしやすいようにCDNを利用します。

```diff
- <script src="{{ "js/highlight.min.js" | absURL }}"></script>
+ <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.10.0/highlight.min.js"></script>
```

あとは `initHighlightingOnLoad` が非推奨になっているので、ドキュメント通りに変更する。
* [Deprecated API](https://highlightjs.readthedocs.io/en/latest/api.html?highlight=initHighlightingOnLoad#inithighlightingonload)

```diff
- <script>hljs.initHighlightingOnLoad();</script>
+ <script>hljs.highlightAll();</script>
```

### エラーの修正

これで終わりかなと思ったらコンソールに下記 Warning が。。

```console
One of your code blocks includes unescaped HTML. This is a potentially serious security risk.
https://github.com/highlightjs/highlight.js/wiki/security
The element with unescaped HTML:
...
```

調べてたら強調されているコードを再強調すると Warning が表示されるらしい。  
* 参考: [Repeated highlighting of already highlighted code causes "*One of your code blocks includes unescaped HTML. This is a potentially serious security risk.*"](https://github.com/highlightjs/highlight.js/issues/3761)

実際にコンソールで `hljs.highlightAll();` を叩いてみるとページ表示時と同じ箇所で Warning が表示されました。  
色々試して Highlight.js の読み込みを削除してもシンタックスハイライトが適用されていました。
Hugo のドキュメントを見てみると Hugo 側で [Syntax highlighting](https://gohugo.io/content-management/syntax-highlighting/#highlight-shortcode) 機能を持っているようでした。  

Hugo 側でハイライトを付けた後に Highlight.js でハイライト付けようとしているから Warning が表示されるのかな。多分。  
あとはドキュメントを参考に Hugo 側のシンタックスハイライトをオフにしてみます。
* 参考: [Configure markup](https://gohugo.io/getting-started/configuration-markup/#highlight)

```toml
[markup]
  [markup.highlight]
    codeFences = false
```

設定してコンソールをみると Warning は表示されませんでした。めでたしめでたし。

### Reference

* [Repeated highlighting of already highlighted code causes "*One of your code blocks includes unescaped HTML. This is a potentially serious security risk.*"](https://github.com/highlightjs/highlight.js/issues/3761)