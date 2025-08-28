// features/lead/domain/usecases/get_leads_usecase.dart

import 'package:tisser_app/features/task/domain/entities/task_entities.dart';
import 'package:tisser_app/features/task/domain/repositories/task_repo.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Stream<List<TaskEntity>> call() {
    return repository.getTasks();
  }
}
