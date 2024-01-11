// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reffered_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RefferedDocument _$$_RefferedDocumentFromJson(Map<String, dynamic> json) =>
    _$_RefferedDocument(
      createdAt: json['createdAt'],
      refferedDocumentId: json['refferedDocumentId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      fileName: json['fileName'] as String,
      storageContentId: json['storageContentId'] as String,
      storageDocumentId: json['storageDocumentId'] as String,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$_RefferedDocumentToJson(_$_RefferedDocument instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'refferedDocumentId': instance.refferedDocumentId,
      'title': instance.title,
      'body': instance.body,
      'fileName': instance.fileName,
      'storageContentId': instance.storageContentId,
      'storageDocumentId': instance.storageDocumentId,
      'isDeleted': instance.isDeleted,
    };
