import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_management_app/hive_local_storage/hive_constants.dart';

part 'task.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.taskTypeId)
class Task extends HiveObject {
  Task(
      {required this.id,
      this.title,
      this.description,
      this.createdAt,
      this.isCompleted = false,
      this.deadLine,
      this.priority,
      this.editedAt});

  @HiveField(1)
  int id;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? description;

  DateTime? createdAt;

  DateTime? editedAt;

  DateTime? deadLine;

  Priority? priority;

  @HiveField(4)
  bool isCompleted;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? editedAt,
    DateTime? deadLine,
    Priority? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt ?? this.editedAt,
      deadLine: deadLine ?? this.deadLine,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

enum Priority {
  low,
  medium,
  high,
}
