---
title: "Vscodeのキーバインド"
date: 2025-04-29T14:20:57+09:00
tags: ["2025-04", "Windows", "VS Code"]
---

WindowsのVS Codeを利用するにあたりMacのターミナルみたいな動きをしたくなったので、Claude君にキーバインドを作成してもらった。

### キーバインド設定

`Ctrl+K Ctrl+S`でキーボードショートカットを開き、右上の「キーボードショートカット(JSON)」を押して `keybindings.json` を開きます。  
後は下のJsonを貼り付けると以下のような設定になります。

- Ctrl+E
  - カーソルを行末に移動
- Ctrl+A
  - カーソルを行頭に移動する
- Ctrl+K
  - カーソルの位置から行末までのテキストをすべて削除する
- Ctrl+F
  - カーソルを右に1文字移動する
- Ctrl+B
  - カーソルを左に1文字移動する
- Alt+Z
  - 操作を元に戻す
- Shift+Alt+Z
  - 元に戻した操作をやり直す
- Alt+A
  - エディタ内のテキストをすべて選択する
- Alt+F
  - 検索機能を開く

```json
[
  {
      "key": "ctrl+e",
      "command": "cursorEnd",
      "when": "editorTextFocus"
  },
  {
      "key": "ctrl+a",
      "command": "cursorHome",
      "when": "editorTextFocus"
  },
  {
      "key": "ctrl+k",
      "command": "deleteAllRight",
      "when": "editorTextFocus"
  },
  {
      "key": "alt+z",
      "command": "undo",
      "when": "editorTextFocus"
  },
  {
    "key": "shift+alt+z",
    "command": "redo",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+f",
    "command": "cursorRight",
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+b",
    "command": "cursorLeft",
    "when": "editorTextFocus"
  },
  {
    "key": "alt+a",
    "command": "editor.action.selectAll",
    "when": "editorTextFocus"
  },
  {
    "key": "alt+f",
    "command": "actions.find",
    "when": "editorFocus || editorIsOpen"
  }
]
```

とりあえず、もともと`Ctrl`にあったものは`Alt`に割り当てる。ほかに不都合があれば`when`あたりを調整する