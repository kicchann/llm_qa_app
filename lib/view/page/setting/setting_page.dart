// flutter
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constatnt
import 'package:botob/constant/doubles.dart';
import 'package:botob/constant/others.dart';
import 'package:botob/constant/routes.dart' as routes;
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/firestore_user/firestore_user.dart';

// repogitory
import 'package:botob/repogitory/firestore_user_repogitory.dart';

// util
import 'package:botob/util/auth.dart';

// view
import 'package:botob/view/component/icon/circle_icon.dart';
import 'package:botob/view/component/image/user_image.dart';
import 'package:botob/view/component/button/rounded_button_icon_text.dart';
import 'package:botob/view/page/setting/component/stripe_dialog_component.dart';
import 'package:botob/view/page/setting/component/user_name_dialog_component.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  String _authProvider({required String provider}) {
    switch (provider) {
      case 'google.com':
        return 'Google';
      case 'password':
        return 'メールアドレス';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<FirestoreUser?> asyncFirestoreUser =
        ref.watch(firestoreUserFutureProvider);
    final FirestoreUserRepository firestoreUserRepository =
        FirestoreUserRepository();
    final double width = getWidth(context, normalColumnWidth);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(settingDrawerTitle),
      ),
      body: Center(
        child: SizedBox(
          width: width,
          child: asyncFirestoreUser.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
            data: (firestoreUser) => firestoreUser == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      /*
                      ユーザー画像
                      */
                      InkWell(
                        onTap: () async {
                          final file = await returnXFile();
                          file == null
                              ? null
                              : firestoreUserRepository
                                  .updateFirestoreUserImage(
                                  uid: firestoreUser.uid,
                                  file: file,
                                );
                        },
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Stack(
                          children: [
                            UserImage(
                              length: 100,
                              userImageUrl: firestoreUser.userImageUrl.isEmpty
                                  ? ''
                                  : firestoreUser.userImageUrl,
                            ),
                            const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleIcon(
                                  size: 30,
                                  icon: Icons.edit,
                                  iconSize: 20,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      /*
                      ユーザー名
                      */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            firestoreUser.userName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              if (context.mounted) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return UserNameDialogComponent(
                                          oldUserName: firestoreUser.userName,
                                          okAction: (String userName) {
                                            firestoreUserRepository
                                                .updateFirestoreUserName(
                                              uid: firestoreUser.uid,
                                              userName: userName,
                                            );
                                          });
                                    });
                              }
                            },
                            child: const CircleIcon(
                              size: 30,
                              icon: Icons.edit,
                              iconSize: 20,
                              fillColor: Colors.transparent,
                              borderColor: Colors.transparent,
                              iconColor: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      /*
                      メールアドレス
                      */
                      Text(
                        firestoreUser.email,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      /*
                      認証プロバイダ
                      */
                      Text(
                          '認証： ${_authProvider(provider: firestoreUser.authProvider)}',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 20),
                      /*
                      ポイント残高
                      */
                      Text(
                        remainingPointText + firestoreUser.userPoint.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      /*
                      チャージボタン
                      */
                      RoundedButtonIconText(
                        icon: Icons.local_atm_rounded,
                        text: chargeButtonText,
                        onPressed: () {
                          if (context.mounted) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StripeDialogComponent(
                                      userUid: firestoreUser.uid);
                                });
                          }
                        },
                        width: width,
                      ),
                      const SizedBox(height: 20),
                      /*
                      パスワード変更ボタン
                      */
                      if (firestoreUser.authProvider == 'password')
                        RoundedButtonIconText(
                            icon: Icons.password_rounded,
                            text: changePasswordButtonText,
                            onPressed: () =>
                                routes.toResetPassword(context: context),
                            width: width),
                      const SizedBox(height: 20),
                      RoundedButtonIconText(
                        icon: Icons.logout_rounded,
                        text: signoutButtonText,
                        onPressed: () async {
                          try {
                            await Auth().signOut();
                            if (context.mounted) {
                              routes.toMyApp(context: context);
                            }
                          } on FirebaseAuthException catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        width: width,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
