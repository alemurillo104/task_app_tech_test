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

  static fromLiteralStringtoEnum(String value) {
    switch (value) {
      case 'Pendiente':
        return TaskStatus.pending;
      default:
        return TaskStatus.completed;
    }
  }

  static fromEnumtoString(TaskStatus value) {
    switch (value) {
      case TaskStatus.pending:
        return 'pending';
      default:
        return 'completed';
    }
  }
}
