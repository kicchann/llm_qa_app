// package
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// models
import 'package:botob/model/user_query/user_query.dart';

part 'qa_state.freezed.dart';

@freezed
abstract class QaState with _$QaState {
  const factory QaState({
    @Default(null) UserQuery? activeQuery,
  }) = _QaState;
}
