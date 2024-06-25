import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';
import 'package:task_management_app/state/task_bloc/task_state.dart';
import 'package:task_management_app/ui/task_page.dart';
import 'package:task_management_app/ui/widgets/task_card.dart';
import 'package:task_management_app/utils/constants.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Task list
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, taskState) {
              if (taskState.tasks.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text(
                      "Wow, such empty...",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              } else {
                return Flexible(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    itemCount: taskState.tasks.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: taskState.isLongPressMode ?? false,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox.adaptive(
                                  value: taskState.isChecked?.contains(index) ??
                                      false,
                                  onChanged: (value) {
                                    context
                                        .read<TasksCubit>()
                                        .checkboxChanged(index, value ?? false);
                                  },
                                ),
                                const SizedBox(
                                  width: padding8,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: TaskCard(
                              onLongPress: () {
                                context.read<TasksCubit>().longPress();
                              },
                              onTap: !(taskState.isLongPressMode ?? false)
                                  ? () {
                                      context
                                          .read<TasksCubit>()
                                          .selectTask(taskState.tasks[index]);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (taskPageContext) {
                                          return BlocProvider.value(
                                              value:
                                                  BlocProvider.of<TasksCubit>(
                                                      context),
                                              child: const TaskPage());
                                        },
                                      ));
                                    }
                                  :

                                  /// Add selection behavior here
                                  null,
                              task: taskState.tasks[index],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
