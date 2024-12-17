import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../blocs/tasks/tasks_bloc.dart';
import '../widgets/task_item.widget.dart';
import '../../../navigation/navigation.dart';
import '../blocs/deleteTask/delete_task_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final deleteTaskBloc = Modular.get<DeleteTaskBloc>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Modular.get<TasksBloc>()
            ..add(
              const TasksFetched(),
            ),
        ),
        BlocProvider(
          create: (context) => deleteTaskBloc,
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
        body: BlocListener<DeleteTaskBloc, DeleteTaskState>(
          listener: (context, state) {
            switch (state.status) {
              case DeleteTaskStatus.success:
                context.read<TasksBloc>().add(const TasksFetched());
                break;
              default:
            }
          },
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
                                          },
                                        );
                                      },
                                    );
                                  },
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
                      )
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
