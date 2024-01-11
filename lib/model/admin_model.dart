// packages
import 'package:cloud_firestore/cloud_firestore.dart';

// constants
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

class AdminModel {
  AdminModel() {
    _init();
  }

  late final String activeUid;

  void _init() {
    activeUid = returnAuthUser()!.uid;
  }

  /// 管理者権限を持つユーザーのみが実行できる処理
  /// デフォルトのexerciseを登録する
  /// 過去に登録したデフォルトのexerciseは削除される
  Future<void> resetDefaultExercise() async {
    // // バッチの準備
    // WriteBatch batch = FirebaseFirestore.instance.batch();
    // // 先に登録済みのデフォルトのexerciseを削除
    // final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    //     await FirebaseFirestore.instance
    //         .collection(exercisesFieldKey)
    //         .where('isDefault', isEqualTo: true)
    //         .get();
    // for (int i = 0; i < querySnapshot.docs.length; i++) {
    //   final DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore
    //       .instance
    //       .collection(exercisesFieldKey)
    //       .doc(querySnapshot.docs[i].id);
    //   batch.delete(docRef);
    // }
    // await batch.commit();

    // // Map<String, List<String>> defaultExercisesをfor文で回して，firestoreに登録
    // WriteBatch batch2 = FirebaseFirestore.instance.batch();
    // defaultExercises.forEach((bodyPart, exerciseList) {
    //   for (int i = 0; i < exerciseList.length; i++) {
    //     print('name: ${exerciseList[i]}');
    //     final Timestamp now = Timestamp.now();
    //     final String exerciseId = returnUuidV4();
    //     final Exercise exercise = Exercise(
    //       createdAt: now,
    //       updatedAt: now,
    //       exerciseId: exerciseId,
    //       uid: activeUid,
    //       exerciseName: exerciseList[i],
    //       bodyPart: bodyPart,
    //       exerciseType: "weightAndReps",
    //       isDefault: true,
    //       hashTags: [],
    //       text: '',
    //       videoUrl: '',
    //     );
    //     final DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore
    //         .instance
    //         .collection(exercisesFieldKey)
    //         .doc(exerciseId);
    //     batch2.set(docRef, exercise.toJson());
    //   }
    // });
    // // バッチの実行
    // // バッチは500回が上限であることに注意
    // await batch2.commit();
  }
}
