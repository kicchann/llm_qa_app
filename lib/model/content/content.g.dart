// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Content _$$_ContentFromJson(Map<String, dynamic> json) => _$_Content(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      uid: json['uid'] as String,
      contentId: json['contentId'] as String,
      storageIndexId: json['storageIndexId'] as String,
      refferedDocumentIds: (json['refferedDocumentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      refferedDocumentFileNames:
          (json['refferedDocumentFileNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      title: json['title'] as String,
      status: json['status'] as String,
      isPublic: json['isPublic'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ContentToJson(_$_Content instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'uid': instance.uid,
      'contentId': instance.contentId,
      'storageIndexId': instance.storageIndexId,
      'refferedDocumentIds': instance.refferedDocumentIds,
      'refferedDocumentFileNames': instance.refferedDocumentFileNames,
      'title': instance.title,
      'status': instance.status,
      'isPublic': instance.isPublic,
      'isDeleted': instance.isDeleted,
    };
