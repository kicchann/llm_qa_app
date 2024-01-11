// flutter
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// constant
import 'package:botob/constant/doubles.dart';
import 'package:botob/constant/enums.dart';
import 'package:botob/constant/others.dart';
import 'package:botob/constant/routes.dart' as routes;
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/voids.dart';

// model
import 'package:botob/model/sign_up_model.dart';

// view
import 'package:botob/view/component/text_field/rounded_text_field.dart';
import 'package:botob/view/component/text_field/rounded_password_field.dart';
import 'package:botob/view/component/button/rounded_button_text.dart';
import 'package:botob/view/component/button/rounded_button_asset_text.dart';

class SignUpPage extends HookWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userName = useState<String>('');
    final email = useState<String>('');
    final password = useState<String>('');
    final isObscure = useState<bool>(true);
    final signupErrorMessage =
        useState<SignupErrorMessages>(SignupErrorMessages.noError);

    final userNameEditingController =
        useTextEditingController(text: userName.value);
    final emailEditingController = useTextEditingController(text: email.value);
    final passwordEditingController =
        useTextEditingController(text: password.value);

    final SignupModel signUpModel = SignupModel();
    final double width = getWidth(context, normalColumnWidth);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*
          タイトル
          */
          Text(
            signupPageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          /*
          ユーザー名入力欄
          */
          RoundedTextField(
              keyboardType: TextInputType.name,
              onChanged: (text) {
                // 改行は入力できないようにする
                userName.value = text.replaceAll('\n', '');
                int userNameCursorPos =
                    userNameEditingController.selection.base.offset;
                userNameEditingController.selection =
                    TextSelection.fromPosition(
                        TextPosition(offset: userNameCursorPos));
              },
              controller: userNameEditingController,
              labelText: userNameText,
              maxLength: 30,
              width: width),
          const SizedBox(height: 20),
          /*
          メールアドレス入力欄
          */
          RoundedTextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                email.value = text;
                int emailCursorPos =
                    emailEditingController.selection.base.offset;
                emailEditingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: emailCursorPos));
              },
              controller: emailEditingController,
              labelText: mailAddressText,
              width: width),
          const SizedBox(height: 20),
          /*
          パスワード入力欄
          */
          RoundedPasswordField(
            onChanged: (text) {
              password.value = text;
              int passwordCursorPos =
                  passwordEditingController.selection.base.offset;
              passwordEditingController.selection = TextSelection.fromPosition(
                  TextPosition(offset: passwordCursorPos));
            },
            controller: passwordEditingController,
            isObscure: isObscure.value,
            toggleIsObscure: () => isObscure.value = !isObscure.value,
            width: width,
          ),
          const SizedBox(height: 10),
          /*
          エラーメッセージ
          */
          Text(
            signupErrorMessage.value.value,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(height: 20),
          /*
          サインアップボタン
          */
          RoundedButtonText(
            onPressed: () async {
              if (isValidPassword(password.value) ==
                  SignupErrorMessages.noError) {
                signupErrorMessage.value = SignupErrorMessages.noError;
                await signUpModel.createUserWithEmailAndPassword(
                  context: context,
                  email: email.value,
                  password: password.value,
                  userName: userName.value,
                );
                // サインアウトしておく
                await signUpModel.signOut();
                if (context.mounted) {
                  routes.toMyApp(context: context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(signinDialogTitle),
                      content: const Text(signinDialogText),
                      actions: [
                        TextButton(
                          onPressed: () => routes.toMyApp(context: context),
                          child: const Text(okButtonText),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                signupErrorMessage.value = isValidPassword(password.value);
              }
            },
            text: signUpText,
            width: width,
          ),
          const SizedBox(height: 20),
          /*
          Googleアカウントでサインイン
          */
          RoundedButtonAssetText(
            onPressed: () async {
              await signUpModel.createUserWithGoogle(context: context);
              if (context.mounted) {
                showSnackBar(
                  context: context,
                  msg: userCreatedMsg,
                  type: AnimatedSnackBarType.success,
                );
                routes.toMyApp(context: context);
              }
            },
            assetName: googleLogoAsset,
            text: signInGoogleText,
            width: width,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          /*
          サインアップページへ移動
          */
          TextButton(
              onPressed: () => routes.toSigninPage(context: context),
              style: Theme.of(context).textButtonTheme.style,
              child: const Text(hasAccountText)),
        ],
      ),
    );
  }
}
