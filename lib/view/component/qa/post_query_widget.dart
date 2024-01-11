// flutter
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

// constants
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/voids.dart';

// models
import 'package:botob/model/firestore_user/firestore_user.dart';
import 'package:botob/model/content/content.dart';

// repogitories
import 'package:botob/repogitory/firestore_user_repogitory.dart';
import 'package:botob/repogitory/user_query_repogitory.dart';

var logger = Logger();

class PostQueryWidget extends HookConsumerWidget {
  const PostQueryWidget({
    Key? key,
    required this.currentContent,
  }) : super(key: key);

  final Content currentContent;

  void _onPostQuery(
    String body,
    BuildContext context,
    AsyncValue<FirestoreUser?> asyncFirestoreUser,
  ) {
    final UserQueryRepository userQueryRepository = UserQueryRepository();
    if (asyncFirestoreUser.value == null) {
      logger.e('firestoreUser is null');
      return;
    }
    FirestoreUser firestoreUser = asyncFirestoreUser.value!;
    if (firestoreUser.userPoint < 10) {
      logger.d('point is not enough to post query');
      // popupを表示
      showSnackBar(
        context: context,
        msg: lackOfPointMsg,
        type: AnimatedSnackBarType.error,
      );
      return;
    }
    userQueryRepository.createQuery(
      content: currentContent,
      body: body,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryText = useState<String>("");
    final qeuryEditingController =
        useTextEditingController(text: queryText.value);
    final AsyncValue<FirestoreUser?> asyncFirestoreUser =
        ref.watch(firestoreUserFutureProvider);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          controller: qeuryEditingController,
          onChanged: (text) {
            queryText.value = text;
            int cursorPos = qeuryEditingController.selection.base.offset;
            qeuryEditingController.selection =
                TextSelection.fromPosition(TextPosition(offset: cursorPos));
          },
          onFieldSubmitted: (text) {
            // 余分な改行を削除
            String body = queryText.value.replaceAll(RegExp(r'\n+'), '\n');
            if (body.trim().isNotEmpty) {
              _onPostQuery(body, context, asyncFirestoreUser);
            }
            qeuryEditingController.clear();
          },
          minLines: 2,
          maxLines: 10,
          decoration: InputDecoration(
            suffixIcon: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (queryText.value != "") {
                      // 余分な改行を削除
                      String body =
                          queryText.value.replaceAll(RegExp(r'\n+'), '\n');
                      if (body.trim().isNotEmpty) {
                        _onPostQuery(body, context, asyncFirestoreUser);
                      }
                    }
                    qeuryEditingController.clear();
                  },
                ),
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: enterQueryText,
          ),
        ),
      ),
    );
  }
}
