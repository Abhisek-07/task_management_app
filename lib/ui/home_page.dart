import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/state/task_bloc/task_cubit.dart';
import 'package:task_management_app/state/task_bloc/task_state.dart';
import 'package:task_management_app/ui/task_page.dart';
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
      ),
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
      body: Padding(
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
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
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
                        return TaskCard(
                          onTap: () {
                            context
                                .read<TasksCubit>()
                                .selectTask(taskState.tasks[index]);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (taskPageContext) {
                                return BlocProvider.value(
                                    value: BlocProvider.of<TasksCubit>(context),
                                    child: const TaskPage());
                              },
                            ));
                          },
                          task: taskState.tasks[index],
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
