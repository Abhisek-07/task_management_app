import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';

import 'package:task_management_app/utils/constants.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool isSaveEnabled = false;

  

  @override
  void dispose() {
    _titleController.removeListener(handleIsSaveEnabled);
    _contentController.removeListener(handleIsSaveEnabled);
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(handleIsSaveEnabled);
    _contentController.addListener(handleIsSaveEnabled);
  }

  void handleIsSaveEnabled() {
      setState(() {
        isSaveEnabled = _titleController.text.isNotEmpty || _contentController.text.isNotEmpty;
      });
  }

  @override
  Widget build(BuildContext context) {

  final TasksCubit taskCubit = BlocProvider.of<TasksCubit>(context);

void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (isSaveEnabled) {
      final newTask = Task(
        id: DateTime.now().microsecondsSinceEpoch,
        title: title,
        description: content,
      );
      taskCubit.addTask(newTask);
      Navigator.pop(context, 
      // newTask : Passes the result in pop method return
      )
      ;
    } else {
      Navigator.pop(context);
    }
  }


    return PopScope(
      onPopInvoked: (didPop) {
        log("pop invoked");
        _saveNote();
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
                onPressed: _saveNote,
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
