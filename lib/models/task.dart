import 'package:json_annotation/json_annotation.dart';


part 'task.g.dart';


@JsonSerializable()
class Task {
  Task({
    required this.id ,
    this.title, this.description, this.createdAt, this.isCompleted = false, this.deadLine, this.priority});

  int id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? editedAt;
  DateTime? deadLine;
  Priority? priority;
  bool isCompleted;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

 
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

enum Priority {
  low,
  medium,
  high,
}