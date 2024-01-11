import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
abstract class Content with _$Content {
  const factory Content({
    required dynamic createdAt,
    required dynamic updatedAt,
    required String uid,
    required String contentId,
    required String storageIndexId,
    required List<String> refferedDocumentIds,
    required List<String> refferedDocumentFileNames,
    required String title,
    required String status,
    @Default(false) bool isPublic,
    @Default(false) bool isDeleted,
  }) = _Content;
  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
