import 'package:common_dependency_module/common_dependency_module.dart';
import '../enums/task_status.enum.dart';

class Task extends Equatable {
  String? id;
  final String name;
  final String description;
  final TaskStatus status;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, description, status];
}
