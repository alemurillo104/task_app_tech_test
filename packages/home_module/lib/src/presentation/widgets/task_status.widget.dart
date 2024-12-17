import 'package:flutter/material.dart';
import '../../domain/enums/task_status.enum.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class TaskStatusWidget extends StatelessWidget {
  final TaskStatus status;

  const TaskStatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: status == TaskStatus.completed
            ? Colors.greenAccent.shade200
            : Colors.amberAccent.shade400,
      ),
      child: Text(
        TaskStatusMapper.fromEnumtoLiteralString(status),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
