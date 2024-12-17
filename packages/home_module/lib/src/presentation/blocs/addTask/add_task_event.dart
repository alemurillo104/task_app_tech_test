part of 'add_task_bloc.dart';

abstract class AddTaskEvent {
  const AddTaskEvent();
}

final class TaskAdded extends AddTaskEvent {
  final Task task;

  const TaskAdded(this.task);
}
