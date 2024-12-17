import 'dart:async';
import 'package:common_dependency_module/common_dependency_module.dart';
import '../../../data/repositories/task.repository.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  final TaskRepository repository;
  DeleteTaskBloc({
    required this.repository,
  }) : super(DeleteTaskState()) {
    on<TaskDeleted>(_deleteTask);
  }

  FutureOr<void> _deleteTask(
    TaskDeleted event,
    Emitter<DeleteTaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DeleteTaskStatus.loading));

      await repository.deleteTask(event.id);
      emit(state.copyWith(status: DeleteTaskStatus.success));
    } catch (e) {
      logger.d(e.toString());
      emit(state.copyWith(status: DeleteTaskStatus.failure));
    }
  }
}
