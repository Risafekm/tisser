// features/lead/domain/usecases/update_lead_usecase.dart
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';
import 'package:tisser_app/features/task/domain/repositories/task_repo.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(TaskEntity lead) {
    return repository.updateTask(lead);
  }
}
