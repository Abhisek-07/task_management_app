import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/task.dart';

class TasksState extends Equatable {
  final List<Task> tasks;
  final Task? selectedTask;

  const TasksState({this.tasks = const [], this.selectedTask});

  TasksState copyWith({
    List<Task>? tasks,
    Task? selectedTask,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask ?? this.selectedTask,
    );
  }

  @override
  List<Object?> get props => [tasks, selectedTask];
}
