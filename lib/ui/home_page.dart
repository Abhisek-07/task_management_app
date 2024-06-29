import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';
import 'package:task_management_app/state/task_bloc/task_state.dart';
import 'package:task_management_app/ui/task_page.dart';
import 'package:task_management_app/ui/widgets/task_list_widget.dart';
import 'package:task_management_app/utils/export.dart';
import 'package:task_management_app/ui/widgets/floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Tasks",
            ),
            actions: [
              BlocBuilder<TasksCubit, TasksState>(
                builder: (context, taskState) {
                  if (taskState.isLongPressMode ?? false) {
                    return IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<TasksCubit>().deleteSelectedTasks();
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<TasksCubit, TasksState>(
                builder: (context, taskState) {
                  if (taskState.isLongPressMode ?? false) {
                    return IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        context
                            .read<TasksCubit>()
                            .markSelectedTasksAsCompleted();
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<TasksCubit, TasksState>(
                builder: (context, taskState) {
                  if (taskState.isLongPressMode ?? false) {
                    return IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context.read<TasksCubit>().cancelLongPressMode();
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ]),
        floatingActionButton: Container(
            margin: const EdgeInsets.only(
                bottom:
                    // MediaQuery.of(context).viewInsets.bottom +
                    padding16,
                right:
                    // MediaQuery.of(context).viewInsets.right +
                    padding8),
            child: CustomFloatingActionButton(
              onTap: () {
                context.read<TasksCubit>().cancelLongPressMode();
                context.read<TasksCubit>().clearSelectedTask();
                Navigator.push(context, MaterialPageRoute(
                  builder: (taskPageContext) {
                    return BlocProvider.value(
                        value: BlocProvider.of<TasksCubit>(context),
                        child: const TaskPage());
                  },
                ));
              },
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body:
            BlocBuilder<TasksCubit, TasksState>(builder: (context, taskState) {
          return GestureDetector(
              // behavior: HitTestBehavior.opaque,
              onTap: (taskState.isLongPressMode ?? false)
                  ? () {
                      context.read<TasksCubit>().cancelLongPressMode();
                    }
                  : null,
              child: const TasksListWidget());
        }));
  }
}
