// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      department: json['department'] as String?,
      faculty: json['faculty'] as String?,
      address: json['address'] as String?,
      hostile: json['hostile'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
      gender: json['gender'] as String?,
      userId: json['userId'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'role': instance.role,
      'department': instance.department,
      'faculty': instance.faculty,
      'address': instance.address,
      'hostile': instance.hostile,
      'date': instance.date,
      'status': instance.status,
      'gender': instance.gender,
      'userId': instance.userId,
      'password': instance.password,
    };
