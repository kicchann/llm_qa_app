// flutter
import 'package:botob/model/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

ThemeData returnThemeData({
  required BuildContext context,
  required AsyncValue<Setting> asyncSetting,
}) {
  final Setting currentSetting = asyncSetting.when(
    data: (setting) => setting,
    loading: () => const Setting(uid: ""),
    error: (error, stackTrace) => const Setting(uid: ""),
  );
  final ThemeData theme = currentSetting.isDarkTheme
      ? ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(currentSetting.primaryColor),
        )
      : ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(currentSetting.primaryColor),
        );
  // ? ThemeData.dark()
  //     .copyWith(primaryColor: Color(currentSetting.primaryColor))
  // : ThemeData.light()
  //     .copyWith(primaryColor: Color(currentSetting.primaryColor));
  return theme;
}
