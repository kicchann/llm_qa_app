// flutter
import 'package:flutter/material.dart';

// pages
import 'package:botob/main.dart';
import 'package:botob/view/page/setting/setting_page.dart';
import 'package:botob/view/admin_page.dart';
import 'package:botob/view/page/sign_up/sign_up_page.dart';
import 'package:botob/view/page/sign_in/sign_in_page.dart';
import 'package:botob/view/page/reset_password/reset_password_page.dart';

import 'package:botob/view/page/new_content/new_content_page.dart';

void toMyApp({required BuildContext context}) {
  Navigator.push(
    // Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyApp()),
  );
}

void toSignupPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignUpPage()),
  );
}

void toSigninPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignInPage()),
  );
}

void toResetPassword({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
  );
}

void toSettingPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SettingPage()),
  );
}

void toAdminPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AdminPage()),
  );
}

void toNewContentPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const NewContentPage()),
  );
}

void toCompliancePage({required BuildContext context}) {
  Navigator.pushNamed(context, '/transaction_compliance');
}

void toPrivacyPolicyPage({required BuildContext context}) {
  Navigator.pushNamed(context, '/privacy_policy');
}

void toTermsAndConditionsPage({required BuildContext context}) {
  Navigator.pushNamed(context, '/terms_and_conditions');
}
