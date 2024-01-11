import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// packages
part 'user_query.freezed.dart';
part 'user_query.g.dart';

@freezed
abstract class UserQuery with _$UserQuery {
  const factory UserQuery({
    required dynamic createdAt,
    required String uid,
    required String contentId,
    required String queryId,
    required String answerId,
    required String body,
    @Default(false) bool isDeleted,
  }) = _UserQuery;
  factory UserQuery.fromJson(Map<String, dynamic> json) =>
      _$UserQueryFromJson(json);
}
