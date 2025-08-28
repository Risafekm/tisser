// features/lead/domain/repositories/lead_repository.dart

import 'package:tisser_app/features/task/domain/entities/task_entities.dart';

abstract class TaskRepository {
  Stream<List<TaskEntity>> getTasks();
  Future<void> addTask(TaskEntity lead);
  Future<void> updateTask(TaskEntity lead);
  Future<void> deleteTask(String id);
}
