part of 'tasks_bloc.dart';

enum TasksStatus { initial, loading, success, failure }

class TasksState {
  final TasksStatus status;
  final List<Task> tasks;
  final List<Task> filteredtasks;
  final TaskStatus? currentTaskStatusFiltered;
  final String? error;

  TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.filteredtasks = const [],
    this.currentTaskStatusFiltered,
    this.error,
  });
  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
    List<Task>? filteredtasks,
    TaskStatus? currentTaskStatusFiltered,
    String? error,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      filteredtasks: filteredtasks ?? this.filteredtasks,
      currentTaskStatusFiltered:
          currentTaskStatusFiltered ?? this.currentTaskStatusFiltered,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
