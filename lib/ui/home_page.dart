import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management_app/temp.dart';
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
      appBar: AppBar(title: const Text("Tasks"),),
      floatingActionButton: Container(margin: const EdgeInsets.only(bottom: 
      // MediaQuery.of(context).viewInsets.bottom + 
      padding16, right: 
      // MediaQuery.of(context).viewInsets.right + 
      padding8),child:  CustomFloatingActionButton(onTap: () {
        ///
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
            Flexible(
              child: ListView.builder(itemCount: taskList.length, itemBuilder: (context, index) {
               return  TaskCard(task: taskList[index],);
              },),
            )
          ],
        ),
      ),
    );
  }
}