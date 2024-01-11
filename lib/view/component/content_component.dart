// flutter
import 'package:botob/view/component/button/floating_button_bubble.dart';
import 'package:flutter/material.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constant
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/routes.dart' as routes;

// model
import 'package:botob/model/content/content.dart';

// view
import 'package:botob/view/component/content/sort_widget.dart';
import 'package:botob/view/component/content/content_widget.dart';

// view_model
import 'package:botob/view_model/content/content_state.dart';
import 'package:botob/view_model/content/content_view_model.dart';

// repogitory
import 'package:botob/repogitory/content_repogitory.dart';

class ContentComponent extends ConsumerWidget {
  const ContentComponent({
    required this.isDesktop,
    required this.onTapForMobile,
    Key? key,
  }) : super(key: key);

  final bool isDesktop;
  final VoidCallback onTapForMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Content>> asyncContents =
        ref.watch(contentStreamProvider);
    final ContentState contentState = ref.watch(contentViewModelProvider);
    final ContentViewModel contentViewModel =
        ref.watch(contentViewModelProvider.notifier);

    return Scaffold(
      floatingActionButton: asyncContents.when(
        data: (contents) {
          String text = (contents.isEmpty) ? letsAddContentText : '';
          return FloatingButtonBubble(
            onPressed: () => routes.toNewContentPage(context: context),
            text: text,
          );
        },
        error: (error, stackTrace) => null,
        loading: () => null,
      ),
      body: Center(
        child: SizedBox(
            // width: getWidth(context),
            child: asyncContents.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          data: (contents) {
            // isDeletedがfalseのものだけを表示する
            contents.removeWhere((content) => content.isDeleted);
            // contentsをソートする
            contents = _sortContents(
              contents,
              contentState.sortBy,
              contentState.isAscending,
            );
            return (contents.isEmpty)
                // contentsが空のとき
                ? Text(
                    noContentText,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                // contentsが空でないとき
                : Column(
                    children: [
                      // ソート機能
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          SortWidget(
                            onTapSortFeild: (value) {
                              contentViewModel.updateSortBy(value);
                            },
                            onTapSortOrder: () {
                              contentViewModel.toggleIsAscending();
                            },
                            sortFields: attrsContent,
                            selectedSortField: contentState.sortBy,
                            isAscending: contentState.isAscending,
                          ),
                        ],
                      ),
                      // contentsの表示
                      Expanded(
                        child: ListView.builder(
                          itemCount: contents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ContentWidget(
                              onTap: () {
                                contentViewModel.updateContent(contents[index]);
                                onTapForMobile();
                              },
                              refferedDocumentIds:
                                  contents[index].refferedDocumentIds,
                              refferedFileNames:
                                  contents[index].refferedDocumentFileNames,
                              title: contents[index].title,
                              date: contents[index].createdAt.toDate(),
                              status: contents[index].status,
                            );
                          },
                        ),
                      )
                    ],
                  );
          },
        )),
      ),
    );
  }

  List<Content> _sortContents(
      List<Content> contents, String sortBy, bool isAscending) {
    if (sortBy == createdAtContent) {
      if (isAscending) {
        contents.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      } else {
        contents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    } else if (sortBy == titleContent) {
      if (isAscending) {
        contents.sort((a, b) => a.title.compareTo(b.title));
      } else {
        contents.sort((a, b) => b.title.compareTo(a.title));
      }
    }
    return contents;
  }
}
