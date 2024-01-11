// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'index_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IndexManager _$IndexManagerFromJson(Map<String, dynamic> json) {
  return _IndexManager.fromJson(json);
}

/// @nodoc
mixin _$IndexManager {
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get indexManagerId => throw _privateConstructorUsedError;
  List<String> get refferedDocumentIds => throw _privateConstructorUsedError;
  List<String> get completedDocumentIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IndexManagerCopyWith<IndexManager> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndexManagerCopyWith<$Res> {
  factory $IndexManagerCopyWith(
          IndexManager value, $Res Function(IndexManager) then) =
      _$IndexManagerCopyWithImpl<$Res, IndexManager>;
  @useResult
  $Res call(
      {dynamic createdAt,
      String indexManagerId,
      List<String> refferedDocumentIds,
      List<String> completedDocumentIds});
}

/// @nodoc
class _$IndexManagerCopyWithImpl<$Res, $Val extends IndexManager>
    implements $IndexManagerCopyWith<$Res> {
  _$IndexManagerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? indexManagerId = null,
    Object? refferedDocumentIds = null,
    Object? completedDocumentIds = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      indexManagerId: null == indexManagerId
          ? _value.indexManagerId
          : indexManagerId // ignore: cast_nullable_to_non_nullable
              as String,
      refferedDocumentIds: null == refferedDocumentIds
          ? _value.refferedDocumentIds
          : refferedDocumentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completedDocumentIds: null == completedDocumentIds
          ? _value.completedDocumentIds
          : completedDocumentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IndexManagerCopyWith<$Res>
    implements $IndexManagerCopyWith<$Res> {
  factory _$$_IndexManagerCopyWith(
          _$_IndexManager value, $Res Function(_$_IndexManager) then) =
      __$$_IndexManagerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      String indexManagerId,
      List<String> refferedDocumentIds,
      List<String> completedDocumentIds});
}

/// @nodoc
class __$$_IndexManagerCopyWithImpl<$Res>
    extends _$IndexManagerCopyWithImpl<$Res, _$_IndexManager>
    implements _$$_IndexManagerCopyWith<$Res> {
  __$$_IndexManagerCopyWithImpl(
      _$_IndexManager _value, $Res Function(_$_IndexManager) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? indexManagerId = null,
    Object? refferedDocumentIds = null,
    Object? completedDocumentIds = null,
  }) {
    return _then(_$_IndexManager(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      indexManagerId: null == indexManagerId
          ? _value.indexManagerId
          : indexManagerId // ignore: cast_nullable_to_non_nullable
              as String,
      refferedDocumentIds: null == refferedDocumentIds
          ? _value._refferedDocumentIds
          : refferedDocumentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completedDocumentIds: null == completedDocumentIds
          ? _value._completedDocumentIds
          : completedDocumentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IndexManager with DiagnosticableTreeMixin implements _IndexManager {
  const _$_IndexManager(
      {required this.createdAt,
      required this.indexManagerId,
      required final List<String> refferedDocumentIds,
      required final List<String> completedDocumentIds})
      : _refferedDocumentIds = refferedDocumentIds,
        _completedDocumentIds = completedDocumentIds;

  factory _$_IndexManager.fromJson(Map<String, dynamic> json) =>
      _$$_IndexManagerFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final String indexManagerId;
  final List<String> _refferedDocumentIds;
  @override
  List<String> get refferedDocumentIds {
    if (_refferedDocumentIds is EqualUnmodifiableListView)
      return _refferedDocumentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refferedDocumentIds);
  }

  final List<String> _completedDocumentIds;
  @override
  List<String> get completedDocumentIds {
    if (_completedDocumentIds is EqualUnmodifiableListView)
      return _completedDocumentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedDocumentIds);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IndexManager(createdAt: $createdAt, indexManagerId: $indexManagerId, refferedDocumentIds: $refferedDocumentIds, completedDocumentIds: $completedDocumentIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IndexManager'))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('indexManagerId', indexManagerId))
      ..add(DiagnosticsProperty('refferedDocumentIds', refferedDocumentIds))
      ..add(DiagnosticsProperty('completedDocumentIds', completedDocumentIds));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IndexManager &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.indexManagerId, indexManagerId) ||
                other.indexManagerId == indexManagerId) &&
            const DeepCollectionEquality()
                .equals(other._refferedDocumentIds, _refferedDocumentIds) &&
            const DeepCollectionEquality()
                .equals(other._completedDocumentIds, _completedDocumentIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      indexManagerId,
      const DeepCollectionEquality().hash(_refferedDocumentIds),
      const DeepCollectionEquality().hash(_completedDocumentIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IndexManagerCopyWith<_$_IndexManager> get copyWith =>
      __$$_IndexManagerCopyWithImpl<_$_IndexManager>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IndexManagerToJson(
      this,
    );
  }
}

abstract class _IndexManager implements IndexManager {
  const factory _IndexManager(
      {required final dynamic createdAt,
      required final String indexManagerId,
      required final List<String> refferedDocumentIds,
      required final List<String> completedDocumentIds}) = _$_IndexManager;

  factory _IndexManager.fromJson(Map<String, dynamic> json) =
      _$_IndexManager.fromJson;

  @override
  dynamic get createdAt;
  @override
  String get indexManagerId;
  @override
  List<String> get refferedDocumentIds;
  @override
  List<String> get completedDocumentIds;
  @override
  @JsonKey(ignore: true)
  _$$_IndexManagerCopyWith<_$_IndexManager> get copyWith =>
      throw _privateConstructorUsedError;
}
