import '../../domain/entities/task.entity.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.name,
    required super.description,
    required super.status,
  });
}
