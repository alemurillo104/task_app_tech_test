part of 'delete_task_bloc.dart';

enum DeleteTaskStatus { initial, loading, success, failure }

class DeleteTaskState {
  final DeleteTaskStatus status;
  final String? error;

  DeleteTaskState({
    this.status = DeleteTaskStatus.initial,
    this.error,
  });
  DeleteTaskState copyWith({
    DeleteTaskStatus? status,
    String? error,
  }) {
    return DeleteTaskState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
