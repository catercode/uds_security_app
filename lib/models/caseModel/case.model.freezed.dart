// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CaseModel _$CaseModelFromJson(Map<String, dynamic> json) {
  return _CaseModel.fromJson(json);
}

/// @nodoc
mixin _$CaseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get studentId => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get quickReport => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get securityAssign => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CaseModelCopyWith<CaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaseModelCopyWith<$Res> {
  factory $CaseModelCopyWith(CaseModel value, $Res Function(CaseModel) then) =
      _$CaseModelCopyWithImpl<$Res, CaseModel>;
  @useResult
  $Res call(
      {String? id,
      String? studentId,
      String? level,
      String? statement,
      String? quickReport,
      String? date,
      String? status,
      String? securityAssign});
}

/// @nodoc
class _$CaseModelCopyWithImpl<$Res, $Val extends CaseModel>
    implements $CaseModelCopyWith<$Res> {
  _$CaseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studentId = freezed,
    Object? level = freezed,
    Object? statement = freezed,
    Object? quickReport = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? securityAssign = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      quickReport: freezed == quickReport
          ? _value.quickReport
          : quickReport // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      securityAssign: freezed == securityAssign
          ? _value.securityAssign
          : securityAssign // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CaseModelImplCopyWith<$Res>
    implements $CaseModelCopyWith<$Res> {
  factory _$$CaseModelImplCopyWith(
          _$CaseModelImpl value, $Res Function(_$CaseModelImpl) then) =
      __$$CaseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? studentId,
      String? level,
      String? statement,
      String? quickReport,
      String? date,
      String? status,
      String? securityAssign});
}

/// @nodoc
class __$$CaseModelImplCopyWithImpl<$Res>
    extends _$CaseModelCopyWithImpl<$Res, _$CaseModelImpl>
    implements _$$CaseModelImplCopyWith<$Res> {
  __$$CaseModelImplCopyWithImpl(
      _$CaseModelImpl _value, $Res Function(_$CaseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studentId = freezed,
    Object? level = freezed,
    Object? statement = freezed,
    Object? quickReport = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? securityAssign = freezed,
  }) {
    return _then(_$CaseModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      quickReport: freezed == quickReport
          ? _value.quickReport
          : quickReport // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      securityAssign: freezed == securityAssign
          ? _value.securityAssign
          : securityAssign // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CaseModelImpl implements _CaseModel {
  _$CaseModelImpl(
      {this.id,
      this.studentId,
      this.level,
      this.statement,
      this.quickReport,
      this.date,
      this.status,
      this.securityAssign});

  factory _$CaseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? studentId;
  @override
  final String? level;
  @override
  final String? statement;
  @override
  final String? quickReport;
  @override
  final String? date;
  @override
  final String? status;
  @override
  final String? securityAssign;

  @override
  String toString() {
    return 'CaseModel(id: $id, studentId: $studentId, level: $level, statement: $statement, quickReport: $quickReport, date: $date, status: $status, securityAssign: $securityAssign)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.quickReport, quickReport) ||
                other.quickReport == quickReport) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.securityAssign, securityAssign) ||
                other.securityAssign == securityAssign));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, studentId, level, statement,
      quickReport, date, status, securityAssign);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CaseModelImplCopyWith<_$CaseModelImpl> get copyWith =>
      __$$CaseModelImplCopyWithImpl<_$CaseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaseModelImplToJson(
      this,
    );
  }
}

abstract class _CaseModel implements CaseModel {
  factory _CaseModel(
      {final String? id,
      final String? studentId,
      final String? level,
      final String? statement,
      final String? quickReport,
      final String? date,
      final String? status,
      final String? securityAssign}) = _$CaseModelImpl;

  factory _CaseModel.fromJson(Map<String, dynamic> json) =
      _$CaseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get studentId;
  @override
  String? get level;
  @override
  String? get statement;
  @override
  String? get quickReport;
  @override
  String? get date;
  @override
  String? get status;
  @override
  String? get securityAssign;
  @override
  @JsonKey(ignore: true)
  _$$CaseModelImplCopyWith<_$CaseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
