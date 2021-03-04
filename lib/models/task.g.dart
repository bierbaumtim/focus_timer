// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    uuid: json['uuid'] as String,
    name: json['name'] as String? ?? '',
    isCompleted: json['isCompleted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'isCompleted': instance.isCompleted,
    };
