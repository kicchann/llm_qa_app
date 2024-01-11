// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IndexManager _$$_IndexManagerFromJson(Map<String, dynamic> json) =>
    _$_IndexManager(
      createdAt: json['createdAt'],
      indexManagerId: json['indexManagerId'] as String,
      refferedDocumentIds: (json['refferedDocumentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      completedDocumentIds: (json['completedDocumentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_IndexManagerToJson(_$_IndexManager instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'indexManagerId': instance.indexManagerId,
      'refferedDocumentIds': instance.refferedDocumentIds,
      'completedDocumentIds': instance.completedDocumentIds,
    };
