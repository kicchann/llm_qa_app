// flutter
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// constants
import 'package:botob/constant/doubles.dart';
import 'package:botob/constant/ints.dart';
import 'package:botob/constant/others.dart';
import 'package:botob/constant/routes.dart' as routes;
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/colors.dart';
import 'package:botob/constant/voids.dart';

// models
import 'package:botob/model/reffered_document/reffered_document.dart';

// repogitories
import 'package:botob/repogitory/content_repogitory.dart';
import 'package:botob/repogitory/firebase_user_repogitory.dart';
import 'package:botob/repogitory/index_manager_repogitory.dart';
import 'package:botob/repogitory/reffered_document_repogitory.dart';

// views
import 'package:botob/view/component/button/rounded_button_text.dart';
import 'package:botob/view/component/text_field/rounded_text_field.dart';
import 'package:botob/view/component/continuous_text.dart';

// view models
import 'package:botob/view_model/new_content/new_content_state.dart';
import 'package:botob/view_model/new_content/new_content_view_model.dart';

/*
ドキュメントを新規作成する画面
ファイル選択をするタブ
・file pickerのボタン
・決定ボタン
・キャンセルボタン
*/

class FileContentComponent extends HookConsumerWidget {
  const FileContentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(firebaseUserStreamProvider).value;
    String uid = user!.uid;
    final NewContentState newContentState =
        ref.watch(newContentViewModelProvider);
    final NewContentViewModel newContentViewModel =
        ref.read(newContentViewModelProvider.notifier);
    final ContentRepository contentRepogitory = ContentRepository();
    final IndexManagerRepository indexManagerRepogitory =
        IndexManagerRepository();
    final RefferedDocumentRepository refferedDocumentRepogitory =
        RefferedDocumentRepository();
    final double width = getWidth(context, normalColumnWidth);
    final TextEditingController titleController =
        useTextEditingController(text: newContentState.title);
    FilePickerResult? result;

    return Column(
      children: [
        const SizedBox(height: 20),
        RoundedButtonText(
          text: selectFileButtonText,
          width: width,
          color: Theme.of(context).primaryColor,
          // TODO: 複数ファイル選択に対応する
          onPressed: () async {
            result = await FilePicker.platform.pickFiles(
              withData: true,
              type: FileType.custom,
              allowedExtensions: contentTypes,
            );
            if (result != null) {
              List<PlatformFile> files = [result!.files.first];
              // filesを一つずつ処理する
              for (PlatformFile file in files) {
                // 10MB以上のファイルはアップロードしない
                if (file.size > maxFileSize && context.mounted) {
                  showSnackBar(
                    context: context,
                    msg: prohibitedUploadingLargeFile,
                    type: AnimatedSnackBarType.warning,
                  );
                  continue;
                }
                RefferedDocument refferedDocument = RefferedDocument(
                  createdAt: null,
                  refferedDocumentId: returnUuidV4(),
                  title: file.name,
                  body: '',
                  fileName: file.name,
                  storageContentId: returnUuidV4(),
                  storageDocumentId: '',
                );
                await uploadContentFile(
                  uid: uid,
                  storageContentId: refferedDocument.storageContentId,
                  file: file,
                );
                if (!context.mounted) continue;
                newContentViewModel.updateRefferedDocuments([refferedDocument]);
                // 複数ファイルをアップするのを認める場合は以下
                // newContentViewModel.addRefferedContent(refferedDocument);
              }
            }
          },
        ),
        newContentState.refferedDocuments.isEmpty
            ? result == null
                ? Container()
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      ContinuousText(
                        text: 'ファイルを読み込み中',
                        suffix: '...',
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
            : Column(
                children: [
                  const SizedBox(height: 20),
                  RoundedTextField(
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      newContentViewModel.updateTitle(value);
                      int titleCursorPos =
                          titleController.selection.base.offset;
                      titleController.selection = TextSelection.fromPosition(
                          TextPosition(offset: titleCursorPos));
                    },
                    controller: titleController,
                    labelText: titleContentText,
                    width: width,
                    maxLength: 50,
                  ),
                  const SizedBox(height: 20),
                  for (RefferedDocument refferedDocument
                      in newContentState.refferedDocuments)
                    SizedBox(
                      width: width,
                      child: Row(
                        children: [
                          // 拡張子に応じてアイコンを変更する
                          Icon(getMdiIcons([refferedDocument.fileName]),
                              size: 30),
                          const SizedBox(width: 20),
                          Text(refferedDocument.fileName,
                              style: Theme.of(context).textTheme.bodyLarge),
                          const Expanded(child: SizedBox()),
                          IconButton(
                            onPressed: () => newContentViewModel
                                .removeRefferedContent(refferedDocument),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  RoundedButtonText(
                    text: decideButtonText,
                    width: width,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      /*
                      ドキュメントを新規作成する
                      1. firestoreにindexManagerを作成する
                        (reffredDocumentIdのお迎え準備)
                      2. firestoreにrefferedDocumentを作成する
                        (cloud function: create_documentが発火)
                      3. firestoreにcontentを作成する
                      */
                      final List<String> refferedDocumentIds = newContentState
                          .refferedDocuments
                          .map((RefferedDocument refferedDocument) =>
                              refferedDocument.refferedDocumentId)
                          .toList();
                      final List<String> refferedFileNames = newContentState
                          .refferedDocuments
                          .map((RefferedDocument refferedDocument) =>
                              refferedDocument.fileName)
                          .toList();
                      // 1. firestoreにindexManagerを作成する
                      await indexManagerRepogitory.createIndexManager(
                        uid: uid,
                        contentId: newContentState.contentId,
                        refferedDocumentIds: refferedDocumentIds,
                      );
                      // 2. firestoreにrefferedDocumentを作成する
                      for (RefferedDocument refferedDocument
                          in newContentState.refferedDocuments) {
                        await refferedDocumentRepogitory.createRefferedDocument(
                          uid: uid,
                          refferedDocumentId:
                              refferedDocument.refferedDocumentId,
                          title: refferedDocument.title,
                          body: refferedDocument.body,
                          fileName: refferedDocument.fileName,
                          storageContentId: refferedDocument.storageContentId,
                          storageDocumentId: refferedDocument.storageDocumentId,
                        );
                      }
                      // 3. firestoreにcontentを作成する
                      await contentRepogitory.createContent(
                        uid: uid,
                        contentId: newContentState.contentId,
                        refferedDocumentIds: refferedDocumentIds,
                        refferedDocumentFileNames: refferedFileNames,
                        /*
                        TODO: 複数ファイル選択に対応した場合はここも修正を加える
                        */
                        title: newContentState.title == ''
                            ? newContentState.refferedDocuments.first.fileName
                            : newContentState.title,
                      );
                      if (!context.mounted) return;
                      newContentViewModel.refresh();
                      routes.toMyApp(context: context);
                    },
                  ),
                ],
              ),
        const SizedBox(height: 20),
        RoundedButtonText(
          text: cancelButtonText,
          width: width,
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
