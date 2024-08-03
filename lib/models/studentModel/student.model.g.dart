// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentModelImpl _$$StudentModelImplFromJson(Map<String, dynamic> json) =>
    _$StudentModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      faculty: json['faculty'] as String?,
      address: json['address'] as String?,
      hostile: json['hostile'] as String?,
      date: json['date'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$StudentModelImplToJson(_$StudentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'faculty': instance.faculty,
      'address': instance.address,
      'hostile': instance.hostile,
      'date': instance.date,
      'status': instance.status,
    };
