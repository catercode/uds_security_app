// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaseModelImpl _$$CaseModelImplFromJson(Map<String, dynamic> json) =>
    _$CaseModelImpl(
      id: json['id'] as String?,
      studentId: json['studentId'] as String?,
      level: json['level'] as String?,
      statement: json['statement'] as String?,
      quickReport: json['quickReport'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
      securityAssign: json['securityAssign'] as String?,
    );

Map<String, dynamic> _$$CaseModelImplToJson(_$CaseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'level': instance.level,
      'statement': instance.statement,
      'quickReport': instance.quickReport,
      'date': instance.date,
      'status': instance.status,
      'securityAssign': instance.securityAssign,
    };
