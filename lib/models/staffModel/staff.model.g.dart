// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffModelImpl _$$StaffModelImplFromJson(Map<String, dynamic> json) =>
    _$StaffModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
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
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$StaffModelImplToJson(_$StaffModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
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
    };
