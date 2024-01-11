// content typeについて
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum NoticeDocuments {
  compliance,
  termsAndConditions,
  privacyPolicy,
}

extension NoticeDocumentsExtension on NoticeDocuments {
  static final values = {
    NoticeDocuments.compliance: "特定商取引法に基づく表記",
    NoticeDocuments.termsAndConditions: "利用規約",
    NoticeDocuments.privacyPolicy: "プライバシーポリシー",
  };
  String get value => values[this]!;

  static final assetPaths = {
    NoticeDocuments.compliance: 'assets/compliance.md',
    NoticeDocuments.termsAndConditions: "assets/terms-and-conditions.md",
    NoticeDocuments.privacyPolicy: "assets/privacy-policy.md",
  };

  String get assetPath => assetPaths[this]!;
}

enum ContentTypeIcons {
  txt,
  md,
  json,
  pdf,
}

extension ContentTypeIconsExtension on ContentTypeIcons {
  static final icons = {
    ContentTypeIcons.txt: MdiIcons.textBoxOutline,
    ContentTypeIcons.md: MdiIcons.languageMarkdownOutline,
    ContentTypeIcons.json: MdiIcons.codeJson,
    ContentTypeIcons.pdf: MdiIcons.filePdfBox,
  };

  IconData get icon => icons[this]!;
  IconData getIcon(String contentType) {
    switch (contentType) {
      case 'txt':
        return MdiIcons.textBoxOutline;
      case 'md':
        return MdiIcons.languageMarkdownOutline;
      case 'json':
        return MdiIcons.codeJson;
      case 'pdf':
        return MdiIcons.filePdfBox;
      default:
        return MdiIcons.fileOutline;
    }
  }
}

// サインイン時のエラーメッセージ
enum SigninErrorMessages {
  noError,
  invalidEmailOrPassword,
}

extension SigninErrorMessagesExtension on SigninErrorMessages {
  static final values = {
    SigninErrorMessages.noError: "",
    SigninErrorMessages.invalidEmailOrPassword: "メールアドレスまたはパスワードが間違っています",
  };

  String get value => values[this]!;
}

// サインイン時のエラーメッセージ
enum SignupErrorMessages {
  noError,
  emailAlreadyInUse,
  invalidEmail,
  weakPassword,
  invalidPassword,
}

extension SignupErrorMessagesExtension on SignupErrorMessages {
  static final values = {
    SignupErrorMessages.noError: "",
    SignupErrorMessages.emailAlreadyInUse: "このメールアドレスは既に使用されています",
    SignupErrorMessages.invalidEmail: "メールアドレスが不正です",
    SignupErrorMessages.weakPassword: "パスワードが短すぎます",
    SignupErrorMessages.invalidPassword: "パスワードは英字・数字を含む8文字以上で設定してください",
  };

  String get value => values[this]!;
}
