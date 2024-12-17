import '../../domain/entities/task.entity.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.name,
    required super.description,
    required super.status,
  });
}
