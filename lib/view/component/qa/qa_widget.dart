import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

// constants
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/user_answer/user_answer.dart';
import 'package:botob/model/user_query/user_query.dart';
import 'package:intl/intl.dart';

// views
import 'package:botob/view/component/qa/copy_qa_widget.dart';
import 'package:botob/view/component/qa/delete_qa_widget.dart';

// view_models
import 'package:botob/view_model/qa/qa_state.dart';
import 'package:botob/view_model/qa/qa_view_model.dart';

class QaWidget extends ConsumerWidget {
  const QaWidget({
    Key? key,
    required this.userQuery,
    required this.userAnswer,
  }) : super(key: key);

  final UserQuery userQuery;
  final UserAnswer? userAnswer;

  // userAnswerのresponseからsourceを取得
  List<dynamic> get sources {
    if (userAnswer == null) {
      return [];
    } else {
      return convert.jsonDecode(userAnswer!.sources);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final QaState qaState = ref.watch(qaViewModelProvider);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: qaState.activeQuery == userQuery ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                // コピーする
                CopyQaWidget(
                  userQuery: userQuery,
                  userAnswer: userAnswer,
                ),
                const SizedBox(width: 10),
                // 削除する
                DeleteQaWidget(userQuery: userQuery),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _queryWidget(context, userQuery),
                  const Divider(),
                  _answerWidget(context, userAnswer),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _queryWidget(BuildContext context, UserQuery userQuery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          userQuery.body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Text(
              DateFormat(datetimeFormatText)
                  .format(userQuery.createdAt.toDate()),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _answerWidget(BuildContext context, UserAnswer? userAnswer) {
    if (userAnswer == null) {
      return SelectableText(
        noAnswerText,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            userAnswer.body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(
                DateFormat(datetimeFormatText)
                    .format(userAnswer.createdAt.toDate()),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            trailing: const SizedBox(width: 0.0, height: 0.0),
            title: Text(
              referenceText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            // childrenはfor文で回して生成
            // response['source']はList型なので、for文でindexと要素を取得
            // for文で取得した要素はindexとsource
            // sourceはMap型で，keyはmetadataとtext
            // metadataもMap型なので，For文で回してkeyとvalueを取得して，文字列metadataToStringを生成
            // source['text']とmetadataToStringをColumnで表示
            children: [
              for (var index = 0; index < sources.length; index++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      sources[index]['text']
                          .replaceAll('\n', '')
                          .replaceAll('\r', ''),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    for (var key in sources[index]['metadata'].keys)
                      Text(
                        key + ': ' + sources[index]['metadata'][key].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (index != sources.length - 1) const Divider(),
                  ],
                ),
            ],
          ),
        ],
      );
    }
  }
}
