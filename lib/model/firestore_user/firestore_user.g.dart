// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreUser _$$_FirestoreUserFromJson(Map<String, dynamic> json) =>
    _$_FirestoreUser(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      uid: json['uid'] as String,
      email: json['email'] as String,
      authProvider: json['authProvider'] as String,
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String,
      isAdmin: json['isAdmin'] as bool,
      isPremium: json['isPremium'] as bool,
      userPoint: json['userPoint'] as int? ?? 500,
    );

Map<String, dynamic> _$$_FirestoreUserToJson(_$_FirestoreUser instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'uid': instance.uid,
      'email': instance.email,
      'authProvider': instance.authProvider,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'isAdmin': instance.isAdmin,
      'isPremium': instance.isPremium,
      'userPoint': instance.userPoint,
    };
