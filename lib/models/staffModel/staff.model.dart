import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff.model.freezed.dart';
part 'staff.model.g.dart';

@freezed
class StaffModel with _$StaffModel {
  factory StaffModel({
    String? id,
    String? userId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phone,
    String? email,
    String? role,
    String? department,
    String? faculty,
    String? address,
    String? hostile,
    String? date,
    bool? status
    
  }) = _StaffModel;

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);
}
