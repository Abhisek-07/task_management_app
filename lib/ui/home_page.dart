import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management_app/utils/export.dart';
import 'package:task_management_app/widgets/floating_action_button.dart';

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
      16, right: 
      // MediaQuery.of(context).viewInsets.right + 
      8),child:  CustomFloatingActionButton(onTap: () {
        ///
      },)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:  const Padding(
        padding:  EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: defaultPadding,),
            /// Task list
            Text("data"),
          ],
        ),
      ),
    );
  }
}