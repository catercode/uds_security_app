import 'package:freezed_annotation/freezed_annotation.dart';

part 'case.model.freezed.dart';
part 'case.model.g.dart';

@freezed
class CaseModel with _$CaseModel {
  factory CaseModel({
    String? id,
    String? studentId,
    String? level,
    String? statement,
    String? date,
    bool? status,
    String? securityAssign
    
  }) = _CaseModel;

  factory CaseModel.fromJson(Map<String, dynamic> json) =>
      _$CaseModelFromJson(json);
}
