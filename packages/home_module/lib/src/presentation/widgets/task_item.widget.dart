import 'package:flutter/material.dart';
import 'package:common_module/common_module.dart';
import 'task_status_tag.widget.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/enums/task_status.enum.dart';

class TaskItemWidget extends StatelessWidget {
  final int index;
  final Task task;
  final Function()? onTap;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    task.name.capitalize(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 248, 221, 231),
                  ),
                  child: Icon(
                    Icons.card_travel,
                    size: 18,
                    color: Colors.pink.shade200,
                  ),
                ),
              ],
            ),
            Text(
              task.description.capitalize(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: Colors.deepPurpleAccent.shade100,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '12:00 PM',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurpleAccent.shade100,
                      ),
                    ),
                  ],
                ),
                TaskStatusTagWidget(
                  status: task.status,
                  color: task.status == TaskStatus.pending
                      ? Colors.deepOrangeAccent
                      : Colors.deepPurpleAccent,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
