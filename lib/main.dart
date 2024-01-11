// flutter
import 'package:botob/constant/enums.dart';
import 'package:botob/constant/others.dart';
import 'package:botob/model/setting/setting.dart';
import 'package:botob/repogitory/setting_repogitory.dart';
import 'package:botob/view/page/notice_document/notice_document_page.dart';
import 'package:botob/view/page/top/top_page.dart';
import 'package:flutter/material.dart';

// packages
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

// firebase_options
import 'package:botob/firebase_options/firebase_options.dart';

// constant
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/themes.dart';

// repogitory
import 'package:botob/repogitory/firebase_user_repogitory.dart';

// view
import 'package:botob/view/page/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<bool> asyncIsAuthenticated = ref.watch(authStreamProvider);
    final AsyncValue<Setting> asyncSetting = ref.watch(settingStreamProvider);

    Widget routeWidget = asyncIsAuthenticated.when(
      data: (isAuthenticated) {
        final bool isValid = isValidUser(returnAuthUser());
        return (isAuthenticated && isValid)
            ? const HomePage()
            : const TopPage();
      },
      loading: () => const Scaffold(
        body: Center(
          child: Text(errorOccurredText),
        ),
      ),
      error: (error, stackTrace) => const Scaffold(
        body: Center(
          child: Text(errorOccurredText),
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: returnThemeData(
        context: context,
        asyncSetting: asyncSetting,
      ),
      home: routeWidget,
      routes: {
        '/transaction_compliance': (context) => const NoticeDocumentPage(
            noticeDocument: NoticeDocuments.compliance),
        '/privacy_policy': (context) => const NoticeDocumentPage(
            noticeDocument: NoticeDocuments.privacyPolicy),
        '/terms_and_conditions': (context) => const NoticeDocumentPage(
            noticeDocument: NoticeDocuments.termsAndConditions),
      },
    );
  }
}
