import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.model.freezed.dart';
part 'student.model.g.dart';

@freezed
class StudentModel with _$StudentModel {
  factory StudentModel({
    String? id,
    String? userId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phone,
    String? email,
    String? faculty,
    String? address,
    String? hostile,
    String? date,
    bool? status
    
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);
}
