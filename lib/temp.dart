import 'package:task_management_app/models/task.dart';

List<Task> taskList = [
  Task(title: "Task 1", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: false, priority: Priority.low, deadLine: DateTime(2025),),
  Task(title: "Task 2", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: false, priority: Priority.high, deadLine: DateTime(2025)),
  Task(title: "Task 3", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: true, priority: Priority.low, deadLine: DateTime(2025)),
  Task(title: "Task 4", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: false, priority: Priority.low, deadLine: DateTime(2025)),
  Task(title: "Task 5", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: true, priority: Priority.medium, deadLine: DateTime(2025)),
  Task(title: "Task 6", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: true, priority: Priority.low, deadLine: DateTime(2025)),
  Task(title: "Task 7", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: false, priority: Priority.medium, deadLine: DateTime(2025)),
  Task(title: "Task 8", description: "Task 1 description", createdAt: DateTime.now(), isCompleted: false, priority: Priority.low, deadLine: DateTime(2025)),
];