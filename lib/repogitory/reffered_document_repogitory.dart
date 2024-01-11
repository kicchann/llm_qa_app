// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// constants
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/reffered_document/reffered_document.dart';

// repogitories
import 'package:botob/repogitory/firebase_user_repogitory.dart';

final logger = Logger();

// FireStoreのcontents情報を取得するプロバイダー
final refferedDocumentStreamProvider =
    StreamProvider<List<RefferedDocument>>((ref) {
  // User? user = returnAuthUser();
  User? user = ref.watch(firebaseUserStreamProvider).value;
  if (isValidUser(user)) {
    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('$usersFieldKey/${user!.uid}/$refferedDocumentsFieldKey');
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = cref.snapshots();
    return stream.map((snapshot) {
      return snapshot.docs
          .map((doc) => RefferedDocument.fromJson(doc.data()))
          .toList();
    });
  } else {
    return Stream.value([]);
  }
});

// FireStoreのcontents情報のCRUDを担当するクラス
class RefferedDocumentRepository {
  RefferedDocumentRepository();

  Future<void> createRefferedDocument({
    required String uid,
    required String refferedDocumentId,
    required String title,
    required String body,
    required String fileName,
    required String storageContentId,
    String storageDocumentId = '',
  }) async {
    logger.d('RefferedContentRepository.createRefferedDocument: called');
    DateTime now = DateTime.now();
    final RefferedDocument reffredDocument = RefferedDocument(
        createdAt: now,
        refferedDocumentId: refferedDocumentId,
        title: title,
        body: body,
        fileName: fileName,
        storageContentId: storageContentId,
        storageDocumentId: storageDocumentId);

    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('/$usersFieldKey/$uid/$refferedDocumentsFieldKey');
    await cref.doc(refferedDocumentId).set(reffredDocument.toJson());
    logger.d(
        'RefferedContentRepository.createRefferedDocument: reffered created content ${reffredDocument.refferedDocumentId}');
    return;
  }

  Future<void> deleteRefferedDocument({
    required String uid,
    required RefferedDocument refferedDocument,
  }) async {
    logger.d('RefferedContentRepository.deleteRefferedDocument: called');
    // refferedDocumentを論理削除する
    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('/$usersFieldKey/$uid/$refferedDocumentsFieldKey');
    await cref
        .doc(refferedDocument.refferedDocumentId)
        .update({'isDeleted': true});
    logger.d('RefferedContentRepository.deleteRefferedDocument: finished');
    return;
  }
}
