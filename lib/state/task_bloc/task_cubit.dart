import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/state/task_bloc/task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(const TasksState(tasks: []));

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

  void longPress() {
    emit(state.copyWith(isLongPressMode: true));
  }

  void checkboxChanged(int index, bool value) {
    final newChecked = value
        ? (List<int>.from(state.isChecked ?? [])..add(index))
        : (List<int>.from(state.isChecked ?? [])
          ..removeWhere(
            (element) => element == index,
          ));
    emit(state.copyWith(isChecked: newChecked));
  }

  void cancelLongPressMode() {
    emit(state.copyWith(
      isLongPressMode: false,
      isChecked: [],
    ));
  }

  void deleteSelectedTasks() {
    final newTasks = state.tasks
        .asMap()
        .entries
        .where(
          (element) => !(state.isChecked ?? []).contains(element.key),
        )
        .map((e) => e.value)
        .toList();
    emit(TasksState(
        tasks: newTasks, isChecked: const [], isLongPressMode: false));
  }

  void markSelectedTasksAsCompleted() {
    final newTasks = state.tasks.asMap().entries.map((entry) {
      if ((state.isChecked ?? []).contains(entry.key)) {
        return entry.value.copyWith(isCompleted: true);
      } else {
        return entry.value;
      }
    }).toList();
    emit(TasksState(
        tasks: newTasks, isChecked: const [], isLongPressMode: false));
  }
}
