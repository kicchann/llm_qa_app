// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constant
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/content/content.dart';
import 'package:botob/model/user_query/user_query.dart';

// view_model
import 'package:botob/view_model/content/content_state.dart';
import 'package:botob/view_model/content/content_view_model.dart';

// FireStoreのUserQuery情報を取得するプロバイダー
final userQueryStreamProvider =
    StreamProvider.autoDispose<List<UserQuery>>((ref) {
  final ContentState contentState = ref.watch(contentViewModelProvider);
  String uid = contentState.user!.uid;
  String contendId = contentState.currentContentId;
  Query<Map<String, dynamic>> cref = FirebaseFirestore.instance
      .collection(
        '$usersFieldKey/$uid/$contentsFieldKey/$contendId/$queryFieldKey',
      )
      .orderBy('createdAt', descending: false);
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = cref.snapshots();
  return stream.map((snapshot) {
    return snapshot.docs.map((doc) => UserQuery.fromJson(doc.data())).toList();
  });
});

// FireStoreのUserQuery情報のCRUDを担当するクラス
class UserQueryRepository {
  UserQueryRepository();

  Future<void> createQuery({
    required Content content,
    required String body,
  }) async {
    DateTime now = DateTime.now();
    String uid = content.uid;
    String queryId = returnUuidV4();
    UserQuery newQuery = UserQuery(
      createdAt: now,
      uid: uid,
      contentId: content.contentId,
      queryId: queryId,
      answerId: "",
      body: body,
    );

    CollectionReference<
        Map<String,
            dynamic>> cref = FirebaseFirestore.instance.collection(
        '/$usersFieldKey/$uid/$contentsFieldKey/${content.contentId}/$queryFieldKey');
    await cref.doc(newQuery.queryId).set(newQuery.toJson());
    return;
  }

  Future<void> deleteQuery({
    required UserQuery userQuery,
  }) async {
    // UserQueryのisDeletedをtrueに変更
    String uid = userQuery.uid;
    String contentId = userQuery.contentId;
    String queryId = userQuery.queryId;

    CollectionReference<Map<String, dynamic>> cref = FirebaseFirestore.instance
        .collection(
            '/$usersFieldKey/$uid/$contentsFieldKey/$contentId/$queryFieldKey');
    await cref.doc(queryId).update({'isDeleted': true});
    return;
  }
}
