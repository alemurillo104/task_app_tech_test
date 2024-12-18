import 'package:flutter/material.dart';
import 'package:home_module/home_module.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class TaskStatusTagWidget extends StatelessWidget {
  final TaskStatus status;
  final Color color;

  const TaskStatusTagWidget({
    super.key,
    required this.status,
    this.color = Colors.deepOrangeAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        TaskStatusMapper.fromEnumtoLiteralString(
          status,
        ),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
