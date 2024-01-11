// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) {
  return _UserAnswer.fromJson(json);
}

/// @nodoc
mixin _$UserAnswer {
  String get answerId => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get contentId => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get queryId => throw _privateConstructorUsedError;
  String get sources => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAnswerCopyWith<UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnswerCopyWith<$Res> {
  factory $UserAnswerCopyWith(
          UserAnswer value, $Res Function(UserAnswer) then) =
      _$UserAnswerCopyWithImpl<$Res, UserAnswer>;
  @useResult
  $Res call(
      {String answerId,
      String body,
      String contentId,
      dynamic createdAt,
      String queryId,
      String sources,
      String uid});
}

/// @nodoc
class _$UserAnswerCopyWithImpl<$Res, $Val extends UserAnswer>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answerId = null,
    Object? body = null,
    Object? contentId = null,
    Object? createdAt = freezed,
    Object? queryId = null,
    Object? sources = null,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      answerId: null == answerId
          ? _value.answerId
          : answerId // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      queryId: null == queryId
          ? _value.queryId
          : queryId // ignore: cast_nullable_to_non_nullable
              as String,
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserAnswerCopyWith<$Res>
    implements $UserAnswerCopyWith<$Res> {
  factory _$$_UserAnswerCopyWith(
          _$_UserAnswer value, $Res Function(_$_UserAnswer) then) =
      __$$_UserAnswerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String answerId,
      String body,
      String contentId,
      dynamic createdAt,
      String queryId,
      String sources,
      String uid});
}

/// @nodoc
class __$$_UserAnswerCopyWithImpl<$Res>
    extends _$UserAnswerCopyWithImpl<$Res, _$_UserAnswer>
    implements _$$_UserAnswerCopyWith<$Res> {
  __$$_UserAnswerCopyWithImpl(
      _$_UserAnswer _value, $Res Function(_$_UserAnswer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answerId = null,
    Object? body = null,
    Object? contentId = null,
    Object? createdAt = freezed,
    Object? queryId = null,
    Object? sources = null,
    Object? uid = null,
  }) {
    return _then(_$_UserAnswer(
      answerId: null == answerId
          ? _value.answerId
          : answerId // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      queryId: null == queryId
          ? _value.queryId
          : queryId // ignore: cast_nullable_to_non_nullable
              as String,
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserAnswer with DiagnosticableTreeMixin implements _UserAnswer {
  const _$_UserAnswer(
      {required this.answerId,
      required this.body,
      required this.contentId,
      required this.createdAt,
      required this.queryId,
      required this.sources,
      required this.uid});

  factory _$_UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$$_UserAnswerFromJson(json);

  @override
  final String answerId;
  @override
  final String body;
  @override
  final String contentId;
  @override
  final dynamic createdAt;
  @override
  final String queryId;
  @override
  final String sources;
  @override
  final String uid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserAnswer(answerId: $answerId, body: $body, contentId: $contentId, createdAt: $createdAt, queryId: $queryId, sources: $sources, uid: $uid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserAnswer'))
      ..add(DiagnosticsProperty('answerId', answerId))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('contentId', contentId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('queryId', queryId))
      ..add(DiagnosticsProperty('sources', sources))
      ..add(DiagnosticsProperty('uid', uid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserAnswer &&
            (identical(other.answerId, answerId) ||
                other.answerId == answerId) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.queryId, queryId) || other.queryId == queryId) &&
            (identical(other.sources, sources) || other.sources == sources) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, answerId, body, contentId,
      const DeepCollectionEquality().hash(createdAt), queryId, sources, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAnswerCopyWith<_$_UserAnswer> get copyWith =>
      __$$_UserAnswerCopyWithImpl<_$_UserAnswer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserAnswerToJson(
      this,
    );
  }
}

abstract class _UserAnswer implements UserAnswer {
  const factory _UserAnswer(
      {required final String answerId,
      required final String body,
      required final String contentId,
      required final dynamic createdAt,
      required final String queryId,
      required final String sources,
      required final String uid}) = _$_UserAnswer;

  factory _UserAnswer.fromJson(Map<String, dynamic> json) =
      _$_UserAnswer.fromJson;

  @override
  String get answerId;
  @override
  String get body;
  @override
  String get contentId;
  @override
  dynamic get createdAt;
  @override
  String get queryId;
  @override
  String get sources;
  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$_UserAnswerCopyWith<_$_UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}
