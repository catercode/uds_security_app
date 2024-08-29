// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnitModelImpl _$$UnitModelImplFromJson(Map<String, dynamic> json) =>
    _$UnitModelImpl(
      unitId: json['unitId'] as String?,
      unitName: json['unitName'] as String?,
      location: json['location'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$UnitModelImplToJson(_$UnitModelImpl instance) =>
    <String, dynamic>{
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'location': instance.location,
      'date': instance.date,
      'status': instance.status,
    };
