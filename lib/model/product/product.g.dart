// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      active: json['active'] as bool,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>,
      name: json['name'] as String?,
      role: json['role'] as String?,
      tax_code: json['tax_code'] as String?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'active': instance.active,
      'description': instance.description,
      'images': instance.images,
      'metadata': instance.metadata,
      'name': instance.name,
      'role': instance.role,
      'tax_code': instance.tax_code,
    };
