// dart
import 'dart:io';

// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// constant
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/firestore_user/firestore_user.dart';

// repogitory
import 'package:botob/repogitory/firebase_user_repogitory.dart';

/// FireStoreのユーザー情報を取得するプロバイダー
final firestoreUserFutureProvider = StreamProvider<FirestoreUser?>((ref) {
  User? user = ref.watch(firebaseUserStreamProvider).value;
  if (isValidUser(user)) {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(usersFieldKey).doc(user!.uid);
    // documentを取得
    return docRef.snapshots().map((doc) {
      if (doc.exists) {
        return FirestoreUser.fromJson(doc.data()!);
      } else {
        return null;
      }
    });
  } else {
    return Stream.value(null);
  }
});

/// FireStoreのユーザー情報のCRUDを担当するクラス
class FirestoreUserRepository {
  FirestoreUserRepository();

  Future<void> createFirestoreUser({
    required String email,
    required String userName,
    required String userImageUrl,
    required String uid,
    required String authProvider,
  }) async {
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      updatedAt: now,
      uid: uid,
      email: email,
      authProvider: authProvider,
      isAdmin: false,
      userName: userName,
      userImageUrl: userImageUrl,
      isPremium: false,
      userPoint: 500,
    );
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(usersFieldKey).doc(uid);
    await docRef.set(firestoreUser.toJson());
    return;
  }

  Future<void> updateFirestoreUserName({
    required String uid,
    required String userName,
  }) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(usersFieldKey).doc(uid);
    final FirestoreUser oldFirestoreUser = await docRef
        .get()
        .then((value) => FirestoreUser.fromJson(value.data()!));

    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = oldFirestoreUser.copyWith(
      updatedAt: now,
      userName: userName,
    );
    await docRef.update(firestoreUser.toJson());
    return;
  }

  Future<void> updateFirestoreUserImage({
    required String uid,
    required XFile file,
  }) async {
    const String fileName = 'userImage.jpg';
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child(usersFieldKey)
        .child(uid)
        .child('image')
        .child(fileName);
    // users/uid/ファイル名にアップロード
    // webの場合はputDataを使う

    if (kIsWeb) {
      await storageReference.putData(await file.readAsBytes());
    } else {
      await storageReference.putFile(File(file.path));
    }
    // users/uid/ファイル名のurlを取得
    final String imageUrl = await storageReference.getDownloadURL();
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(usersFieldKey).doc(uid);
    final FirestoreUser oldFirestoreUser = await docRef
        .get()
        .then((value) => FirestoreUser.fromJson(value.data()!));

    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = oldFirestoreUser.copyWith(
      updatedAt: now,
      userImageUrl: imageUrl,
    );
    await docRef.update(firestoreUser.toJson());
    return;
  }

  Future<void> deleteFirestoreUser({
    required String uid,
  }) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(usersFieldKey).doc(uid);
    await docRef.delete();
    return;
  }

  /// firestoreにユーザー情報が存在するかどうかを確認する
  Future<bool> uidExistsInFireStore({required String uid}) async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .doc(uid)
        .get();
    return userDoc.exists;
  }
}
