# llm_qa_app

## 履歴

- 2023/10/27: プロジェクト作成
-  

## 概要

ドキュメントファイルをアップロードすることで，そのファイルの内容を解析し，その内容に基づいてボットが返答を行うアプリケーション．  
llama indexのVecotrStoreIndexでindex.jsonを生成して，質問を受け取るとindex.jsonを参照して，関連情報を参照しながら返答を行う．  

アプリの構成は以下

- フロントエンド言語: Flutter/Dart
- バックエンド言語: Python
- プラットフォーム: Firebase
- データベース: Firestore, Firebase Storage
- ホスティング: Firebase Hosting
- 認証: Firebase Authentication
- バックエンド処理: Cloud Functions, Cloud Tasks

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in your preferred IDE.
3. Run the application to see it in action.

For more information on Flutter development, check out the online documentation at https://docs.flutter.dev/.