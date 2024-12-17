part of 'tasks_bloc.dart';

enum TasksStatus { initial, loading, success, failure }

class TasksState {
  final TasksStatus status;
  final List<Task> tasks;
  final String? error;

  TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.error,
  });
  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
    String? error,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
