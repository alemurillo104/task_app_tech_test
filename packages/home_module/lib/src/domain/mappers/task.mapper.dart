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
}
