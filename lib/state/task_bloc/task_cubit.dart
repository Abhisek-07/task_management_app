import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/state/task_bloc/task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(const TasksState());

  void addTask(Task task) {
    final newTasks = List<Task>.from(state.tasks)..insert(0, task);
    emit(TasksState(tasks: newTasks));
  }

  void updateTask(Task updatedTask) {
    final newTasks = state.tasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    emit(TasksState(tasks: newTasks));
  }

  void deleteTaskById(int id) {
    final newTasks = state.tasks.where((task) => task.id != id).toList();
    emit(TasksState(tasks: newTasks));
  }

    void selectTask(Task task) {
    emit(state.copyWith(selectedTask: task));
  }

  void clearSelectedTask() {
    emit(state.copyWith(selectedTask: null));
  }
}
