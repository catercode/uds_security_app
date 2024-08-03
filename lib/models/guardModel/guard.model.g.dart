// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuardModelImpl _$$GuardModelImplFromJson(Map<String, dynamic> json) =>
    _$GuardModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      groupId: json['groupId'] as String?,
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      unit: json['unit'] as String?,
      address: json['address'] as String?,
      date: json['date'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$GuardModelImplToJson(_$GuardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'groupId': instance.groupId,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'role': instance.role,
      'unit': instance.unit,
      'address': instance.address,
      'date': instance.date,
      'status': instance.status,
    };
