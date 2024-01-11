// flutter
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// constant
import 'package:botob/constant/strings.dart';

// view
import 'package:botob/view/component/user_drawer.dart';
import 'package:botob/view/component/content_component.dart';
import 'package:botob/view/component/qa_component.dart';

// view_model
import 'package:botob/view_model/mobile_page/mobile_page_view_model.dart';
import 'package:botob/view_model/content/content_state.dart';
import 'package:botob/view_model/content/content_view_model.dart';

class DesktopPage extends ConsumerWidget {
  const DesktopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MobilePageViewModel mobilePageViewModel =
        ref.watch(mobilePageViewModelProvider.notifier);
    final ContentState contentState = ref.watch(contentViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(appTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const UserDrawer(),
      // widthに応じて表示するwidgetを変更
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ContentComponent(
              isDesktop: true,
              onTapForMobile: () {
                mobilePageViewModel.updateIndex(1);
              },
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Colors.grey),
          Expanded(
            flex: 2,
            child: QaComponent(currentContentId: contentState.currentContentId),
          ),
        ],
      ),
    );
  }
}
