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
    return   Scaffold(
      appBar: AppBar(title: const Text("Tasks",),),
      floatingActionButton: Container(margin: const EdgeInsets.only(bottom: 
      // MediaQuery.of(context).viewInsets.bottom + 
      padding16, right: 
      // MediaQuery.of(context).viewInsets.right + 
      padding8),child:  CustomFloatingActionButton(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const TaskPage();
        },));
      },)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding,),
            /// Task list
            BlocBuilder<TasksCubit, TasksState>(
              
              builder: (context, state) {
                if(state.tasks.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text("Wow, such empty...", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                    ),
                  );
                } else {
                return Flexible(
                child: ListView.builder(itemCount: state.tasks.length, itemBuilder: (context, index) {
                 return  TaskCard(task: state.tasks[index],);
                },),
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