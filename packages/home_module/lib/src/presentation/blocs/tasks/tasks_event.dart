part of 'tasks_bloc.dart';

abstract class TasksEvent {
  const TasksEvent();
}

final class TasksFetched extends TasksEvent {
  const TasksFetched();
}

final class TasksFiltered extends TasksEvent {
  final TaskStatus status;

  const TasksFiltered(this.status);
}

final class ResetTasksList extends TasksEvent {
  const ResetTasksList();
}
