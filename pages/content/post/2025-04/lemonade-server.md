---
title: "Lemonade Serverの導入"
date: 2025-04-20T19:50:50+09:00
tags: ["2025-04", "Windows", "lemonade-server"]
---

新しく購入した PC の CPU である AMD Ryzen AI 9 HX 370 には NPU を使用するために [Lemonade Server](https://github.com/onnx/turnkeyml) を導入した時のメモです。

## Lemonade Server
最近 AMD から [GAIA](https://github.com/amd/gaia) という OSS で AMD Ryzen AI プロセッサの NPU を利用して生成 AI を動かせそうでした。  
その GAIA のバックエンドの Lemonade を導入することで VS Code の拡張機能からも利用できるとのことなので、Lemonade Server をインストールします。  

### インストール
GitHub の Releases からインストーラーをダウンロードしてインストールするだけです。
* https://github.com/onnx/turnkeyml/releases

インストール時にダウンロードするモデルも選択できました。NPU に対応した Hybrid のモデルがダウンロードできます。  
現在用意されているモデルは Huggingface で確認できます。
* https://huggingface.co/amd 

### 起動

デスクトップに作成される lemonade-server をクリックするだけです。 `8000`ポートで立ち上がります。
ダウンロードしたモデル一覧は下記にアクセスすると取得できました。
* http://localhost:8000/api/v0/models 

~~追加でモデルダウンロードしたい時はどこからだろう...？~~

### モデルの追加

lemonade-server をインストール後に `~/AppData/Local/lemonade_server/bin` に `lemonade-server.bat` が追加されています。
* コマンド一覧 (v6.2.2)
```shell
$ lemonade-server.bat --help
Serve LLMs on CPU, GPU, and NPU.

options:
  -h, --help     show this help message and exit
  -v, --version  Show version number

Available Commands:

    serve        Start server
    status       Check if server is running
    stop         Stop the server
    pull         Install an LLM
```

[Lemonade Server Models](https://github.com/onnx/turnkeyml/blob/main/docs/lemonade/server_models.md) から使いたいモデルを確認して追加できます。

```shell
$ lemonade-server.bat pull Qwen-1.5-7B-Chat-Hybrid
```

## Continueから使用する

連携アプリの例にあった [Continue](https://www.continue.dev/) から今回利用してみます。
流れは GitHub の examples の通りです。
* [Continue Coding Assistant](https://github.com/onnx/turnkeyml/blob/main/examples/lemonade/server/continue.md)

Add Chat Model から Connect ボタンの下にある config file から models を以下のように変更して保存します。
```yaml
models:
  - name: Lemonade
    provider: openai
    model: Qwen-1.5-7B-Chat-Hybrid 
    apiBase: http://localhost:8000/api/v0
    apiKey: none
  - name: Lemonade Autocomplete Model
    provider: openai
    model: Qwen-1.5-7B-Chat-Hybrid
    apiBase: http://localhost:8000/api/v0
    apiKey: none
    roles:
      - autocomplete
```

後は model 選択のプルダウンメニューから Lemonade を選べるようになっています。  
タスクマネージャーを起動して Continue を使ってみると NPU と GPU が使われていることを確認できます。

あとは色々使ってみよう。有料と比べモデル性能は低いとしてもお金に気を遣わずに利用できるのはいいですね。

## 参考

* [Unlocking a Wave of LLM Apps on Ryzen™ AI Through Lemonade Server](https://www.amd.com/en/developer/resources/technical-articles/unlocking-a-wave-of-llm-apps-on-ryzen-ai-through-lemonade-server.html)