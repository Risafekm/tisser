// features/lead/domain/usecases/delete_lead_usecase.dart

import 'package:tisser_app/features/task/domain/repositories/task_repo.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteTask(id);
  }
}
