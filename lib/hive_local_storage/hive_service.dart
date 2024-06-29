import 'package:hive/hive.dart';
import 'package:task_management_app/models/task.dart';

class HiveService {
  static final HiveService _singleton = HiveService._internal();

  factory HiveService() {
    return _singleton;
  }

  HiveService._internal();

  Box<Task> get taskBox => Hive.box<Task>('tasksBox');

  Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    // await task.save(); // TO-DO: Investigate why [task.save()] does not work
    taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  List<Task> getTasks() {
    return taskBox.values.toList();
  }
}
