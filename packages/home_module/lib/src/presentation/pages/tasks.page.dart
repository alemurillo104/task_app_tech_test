import 'package:flutter/material.dart';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../blocs/tasks/tasks_bloc.dart';
import '../widgets/task_item.widget.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<TasksBloc>()..add(const TasksFetched()),
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
        body: Padding(
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
                                    onTap: () {},
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
    );
  }
}
