// flutter
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// view
import 'package:botob/view/page/desktop/desktop_page.dart';
import 'package:botob/view/page/mobile/mobile_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isDesktop = constraints.maxWidth >= 1100;
        return isDesktop ? const DesktopPage() : const MobilePage();
      },
    );
  }
}
