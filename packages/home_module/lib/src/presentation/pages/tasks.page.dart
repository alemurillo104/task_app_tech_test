import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import 'package:home_module/home_module.dart';
import '../blocs/tasks/tasks_bloc.dart';
import '../widgets/task_list.widget.dart';
import '../widgets/filter_task.widget.dart';
import '../blocs/addTask/add_task_bloc.dart';
import '../blocs/updateTask/update_task_bloc.dart';
import '../blocs/deleteTask/delete_task_bloc.dart';
import '../widgets/add_task_bottom_sheet.widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final deleteTaskBloc = Modular.get<DeleteTaskBloc>();
  final updateTaskBloc = Modular.get<UpdateTaskBloc>();
  final addTaskBloc = Modular.get<AddTaskBloc>();
  final tasksBloc = Modular.get<TasksBloc>();
  String? taskStatusSelected;

  final tasksStatus = [
    TaskStatus.all,
    TaskStatus.pending,
    TaskStatus.completed
  ];

  TaskStatus currentStatusFilter = TaskStatus.all;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => tasksBloc
            ..add(
              const TasksFetched(),
            ),
        ),
        BlocProvider(
          create: (context) => deleteTaskBloc,
        ),
        BlocProvider(
          create: (context) => updateTaskBloc,
        ),
        BlocProvider(
          create: (context) => addTaskBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Listado de tareas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<DeleteTaskBloc, DeleteTaskState>(
              listener: (context, state) {
                switch (state.status) {
                  case DeleteTaskStatus.success:
                    context.read<TasksBloc>().add(
                          TasksFetched(
                            status: currentStatusFilter,
                          ),
                        );
                    Navigator.pop(context);
                    break;
                  default:
                }
              },
            ),
            BlocListener<UpdateTaskBloc, UpdateTaskState>(
              listener: (context, state) {
                switch (state.status) {
                  case UpdateTaskStatus.success:
                    context.read<TasksBloc>().add(
                          TasksFetched(
                            status: currentStatusFilter,
                          ),
                        );
                    Navigator.pop(context);
                    break;
                  default:
                }
              },
            ),
            BlocListener<AddTaskBloc, AddTaskState>(
              bloc: addTaskBloc,
              listener: (context, state) {
                switch (state.status) {
                  case AddTaskStatus.success:
                    context.read<TasksBloc>().add(
                          TasksFetched(
                            status: currentStatusFilter,
                          ),
                        );
                    break;
                  default:
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                SizedBox(
                  height: 30,
                  child: FilterTaskWidget(
                    status: tasksStatus,
                    currentStatus: currentStatusFilter,
                    onFilterChanged: (status) {
                      setState(() => currentStatusFilter = status);
                      logger.d(status);
                      tasksBloc.add(TasksFetched(status: status));
                    },
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: BlocBuilder<TasksBloc, TasksState>(
                          builder: (context, state) {
                            switch (state.status) {
                              case TasksStatus.success:
                                return TaskListWidget(
                                  statusSelected:
                                      state.currentTaskStatusFiltered ??
                                          TaskStatus.all,
                                  tasks: state.filteredtasks,
                                  deleteTaskBloc: deleteTaskBloc,
                                  updateTaskBloc: updateTaskBloc,
                                );
                              case TasksStatus.failure:
                                return const Text('Error');
                              default:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddTaskBottomSheetWidget(
                  addTaskBloc: addTaskBloc,
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
