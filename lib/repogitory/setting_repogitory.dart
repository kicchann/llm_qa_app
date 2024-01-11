// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// constant
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/setting/setting.dart';

// repogitory
import 'package:botob/repogitory/firebase_user_repogitory.dart';

final logger = Logger();

// FireStoreのsettings情報を取得するプロバイダー
final settingStreamProvider = StreamProvider<Setting>((ref) {
  User? user = ref.watch(firebaseUserStreamProvider).value;
  if (isValidUser(user)) {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(settingsFieldKey).doc(user!.uid);
    // documentを取得
    return docRef.snapshots().map((doc) {
      if (doc.exists) {
        return Setting.fromJson(doc.data()!);
      } else {
        return const Setting(uid: "");
      }
    });
  } else {
    return Stream.value(const Setting(uid: ""));
  }
});

// FireStoreのsettings情報のCRUDを担当するクラス
class SettingRepository {
  SettingRepository();

  Future<void> createSetting({
    required String uid,
  }) async {
    Setting newSetting = Setting(
      uid: uid,
    );
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(settingsFieldKey).doc(uid);
    await docRef.set(newSetting.toJson());
    logger.d('create setting success');
    return;
  }

  Future<void> toggleDarkTheme({
    required String uid,
  }) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(settingsFieldKey).doc(uid);
    final Setting oldSetting =
        await docRef.get().then((value) => Setting.fromJson(value.data()!));

    final Setting newSetting = oldSetting.copyWith(
      isDarkTheme: !oldSetting.isDarkTheme,
    );
    await docRef.update(newSetting.toJson());

    logger.d('toggle dark theme success');
    return;
  }

  Future<void> updatePrimaryColor({
    required String uid,
    required Color primaryColor,
  }) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(settingsFieldKey).doc(uid);
    final Setting oldSetting =
        await docRef.get().then((value) => Setting.fromJson(value.data()!));

    final Setting newSetting = oldSetting.copyWith(
      primaryColor: primaryColor.value,
    );
    await docRef.update(newSetting.toJson());

    logger.d('update primary color success');
    return;
  }
}
