part of 'update_task_bloc.dart';

abstract class UpdateTaskEvent {
  const UpdateTaskEvent();
}

final class TaskUpdated extends UpdateTaskEvent {
  final Task task;

  const TaskUpdated(this.task);
}
