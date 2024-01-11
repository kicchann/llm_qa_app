// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserQuery _$UserQueryFromJson(Map<String, dynamic> json) {
  return _UserQuery.fromJson(json);
}

/// @nodoc
mixin _$UserQuery {
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get contentId => throw _privateConstructorUsedError;
  String get queryId => throw _privateConstructorUsedError;
  String get answerId => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserQueryCopyWith<UserQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserQueryCopyWith<$Res> {
  factory $UserQueryCopyWith(UserQuery value, $Res Function(UserQuery) then) =
      _$UserQueryCopyWithImpl<$Res, UserQuery>;
  @useResult
  $Res call(
      {dynamic createdAt,
      String uid,
      String contentId,
      String queryId,
      String answerId,
      String body,
      bool isDeleted});
}

/// @nodoc
class _$UserQueryCopyWithImpl<$Res, $Val extends UserQuery>
    implements $UserQueryCopyWith<$Res> {
  _$UserQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? uid = null,
    Object? contentId = null,
    Object? queryId = null,
    Object? answerId = null,
    Object? body = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      queryId: null == queryId
          ? _value.queryId
          : queryId // ignore: cast_nullable_to_non_nullable
              as String,
      answerId: null == answerId
          ? _value.answerId
          : answerId // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserQueryCopyWith<$Res> implements $UserQueryCopyWith<$Res> {
  factory _$$_UserQueryCopyWith(
          _$_UserQuery value, $Res Function(_$_UserQuery) then) =
      __$$_UserQueryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      String uid,
      String contentId,
      String queryId,
      String answerId,
      String body,
      bool isDeleted});
}

/// @nodoc
class __$$_UserQueryCopyWithImpl<$Res>
    extends _$UserQueryCopyWithImpl<$Res, _$_UserQuery>
    implements _$$_UserQueryCopyWith<$Res> {
  __$$_UserQueryCopyWithImpl(
      _$_UserQuery _value, $Res Function(_$_UserQuery) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? uid = null,
    Object? contentId = null,
    Object? queryId = null,
    Object? answerId = null,
    Object? body = null,
    Object? isDeleted = null,
  }) {
    return _then(_$_UserQuery(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      queryId: null == queryId
          ? _value.queryId
          : queryId // ignore: cast_nullable_to_non_nullable
              as String,
      answerId: null == answerId
          ? _value.answerId
          : answerId // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserQuery with DiagnosticableTreeMixin implements _UserQuery {
  const _$_UserQuery(
      {required this.createdAt,
      required this.uid,
      required this.contentId,
      required this.queryId,
      required this.answerId,
      required this.body,
      this.isDeleted = false});

  factory _$_UserQuery.fromJson(Map<String, dynamic> json) =>
      _$$_UserQueryFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final String uid;
  @override
  final String contentId;
  @override
  final String queryId;
  @override
  final String answerId;
  @override
  final String body;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserQuery(createdAt: $createdAt, uid: $uid, contentId: $contentId, queryId: $queryId, answerId: $answerId, body: $body, isDeleted: $isDeleted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserQuery'))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('contentId', contentId))
      ..add(DiagnosticsProperty('queryId', queryId))
      ..add(DiagnosticsProperty('answerId', answerId))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('isDeleted', isDeleted));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserQuery &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.queryId, queryId) || other.queryId == queryId) &&
            (identical(other.answerId, answerId) ||
                other.answerId == answerId) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      uid,
      contentId,
      queryId,
      answerId,
      body,
      isDeleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserQueryCopyWith<_$_UserQuery> get copyWith =>
      __$$_UserQueryCopyWithImpl<_$_UserQuery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserQueryToJson(
      this,
    );
  }
}

abstract class _UserQuery implements UserQuery {
  const factory _UserQuery(
      {required final dynamic createdAt,
      required final String uid,
      required final String contentId,
      required final String queryId,
      required final String answerId,
      required final String body,
      final bool isDeleted}) = _$_UserQuery;

  factory _UserQuery.fromJson(Map<String, dynamic> json) =
      _$_UserQuery.fromJson;

  @override
  dynamic get createdAt;
  @override
  String get uid;
  @override
  String get contentId;
  @override
  String get queryId;
  @override
  String get answerId;
  @override
  String get body;
  @override
  bool get isDeleted;
  @override
  @JsonKey(ignore: true)
  _$$_UserQueryCopyWith<_$_UserQuery> get copyWith =>
      throw _privateConstructorUsedError;
}
