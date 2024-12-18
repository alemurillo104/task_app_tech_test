import 'dart:async';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../../../domain/mappers/task.mapper.dart';
import '../../../domain/entities/task.entity.dart';
import '../../../domain/enums/task_status.enum.dart';
import '../../../data/repositories/task.repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository repository;
  TasksBloc(this.repository) : super(TasksState()) {
    on<TasksFetched>(_getTasks);
  }

  FutureOr<void> _getTasks(
    TasksFetched event,
    Emitter<TasksState> emit,
  ) async {
    try {
      final tasksResponse = await repository.getTasks();
      final tasks = tasksResponse
          .map(
            (task) => TaskMapper.mapToEntity(task),
          )
          .toList();
      if (event.status != null && event.status != TaskStatus.all) {
        final filteredTasks = tasks
            .where(
              (task) => task.status == event.status,
            )
            .toList();
        return emit(
          state.copyWith(
            status: TasksStatus.success,
            tasks: tasks,
            currentTaskStatusFiltered: event.status,
            filteredtasks: filteredTasks,
          ),
        );
      }
      return emit(
        state.copyWith(
          status: TasksStatus.success,
          tasks: tasks,
          currentTaskStatusFiltered: event.status,
          filteredtasks: tasks,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }
}
