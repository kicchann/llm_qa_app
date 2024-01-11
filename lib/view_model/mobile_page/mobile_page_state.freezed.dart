// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mobile_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MobilePageState {
  int get index => throw _privateConstructorUsedError;
  PageController get controller => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MobilePageStateCopyWith<MobilePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobilePageStateCopyWith<$Res> {
  factory $MobilePageStateCopyWith(
          MobilePageState value, $Res Function(MobilePageState) then) =
      _$MobilePageStateCopyWithImpl<$Res, MobilePageState>;
  @useResult
  $Res call({int index, PageController controller});
}

/// @nodoc
class _$MobilePageStateCopyWithImpl<$Res, $Val extends MobilePageState>
    implements $MobilePageStateCopyWith<$Res> {
  _$MobilePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? controller = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as PageController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MobilePageStateCopyWith<$Res>
    implements $MobilePageStateCopyWith<$Res> {
  factory _$$_MobilePageStateCopyWith(
          _$_MobilePageState value, $Res Function(_$_MobilePageState) then) =
      __$$_MobilePageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, PageController controller});
}

/// @nodoc
class __$$_MobilePageStateCopyWithImpl<$Res>
    extends _$MobilePageStateCopyWithImpl<$Res, _$_MobilePageState>
    implements _$$_MobilePageStateCopyWith<$Res> {
  __$$_MobilePageStateCopyWithImpl(
      _$_MobilePageState _value, $Res Function(_$_MobilePageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? controller = null,
  }) {
    return _then(_$_MobilePageState(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as PageController,
    ));
  }
}

/// @nodoc

class _$_MobilePageState implements _MobilePageState {
  const _$_MobilePageState({this.index = 0, required this.controller});

  @override
  @JsonKey()
  final int index;
  @override
  final PageController controller;

  @override
  String toString() {
    return 'MobilePageState(index: $index, controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MobilePageState &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MobilePageStateCopyWith<_$_MobilePageState> get copyWith =>
      __$$_MobilePageStateCopyWithImpl<_$_MobilePageState>(this, _$identity);
}

abstract class _MobilePageState implements MobilePageState {
  const factory _MobilePageState(
      {final int index,
      required final PageController controller}) = _$_MobilePageState;

  @override
  int get index;
  @override
  PageController get controller;
  @override
  @JsonKey(ignore: true)
  _$$_MobilePageStateCopyWith<_$_MobilePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
