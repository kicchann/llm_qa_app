import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'reffered_document.freezed.dart';
part 'reffered_document.g.dart';

@freezed
abstract class RefferedDocument with _$RefferedDocument {
  const factory RefferedDocument({
    required dynamic createdAt,
    required String refferedDocumentId,
    required String title,
    required String body,
    required String fileName,
    required String storageContentId,
    required String storageDocumentId,
    @Default(false) bool isDeleted,
  }) = _RefferedDocument;
  factory RefferedDocument.fromJson(Map<String, dynamic> json) =>
      _$RefferedDocumentFromJson(json);
}
