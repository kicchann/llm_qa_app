// flutter
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

// constants
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/content/content.dart';
import 'package:botob/model/reffered_document/reffered_document.dart';

// repogitories
import 'package:botob/repogitory/reffered_document_repogitory.dart';

// views
import 'package:botob/view/component/content/delete_content_dialog_widget.dart';

class ContentDetailWidget extends ConsumerWidget {
  const ContentDetailWidget({
    Key? key,
    required this.content,
    required this.refferedDocumentIds,
  }) : super(key: key);
  final Content content;
  final List<String> refferedDocumentIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<RefferedDocument>> asyncRefferedDocuments =
        ref.watch(refferedDocumentStreamProvider);
    final List<RefferedDocument> refferedDocumentsList =
        asyncRefferedDocuments.when(
            loading: () => [],
            error: (error, stackTrace) => [],
            data: (refferedDocuments) {
              // refferedDocumentIdsで抽出
              return refferedDocuments
                  .where((refferedDocument) => refferedDocumentIds
                      .contains(refferedDocument.refferedDocumentId))
                  .toList();
            });
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) =>
                      DeleteContentDialogWidget(content: content),
                ),
                child: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(content.title,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  DateFormat('作成日時：$datetimeFormatText')
                      .format(content.createdAt.toDate()),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            children: [
              const SizedBox(height: 10),
              Text("参考資料", style: Theme.of(context).textTheme.bodyMedium),
              for (RefferedDocument refferedDocument in refferedDocumentsList)
                ListTile(
                  leading: Icon(getMdiIcons([refferedDocument.fileName])),
                  onTap: () => {},
                  title: Text(
                    refferedDocument.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                      refferedDocument.body.length > 100
                          ? '${refferedDocument.body.substring(0, 100)}...'
                          : refferedDocument.body,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
