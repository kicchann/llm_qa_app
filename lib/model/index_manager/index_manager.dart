import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'index_manager.freezed.dart';
part 'index_manager.g.dart';

@freezed
abstract class IndexManager with _$IndexManager {
  const factory IndexManager({
    required dynamic createdAt,
    required String indexManagerId,
    required List<String> refferedDocumentIds,
    required List<String> completedDocumentIds,
  }) = _IndexManager;
  factory IndexManager.fromJson(Map<String, dynamic> json) =>
      _$IndexManagerFromJson(json);
}
