import 'package:common_dependency_module/common_dependency_module.dart';
import '../models/task.model.dart';
import '../../domain/mappers/task.enum.mapper.dart';

class TaskRepository {
  final _collection = FirebaseFirestore.instance.collection('tasks');

  Future<List<TaskModel>> getTasks() async {
    var snapshot = await _collection.get();
    var accounts = snapshot.docs.map((doc) {
      var item = doc.data();
      return TaskModel(
        id: doc.id,
        name: item['name'],
        description: item['description'],
        status: TaskStatusMapper.toEnum(item['status']),
      );
    }).toList();

    return accounts;
  }

  Future<void> deleteTask(String categoryId) async {
    await _collection.doc(categoryId).delete();
  }
}
