// flutter
import 'package:botob/view/component/markdown/custom_pre_builder.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// constant
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/content/content.dart';

// repogitory
import 'package:botob/repogitory/content_repogitory.dart';

// view
import 'package:botob/view/component/content/content_detail_widget.dart';
import 'package:botob/view/component/content/delete_content_dialog_widget.dart';
import 'package:botob/view/component/qa/post_query_widget.dart';
import 'package:botob/view/component/qa/qa_list_widget.dart';
import 'package:url_launcher/url_launcher.dart';

var logger = Logger();

class QaComponent extends ConsumerWidget {
  const QaComponent({
    Key? key,
    required this.currentContentId,
  }) : super(key: key);

  final String currentContentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Content>> asyncContent =
        ref.watch(contentStreamProvider);

    return currentContentId == ''
        // contentが選択されていない場合
        // 選択されてないことを表示
        ? Center(
            child: Text(selectContentText,
                style: Theme.of(context).textTheme.titleLarge))
        // contentが選択されている場合
        // userQueryを取得
        : asyncContent.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              logger.e(error, stackTrace: stackTrace);
              return Center(
                  child: Text(errorOccurredText,
                      style: Theme.of(context).textTheme.bodyMedium));
            },
            data: (contents) {
              // currentContentを取得
              Content? currentContent = contents.firstWhereOrNull((content) {
                return content.contentId == currentContentId;
              });
              // currentContentがnullの場合
              // contentを選択してくださいと表示
              if (currentContent == null) {
                return Center(
                    child: Text(selectContentText,
                        style: Theme.of(context).textTheme.titleLarge));
              }
              // currentContentのstorageIndexIdが空の場合
              // statusを表示
              if (currentContent.storageIndexId == '') {
                // statusに"失敗"が含まれている場合
                // statusとエラーを表示
                if (currentContent.status.toString().contains('失敗')) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(currentContent.status.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Text(deleteFromHereText,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => DeleteContentDialogWidget(
                              content: currentContent),
                        ),
                        child: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                } else {
                  // statusに"失敗"が含まれていない場合
                  // statusとローディングを表示
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(currentContent.status.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                    ],
                  );
                }
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MarkdownWidget(
                          config: MarkdownConfig.darkConfig,
                          data: """
                          # コード

                          あいうえお

                          ```
                          print("Hello World");
                          ```
                          [Zenn](https://zenn.dev)
                          """,
                        ),
                      ),
                      //   child: MarkdownBody(
                      //       selectable: true,
                      //       // builders: {
                      //       //   'pre': CustomPreBuilder(),
                      //       // },
                      //       onTapLink: (text, href, title) {
                      //         // 追加
                      //         if (href != null) {
                      //           launchUrl(Uri.parse(href));
                      //         }
                      //       },
                      //       data: ),
                      // ),
                      // 各種ボタン

                      // contentの詳細を表示
                      ContentDetailWidget(
                        content: currentContent,
                        refferedDocumentIds: currentContent.refferedDocumentIds,
                      ),
                      const QaListWidget(),
                      PostQueryWidget(currentContent: currentContent),
                    ]);
              }
            },
          );
  }
}
