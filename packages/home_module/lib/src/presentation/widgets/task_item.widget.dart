import 'package:flutter/material.dart';
import '../../domain/entities/task.entity.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final Function()? onTap;

  const TaskItemWidget({
    super.key,
    required this.task,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.amber.shade100,
        ),
        child: ListTile(
          leading: const Icon(Icons.task),
          title: Text(
            task.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          subtitle: Text(
            task.description,
          ),
        ),
      ),
    );
  }
}
