// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TODOItem _$TODOItemFromJson(Map<String, dynamic> json) {
  return TODOItem(
    id: json['id'] as int?,
    description: json['description'] as String?,
    done: json['done'] as bool,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$TODOItemToJson(TODOItem instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'done': instance.done,
      'order': instance.order,
    };
