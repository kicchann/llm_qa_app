// flutter
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:botob/constant/voids.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

// constant
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/doubles.dart';

// view
import 'package:botob/view/component/text_field/rounded_text_field.dart';
import 'package:botob/view/component/button/rounded_button_text.dart';

var logger = Logger();

class ResetPasswordPage extends HookWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = useState('');

    final TextEditingController emailEditingController =
        TextEditingController(text: email.value);
    final double width = getWidth(context, normalColumnWidth);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(resetPasswordTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // メールアドレス
          RoundedTextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => email.value = text,
            controller: emailEditingController,
            labelText: mailAddressText,
            width: width,
          ),
          // サインインボタン
          RoundedButtonText(
            onPressed: () async {
              try {
                final auth = FirebaseAuth.instance;
                auth.setLanguageCode('ja');
                await auth.sendPasswordResetEmail(email: email.value);
                if (!context.mounted) return;
                showSnackBar(
                  context: context,
                  msg: sendResetPasswordMsg,
                  type: AnimatedSnackBarType.info,
                );
              } catch (e) {
                logger.e('error on send password reset email');
                logger.e(e);
                showSnackBar(
                  context: context,
                  msg: failResetPasswordMsg,
                  type: AnimatedSnackBarType.error,
                );
              }
            },
            text: resetPasswordButtonText,
            width: width,
          ),
        ],
      ),
    );
  }
}
