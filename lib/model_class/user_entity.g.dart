// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      fullName: json['fullName'] as String?,
      address: json['address'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      phoneNo: json['phoneNo'] as int?,
      city: json['city'] as String?,
      items: json ['items'] as List<dynamic>,
      totalAmount: json ['totalAmount'] as double,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'province': instance.province,
      'district': instance.district,
      'address': instance.address,
      'city': instance.city,
      'phoneNo': instance.phoneNo,
      'items' : instance.items,
      'totalAmount' : instance.totalAmount,
    };
