import 'package:flutter/material.dart';
import 'empty.widget.dart';
import 'task_item.widget.dart';
import 'task_options_bottom_sheet.widget.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/enums/task_status.enum.dart';
import '../blocs/deleteTask/delete_task_bloc.dart';
import '../blocs/updateTask/update_task_bloc.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;
  final TaskStatus statusSelected;
  final DeleteTaskBloc deleteTaskBloc;
  final UpdateTaskBloc updateTaskBloc;

  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.deleteTaskBloc,
    required this.updateTaskBloc,
    required this.statusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (tasks.isEmpty)
            ? (statusSelected == TaskStatus.all)
                ? const EmptyWidget(
                    text: 'No tienes tareas registradas',
                  )
                : EmptyWidget(
                    text:
                        'No tienes tareas con el estado\n${TaskStatusMapper.fromEnumtoLiteralString(
                      statusSelected,
                    )}',
                  )
            : const SizedBox(),
        if (tasks.isNotEmpty)
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  index: index,
                  task: tasks[index],
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return TaskOptionsBottomSheetWidget(
                          task: tasks[index],
                          deleteTaskBloc: deleteTaskBloc,
                          updateTaskBloc: updateTaskBloc,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
