import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TODOItem {
  int? id;
  String? description;
  bool done;
  int order;

  TODOItem({this.id, this.description, this.done = false, this.order = 0});

  factory TODOItem.fromJson(Map<String, dynamic> json) => _$TODOItemFromJson(json);
  Map<String, dynamic> toJson() => _$TODOItemToJson(this);
}