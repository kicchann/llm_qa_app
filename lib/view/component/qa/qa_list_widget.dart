// packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

// constants
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/user_answer/user_answer.dart';
import 'package:botob/model/user_query/user_query.dart';

// repogitories
import 'package:botob/repogitory/user_answer_repogitory.dart';
import 'package:botob/repogitory/user_query_repogitory.dart';

// views
import 'package:botob/view/component/qa/qa_widget.dart';
import 'package:botob/view_model/qa/qa_view_model.dart';

var logger = Logger();

class QaListWidget extends ConsumerWidget {
  const QaListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UserQuery>> asyncQueries =
        ref.watch(userQueryStreamProvider);
    final AsyncValue<List<UserAnswer?>> asyncAnswers =
        ref.watch(userAnswerStreamProvider);
    final QaViewModel qaViewModel = ref.watch(qaViewModelProvider.notifier);

    return asyncQueries.when(
      loading: () => Container(),
      error: (error, stackTrace) {
        logger.e(error, stackTrace: stackTrace);
        return Center(
            child: Text(errorOccurredText,
                style: Theme.of(context).textTheme.bodyMedium));
      },
      data: (queries) {
        queries.removeWhere((query) => query.isDeleted);
        // queriesが空の場合
        if (queries.isEmpty) {
          return Center(
              child: Text(letsQueryText,
                  style: Theme.of(context).textTheme.titleLarge));
        }
        // queriesがある場合
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: queries.length,
            itemBuilder: (BuildContext context, int index) {
              final UserQuery query = queries[index];
              // userAnswerを取得
              final UserAnswer? answer = asyncAnswers.when(
                loading: () => null,
                error: (error, stackTrace) {
                  logger.e(error, stackTrace: stackTrace);
                  return null;
                },
                data: (answers) {
                  return answers.firstWhereOrNull((answer) =>
                      answer != null && answer.queryId == query.queryId);
                },
              );
              // QaWidgetを返す
              return InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () => qaViewModel.updateUserQuery(query),
                onHover: (isHover) {
                  (isHover)
                      ? qaViewModel.updateUserQuery(query)
                      : qaViewModel.refresh();
                },
                child: QaWidget(userQuery: query, userAnswer: answer),
              );
            },
          ),
        );
      },
    );
  }
}
