// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Setting _$$_SettingFromJson(Map<String, dynamic> json) => _$_Setting(
      uid: json['uid'] as String,
      isDarkTheme: json['isDarkTheme'] as bool? ?? true,
      primaryColor: json['primaryColor'] as int? ?? 4280391411,
    );

Map<String, dynamic> _$$_SettingToJson(_$_Setting instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'isDarkTheme': instance.isDarkTheme,
      'primaryColor': instance.primaryColor,
    };
