import 'package:flutter/material.dart';
import 'package:common_module/common_module.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/enums/task_status.enum.dart';
import '../blocs/deleteTask/delete_task_bloc.dart';
import '../blocs/updateTask/update_task_bloc.dart';

class TaskOptionsBottomSheetWidget extends StatefulWidget {
  final Task task;
  final DeleteTaskBloc deleteTaskBloc;
  final UpdateTaskBloc updateTaskBloc;

  const TaskOptionsBottomSheetWidget({
    super.key,
    required this.task,
    required this.deleteTaskBloc,
    required this.updateTaskBloc,
  });

  @override
  State<TaskOptionsBottomSheetWidget> createState() =>
      _TaskOptionsBottomSheetWidgetState();
}

class _TaskOptionsBottomSheetWidgetState
    extends State<TaskOptionsBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 29,
              top: 5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Opciones de tarea',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                if (widget.task.status != TaskStatus.completed)
                  Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          widget.updateTaskBloc.add(TaskUpdated(widget.task));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepPurpleAccent,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Marcar tarea completada',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pop(context);
                    showDialogCustomWidget(
                      context,
                      title: 'Eliminar tarea',
                      description: 'Seguro que quieres eliminar la tarea?',
                      okButton: 'Eliminar',
                      rightOnPressed: () {
                        widget.deleteTaskBloc.add(TaskDeleted(widget.task.id!));
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 233, 221, 255),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.deepPurpleAccent,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Eliminar tarea',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
