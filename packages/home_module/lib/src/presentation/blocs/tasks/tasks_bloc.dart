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
    on<TasksFiltered>(_getTasksByStatus);
    on<ResetTasksList>(_resetTasksList);
  }

  FutureOr<void> _resetTasksList(
    ResetTasksList event,
    Emitter<TasksState> emit,
  ) async {
    emit(TasksState());
    add(const TasksFetched());
  }

  FutureOr<void> _getTasksByStatus(
    TasksFiltered event,
    Emitter<TasksState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TasksStatus.loading));

      final tasksResponse = await repository.getTasks();
      final tasks = tasksResponse
          .map(
            (task) => TaskMapper.mapToEntity(task),
          )
          .toList();
      final filteredTasks = tasks
          .where(
            (task) => task.status == event.status,
          )
          .toList();

      return emit(
        state.copyWith(
          status: TasksStatus.filterMode,
          filteredMode: true,
          tasks: tasks,
          currentTaskStatusFiltered: event.status,
          filteredtasks: filteredTasks,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

  FutureOr<void> _getTasks(
    TasksFetched event,
    Emitter<TasksState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TasksStatus.loading));

      final tasksResponse = await repository.getTasks();
      final tasks = tasksResponse
          .map(
            (task) => TaskMapper.mapToEntity(task),
          )
          .toList();

      emit(state.copyWith(status: TasksStatus.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }
}
