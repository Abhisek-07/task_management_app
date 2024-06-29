import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/hive_local_storage/hive_service.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/state/task_bloc/task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final HiveService _hiveService = HiveService();

  TasksCubit() : super(const TasksState(tasks: [], isLoadingTasks: true)) {
    loadTasks();
  }

  void loadTasks({TasksState? tasksState}) {
    final tasks = _hiveService.getTasks();
    emit((tasksState ?? state).copyWith(
      tasks: tasks,
      isLoadingTasks: false,
    ));
  }

  void addTask(Task task) async {
    await _hiveService.addTask(task);
    loadTasks();
  }

  void updateTask(Task updatedTask) async {
    await _hiveService.updateTask(updatedTask);
    loadTasks();
  }

  void deleteTaskById(String id) async {
    await _hiveService.deleteTask(id);
    loadTasks();
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

  void deleteSelectedTasks() async {
    for (int index in state.isChecked ?? []) {
      await _hiveService.deleteTask(state.tasks[index].id);
    }
    loadTasks(
        tasksState: state.copyWith(isChecked: [], isLongPressMode: false));
  }

  void markSelectedTasksAsCompleted() async {
    for (int index in state.isChecked ?? []) {
      final updatedTask = state.tasks[index].copyWith(isCompleted: true);
      await _hiveService.updateTask(updatedTask);
    }
    loadTasks(
        tasksState: state.copyWith(isChecked: [], isLongPressMode: false));
  }
}
