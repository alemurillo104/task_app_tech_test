part of 'tasks_bloc.dart';

abstract class TasksEvent {
  const TasksEvent();
}

final class TasksFetched extends TasksEvent {
  final TaskStatus? status;

  const TasksFetched({this.status});
}

