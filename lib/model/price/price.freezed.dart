// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Price _$PriceFromJson(Map<String, dynamic> json) {
  return _Price.fromJson(json);
}

/// @nodoc
mixin _$Price {
  bool get active => throw _privateConstructorUsedError;
  String? get billing_scheme => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get interval => throw _privateConstructorUsedError;
  int? get interval_count => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get product => throw _privateConstructorUsedError;
  bool? get reccuring => throw _privateConstructorUsedError;
  String? get tax_behavior => throw _privateConstructorUsedError;
  String? get tiers => throw _privateConstructorUsedError;
  String? get tiers_mode => throw _privateConstructorUsedError;
  Map<String, dynamic> get transform_quantity =>
      throw _privateConstructorUsedError;
  int? get trial_period_days => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  int? get unit_amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceCopyWith<Price> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) then) =
      _$PriceCopyWithImpl<$Res, Price>;
  @useResult
  $Res call(
      {bool active,
      String? billing_scheme,
      String? currency,
      String? description,
      int? interval,
      int? interval_count,
      Map<String, dynamic> metadata,
      String? product,
      bool? reccuring,
      String? tax_behavior,
      String? tiers,
      String? tiers_mode,
      Map<String, dynamic> transform_quantity,
      int? trial_period_days,
      String? type,
      int? unit_amount});
}

/// @nodoc
class _$PriceCopyWithImpl<$Res, $Val extends Price>
    implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? billing_scheme = freezed,
    Object? currency = freezed,
    Object? description = freezed,
    Object? interval = freezed,
    Object? interval_count = freezed,
    Object? metadata = null,
    Object? product = freezed,
    Object? reccuring = freezed,
    Object? tax_behavior = freezed,
    Object? tiers = freezed,
    Object? tiers_mode = freezed,
    Object? transform_quantity = null,
    Object? trial_period_days = freezed,
    Object? type = freezed,
    Object? unit_amount = freezed,
  }) {
    return _then(_value.copyWith(
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      billing_scheme: freezed == billing_scheme
          ? _value.billing_scheme
          : billing_scheme // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      interval: freezed == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int?,
      interval_count: freezed == interval_count
          ? _value.interval_count
          : interval_count // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as String?,
      reccuring: freezed == reccuring
          ? _value.reccuring
          : reccuring // ignore: cast_nullable_to_non_nullable
              as bool?,
      tax_behavior: freezed == tax_behavior
          ? _value.tax_behavior
          : tax_behavior // ignore: cast_nullable_to_non_nullable
              as String?,
      tiers: freezed == tiers
          ? _value.tiers
          : tiers // ignore: cast_nullable_to_non_nullable
              as String?,
      tiers_mode: freezed == tiers_mode
          ? _value.tiers_mode
          : tiers_mode // ignore: cast_nullable_to_non_nullable
              as String?,
      transform_quantity: null == transform_quantity
          ? _value.transform_quantity
          : transform_quantity // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trial_period_days: freezed == trial_period_days
          ? _value.trial_period_days
          : trial_period_days // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      unit_amount: freezed == unit_amount
          ? _value.unit_amount
          : unit_amount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PriceCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$$_PriceCopyWith(_$_Price value, $Res Function(_$_Price) then) =
      __$$_PriceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool active,
      String? billing_scheme,
      String? currency,
      String? description,
      int? interval,
      int? interval_count,
      Map<String, dynamic> metadata,
      String? product,
      bool? reccuring,
      String? tax_behavior,
      String? tiers,
      String? tiers_mode,
      Map<String, dynamic> transform_quantity,
      int? trial_period_days,
      String? type,
      int? unit_amount});
}

/// @nodoc
class __$$_PriceCopyWithImpl<$Res> extends _$PriceCopyWithImpl<$Res, _$_Price>
    implements _$$_PriceCopyWith<$Res> {
  __$$_PriceCopyWithImpl(_$_Price _value, $Res Function(_$_Price) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? billing_scheme = freezed,
    Object? currency = freezed,
    Object? description = freezed,
    Object? interval = freezed,
    Object? interval_count = freezed,
    Object? metadata = null,
    Object? product = freezed,
    Object? reccuring = freezed,
    Object? tax_behavior = freezed,
    Object? tiers = freezed,
    Object? tiers_mode = freezed,
    Object? transform_quantity = null,
    Object? trial_period_days = freezed,
    Object? type = freezed,
    Object? unit_amount = freezed,
  }) {
    return _then(_$_Price(
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      billing_scheme: freezed == billing_scheme
          ? _value.billing_scheme
          : billing_scheme // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      interval: freezed == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int?,
      interval_count: freezed == interval_count
          ? _value.interval_count
          : interval_count // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as String?,
      reccuring: freezed == reccuring
          ? _value.reccuring
          : reccuring // ignore: cast_nullable_to_non_nullable
              as bool?,
      tax_behavior: freezed == tax_behavior
          ? _value.tax_behavior
          : tax_behavior // ignore: cast_nullable_to_non_nullable
              as String?,
      tiers: freezed == tiers
          ? _value.tiers
          : tiers // ignore: cast_nullable_to_non_nullable
              as String?,
      tiers_mode: freezed == tiers_mode
          ? _value.tiers_mode
          : tiers_mode // ignore: cast_nullable_to_non_nullable
              as String?,
      transform_quantity: null == transform_quantity
          ? _value._transform_quantity
          : transform_quantity // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trial_period_days: freezed == trial_period_days
          ? _value.trial_period_days
          : trial_period_days // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      unit_amount: freezed == unit_amount
          ? _value.unit_amount
          : unit_amount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Price with DiagnosticableTreeMixin implements _Price {
  const _$_Price(
      {required this.active,
      required this.billing_scheme,
      required this.currency,
      required this.description,
      required this.interval,
      required this.interval_count,
      required final Map<String, dynamic> metadata,
      required this.product,
      required this.reccuring,
      required this.tax_behavior,
      required this.tiers,
      required this.tiers_mode,
      required final Map<String, dynamic> transform_quantity,
      required this.trial_period_days,
      required this.type,
      required this.unit_amount})
      : _metadata = metadata,
        _transform_quantity = transform_quantity;

  factory _$_Price.fromJson(Map<String, dynamic> json) =>
      _$$_PriceFromJson(json);

  @override
  final bool active;
  @override
  final String? billing_scheme;
  @override
  final String? currency;
  @override
  final String? description;
  @override
  final int? interval;
  @override
  final int? interval_count;
  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? product;
  @override
  final bool? reccuring;
  @override
  final String? tax_behavior;
  @override
  final String? tiers;
  @override
  final String? tiers_mode;
  final Map<String, dynamic> _transform_quantity;
  @override
  Map<String, dynamic> get transform_quantity {
    if (_transform_quantity is EqualUnmodifiableMapView)
      return _transform_quantity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_transform_quantity);
  }

  @override
  final int? trial_period_days;
  @override
  final String? type;
  @override
  final int? unit_amount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Price(active: $active, billing_scheme: $billing_scheme, currency: $currency, description: $description, interval: $interval, interval_count: $interval_count, metadata: $metadata, product: $product, reccuring: $reccuring, tax_behavior: $tax_behavior, tiers: $tiers, tiers_mode: $tiers_mode, transform_quantity: $transform_quantity, trial_period_days: $trial_period_days, type: $type, unit_amount: $unit_amount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Price'))
      ..add(DiagnosticsProperty('active', active))
      ..add(DiagnosticsProperty('billing_scheme', billing_scheme))
      ..add(DiagnosticsProperty('currency', currency))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('interval', interval))
      ..add(DiagnosticsProperty('interval_count', interval_count))
      ..add(DiagnosticsProperty('metadata', metadata))
      ..add(DiagnosticsProperty('product', product))
      ..add(DiagnosticsProperty('reccuring', reccuring))
      ..add(DiagnosticsProperty('tax_behavior', tax_behavior))
      ..add(DiagnosticsProperty('tiers', tiers))
      ..add(DiagnosticsProperty('tiers_mode', tiers_mode))
      ..add(DiagnosticsProperty('transform_quantity', transform_quantity))
      ..add(DiagnosticsProperty('trial_period_days', trial_period_days))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('unit_amount', unit_amount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Price &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.billing_scheme, billing_scheme) ||
                other.billing_scheme == billing_scheme) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.interval_count, interval_count) ||
                other.interval_count == interval_count) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.reccuring, reccuring) ||
                other.reccuring == reccuring) &&
            (identical(other.tax_behavior, tax_behavior) ||
                other.tax_behavior == tax_behavior) &&
            (identical(other.tiers, tiers) || other.tiers == tiers) &&
            (identical(other.tiers_mode, tiers_mode) ||
                other.tiers_mode == tiers_mode) &&
            const DeepCollectionEquality()
                .equals(other._transform_quantity, _transform_quantity) &&
            (identical(other.trial_period_days, trial_period_days) ||
                other.trial_period_days == trial_period_days) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.unit_amount, unit_amount) ||
                other.unit_amount == unit_amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      active,
      billing_scheme,
      currency,
      description,
      interval,
      interval_count,
      const DeepCollectionEquality().hash(_metadata),
      product,
      reccuring,
      tax_behavior,
      tiers,
      tiers_mode,
      const DeepCollectionEquality().hash(_transform_quantity),
      trial_period_days,
      type,
      unit_amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PriceCopyWith<_$_Price> get copyWith =>
      __$$_PriceCopyWithImpl<_$_Price>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PriceToJson(
      this,
    );
  }
}

abstract class _Price implements Price {
  const factory _Price(
      {required final bool active,
      required final String? billing_scheme,
      required final String? currency,
      required final String? description,
      required final int? interval,
      required final int? interval_count,
      required final Map<String, dynamic> metadata,
      required final String? product,
      required final bool? reccuring,
      required final String? tax_behavior,
      required final String? tiers,
      required final String? tiers_mode,
      required final Map<String, dynamic> transform_quantity,
      required final int? trial_period_days,
      required final String? type,
      required final int? unit_amount}) = _$_Price;

  factory _Price.fromJson(Map<String, dynamic> json) = _$_Price.fromJson;

  @override
  bool get active;
  @override
  String? get billing_scheme;
  @override
  String? get currency;
  @override
  String? get description;
  @override
  int? get interval;
  @override
  int? get interval_count;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get product;
  @override
  bool? get reccuring;
  @override
  String? get tax_behavior;
  @override
  String? get tiers;
  @override
  String? get tiers_mode;
  @override
  Map<String, dynamic> get transform_quantity;
  @override
  int? get trial_period_days;
  @override
  String? get type;
  @override
  int? get unit_amount;
  @override
  @JsonKey(ignore: true)
  _$$_PriceCopyWith<_$_Price> get copyWith =>
      throw _privateConstructorUsedError;
}
