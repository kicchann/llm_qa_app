// flutter
import 'dart:html' as html;
import 'package:botob/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// constants
import 'package:botob/constant/doubles.dart';
import 'package:botob/constant/enums.dart';
import 'package:botob/constant/strings.dart';

// views
import 'package:botob/view/component/button/rounded_button_text.dart';

class NoticeDocumentPage extends StatelessWidget {
  const NoticeDocumentPage({
    Key? key,
    required this.noticeDocument,
  }) : super(key: key);
  final NoticeDocuments noticeDocument;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(noticeDocument.assetPath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(noticeDocument.value,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Container(
                      width: getWidth(context, largeColumnWidth),
                      height: 500,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).cardColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Markdown(
                          data: snapshot.data ?? '',
                          shrinkWrap: true,
                          onTapLink: (text, href, title) {
                            if (href != null) {
                              html.window.open(href, '');
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RoundedButtonText(
                        width: getWidth(context, normalColumnWidth),
                        text: backButtonText,
                        onPressed: () => Navigator.pop(context)),
                    // 他のドキュメントを表示するボタン
                    if (noticeDocument != NoticeDocuments.termsAndConditions)
                      TextButton(
                        onPressed: () =>
                            toTermsAndConditionsPage(context: context),
                        child: Text(
                          NoticeDocuments.termsAndConditions.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    if (noticeDocument != NoticeDocuments.privacyPolicy)
                      TextButton(
                        onPressed: () => toPrivacyPolicyPage(context: context),
                        child: Text(
                          NoticeDocuments.privacyPolicy.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    if (noticeDocument != NoticeDocuments.compliance)
                      TextButton(
                        onPressed: () => toCompliancePage(context: context),
                        child: Text(
                          NoticeDocuments.compliance.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        } else {
          // You can return a loading spinner here or some sort of placeholder widget
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
