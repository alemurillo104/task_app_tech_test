part of 'add_task_bloc.dart';

enum AddTaskStatus { initial, loading, success, failure }

class AddTaskState {
  final AddTaskStatus status;
  final Task? task;
  final String? error;

  AddTaskState({
    this.status = AddTaskStatus.initial,
    this.task,
    this.error,
  });
  AddTaskState copyWith({
    AddTaskStatus? status,
    Task? task,
    String? error,
  }) {
    return AddTaskState(
      task: task ?? this.task,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
