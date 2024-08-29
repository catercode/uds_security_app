import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {
        String? id,
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
      String? status,
      String? gender,
      String? userId,
      String? unitAssigned,
     
      String? password}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
