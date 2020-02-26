# Tuning MV

## MV(ミュージックビデオ)を気分に合わせて再生するアプリ

YoutubeからMV(ミュージックビデオ)動画を取得して再生するアプリです。
そのときの「気分」にあった動画をYoutubeの再生リストから取得し、アプリ上で再生できます!
- 例.)
  - 疲れて元気が欲しいとき => 気分:「元気が出るMV」を選択
  - 脳に刺激を与え目を覚まさせたい時 => 気分:「色鮮やかなMV」を選択

![result](https://user-images.githubusercontent.com/54093324/73136437-06fe8300-4091-11ea-92dc-2c9b8846c4d3.gif)

## 機能

- ユーザー機能: ユーザ登録可能, ゲストユーザー(仮のユーザー)でログインしアプリを試すこともできる
- MV再生機能: そのときの「気分」に「マッチしたMV」を再生できる
- プレイリスト機能: 気に入ったMVを「自分だけのプレイリストに保存し、再生」できる

## 環境
### 開発環境
- ruby: 2.6.3
- rails: 5.2.4.1
- google-api-client 0.36.3
- Youtube Data API v3
- DB: PostgreSQL
- テストフレームワーク: Rspec

### 本番環境
- AWS
  - EC2 (AMI:Amazon Linux 2 AMI (HVM))
  - ELB
  - RDS(PostgreSQL)
  - Webサーバ：Nginx
  - アプリケーションサーバ: Unicorn
　
