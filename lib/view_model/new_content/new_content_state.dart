// package
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// models
import 'package:botob/model/reffered_document/reffered_document.dart';

part 'new_content_state.freezed.dart';

@freezed
abstract class NewContentState with _$NewContentState {
  const factory NewContentState({
    @Default('') String title,
    @Default('') String body,
    @Default([]) List<RefferedDocument> refferedDocuments,
    @Default('') String contentId,
  }) = _NewContentState;
}
