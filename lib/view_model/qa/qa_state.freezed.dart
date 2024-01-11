// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qa_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QaState {
  UserQuery? get activeQuery => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QaStateCopyWith<QaState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QaStateCopyWith<$Res> {
  factory $QaStateCopyWith(QaState value, $Res Function(QaState) then) =
      _$QaStateCopyWithImpl<$Res, QaState>;
  @useResult
  $Res call({UserQuery? activeQuery});

  $UserQueryCopyWith<$Res>? get activeQuery;
}

/// @nodoc
class _$QaStateCopyWithImpl<$Res, $Val extends QaState>
    implements $QaStateCopyWith<$Res> {
  _$QaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeQuery = freezed,
  }) {
    return _then(_value.copyWith(
      activeQuery: freezed == activeQuery
          ? _value.activeQuery
          : activeQuery // ignore: cast_nullable_to_non_nullable
              as UserQuery?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserQueryCopyWith<$Res>? get activeQuery {
    if (_value.activeQuery == null) {
      return null;
    }

    return $UserQueryCopyWith<$Res>(_value.activeQuery!, (value) {
      return _then(_value.copyWith(activeQuery: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_QaStateCopyWith<$Res> implements $QaStateCopyWith<$Res> {
  factory _$$_QaStateCopyWith(
          _$_QaState value, $Res Function(_$_QaState) then) =
      __$$_QaStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserQuery? activeQuery});

  @override
  $UserQueryCopyWith<$Res>? get activeQuery;
}

/// @nodoc
class __$$_QaStateCopyWithImpl<$Res>
    extends _$QaStateCopyWithImpl<$Res, _$_QaState>
    implements _$$_QaStateCopyWith<$Res> {
  __$$_QaStateCopyWithImpl(_$_QaState _value, $Res Function(_$_QaState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeQuery = freezed,
  }) {
    return _then(_$_QaState(
      activeQuery: freezed == activeQuery
          ? _value.activeQuery
          : activeQuery // ignore: cast_nullable_to_non_nullable
              as UserQuery?,
    ));
  }
}

/// @nodoc

class _$_QaState with DiagnosticableTreeMixin implements _QaState {
  const _$_QaState({this.activeQuery = null});

  @override
  @JsonKey()
  final UserQuery? activeQuery;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QaState(activeQuery: $activeQuery)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QaState'))
      ..add(DiagnosticsProperty('activeQuery', activeQuery));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QaState &&
            (identical(other.activeQuery, activeQuery) ||
                other.activeQuery == activeQuery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QaStateCopyWith<_$_QaState> get copyWith =>
      __$$_QaStateCopyWithImpl<_$_QaState>(this, _$identity);
}

abstract class _QaState implements QaState {
  const factory _QaState({final UserQuery? activeQuery}) = _$_QaState;

  @override
  UserQuery? get activeQuery;
  @override
  @JsonKey(ignore: true)
  _$$_QaStateCopyWith<_$_QaState> get copyWith =>
      throw _privateConstructorUsedError;
}
