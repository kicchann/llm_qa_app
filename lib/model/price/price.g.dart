// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Price _$$_PriceFromJson(Map<String, dynamic> json) => _$_Price(
      active: json['active'] as bool,
      billing_scheme: json['billing_scheme'] as String?,
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      interval: json['interval'] as int?,
      interval_count: json['interval_count'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>,
      product: json['product'] as String?,
      reccuring: json['reccuring'] as bool?,
      tax_behavior: json['tax_behavior'] as String?,
      tiers: json['tiers'] as String?,
      tiers_mode: json['tiers_mode'] as String?,
      transform_quantity: json['transform_quantity'] as Map<String, dynamic>,
      trial_period_days: json['trial_period_days'] as int?,
      type: json['type'] as String?,
      unit_amount: json['unit_amount'] as int?,
    );

Map<String, dynamic> _$$_PriceToJson(_$_Price instance) => <String, dynamic>{
      'active': instance.active,
      'billing_scheme': instance.billing_scheme,
      'currency': instance.currency,
      'description': instance.description,
      'interval': instance.interval,
      'interval_count': instance.interval_count,
      'metadata': instance.metadata,
      'product': instance.product,
      'reccuring': instance.reccuring,
      'tax_behavior': instance.tax_behavior,
      'tiers': instance.tiers,
      'tiers_mode': instance.tiers_mode,
      'transform_quantity': instance.transform_quantity,
      'trial_period_days': instance.trial_period_days,
      'type': instance.type,
      'unit_amount': instance.unit_amount,
    };
