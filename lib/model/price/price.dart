import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@freezed
abstract class Price with _$Price {
  const factory Price({
    required bool active,
    required String? billing_scheme,
    required String? currency,
    required String? description,
    required int? interval,
    required int? interval_count,
    required Map<String, dynamic> metadata,
    required String? product,
    required bool? reccuring,
    required String? tax_behavior,
    required String? tiers,
    required String? tiers_mode,
    required Map<String, dynamic> transform_quantity,
    required int? trial_period_days,
    required String? type,
    required int? unit_amount,
  }) = _Price;
  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
