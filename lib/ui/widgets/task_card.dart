import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/utils/export.dart';





class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super. key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate remaining days and hours
    final now = DateTime.now();
    final remaining = task.deadLine?.difference(now);
    final days = remaining?.inDays;
    final hours = remaining?.inHours ?? 0 % 24;

    return Card(
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
                    task.title ?? "No title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
              task.description ?? "No description",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Created: ${DateFormat('dd MMM yyyy').format(task.createdAt ?? DateTime.now()) }',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    'Deadline: $days days $hours hours',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    'Priority: ${task.priority.priorityToString()}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
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
