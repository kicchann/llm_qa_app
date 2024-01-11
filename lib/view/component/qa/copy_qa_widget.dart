// packages
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// constant
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/voids.dart';

// model
import 'package:botob/model/user_answer/user_answer.dart';
import 'package:botob/model/user_query/user_query.dart';

class CopyQaWidget extends StatelessWidget {
  const CopyQaWidget({
    Key? key,
    required this.userQuery,
    required this.userAnswer,
  }) : super(key: key);

  final UserQuery userQuery;
  final UserAnswer? userAnswer;

  @override
  Widget build(BuildContext context) {
    // クリップボードにコピーする
    return InkWell(
      onTap: () {
        String txt = returnQATextForClipboard(
            userQuery: userQuery, userAnswer: userAnswer);
        Clipboard.setData(ClipboardData(text: txt));
        showSnackBar(
          context: context,
          msg: copiedMsg,
          type: AnimatedSnackBarType.success,
        );
      },
      child: const Icon(Icons.copy_outlined),
    );
  }
}
