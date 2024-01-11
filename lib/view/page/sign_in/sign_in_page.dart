// flutter
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// constant
import 'package:botob/constant/doubles.dart';
import 'package:botob/constant/enums.dart';
import 'package:botob/constant/routes.dart' as routes;
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/sign_in_model.dart';

// view
import 'package:botob/view/component/text_field/rounded_text_field.dart';
import 'package:botob/view/component/text_field/rounded_password_field.dart';
import 'package:botob/view/component/button/rounded_button_text.dart';
import 'package:botob/view/component/button/rounded_button_asset_text.dart';

class SignInPage extends HookWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = useState<String>('');
    final password = useState<String>('');
    final isObscure = useState<bool>(true);
    final signinErrorMessage =
        useState<SigninErrorMessages>(SigninErrorMessages.noError);

    final emailEditingController = useTextEditingController(text: email.value);
    final passwordEditingController =
        useTextEditingController(text: password.value);

    final SignInModel signInModel = SignInModel();
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
            signinPageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          /*
          メールアドレス入力欄
          */
          RoundedTextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) {
              email.value = text;
              int emailCursorPos = emailEditingController.selection.base.offset;
              emailEditingController.selection = TextSelection.fromPosition(
                  TextPosition(offset: emailCursorPos));
            },
            controller: emailEditingController,
            labelText: mailAddressText,
            width: width,
          ),
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
          TextButton(
            onPressed: () => routes.toResetPassword,
            style: Theme.of(context).textButtonTheme.style,
            child: const Text(resetPasswordText),
          ),
          const SizedBox(height: 10),
          /*
          エラーメッセージ
          */
          Text(
            signinErrorMessage.value.value,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(height: 20),
          /*
          サインインボタン
          */
          RoundedButtonText(
            onPressed: () async {
              await signInModel.signInWithEmailAndPassword(
                context: context,
                email: email.value,
                password: password.value,
              );
              if (signInModel.currentUser != null && context.mounted) {
                routes.toMyApp(context: context);
              } else {
                signinErrorMessage.value =
                    SigninErrorMessages.invalidEmailOrPassword;
              }
            },
            text: signinText,
            width: width,
          ),
          const SizedBox(height: 20),
          /*
          Googleアカウントでサインイン
          */
          RoundedButtonAssetText(
            onPressed: () async {
              await signInModel.signInWithGoogle(
                context: context,
              );
              if (signInModel.currentUser != null && context.mounted) {
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
          サインアップへ移動
          */
          TextButton(
              onPressed: () => routes.toSignupPage(context: context),
              style: Theme.of(context).textButtonTheme.style,
              child: const Text(noAccountText)),
        ],
      ),
    );
  }
}
