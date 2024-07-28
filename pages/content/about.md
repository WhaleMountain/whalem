---
title: About
date: 2021-03-09T21:10:32+09:00
---

自分用のWiki的なやつを書く。

Raspberry Pi から GitHub Pages に移行しました！

## 新構成

- GitHub Pages
- Hugo
  - Theme, [hugo-theme-yuki](https://github.com/WhaleMountain/hugo-theme-yuki)


## 配信の流れ

1. GitHubにプッシュする
1. GitHub ActionでHugoビルドする
1. GitHub Pagesで配信する
1. 以上

---

## 旧構成

- Server
  - Raspberry Pi 3B+

- Software and Application etc
  - [Docker](https://docker.com/)
  - [Nginx](https://www.nginx.com/)
  - [Hugo](https://gohugo.io/)
  - [Gitea](https://gitea.io/)
  - [Drone](https://drone.io/)

- Hugo theme
  - [hugo-theme-yuki](https://github.com/WhaleMountain/hugo-theme-yuki)

## 旧構成の配信の流れ

1. Giteaにプッシュする
2. DroneでHuboビルドする
3. Nginxで配信する
4. 以上