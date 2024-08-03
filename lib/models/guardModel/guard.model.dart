import 'package:freezed_annotation/freezed_annotation.dart';

part 'guard.model.freezed.dart';
part 'guard.model.g.dart';

@freezed
class GuardModel with _$GuardModel {
  factory GuardModel(
      {String? id,
      String? userId,
      String? groupId,
      String? firstName,
      String? middleName,
      String? lastName,
      String? phone,
      String? email,
      String? role,
      String? unit,
      String? address,
      String? date,
      bool? status}) = _GuardModel;

  factory GuardModel.fromJson(Map<String, dynamic> json) =>
      _$GuardModelFromJson(json);
}
