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
    // Get the current list of tasks, add the new task at the start, and save back
    final tasks = taskBox.values.toList();
    tasks.insert(0, task);
    await taskBox.clear(); // Clear the box before adding all tasks again
    await taskBox
        .addAll(tasks); // Add all tasks back with the new task at the start
  }

  Future<void> updateTask(Task task) async {
    // await task.save(); // TO-DO: Investigate why [task.save()] does not work
    taskBox.putAt(
        taskBox.values.toList().indexWhere((element) => element.id == task.id),
        task);
  }

  Future<void> deleteTask(String id) async {
    await taskBox.deleteAt(
        taskBox.values.toList().indexWhere((element) => element.id == id));
  }

  List<Task> getTasks() {
    return taskBox.values.toList();
  }
}
