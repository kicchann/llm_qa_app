import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'setting.freezed.dart';
part 'setting.g.dart';

@freezed
abstract class Setting with _$Setting {
  const factory Setting({
    required String uid,
    @Default(true) bool isDarkTheme,
    // 4280391411 = Colors.blue.value
    @Default(4280391411) int primaryColor,
  }) = _Setting;
  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);
}
