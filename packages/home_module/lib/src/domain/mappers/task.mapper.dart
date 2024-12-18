import '../entities/task.entity.dart';
import '../../data/models/task.model.dart';

class TaskMapper {
  static Task mapToEntity(TaskModel model) {
    return Task(
      id: model.id,
      name: model.name,
      description: model.description,
      status: model.status,
    );
  }

  static TaskModel mapToModel(Task entity) {
    return TaskModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      status: entity.status,
    );
  }
}
