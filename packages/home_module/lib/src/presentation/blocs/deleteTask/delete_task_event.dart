part of 'delete_task_bloc.dart';

abstract class DeleteTaskEvent {
  const DeleteTaskEvent();
}

final class TaskDeleted extends DeleteTaskEvent {
  final String id;

  const TaskDeleted(this.id);
}
