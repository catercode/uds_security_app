import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit.model.freezed.dart';
part 'unit.model.g.dart';

@freezed
class UnitModel with _$UnitModel {
  factory UnitModel({
    String? unitId,
    String? unitName,
    String? location,
    String? date,
    String? status,
  }) = _UnitModel;

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);
}
