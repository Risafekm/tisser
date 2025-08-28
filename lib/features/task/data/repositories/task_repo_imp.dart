// features/lead/data/repositories/lead_repository_impl.dart
import 'package:tisser_app/features/task/data/data_source/task_datasource.dart';
import 'package:tisser_app/features/task/data/models/task_model.dart';
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';
import 'package:tisser_app/features/task/domain/repositories/task_repo.dart';

class TaskRepositoryImpl implements TaskRepository {
  final FirestoreTaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Stream<List<TaskEntity>> getTasks() {
    return dataSource.getTasks();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    await dataSource.addTask(
      TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        status: task.status,
        createdDate: task.createdDate,
      ),
    );
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await dataSource.updateTask(
      TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        status: task.status,
        createdDate: task.createdDate,
      ),
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    await dataSource.deleteTask(id);
  }
}
