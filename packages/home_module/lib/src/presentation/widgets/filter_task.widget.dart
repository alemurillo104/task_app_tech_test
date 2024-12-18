import 'package:flutter/material.dart';
import '../../domain/enums/task_status.enum.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class FilterTaskWidget extends StatelessWidget {
  final List<TaskStatus> status;
  final ValueChanged<TaskStatus> onFilterChanged;
  final TaskStatus currentStatus;

  const FilterTaskWidget({
    super.key,
    required this.status,
    required this.currentStatus,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: status.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onFilterChanged(status[index]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: currentStatus == status[index]
                  ? Colors.deepPurpleAccent
                  : const Color.fromARGB(255, 233, 221, 255),
            ),
            child: Text(
              TaskStatusMapper.fromEnumtoLiteralString(status[index]),
              style: TextStyle(
                color: currentStatus == status[index]
                    ? Colors.white
                    : Colors.deepPurpleAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
