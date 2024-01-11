import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// packages
part 'user_answer.freezed.dart';
part 'user_answer.g.dart';

@freezed
abstract class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    required String answerId,
    required String body,
    required String contentId,
    required dynamic createdAt,
    required String queryId,
    required String sources,
    required String uid,
  }) = _UserAnswer;
  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);
}
