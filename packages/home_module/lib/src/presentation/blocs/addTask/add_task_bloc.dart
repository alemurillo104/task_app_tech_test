import 'dart:async';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../../../domain/mappers/task.mapper.dart';
import '../../../domain/entities/task.entity.dart';
import '../../../data/repositories/task.repository.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TaskRepository repository;

  AddTaskBloc(this.repository) : super(AddTaskState()) {
    on<TaskAdded>(_addTask);
  }

  FutureOr<void> _addTask(
    TaskAdded event,
    Emitter<AddTaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AddTaskStatus.loading));
      await repository.addTask(TaskMapper.mapToModel(event.task));

      emit(state.copyWith(status: AddTaskStatus.success));
    } catch (e) {
      logger.d(e.toString());
      emit(state.copyWith(status: AddTaskStatus.failure));
    }
  }
}
