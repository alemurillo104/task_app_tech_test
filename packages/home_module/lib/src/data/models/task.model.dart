import '../../domain/entities/task.entity.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.name,
    required super.description,
    required super.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        status: TaskStatusMapper.toEnum(json['status']),
      );

  Map<String, dynamic> toJson() {
    var task = {
      'name': name,
      'description': description,
      'status': TaskStatusMapper.fromEnumtoString(status),
    };
    if (id != null) task['id'] = id!;
    return task;
  }
}
