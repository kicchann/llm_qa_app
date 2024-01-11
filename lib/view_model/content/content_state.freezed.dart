// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContentState {
  User? get user => throw _privateConstructorUsedError;
  String get currentContentId => throw _privateConstructorUsedError;
  String get sortBy => throw _privateConstructorUsedError;
  bool get isAscending => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContentStateCopyWith<ContentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentStateCopyWith<$Res> {
  factory $ContentStateCopyWith(
          ContentState value, $Res Function(ContentState) then) =
      _$ContentStateCopyWithImpl<$Res, ContentState>;
  @useResult
  $Res call(
      {User? user, String currentContentId, String sortBy, bool isAscending});
}

/// @nodoc
class _$ContentStateCopyWithImpl<$Res, $Val extends ContentState>
    implements $ContentStateCopyWith<$Res> {
  _$ContentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? currentContentId = null,
    Object? sortBy = null,
    Object? isAscending = null,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      currentContentId: null == currentContentId
          ? _value.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      isAscending: null == isAscending
          ? _value.isAscending
          : isAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContentStateCopyWith<$Res>
    implements $ContentStateCopyWith<$Res> {
  factory _$$_ContentStateCopyWith(
          _$_ContentState value, $Res Function(_$_ContentState) then) =
      __$$_ContentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User? user, String currentContentId, String sortBy, bool isAscending});
}

/// @nodoc
class __$$_ContentStateCopyWithImpl<$Res>
    extends _$ContentStateCopyWithImpl<$Res, _$_ContentState>
    implements _$$_ContentStateCopyWith<$Res> {
  __$$_ContentStateCopyWithImpl(
      _$_ContentState _value, $Res Function(_$_ContentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? currentContentId = null,
    Object? sortBy = null,
    Object? isAscending = null,
  }) {
    return _then(_$_ContentState(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      currentContentId: null == currentContentId
          ? _value.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      isAscending: null == isAscending
          ? _value.isAscending
          : isAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ContentState with DiagnosticableTreeMixin implements _ContentState {
  const _$_ContentState(
      {required this.user,
      this.currentContentId = '',
      this.sortBy = createdAtContent,
      this.isAscending = false});

  @override
  final User? user;
  @override
  @JsonKey()
  final String currentContentId;
  @override
  @JsonKey()
  final String sortBy;
  @override
  @JsonKey()
  final bool isAscending;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ContentState(user: $user, currentContentId: $currentContentId, sortBy: $sortBy, isAscending: $isAscending)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ContentState'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('currentContentId', currentContentId))
      ..add(DiagnosticsProperty('sortBy', sortBy))
      ..add(DiagnosticsProperty('isAscending', isAscending));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContentState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.currentContentId, currentContentId) ||
                other.currentContentId == currentContentId) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.isAscending, isAscending) ||
                other.isAscending == isAscending));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, user, currentContentId, sortBy, isAscending);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContentStateCopyWith<_$_ContentState> get copyWith =>
      __$$_ContentStateCopyWithImpl<_$_ContentState>(this, _$identity);
}

abstract class _ContentState implements ContentState {
  const factory _ContentState(
      {required final User? user,
      final String currentContentId,
      final String sortBy,
      final bool isAscending}) = _$_ContentState;

  @override
  User? get user;
  @override
  String get currentContentId;
  @override
  String get sortBy;
  @override
  bool get isAscending;
  @override
  @JsonKey(ignore: true)
  _$$_ContentStateCopyWith<_$_ContentState> get copyWith =>
      throw _privateConstructorUsedError;
}
