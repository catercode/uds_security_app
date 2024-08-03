import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit.model.freezed.dart';
part 'unit.model.g.dart';

@freezed
class UnitModel with _$UnitModel {
  factory UnitModel({
    String? id,
    String? name,
    String? location,
  }) = _UnitModel;

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);
}
