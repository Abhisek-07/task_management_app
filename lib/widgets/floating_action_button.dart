import 'package:flutter/material.dart';
import 'package:task_management_app/utils/export.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(decoration: const BoxDecoration(color: Color.fromARGB(255, 227, 215, 34), shape: BoxShape.circle ,), child: const Padding(
          padding: EdgeInsets.all(padding16),
          child: Icon(Icons.add, color: Colors.black, size: padding32,),
        )),
    );
  }
}