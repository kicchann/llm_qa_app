// flutter
import 'package:flutter/material.dart';

// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// constant
import 'package:botob/constant/strings.dart';

// view
import 'package:botob/view/component/content_component.dart';
import 'package:botob/view/component/qa_component.dart';
import 'package:botob/view/component/user_drawer.dart';

// view_model
import 'package:botob/view_model/content/content_state.dart';
import 'package:botob/view_model/content/content_view_model.dart';
import 'package:botob/view_model/mobile_page/mobile_page_state.dart';
import 'package:botob/view_model/mobile_page/mobile_page_view_model.dart';

class MobilePage extends HookConsumerWidget {
  const MobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MobilePageState mobilePageState =
        ref.watch(mobilePageViewModelProvider);
    final MobilePageViewModel mobilePageViewModel =
        ref.watch(mobilePageViewModelProvider.notifier);
    final ContentState contentState = ref.watch(contentViewModelProvider);

    final pageController =
        usePageController(initialPage: mobilePageState.index);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: mobilePageState.index == 0
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text(appTitle),
            )
          : AppBar(
              automaticallyImplyLeading: false, // 自動で生成される戻るボタンを無効化
              leading: InkWell(
                onTap: () {
                  mobilePageViewModel.updateIndex(0);
                  pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              title: const Text(qaPageTitle),
            ),
      endDrawer: mobilePageState.index == 0 ? const UserDrawer() : null,
      body: PageView(
          controller: pageController,
          // ページが変わったらページ番号を変更している
          onPageChanged: (index) {
            mobilePageViewModel.updateIndex(index);
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          // childrenの個数はElementsの数
          children: [
            ContentComponent(
              isDesktop: false,
              onTapForMobile: () {
                // mobile page用にindexを更新
                mobilePageViewModel.updateIndex(1);
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
            QaComponent(currentContentId: contentState.currentContentId),
          ]),
    );
  }
}
