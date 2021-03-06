# 仕様書
### 作者
青木優弥
### アプリ名
find_shop

#### コンセプト
おしゃれに楽しもう　あなたの生活

#### こだわったポイント
- とにかくお洒落なデザインに拘りました。
- そして多くの人が使い慣れているGoogleMapを使用することで使ってもらいやすいデザインにしました。
- 現在地からの半径を指定することによってユーザの移動も考えたシステム設計を目指しました。

## 開発環境
### 開発環境
Version 11.4

### 開発言語
Swift 5.1.3

## 動作対象端末・OS
### 動作対象OS
ios 13.3

## アプリケーション機能

### 機能一覧

- 店舗選択 :　YahooローカルサーチAPIを使用して6つのジャンルから店舗を取得する
- 距離選択 :　現在地からの距離を選択できる
- マップ上に表示 : GoogleMap上に各店舗の情報を表示する。


### 画面一覧
- 検索画面 ：店を選択し、現在地から表示する半径を選択する。
- 結果画面 ：GoogleMap上に検索条件に当てはまる店舗を表示する。

### 使用しているAPI,SDK,ライブラリなど
- GoogleMaps SDK for ios
- Yahooローカルサーチ API

### アドバイスして欲しいポイント
各店舗の写真などもタップした際に表示したいこと、GoogleMapがとにかく動作が重いので軽くしたいと
考えております。
