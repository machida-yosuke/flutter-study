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

flutter へのパスを通す  
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

xcode ライセンス確認

```
sudo xcodebuild -license
```

シミュレーター単体の起動

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

cocos pods

```
sudo gem install cocoapods
```

すべてのエミュレーターで確認
ios Android どちらも起動して必要あり

```
flutter run -d all
```

### vscode でインスペクターを表示させる手順

### VSCode セットアップ

flutter 　プラグインのインストール  
dart 　プラグインインストール

### dart

dartpad.dev  
でコードを試せる

#### hellow world

```dart
void main() {
   print('hello world');
}
```

//でコメント  
main 関数は最初に実行される  
コード末に;が必要

#### 変数

int 整数  
double 小数  
String 文字  
bool true or false

var 代入時自動で型推論

```dart
var a = 1
a = 'a'　これはエラーになる
```

dynamic 型はない
any + let みたいなもの

```dart
dynamic a = 1
a = 'a'　
a = true 　エラーにならない
```

final 値の変更不可能
const みたなもの

```dart
final c = 123
c = 'aaa' エラーになる
```

const 値の変更不可能(コンパイル時に)
const みたいなもの

```dart
const c = 123
c = 'aaa' エラーになる
```

final と const の違い  
値を代入できないことが確定するタイミングが違う

#### 条件分岐

```dart
void main() {
  var a = 1;
  if(a<1){
    print('a');
  }else if(a<2){
    print('b');
  }else{
    print('c');
  }

  switch(a){
    case 0:
      print('a');
      break;
    case 1:
      print('b');
      break;
    case 2:
      print('c');
      break;
  }
}
```

#### リスト set map

リスト 配列のこと  
set リストだけど同じものを追加できない配列  
map key,value のオブジェクトのこと

```dart
void main() {
  // リストの定義と参照
  var list = ['a','b','c'];
  print(list);
  print(list[0]);

  // リストへの追加
  var list1 = <int>[];
  list1.add(1);
  list1.add(2);
  print(list1);

  // listの定義方法
  // var list2 = List<int>();
  List<int> list3 = [];

  var set1 = {'a','b','c'};
  set1.add('a');
  print(set1);

  Set set2={};
  set2.add('tama');
  print(set2);

  var map1 = {
    'a':1,
    'b':2,
    'c':3,
  };

  print(map1['a']);
  map1['a'] = 3;
  print(map1);

  var map2 = {};
  map2['d'] = 4;
  print(map2);
}
```

#### ループ

```dart
void main() {
  for (int i = 0; i < 10; i++) {
    print(i);
  }


  var names = ["Pochi", "Taro", "Jiro", "Shiro"];
  for (var name in names) {
    print(name);
  }

  int i = 0;
  while (i < 10) {
    print(i);
    i++;
  }
}
```

#### 演習

```dart
// 演習: 分岐とループを使い、リストnumsの中の10より小さい数をprintで表示しましょう

void main() {
  var numbers = [21, 5, 0, 10, 15, 8, 3, 12, 1, 2, 31, 9];

  // 以下にコードを記述する
  for(var number in numbers){
    if(number < 10){
      print(number);
    }
  }
}
```

#### 関数

```dart

// 最初に返り値の型をかく
int addFunc1(int a , int b){
  return a +b;
}
// 返り値がない場合
void addFunc2(int a , int b){
  print(a +b);
}

// arrowで省略
int addFunc3(int a , int b) => a + b;

// 引数で[]で囲まれてる場合は省略可能、省略された場合null
int addFunc4(int a , int b, [int? c, int? d]) {
  int result = a + b;
  if(c != null) result += c;
  if(d != null) result += d;
  return result;
}


// 引数で{}で囲まれてる場合は省略可能、呼び出し時に変数を指定できる（省略された場合null）
int addFunc5(int a , int b, {int? c, int? d}) {
  int result = a + b;
  if(c != null) result += c;
  if(d != null) result -= d;
  return result;
}

void main() {
  print(addFunc1(1,2));
  addFunc2(3,4);
  print(addFunc3(1,2));
  print(addFunc4(1,2,3));
  print(addFunc5(1,2,d:3));
}

```

#### クラス

```dart
// classの定義
class Dog1 {
  // メンバ変数
  String name = '';

  // コンストラクタはクラス名から始める
  Dog1(String name){
    this.name = name;
  }

  // メンバメソッド
  String sayName(){
    return 'Im $name';
  }
}


class Dog2 {
  // メンバ変数
  String name = '';
  int age = 0;
  String message = '';

  // コンストラクタはクラス名から始める
  // 省略表記
  Dog2(this.name, this.age);


  //セッター
  // メンバ変数に値を入れる
  // greetingにアクセスしたときに値を入れる事ができる
  set greeting(String text) => message = "$name : $text";

  // ゲッター　取得
  String get introduction => "Name: $name\nAge:$age\n$message";

}



void main() {
  Dog1 dog1 = Dog1('inu');
  print(dog1.sayName());


  Dog2 dog2 = Dog2('inu',10);
  dog2.greeting = 'unko';
  print(dog2.introduction);

}

```

#### 継承

```dart
// classの定義
class Dog {
  // メンバ変数
  String name = '';

  // コンストラクタはクラス名から始める
  Dog(this.name);

  // メンバメソッド
  void sayName(){
    print('Im $name');
  }
}

// クラスの継承
class Shiba extends Dog{
  int age = 0;

  // 継承元のメンバ変数の参照
  Shiba(String name, int age):super(name){
    this.age = age;
  }

  void sayAge(){
    print('$name:$age');
  }

}


void main() {
  Shiba shiba = Shiba('inu',0);
  shiba.sayName();
  shiba.sayAge();
}

```

#### mixinin

必要な機能を付け足すことができる

```dart
// classの定義
class Dog {
  // メンバ変数
  String name = '';

  // コンストラクタはクラス名から始める
  Dog(this.name);

  // メンバメソッド
  void sayName(){
    print('Im $name');
  }
}



// ミックスイン　メンバー変数とメソッドをかける
mixin Jump{
  void jump(){
    print('jump');
  }
}

mixin Sleep{
  void sleep(){
    print('sleep');
  }
}


// クラスの継承
// withでmixinのメソッドを使うことをできる
class Shiba extends Dog with Jump,Sleep{
  int age = 0;

  // 継承元のメンバ変数の参照
  Shiba(String name, int age):super(name){
    this.age = age;
  }

  void sayAge(){
    print('$name:$age');
  }
}


void main() {
  Shiba shiba = Shiba('inu',0);
  shiba.jump();
  shiba.sleep();
}

```

#### Abstract

```dart
// 抽象クラス　このクラスはかならず継承されないといけない
abstract class Dog {
  String name = '';

  Dog(this.name);

  void sayName(){
    print('Im $name');
  }

  //継承先で必ず実装されるもの
  // 抽象メソッド
  void jump();
}


mixin Jump{
  void jump(){
    print('jump');
  }
}

mixin Sleep{
  void sleep(){
    print('sleep');
  }
}


class Shiba extends Dog with Jump,Sleep{
  int age = 0;


  Shiba(String name, int age):super(name){
    this.age = age;
  }

  void sayAge(){
    print('$name:$age');
  }
}


void main() {
  Shiba shiba = Shiba('inu',0);
  shiba.jump();
  shiba.sleep();
}

```

#### インターフェース

```dart
// 抽象クラス　このクラスはかならず継承されないといけない
abstract class Dog {
  String name = '';

  Dog(this.name);

  void sayName(){
    print('Im $name');
  }

  //継承先で必ず実装されるもの
  // 抽象メソッド
  void jump();
}


class Jump{
  void jump(){
    print('jump');
  }
}

class Sleep{
  void sleep(){
    print('sleep');
  }
}

//　クラスの生成と同時に暗黙的インターフェース（外部とのやり取り）を生成する
// implementsの記述によってShibaはJump,Sleepの記述を必須にすることになる
// Shibaはjump,sleepのインターフェースを備える
// インターフェースとは外部のやりとり

class Shiba extends Dog implements Jump,Sleep {
  int age = 0;


  Shiba(String name, int age):super(name){
    this.age = age;
  }

  void sayAge(){
    print('$name:$age');
  }

  void jump(){
    print('jump');
  }

  void sleep(){
    print('sleep');
  }
}

void main() {
  Shiba shiba = Shiba('inu',0);
  shiba.jump();
  shiba.sleep();
}

```

#### 演習

```dart
// 演習: Tunaクラスにコードを追記して、エラーが発生しないようにしましょう

abstract class Fish {
  String name ='';

  Fish(this.name);

  void sayName(){
    print("I'm $name.");
  }

  void swim();
}

mixin Swim {
  void swim() {
    print("Sui-sui!");
  }
}

// 以下のクラスにコードを追記する Fishを継承し、Swimをミックスインする
class Tuna extends Fish  with Swim {
  String color = '';

  Tuna(String name, String color) : super(name){
    this.color = color;
  }

  void sayColor(){
    print("I'm $color.");
  }
}

void main() {
  Tuna tuna = Tuna("Magy", "blue");
  tuna.sayName();
  tuna.swim();
  tuna.sayColor();
}
```

#### ジェネリクス

```dart
// ジェネリクスを伴うクラス
class Dog<T> {
  T name;  // Tは後に決定される型

  Dog(this.name);

  void sayName(){
    print(name);
  }
}

void main() {
  print("----- インスタンスごとに異なる型 -----");
  Dog dog1 = Dog<String>("Hachi");
  dog1.sayName();

  Dog dog2 = Dog<int>(8);
  dog2.sayName();

  print("----- ジェネリクスをリストで利用 -----");
  var names = [];
  names.addAll(["Pochi", "Taro", "Jiro"]);
//   names.add(8); // Error
  print(names);
}
```

#### 例外処理

```dart
void main() {
  try{
    throw 'エラーです';
  }catch(e,s){
    print(e);
    print(s);
  }finally{
    print('例外のありなしに関わらずかならず実行');
  }
}
```

#### Enum

```dart
// 列挙型
enum Animal {dog, cat, rabbit}

void main() {
  var animal = Animal.rabbit;
  switch(animal){
    case Animal.dog:
      print('dog');
      break;
    case Animal.cat:
      print('cat');
      break;
    case Animal.rabbit:
      print('rabbit');
      break;
  }
}
```

#### 非同期処理

```dart
// 非同期処理

//同期処理　ある処理が完了するまで次の処理を実行しない
// 非同期処理　ある処理が完了する前に、他の処理を実行

// 1 2 3の順番で実行
void aFunc(){
  print('1');
  print('2');
  print('3');
}

// 1 3 2の順番で実行
// 非同期にさせる
void aFunc2(){
  print('1');
  Future<String> future = Future.delayed(Duration(seconds:1),()=>'2');
   future.then((message)=> print(message));
  print('3');
}

Future<void> printWithDelay(String message) async {
  await Future.delayed(Duration(seconds:1));
  print(message);
}

// 1 ... 2 3の順番で実行
void aFunc3() async{
  print('1');
  await printWithDelay('2');
  print('3');
}


void main() {
  aFunc3();
}
```

### コード規則

https://dart.dev/guides/language/effective-dart/style

### 無名関数

```dart
void main(){
  // 関数を変数に入れる
  var hello1 = (name) {
    return "Hi, ${name}!";
  };
  print(hello1("Taro"));

  // ワンライナーで記述
  var hello2 = (name) => "Hello, ${name}!";
  print(hello2("Jiro"));

  // リストのforEachメソッド
  var names = ["Pochi", "Taro", "Jiro", "Shiro"];
  names.forEach((name) {
    print("I'm " + name);
  });
}
```

### ウィジェット

見た目に拘る部分を構成するパーツ
文字、ボタンなど、見えない部分でも使われる

ツリー構造で組み合わせることでかんたんに実装でる

stateful
ユーザーの操作などに動的に変更されるもの

stateless
状態をもたない

マテリアルデザイン
google のデザインシステム
現実世界の物理的な法則に従ったデザイン
直感的な UI ってこと
マテリアルデザイン用のウィジェットがたくさんある
