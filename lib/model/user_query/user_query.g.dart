// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserQuery _$$_UserQueryFromJson(Map<String, dynamic> json) => _$_UserQuery(
      createdAt: json['createdAt'],
      uid: json['uid'] as String,
      contentId: json['contentId'] as String,
      queryId: json['queryId'] as String,
      answerId: json['answerId'] as String,
      body: json['body'] as String,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserQueryToJson(_$_UserQuery instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'uid': instance.uid,
      'contentId': instance.contentId,
      'queryId': instance.queryId,
      'answerId': instance.answerId,
      'body': instance.body,
      'isDeleted': instance.isDeleted,
    };
