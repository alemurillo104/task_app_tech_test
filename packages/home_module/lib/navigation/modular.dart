import 'package:common_dependency_module/common_dependency_module.dart';
import '../src/domain/mappers/task.mapper.dart';
import '../src/presentation/pages/tasks.page.dart';
import '../src/data/repositories/task.repository.dart';
import '../src/presentation/blocs/tasks/tasks_bloc.dart';

class HomeModularModule extends Module {
  @override
  void binds(Injector i) {
    i.add(TaskRepository.new);
    i.add(TaskMapper.new);
    i.add(TasksBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const TasksPage());
  }
}
