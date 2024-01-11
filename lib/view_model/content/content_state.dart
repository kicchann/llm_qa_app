// package
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

// constant
import 'package:botob/constant/strings.dart';

part 'content_state.freezed.dart';

@freezed
abstract class ContentState with _$ContentState {
  const factory ContentState({
    required User? user,
    @Default('') String currentContentId,
    @Default(createdAtContent) String sortBy,
    @Default(false) bool isAscending,
  }) = _ContentState;
}
