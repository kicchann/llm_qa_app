// flutter
import 'dart:html' as html;
import 'package:botob/constant/enums.dart';
import 'package:flutter/material.dart';

// packeges
import 'package:hooks_riverpod/hooks_riverpod.dart';

// constatnts
import 'package:botob/constant/routes.dart' as routes;
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/firestore_user/firestore_user.dart';

// repogitories
import 'package:botob/repogitory/firestore_user_repogitory.dart';
import 'package:botob/repogitory/setting_repogitory.dart';

// views
import 'package:botob/view/component/color_picker_dialog_comonent.dart';
import 'package:botob/view/component/image/user_image.dart';

class UserDrawer extends ConsumerWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingRepository settingRepository = SettingRepository();
    final AsyncValue<FirestoreUser?> asyncFirestoreUser =
        ref.watch(firestoreUserFutureProvider);

    return Drawer(
      child: asyncFirestoreUser.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (firestoreUser) => firestoreUser == null
            ? Container()
            : Column(
                children: [
                  /*
                ヘッダ
                */
                  DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // userImage
                        UserImage(
                          length: 80,
                          userImageUrl: firestoreUser.userImageUrl,
                        ),
                        const SizedBox(height: 5),
                        // userName
                        Text(
                          firestoreUser.userName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 5),
                        // userPoint
                        Text(
                          remainingPointText +
                              firestoreUser.userPoint.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  /*
                ダークテーマ
                */
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.dark_mode_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        const Text(themeDrawerTitle),
                      ],
                    ),
                    trailing: Switch(
                        activeColor: Theme.of(context).primaryColor,
                        activeTrackColor:
                            Theme.of(context).primaryColor.withOpacity(0.6),
                        value: Theme.of(context).brightness == Brightness.dark,
                        onChanged: (value) => settingRepository.toggleDarkTheme(
                            uid: firestoreUser.uid)),
                  ),
                  /*
                カラー
                */
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.color_lens_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        const Text(colorDrawerTitle),
                      ],
                    ),
                    trailing: InkWell(
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ColorPickerDialogComponent(
                                selectedColor: Theme.of(context).primaryColor,
                                onColorChange: (Color color) {
                                  settingRepository.updatePrimaryColor(
                                    uid: firestoreUser.uid,
                                    primaryColor: color,
                                  );
                                },
                              );
                            },
                          );
                        }),
                  ),
                  /*
                設定
                */
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.settings_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        const Text(settingDrawerTitle),
                      ],
                    ),
                    onTap: () => routes.toSettingPage(context: context),
                  ),
                  /*
                お問合せ
                */
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.contact_support_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        const Text(queryTitle),
                      ],
                    ),
                    onTap: () => html.window.open(queryLink, ''),
                  ),
                  const Expanded(child: SizedBox()),
                  /* 利用規約・プライバシーポリシー・特商法 */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () =>
                              routes.toTermsAndConditionsPage(context: context),
                          child: Text(
                            NoticeDocuments.termsAndConditions.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () =>
                              routes.toPrivacyPolicyPage(context: context),
                          child: Text(
                            NoticeDocuments.privacyPolicy.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () =>
                              routes.toCompliancePage(context: context),
                          child: Text(
                            NoticeDocuments.compliance.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
