import 'package:common_dependency_module/common_dependency_module.dart';
import '../src/domain/mappers/task.mapper.dart';
import '../src/presentation/pages/tasks.page.dart';
import '../src/data/repositories/task.repository.dart';
import '../src/presentation/pages/task_detail.page.dart';
import '../src/presentation/blocs/tasks/tasks_bloc.dart';
import '../src/presentation/blocs/updateTask/update_task_bloc.dart';
import '../src/presentation/blocs/deleteTask/delete_task_bloc.dart';

class HomeModularModule extends Module {
  @override
  void binds(Injector i) {
    i.add(TaskRepository.new);
    i.add(TaskMapper.new);
    i.add(TasksBloc.new);
    i.add(DeleteTaskBloc.new);
    i.add(UpdateTaskBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const TasksPage());
    r.child(
      '/taskDetail',
      child: (context) => TaskDetailPage(
        task: r.args.data['task'],
        deleteTaskBloc: r.args.data['deleteTaskBloc'],
        updateTaskBloc: r.args.data['updateTaskBloc'],
      ),
    );
  }
}
