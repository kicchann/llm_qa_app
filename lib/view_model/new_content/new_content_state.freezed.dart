// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewContentState {
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  List<RefferedDocument> get refferedDocuments =>
      throw _privateConstructorUsedError;
  String get contentId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewContentStateCopyWith<NewContentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewContentStateCopyWith<$Res> {
  factory $NewContentStateCopyWith(
          NewContentState value, $Res Function(NewContentState) then) =
      _$NewContentStateCopyWithImpl<$Res, NewContentState>;
  @useResult
  $Res call(
      {String title,
      String body,
      List<RefferedDocument> refferedDocuments,
      String contentId});
}

/// @nodoc
class _$NewContentStateCopyWithImpl<$Res, $Val extends NewContentState>
    implements $NewContentStateCopyWith<$Res> {
  _$NewContentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? refferedDocuments = null,
    Object? contentId = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      refferedDocuments: null == refferedDocuments
          ? _value.refferedDocuments
          : refferedDocuments // ignore: cast_nullable_to_non_nullable
              as List<RefferedDocument>,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewContentStateCopyWith<$Res>
    implements $NewContentStateCopyWith<$Res> {
  factory _$$_NewContentStateCopyWith(
          _$_NewContentState value, $Res Function(_$_NewContentState) then) =
      __$$_NewContentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String body,
      List<RefferedDocument> refferedDocuments,
      String contentId});
}

/// @nodoc
class __$$_NewContentStateCopyWithImpl<$Res>
    extends _$NewContentStateCopyWithImpl<$Res, _$_NewContentState>
    implements _$$_NewContentStateCopyWith<$Res> {
  __$$_NewContentStateCopyWithImpl(
      _$_NewContentState _value, $Res Function(_$_NewContentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? refferedDocuments = null,
    Object? contentId = null,
  }) {
    return _then(_$_NewContentState(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      refferedDocuments: null == refferedDocuments
          ? _value._refferedDocuments
          : refferedDocuments // ignore: cast_nullable_to_non_nullable
              as List<RefferedDocument>,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NewContentState
    with DiagnosticableTreeMixin
    implements _NewContentState {
  const _$_NewContentState(
      {this.title = '',
      this.body = '',
      final List<RefferedDocument> refferedDocuments = const [],
      this.contentId = ''})
      : _refferedDocuments = refferedDocuments;

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String body;
  final List<RefferedDocument> _refferedDocuments;
  @override
  @JsonKey()
  List<RefferedDocument> get refferedDocuments {
    if (_refferedDocuments is EqualUnmodifiableListView)
      return _refferedDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refferedDocuments);
  }

  @override
  @JsonKey()
  final String contentId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewContentState(title: $title, body: $body, refferedDocuments: $refferedDocuments, contentId: $contentId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewContentState'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('refferedDocuments', refferedDocuments))
      ..add(DiagnosticsProperty('contentId', contentId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewContentState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._refferedDocuments, _refferedDocuments) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, body,
      const DeepCollectionEquality().hash(_refferedDocuments), contentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewContentStateCopyWith<_$_NewContentState> get copyWith =>
      __$$_NewContentStateCopyWithImpl<_$_NewContentState>(this, _$identity);
}

abstract class _NewContentState implements NewContentState {
  const factory _NewContentState(
      {final String title,
      final String body,
      final List<RefferedDocument> refferedDocuments,
      final String contentId}) = _$_NewContentState;

  @override
  String get title;
  @override
  String get body;
  @override
  List<RefferedDocument> get refferedDocuments;
  @override
  String get contentId;
  @override
  @JsonKey(ignore: true)
  _$$_NewContentStateCopyWith<_$_NewContentState> get copyWith =>
      throw _privateConstructorUsedError;
}
