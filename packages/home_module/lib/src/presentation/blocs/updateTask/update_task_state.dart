part of 'update_task_bloc.dart';

enum UpdateTaskStatus { initial, loading, success, failure }

class UpdateTaskState {
  final UpdateTaskStatus status;
  final Task? currentTask;
  final String? error;

  UpdateTaskState({
    this.status = UpdateTaskStatus.initial,
    this.currentTask,
    this.error,
  });
  UpdateTaskState copyWith({
    UpdateTaskStatus? status,
    Task? currentTask,
    String? error,
  }) {
    return UpdateTaskState(
      currentTask: currentTask ?? this.currentTask,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
