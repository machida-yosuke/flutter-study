# flutter study

### vflutter

google 製の Android、iOS のアプリを同時に作成
ホットリロードを採用、修正を即時反映

### firebase

バックエンドをかんたんに作成可能

### mlkit

機械学習の機能をデバイスで利用できるようにするもの
テキスト読み取り、顔検出など

### flutter の概要

プログラミング言語は dart
柔軟で豊かな表現
豊富なウィジェット
一括デザイン変更

### 素早い開発

ホットリロード
コードの変更反映が素早い

### ネイティブ並の性能

https://flutter.dev/

### flutter

google
人気上昇

### react native

facebook 製

### Xamarine

濃厚接触アプリはこれで作ってる

### unity

ゲーム開発向け

### 環境設定

flutterSDK
環境変数
android studio のダウンロード
Android スタジオを起動コンポーネントのインストール

flutter へのパスｗｐ通す
https://flutter.dev/docs/get-started/install/macos#update-your-path

```
flutter doctor
```

コマンドで flutter の状態を確認できる

Install Android Studio
https://flutter.dev/docs/get-started/install/macos#install-android-studio

普通にインストール
プラグインのインストール
コンフィグのプラグインから flutter を選択してインストール
crate new flutter project がでてくる

### firebase

バックエンド環境
バックエンド縁の下の力持ち
みないところで頑張る

### MKkit

機械学習
デバイス向けのフレームワーク
vision natual lang

### firebase

リアルタイム
サーバー管理保守が楽
フロントに注力できる

### ユーザー認証

プッシュ通知
ストレージ

### MLkit

vision
顔検出
物体検出

### natural language

翻訳
言語識別

### 独自モデル

AutoML
vision Edge tensorFlow

### プロジェクトの作成

packagename は唯一無二に名前を入れる
エミュレーターのインストール
ADV Manager から新規作成できる
Android のバージョンが低いほど対応できる端末が狭くなる

Android シミュレーター
compileDebugJavaWithJavac エラー

```
FAILURE: Build failed with an exception.

* What went wrong:
Could not determine the dependencies of task ':app:compileDebugJavaWithJavac'.
> Failed to install the following Android SDK packages as some licences have not been accepted.
     build-tools;29.0.2 Android SDK Build-Tools 29.0.2
  To build this project, accept the SDK license agreements and install the missing components using the Android Studio SDK Manager.
  Alternatively, to transfer the license agreements from one workstation to another, see http://d.android.com/r/studio-ui/export-licenses.html

  Using Android SDK: /Users/admins/Library/Android/sdk

* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 1s
Exception: Gradle task assembleDebug failed with exit code 1
```

Android のライセンス問題らしい
https://qiita.com/nemui-fujiu/items/47b6cae9e2763a96325c

ios シミュレーター
AndroidSTUDIO なら xcode 入れれれば一瞬で起動できる
open ios simulator

xcode ライセンスまわり

```
sudo xcodebuild -license
```

```
open -a Simulator
```

コマンドでプロジェクト作成

```
flutter create my_app
```

シミュレーターでアプリを起動

```
flutter run
```

### VSCode セットアップ

flutter 　プラグインのインストール
dart 　プラグインインストール

### dart

変数
分岐
ループ

関数
クラス

ジェネリクス
非同期
