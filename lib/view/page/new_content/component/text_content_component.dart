// flutter
import 'package:botob/repogitory/index_manager_repogitory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// constants
import 'package:botob/constant/colors.dart';
import 'package:botob/constant/doubles.dart';
import 'package:botob/constant/routes.dart' as routes;
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/reffered_document/reffered_document.dart';

// repogitories
import 'package:botob/repogitory/content_repogitory.dart';
import 'package:botob/repogitory/firebase_user_repogitory.dart';
import 'package:botob/repogitory/reffered_document_repogitory.dart';

// views
import 'package:botob/view/component/button/rounded_button_text.dart';
import 'package:botob/view/component/text_field/rounded_text_field.dart';

// view models
import 'package:botob/view_model/new_content/new_content_state.dart';
import 'package:botob/view_model/new_content/new_content_view_model.dart';

/*
ドキュメントを新規作成する画面
テキストを直接入力するタブ
・テキストを直接入力するpart
  ・タイトル
  ・本文
・決定ボタン
・キャンセルボタン
*/

class TextContentComponent extends HookConsumerWidget {
  const TextContentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // テキスト入力フォームの表示・非表示を管理する変数
    User? user = ref.watch(firebaseUserStreamProvider).value;
    String uid = user!.uid;
    final NewContentState newContentState =
        ref.watch(newContentViewModelProvider);
    final NewContentViewModel newContentViewModel =
        ref.read(newContentViewModelProvider.notifier);
    final IndexManagerRepository indexManagerRepogitory =
        IndexManagerRepository();
    final RefferedDocumentRepository refferedDocumentRepogitory =
        RefferedDocumentRepository();
    final ContentRepository contentRepogitory = ContentRepository();
    final double normalWidth = getWidth(context, normalColumnWidth);
    final double largeWidth = getWidth(context, largeColumnWidth);
    final TextEditingController titleController =
        useTextEditingController(text: newContentState.title);
    final TextEditingController bodyController =
        useTextEditingController(text: newContentState.body);

    return Column(
      children: [
        const SizedBox(height: 20),
        RoundedTextField(
          keyboardType: TextInputType.text,
          onChanged: (String value) {
            newContentViewModel.updateTitle(value);
            int titleCursorPos = titleController.selection.base.offset;
            titleController.selection = TextSelection.fromPosition(
                TextPosition(offset: titleCursorPos));
          },
          controller: titleController,
          labelText: titleContentText,
          width: largeWidth,
          maxLength: 50,
        ),
        const SizedBox(height: 20),
        RoundedTextField(
          keyboardType: TextInputType.multiline,
          onChanged: (String value) {
            newContentViewModel.updateBody(value);
            int bodyCursorPos = bodyController.selection.base.offset;
            bodyController.selection =
                TextSelection.fromPosition(TextPosition(offset: bodyCursorPos));
          },
          controller: bodyController,
          labelText: bodyContentText,
          width: largeWidth,
          maxLines: 10,
          maxLength: 5000,
        ),
        const SizedBox(height: 20),
        RoundedButtonText(
          text: decideButtonText,
          width: normalWidth,
          color: (newContentState.title == '' || newContentState.body == '')
              ? disabledColor
              : Theme.of(context).primaryColor,
          onPressed: () async {
            if (newContentState.title == '' || newContentState.body == '') {
              null;
            } else {
              /*
              ドキュメントを新規作成する
              1. firestoreにindexManagerを作成する(reffredDocumentIdのお迎え準備)
              2. firestoreにrefferedDocumentを作成する(cloud function: create_documentが発火)
              3. firestoreにcontentを作成する

               */
              RefferedDocument refferedDocument = RefferedDocument(
                createdAt: null,
                refferedDocumentId: returnUuidV4(),
                title: newContentState.title,
                body: newContentState.body,
                fileName: '',
                storageContentId: '',
                storageDocumentId: '',
              );
              // 1. firestoreにindexManagerを作成する(reffredDocumentIdのお迎え準備)
              await indexManagerRepogitory.createIndexManager(
                uid: uid,
                contentId: newContentState.contentId,
                refferedDocumentIds: [refferedDocument.refferedDocumentId],
              );
              // 2. firestoreにrefferedDocumentを作成する(cloud function: create_documentが発火)
              await refferedDocumentRepogitory.createRefferedDocument(
                uid: uid,
                refferedDocumentId: refferedDocument.refferedDocumentId,
                title: refferedDocument.title,
                body: refferedDocument.body,
                fileName: refferedDocument.fileName,
                storageContentId: refferedDocument.storageContentId,
                storageDocumentId: refferedDocument.storageDocumentId,
              );
              // 3. firestoreにcontentを作成する
              await contentRepogitory.createContent(
                uid: uid,
                contentId: newContentState.contentId,
                refferedDocumentIds: [refferedDocument.refferedDocumentId],
                refferedDocumentFileNames: [refferedDocument.fileName],
                title: newContentState.title,
              );
              if (!context.mounted) return;
              newContentViewModel.refresh();
              routes.toMyApp(context: context);
            }
          },
        ),
        const SizedBox(height: 20),
        RoundedButtonText(
          text: cancelButtonText,
          width: normalWidth,
          onPressed: () {
            newContentViewModel.refresh();
            routes.toMyApp(context: context);
          },
          color: cancelColor,
        ),
      ],
    );
  }
}
