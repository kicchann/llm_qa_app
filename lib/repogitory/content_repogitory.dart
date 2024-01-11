// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// constant
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/content/content.dart';

// repogitories
import 'package:botob/repogitory/firebase_user_repogitory.dart';

final logger = Logger();

// FireStoreのcontents情報を取得するプロバイダー
final contentStreamProvider = StreamProvider<List<Content>>((ref) {
  // User? user = returnAuthUser();
  User? user = ref.watch(firebaseUserStreamProvider).value;
  if (isValidUser(user)) {
    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('$usersFieldKey/${user!.uid}/$contentsFieldKey');
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = cref.snapshots();
    return stream.map((snapshot) {
      return snapshot.docs.map((doc) => Content.fromJson(doc.data())).toList();
    });
  } else {
    return Stream.value([]);
  }
});

// FireStoreのcontents情報のCRUDを担当するクラス
class ContentRepository {
  ContentRepository();

  Future<void> createContent({
    required String uid,
    required String contentId,
    required List<String> refferedDocumentIds,
    required List<String> refferedDocumentFileNames,
    required String title,
  }) async {
    logger.d('ContentRepository.createContent: called');
    DateTime now = DateTime.now();
    Content newContent = Content(
      createdAt: now,
      updatedAt: now,
      uid: uid,
      contentId: contentId,
      storageIndexId: '',
      refferedDocumentIds: refferedDocumentIds,
      refferedDocumentFileNames: refferedDocumentFileNames,
      title: title,
      status: startCreationStatusMeg,
    );

    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('/$usersFieldKey/$uid/$contentsFieldKey');
    await cref.doc(newContent.contentId).set(newContent.toJson());
    logger.d(
        'ContentRepository.createContent: created content ${newContent.contentId}');
    return;
  }

  Future<void> deleteContent({
    required Content content,
  }) async {
    logger.d('ContentRepository.deleteContent: called');
    String uid = content.uid;
    // contentのデータを理論削除
    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('/$usersFieldKey/$uid/$contentsFieldKey');
    await cref.doc(content.contentId).update({'isDeleted': true});
    logger.d('ContentRepository.deleteContent: finished');
    return;
  }
}
