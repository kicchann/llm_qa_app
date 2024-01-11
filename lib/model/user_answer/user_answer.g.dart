// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserAnswer _$$_UserAnswerFromJson(Map<String, dynamic> json) =>
    _$_UserAnswer(
      answerId: json['answerId'] as String,
      body: json['body'] as String,
      contentId: json['contentId'] as String,
      createdAt: json['createdAt'],
      queryId: json['queryId'] as String,
      sources: json['sources'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$_UserAnswerToJson(_$_UserAnswer instance) =>
    <String, dynamic>{
      'answerId': instance.answerId,
      'body': instance.body,
      'contentId': instance.contentId,
      'createdAt': instance.createdAt,
      'queryId': instance.queryId,
      'sources': instance.sources,
      'uid': instance.uid,
    };
