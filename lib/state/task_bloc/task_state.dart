import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/task.dart';

class TasksState extends Equatable {
  final List<Task> tasks;

  const TasksState({this.tasks = const [],});

  @override
  List<Object> get props => [tasks];
}
