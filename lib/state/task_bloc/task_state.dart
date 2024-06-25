import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/task.dart';

class TasksState extends Equatable {
  final List<Task> tasks;
  final Task? selectedTask;
  final List<int>? isChecked;
  final bool? isLongPressMode;

  const TasksState(
      {required this.tasks,
      this.selectedTask,
      this.isChecked,
      this.isLongPressMode});

  TasksState copyWith({
    List<Task>? tasks,
    Task? selectedTask,
    List<int>? isChecked,
    bool? isLongPressMode,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask ?? this.selectedTask,
      isChecked: isChecked ?? this.isChecked,
      isLongPressMode: isLongPressMode ?? this.isLongPressMode,
    );
  }

  @override
  List<Object?> get props => [tasks, selectedTask, isChecked, isLongPressMode];
}
