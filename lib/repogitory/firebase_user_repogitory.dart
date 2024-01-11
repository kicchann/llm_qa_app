// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FireBaseの認証状態プロバイダー
final authStreamProvider = StreamProvider((_) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
});

/// FireBase Authenticationのユーザー情報を取得するプロバイダー
final firebaseUserStreamProvider = StreamProvider((_) {
  return FirebaseAuth.instance.authStateChanges().map((user) {
    return user;
  });
});

/// FireBase Authenticationのユーザー情報のCRUDを担当するクラス
