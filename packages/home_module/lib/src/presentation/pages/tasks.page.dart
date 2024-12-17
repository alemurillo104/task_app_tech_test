import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../blocs/tasks/tasks_bloc.dart';
import '../widgets/task_item.widget.dart';
import '../blocs/addTask/add_task_bloc.dart';
import '../../../navigation/navigation.dart';
import '../blocs/updateTask/update_task_bloc.dart';
import '../blocs/deleteTask/delete_task_bloc.dart';
import '../../domain/mappers/task.enum.mapper.dart';
import '../widgets/add_task_bottom_sheet.widget.dart';
import '../widgets/filter_task_bottom_sheet.widget.dart';

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
                    context.read<TasksBloc>().add(const TasksFetched());
                    break;
                  default:
                }
              },
            ),
            BlocListener<UpdateTaskBloc, UpdateTaskState>(
              listener: (context, state) {
                switch (state.status) {
                  case UpdateTaskStatus.success:
                    context.read<TasksBloc>().add(const TasksFetched());
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
                    context.read<TasksBloc>().add(const TasksFetched());
                    break;
                  default:
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
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
                                return ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemCount: state.tasks.length,
                                  itemBuilder: (context, index) {
                                    return TaskItemWidget(
                                      task: state.tasks[index],
                                      onTap: () {
                                        Modular.to.pushNamed(
                                          HomeDestination.taskDetail,
                                          arguments: {
                                            'task': state.tasks[index],
                                            'deleteTaskBloc': deleteTaskBloc,
                                            'updateTaskBloc': updateTaskBloc,
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              case TasksStatus.filterMode:
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Filtro aplicado: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          TaskStatusMapper
                                              .fromEnumtoLiteralString(
                                            state.currentTaskStatusFiltered!,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 10);
                                        },
                                        itemCount: state.filteredtasks.length,
                                        itemBuilder: (context, index) {
                                          return TaskItemWidget(
                                            task: state.filteredtasks[index],
                                            onTap: () {
                                              Modular.to.pushNamed(
                                                HomeDestination.taskDetail,
                                                arguments: {
                                                  'task': state
                                                      .filteredtasks[index],
                                                  'deleteTaskBloc':
                                                      deleteTaskBloc,
                                                  'updateTaskBloc':
                                                      updateTaskBloc,
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
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
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return FilterTaskBottomSheetWidget(
                                currentTaskStatusSelected: taskStatusSelected,
                                onFilterButtonPressed: (status) {
                                  logger.d(status);
                                  tasksBloc.add(TasksFiltered(status));
                                  taskStatusSelected =
                                      TaskStatusMapper.fromEnumtoLiteralString(
                                    status,
                                  );
                                  setState(() {});
                                },
                                onClearFilterPressed: () {
                                  logger.d('clear filters');
                                  taskStatusSelected = null;
                                  setState(() {});
                                  tasksBloc.add(const ResetTasksList());
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade100,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.filter_alt_outlined),
                              SizedBox(width: 8),
                              Text('Filtrar tareas'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AddTaskBottomSheetWidget(
                                addTaskBloc: addTaskBloc,
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade100,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline),
                              SizedBox(width: 8),
                              Text('Agregar nueva tarea'),
                            ],
                          ),
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
      ),
    );
  }
}
