import '../enums/task_status.enum.dart';

class TaskStatusMapper {
  static toEnum(String value) {
    switch (value) {
      case 'pending':
        return TaskStatus.pending;
      default:
        return TaskStatus.completed;
    }
  }
}
