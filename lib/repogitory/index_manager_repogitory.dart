// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// constants
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/index_manager/index_manager.dart';

// repogitories
import 'package:botob/repogitory/firebase_user_repogitory.dart';

final logger = Logger();

// FireStoreのindexManager情報を取得するプロバイダー
final indexManagerStreamProvider = StreamProvider<List<IndexManager>>((ref) {
  User? user = ref.watch(firebaseUserStreamProvider).value;
  if (isValidUser(user)) {
    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('$usersFieldKey/${user!.uid}/$indexManagerFieldKey');
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = cref.snapshots();
    return stream.map((snapshot) {
      return snapshot.docs
          .map((doc) => IndexManager.fromJson(doc.data()))
          .toList();
    });
  } else {
    return Stream.value([]);
  }
});

// FireStoreのindexManager情報のCRUDを担当するクラス
class IndexManagerRepository {
  IndexManagerRepository();

  Future<void> createIndexManager({
    required String uid,
    required String contentId,
    required List<String> refferedDocumentIds,
  }) async {
    logger.d('IndexManagerRepository.createIndexManager: called');
    DateTime now = DateTime.now();
    final IndexManager indexManager = IndexManager(
        createdAt: now,
        indexManagerId: contentId,
        refferedDocumentIds: refferedDocumentIds,
        completedDocumentIds: []);

    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection('/$usersFieldKey/$uid/$indexManagerFieldKey');
    await cref.doc(contentId).set(indexManager.toJson());
    logger.d(
        'IndexManagerRepository.createIndexManager: finished ${indexManager.indexManagerId}');
    return;
  }
}
