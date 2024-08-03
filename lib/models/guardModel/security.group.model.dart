import 'package:freezed_annotation/freezed_annotation.dart';

part 'security.group.model.freezed.dart';
part 'security.group.model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  factory GroupModel({
    String? groupId,
     String? group,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}
