import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management_app/utils/date_time_ext.dart';
import 'package:task_management_app/utils/export.dart';





class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({
    super. key,
    required this.task,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate remaining days and hours
    // final now = DateTime.now();
    // final remaining = task.deadLine?.difference(now);
    // final days = remaining?.inDays;
    // final hours = remaining?.inHours ?? 0 % 24;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      (task.title?.isEmpty ?? true) ? "No title" : task.title ?? "",
                      style:  TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: (task.title?.isEmpty ?? true) ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    task.isCompleted ? 'Completed' : 'Pending',
                    style: TextStyle(
                      color: task.isCompleted ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
               (task.description?.isEmpty ?? true) ? "No description": task.description ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(fontSize: 16, color: (task.description?.isEmpty ?? true) ? Colors.grey : Colors.black),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Visibility(
                    visible: task.createdAt != null,
                    child: Flexible(
                      child: Text(
                        'Created: ${task.createdAt.getDateTime()}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Visibility(
                    visible: task.deadLine != null,
                    child: Flexible(
                      child: Text(
                        'Deadline: ${task.deadLine?.day} days ${task.deadLine?.hour} hours',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Visibility(
                    visible: task.priority != null,
                    child: Flexible(
                      child: Text(
                        'Priority: ${task.priority.priorityToString()}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}

extension PriorityExt on Priority? {
  String priorityToString() {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
      default:
        return "No priority set";
    }
  }
}
