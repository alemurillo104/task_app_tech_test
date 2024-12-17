import 'package:flutter/material.dart';
import 'package:common_module/common_module.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/enums/task_status.enum.dart';
import '../blocs/deleteTask/delete_task_bloc.dart';
import '../blocs/updateTask/update_task_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;
  final DeleteTaskBloc deleteTaskBloc;
  final UpdateTaskBloc updateTaskBloc;

  const TaskDetailPage({
    super.key,
    required this.task,
    required this.deleteTaskBloc,
    required this.updateTaskBloc,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late final LoadingWidget loading;

  @override
  void initState() {
    loading = LoadingWidget(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteTaskBloc, DeleteTaskState>(
          bloc: widget.deleteTaskBloc,
          listener: (context, state) {
            switch (state.status) {
              case DeleteTaskStatus.success:
                loading.hideOverlay();
                logger.d('se elimino todo okay');
                Navigator.pop(context);
                Navigator.pop(context);
                break;
              case DeleteTaskStatus.loading:
                loading.showOverlay();
                break;
              case DeleteTaskStatus.failure:
                loading.hideOverlay();
                showDialogWidget(
                  context,
                  title: 'Ocurrio un error',
                  description: 'Intentalo nuevamente en un momento.',
                );
                break;
              default:
            }
          },
        ),
        BlocListener<UpdateTaskBloc, UpdateTaskState>(
          bloc: widget.updateTaskBloc,
          listener: (context, state) {
            switch (state.status) {
              case UpdateTaskStatus.success:
                loading.hideOverlay();
                logger.d('se actualizo todo okay');
                Navigator.pop(context);
                break;
              case UpdateTaskStatus.loading:
                loading.showOverlay();
                break;
              case UpdateTaskStatus.failure:
                loading.hideOverlay();
                showDialogWidget(
                  context,
                  title: 'Ocurrio un error',
                  description: 'Intentalo nuevamente en un momento.',
                );
                break;
              default:
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task.name),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text('Nombre : ${widget.task.name}'),
                    Text('Descripcion : ${widget.task.description}'),
                    Text('Estado : ${widget.task.status}'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (widget.task.status != TaskStatus.completed)
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    widget.updateTaskBloc.add(TaskUpdated(widget.task));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_border_outlined),
                        SizedBox(width: 8),
                        Text('Marcar tarea completada'),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
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
                    color: Colors.red,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Eliminar tarea',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
