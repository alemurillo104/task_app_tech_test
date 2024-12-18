import '../enums/task_status.enum.dart';

class TaskStatusMapper {
  static toEnum(String value) {
    switch (value) {
      case 'pending':
        return TaskStatus.pending;
      case 'completed':
        return TaskStatus.completed;
      default:
        return TaskStatus.all;
    }
  }

  static fromLiteralStringtoEnum(String value) {
    switch (value) {
      case 'Pendiente':
        return TaskStatus.pending;
      case 'Completado':
        return TaskStatus.completed;
      default:
        return TaskStatus.all;
    }
  }

  static fromEnumtoString(TaskStatus value) {
    switch (value) {
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.completed:
        return 'completed';
      default:
        return 'all';
    }
  }

  static String fromEnumtoLiteralString(TaskStatus value) {
    switch (value) {
      case TaskStatus.pending:
        return 'Pendiente';
      case TaskStatus.completed:
        return 'Completado';
      default:
        return 'Todos';
    }
  }
}
