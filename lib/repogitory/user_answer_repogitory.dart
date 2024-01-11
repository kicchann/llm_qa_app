// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constant
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/user_answer/user_answer.dart';

// view_model
import 'package:botob/view_model/content/content_state.dart';
import 'package:botob/view_model/content/content_view_model.dart';

// FireStoreのUserAnswer情報を取得するプロバイダー
final userAnswerStreamProvider =
    StreamProvider.autoDispose<List<UserAnswer>>((ref) {
  final ContentState contentState = ref.watch(contentViewModelProvider);
  String uid = contentState.user!.uid;
  String contendId = contentState.currentContentId;
  Query<Map<String, dynamic>> cref = FirebaseFirestore.instance
      .collection(
        '$usersFieldKey/$uid/$contentsFieldKey/$contendId/$answerFieldKey',
      )
      .orderBy('createdAt', descending: false);
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = cref.snapshots();
  return stream.map((snapshot) {
    return snapshot.docs.map((doc) => UserAnswer.fromJson(doc.data())).toList();
  });
});

// FireStoreのUserAnswer情報のCRUDはfirebase functionsで行う