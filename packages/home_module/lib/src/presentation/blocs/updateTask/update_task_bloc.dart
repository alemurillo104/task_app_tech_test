import 'dart:async';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../../../domain/entities/task.entity.dart';
import '../../../data/repositories/task.repository.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final TaskRepository repository;

  UpdateTaskBloc(this.repository) : super(UpdateTaskState()) {
    on<TaskUpdated>(_markTaskAsCompleted);
  }

  FutureOr<void> _markTaskAsCompleted(
    TaskUpdated event,
    Emitter<UpdateTaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UpdateTaskStatus.loading));

      await repository.markTaskAsCompleted(event.task.id!);

      emit(state.copyWith(status: UpdateTaskStatus.success));
    } catch (e) {
      logger.d(e.toString());
      emit(state.copyWith(status: UpdateTaskStatus.failure));
    }
  }
}
