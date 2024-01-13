# フリマPOS
フリマPOSは主にフリーマーケットの個人販売で使用することを想定した簡易的なPOSアプリです。  
フリーマーケットで販売する商品の管理や販売時の会計を行うことができます。  
商品の写真やカテゴリー商品と一緒に登録することができ、スムーズに会計を行うことができます。

お客様がどのような商品があるかスマートフォンで確認できるように、商品一覧ページを表示できるQRコードをダウンロードできます。(対応未定)

※開発中...  
※初回リリースでは認証はなく、外部と通信せずにアプリ単体で利用する  
## 使用可能端末
| OS  | Version | API Levels | 画面サイズ |
| :---: | :-------: | :----------: | :--------: | 
|  Android  |  5.1  | 22 | 5~7インチ |

## 開発環境
| OS | 言語 | SDK  |
| :--: |  :--: |  :--: | 
| macOS(M1) | dart 3.2.3 | Flutter 16.5 | 

## 主要な使用パッケージ

- データベース
  - realm
  - firebase_storage (firebaseにデータを保存する)
- データクラス
  - freezed
- API通信
  - retrofit
- DI
  - riverpod
- ロガー
  - flutter-logger
- 監視
  - firebase_core
  - firebase_crashlytics
  - firebase_performance
  - firebase_messaging
- 認証
  - firebase_auth

## アーキテクチャ

DDD + Clean Architecture + MVVM
　
### ディレクトリ構成
- usecase : アプリケーションでのCRUDなどの操作をドメインオブジェクトを使用して行う
  - context (auth, settingsなど)
    - commands：更新用のユースケース
    - queries：取得用のユースケース
- domain：ドメインごとにディレクトリを分けるようにする
  - 各domain_object：vo, entity, repositoryInterface(DIPする), exception,
- infrastructure：DBやデータの永続化などアプリのシステム基盤に必要なクラス
  - data：DBやshared_preferanceなど
  - repsitores：データ取得や永続化の実装クラス
  - providers：repsitoryやユースケースの提供する
- externals：外部と連携する処理を入れる
  - api：api通信を行うクラス
- presentation
  - constants：画面で使用する定数(幅や色など)
  - components：画面で共通で使用するウィジェット
    - 各ウィジェット名
      - view : ウィジェット
      - view_model：ウィジェットの状態保持とユースケース実行
  - context (auth, settingsなど)
    - 各画面名
      - view：画面
      - view_model : 画面の状態保持とユースケース実行
- common : アプリ全体で使用するクラス
  - constants：共通の定数
  - exceptions：共通の例外
  - extensions :　既存のクラスや型の拡張関数
- test


