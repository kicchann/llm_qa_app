// packages
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

// constant
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/voids.dart';

// model
import 'package:botob/model/user_query/user_query.dart';

// repogitories
import 'package:botob/repogitory/user_query_repogitory.dart';

class DeleteQaWidget extends StatelessWidget {
  const DeleteQaWidget({
    Key? key,
    required this.userQuery,
  }) : super(key: key);

  final UserQuery userQuery;

  @override
  Widget build(BuildContext context) {
    UserQueryRepository userQueryRepository = UserQueryRepository();
    // userQueryを論理削除する
    return InkWell(
      onTap: () async {
        await userQueryRepository.deleteQuery(userQuery: userQuery);
        if (!context.mounted) return;
        showSnackBar(
          context: context,
          msg: deletedMsg,
          type: AnimatedSnackBarType.success,
        );
      },
      child: const Icon(Icons.delete_outline_rounded),
    );
  }
}
