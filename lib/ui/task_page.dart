import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';

import 'package:task_management_app/utils/constants.dart';
import 'package:uuid/uuid.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late final TasksCubit taskCubit;

  bool isSaveEnabled = false;

  @override
  void dispose() {
    _titleController.removeListener(handleIsSaveEnabled);
    _contentController.removeListener(handleIsSaveEnabled);
    _titleController
      ..clear()
      ..dispose();
    _contentController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(handleIsSaveEnabled);
    _contentController.addListener(handleIsSaveEnabled);
    taskCubit = BlocProvider.of<TasksCubit>(context);
    prefillSelecteTaskData();
  }

  void prefillSelecteTaskData() {
    final selectedTask = taskCubit.state.selectedTask;
    if (selectedTask != null) {
      _titleController.text = selectedTask.title ?? "";
      _contentController.text = selectedTask.description ?? "";
    } else {
      _titleController.clear();
      _contentController.clear();
    }
  }

  void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (isSaveEnabled) {
      if (taskCubit.state.selectedTask != null) {
        taskCubit.updateTask(taskCubit.state.selectedTask!.copyWith(
          title: title,
          description: content,
        ));
      } else {
        final newTask = Task(
          id: const Uuid().v4(),
          title: title,
          description: content,
        );
        taskCubit.addTask(newTask);
      }
    } else {
      if (taskCubit.state.selectedTask != null) {
        taskCubit.deleteTaskById(taskCubit.state.selectedTask!.id);
      }
    }
  }

  void handleIsSaveEnabled() {
    setState(() {
      isSaveEnabled = _titleController.text.isNotEmpty ||
          _contentController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        log("pop invoked");
        _saveNote();
        // taskCubit.clearSelectedTask();
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: ,
          title: const Text('New Note'),
          actions: [
            Visibility(
              visible: isSaveEnabled,
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: padding16),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    // floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    labelText: 'Description',
                  ),
                  maxLines: null,
                  expands: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
